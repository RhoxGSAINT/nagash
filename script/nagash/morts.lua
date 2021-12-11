--- TODO hook in the various Mortarch unlocks and spawns
--- TODO lock the various Mortarch events behind whatever conditions
--- TODO trigger whatever scripted effects for each event.

----- Handle the Mortarch systems

-- local bdsm = get_bdsm()
local faction_key = bdsm:get_faction_key()

--- Each need:
--[[ 
    agent subtype
    mf horde type (?)
    acquisition state
    tech key?
    spawn details (ie. spawn with Nagash, or spawn in predefined locations, or what)
--]]

---@class mortarch
local mortarch = {
    --- default values
    subtype = "",
    forename = "",
    surname = "",
    acquired = false,
    tech_key = "",
}

---@return mortarch
function mortarch.new(o)
    o = o or {}
    setmetatable(o, {__index = mortarch})
    o.acquired = false

    return o
end

function mortarch:init()
    bdsm:log("Initializing the mortarch " .. self.subtype)
    if not self.acquired then
        -- if not acquired, start the tracking for the acquisition!
        core:add_listener(
            "MortUnlock",
            "ResearchCompleted",
            function (context)
                bdsm:log("Tech " .. context:technology() .. " researched by " .. context:faction():name())
                return context:faction():name() == faction_key and context:technology() == self.tech_key
            end,
            function (context)
                self:spawn()
            end,
            false
        )
    else
        -- if acquired, start the tracking for PR and stuff if needed!
        
    end
    
end

function mortarch:spawn()
    local forename,surname = self.forename,self.surname
    local subtype = self.subtype
    bdsm:log("Spawning " .. subtype)
    
    --- TODO art set needed?
    cm:spawn_character_to_pool(faction_key, forename, surname, "", "", 50, true, "general", subtype, true, "")
    self.acquired = true
end

-- --- TODO don't use this?
-- --- TODO initialize the mortarch objects in the first place!
-- function bdsm:create_mortarchs()
--     local arkhan = mortarchs[4]

--     local mort = mortarch.new(arkhan)
--     -- mort:

--     self._mortarchs[#self._mortarchs+1] = mort

--     mort:init()
-- end

---@param o mortarch
---@param i number Index
function bdsm:instantiate_mortarch(o, i)
    if not is_table(o) then return end

    setmetatable(o, {__index = mortarch})

    self._mortarchs[i] = o

    o:init()
end

function bdsm:instantiate_mortarchs()
    self:log("Instantiating them all")
    self:log("Num mortarchs be " .. #self._mortarchs)
    for i = 1, #self._mortarchs do
        self:log("In " .. i)
        self:instantiate_mortarch(self._mortarchs[i], i)
    end
end

function bdsm:create_mortarchs()
    if #self._mortarchs > 0 then return end

    local mortarch_db = self:load_db("morts")

    for i,mort_info in ipairs(mortarch_db) do
        local mort = mortarch.new(mort_info)

        self._mortarchs[#self._mortarchs+1] = mort
    end
end

function bdsm:get_mortarch_with_key(mortarch_key)
    if not is_string(mortarch_key) then return end

    local mortarchs = self._mortarchs
    for i = 1, #mortarchs do
        if mortarchs[i].subtype == mortarch_key then
            return mortarchs[i]
        end
    end
end

--- Dev function to automatically unlock and spawn every Mortarch.
function bdsm:all_morts()
    self:create_mortarchs()

    local fact = self:get_faction()
    local fact_key = self:get_faction_key()
    local nagash = self:get_faction_leader()
    local nag_mf = nagash:military_force()
    local region = nagash:region()
    local region_key = region:name()

    cm:spawn_agent_at_military_force(fact, nag_mf, "dignitary", "nag_mortarch_isabella")

    for i,mort in ipairs(self._mortarchs) do
        local x,y = cm:find_valid_spawn_location_for_character_from_character(fact_key, "character_cqi:"..nagash:command_queue_index(), true, 6)

        if x ~= -1 then

            cm:create_force_with_general(
                fact_key,
                "",
                region_key,
                x,
                y,
                "general",
                mort.subtype,
                mort.forename,
                "",
                mort.surname,
                "",
                false,
                function(cqi)

                end
            )
        else
            bdsm:error("Couldn't find a position for morty "..mort.subtype)
        end
    end
end



cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("nag_mortarchs", bdsm._mortarchs, context)
    end
)

cm:add_loading_game_callback(
    function(context)
        bdsm:log("Loading game callback!")
        bdsm:create_mortarchs()
        bdsm._mortarchs = cm:load_named_value("nag_mortarchs", bdsm._mortarchs, context)

        bdsm:instantiate_mortarchs()
    end
)