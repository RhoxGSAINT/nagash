--- TODO integrate VLib stuff

--- Campaign only!
if __game_mode ~= __lib_type_campaign or cm:get_campaign_name() ~= "main_warhammer" then return end

---@class bdsm
local bdsm = {
    _faction_key = "nag_nagash",

    write_to_log = true,
    _logpath = "!vandy_lib.txt",
    _default_module_path = "script/nagash/"
}

local vlib = get_vandy_lib()
local log,logf,error,errorf = vlib:get_log_functions("[bdsm]")
function bdsm:log(...) log(...) end
function bdsm:logf(...) logf(...) end
function bdsm:error(...) error(...) end
function bdsm:errorf(...) errorf(...) end

function bdsm:get_logs()
    return 
        function(text) bdsm:log(text) end,
        function(text, ...) bdsm:logf(text, ...) end,
        function(text) bdsm:error(text) end,
        function(text, ...) bdsm:errorf(text, ...) end
end

---@return string
function bdsm:get_faction_key()
    return self._faction_key
end

---@return FACTION_SCRIPT_INTERFACE
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

    local db_path = self._default_module_path.."db/"..db_name

    return require(db_path)
end

function bdsm:init()
    local ok, err = pcall(function()
    local path = self._default_module_path
    -- load up all the modules
    self._turn_one = vlib:load_module("intro_chain", path)
    vlib:load_module("mid_game_start", path)
    -- vlib:load_module("tech", path)
    vlib:load_module("morts", path)
    -- vlib:load_module("ui", path)
    vlib:load_module("souls", path)
    end) if not ok then bdsm:errorf(err) end
end

function get_bdsm()
    return bdsm
end

-- TODO set up army caps, so the only-legendary-lord thing will work with UI and AI

-- TODO set up the Blyramid ritual chain

-- TODO set up the starting QB

-- TODO tracking for the mission chains

-- TODO startup with the Arkhan chains and stuff

bdsm:init()