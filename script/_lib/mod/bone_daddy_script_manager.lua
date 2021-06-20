if __game_mode ~= __lib_type_campaign or cm:get_campaign_name() ~= "main_warhammer" then
    return
end

---@class bdsm
local bdsm = {
    _faction_key = "nag_nagash",

    write_to_log = true,
    _logpath = "!vandy_lib.txt",
    _default_module_path = "script/nagash/"
}

function bdsm:get_faction_key()
    return self._faction_key
end

function bdsm:get_faction()
    return cm:get_faction(self:get_faction_key())
end

function bdsm:get_faction_leader()
    return self:get_faction():faction_leader()
end

--- Bit of a misnomer, doesn't actually do anything with the game's DB; just grabs a Lua file that has a table, and returns that table.
---@param db_name string
---@return string[]
function bdsm:load_db(db_name)
    if not is_string(db_name) then return end

    local db_path = self._default_module_path.."db/"

    return require(db_path)
end

function bdsm:init()
    -- initialize the log
    self:log_init()

    -- load up all the modules
    self._turn_one = self:load_module("intro_chain")
    self:load_module("mid_game_start")
    self:load_module("morts")
    self:load_module("ui")

    -- grab all the missions
    self._missions = {}

    local mission_path = self._default_module_path.."missions/"

    self._missions.arkhan = self:load_module("arkhant_believe_it", mission_path)
    self._missions.harkon = self:load_module("harkon_you_believe_it", mission_path)
    self._missions.krell = self:load_module("krell_a_rebellion", mission_path)
    self._missions.mannfred = self:load_module("mannfred_is_an_asshole", mission_path)
    self._missions.neferata = self:load_module("neferata", mission_path)
    self._missions.vlad = self:load_module("vladnt_you_like_to_know", mission_path)
end

function bdsm:log_init()
    local first_load = core:svr_load_persistent_bool("bdsm_init") ~= true

    if first_load then
        core:svr_save_persistent_bool("bdsm_init", true)

        local file = io.open(self._logpath, "w+")
        file:write("NEW LOG INITIALIZED \n")
        local time_stamp = os.date("%d, %m %Y %X")
        file:write("[" .. time_stamp .. "]\n")
        file:close()
    else
        local i_to_game_mode = {
            [0] = "BATTLE",
            [1] = "CAMPAIGN",
            [2] = "FRONTEND",
        }

        local game_mode = i_to_game_mode[__game_mode]

        local file = io.open(self._logpath, "a+")
        file:write("**********\nNEW GAME MODE: "..game_mode)
        local time_stamp = os.date("%d, %m %Y %X")
        file:write("[" .. time_stamp .. "]\n")
        file:close()
    end
end

--- Basic logging function for outputting text into the MCT log file.
--- @tparam string text The string used for output
function bdsm:log(text)
    if not is_string(text) and not is_number(text) then
        return false
    end

    if not self.write_to_log then
        return false
    end

    local file = io.open(self._logpath, "a+")
    file:write(text .. "\n")
    file:close()
end

--- Basic error logging function for outputting text into the MCT log file.
--- @tparam string text The string used for output
function bdsm:error(text)
    if not is_string(text) and not is_number(text) then
        return false
    end

    if not self.write_to_log then
        return false
    end

    local file = io.open(self._logpath, "a+")
    file:write("ERROR: " .. text .. "\n")
    file:write(debug.traceback("", 2) .. "\n")
    file:close()
end

function bdsm:load_module(module_name, path)
    if not path then path = bdsm._default_module_path end

    local full_file_name = path .. module_name .. ".lua"

    local file, load_error = loadfile(full_file_name)

    if not file then
        self:error("Attempted to load module with name ["..module_name.."], but loadfile had an error: ".. load_error .."")
        --return
    else
        self:log("Loading module with name [" .. module_name .. ".lua]")

        local global_env = core:get_env()
        local attach_env = {}
        setmetatable(attach_env, {__index = global_env})

        -- pass valuable stuff to the modules
        --attach_env.bdsm = self
        --attach_env.core = core

        setfenv(file, attach_env)
        local lua_module = file(module_name)
        package.loaded[module_name] = lua_module or true

        self:log("[" .. module_name .. ".lua] loaded successfully!")

        --if module_name == "mod_obj" then
        --    self.mod_obj = lua_module
        --end

        --self[module_name] = lua_module

        return lua_module
    end

    local _, err = pcall(function() require(module_name) end)

    self:error("Tried to load module with name [" .. module_name .. ".lua], failed on runtime. Error below:")
    self:error(err)
    return false
end

-- TODO set up army caps, so the only-legendary-lord thing will work with UI and AI

-- TODO work on Blyramid upgrade prototype and design

-- TODO set up Sentinels of Blyramid occupation

-- TODO set up the Blyramid ritual chain

-- TODO work on Mortarch UI prototype, some pretty screen with each lord displayed

-- TODO set up the starting QB

-- TODO tracking for the mission chains

-- TODO startup with the Arkhan chains and stuff

---@return bdsm
function get_bdsm()
    return core:get_static_object("bone_daddy_script_manager")
end

core:add_static_object("bone_daddy_script_manager", bdsm)

_G.get_bdsm = get_bdsm

bdsm:init()