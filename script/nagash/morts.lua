--- TODO hook in the various Mortarch unlocks and spawns
--- TODO lock the various Mortarch events behind whatever conditions
--- TODO trigger whatever scripted effects for each event.

----- Handle the Mortarch systems

---@class bdsm
local bdsm = get_bdsm()
local log,logf,err,errf = bdsm:get_logs()
local faction_key = bdsm:get_faction_key()

--- Each need:
--[[ 
    agent subtype
    mf horde type (?)
    acquisition state
    tech key?
    spawn details (ie. spawn with Nagash, or spawn in predefined locations, or what)
--]]

bdsm._mortarchs = {}

---@class mortarch
local mortarch = {
    --- default values
    subtype = "",
    forename = "",
    surname = "",
    acquired = false,
    tech_key = "",

    ---@type string[] Units starting in this army.
    starting_army = {},

    ---@type {x:number,y:number,region:string} Starting position. Can also be a string - "NAGASH"
    pos = {x=0,y=0},
}

---@return mortarch
function mortarch.new(o)
    o = o or {}
    setmetatable(o, {__index = mortarch})
    o.acquired = false

    return o
end

function mortarch:init()

end

-- function mortarch:init()
--     bdsm:log("Initializing the mortarch " .. self.subtype)
--     if not self.acquired then
--         -- if not acquired, start the tracking for the acquisition!
--         core:add_listener(
--             "MortUnlock",
--             "ResearchCompleted",
--             function (context)
--                 bdsm:log("Tech " .. context:technology() .. " researched by " .. context:faction():name())
--                 return context:faction():name() == faction_key and context:technology() == self.tech_key
--             end,
--             function (context)
--                 self:spawn_to_pool()
--             end,
--             false
--         )
--     else
--         -- if acquired, start the tracking for PR and stuff if needed!
        
--     end
--     --- TODO when this lord is spawned from the pool, add ancillaries or whatever is needed?
-- end

--- TODO choose between pool/spawn at pos, based on if they have pos table set?

function mortarch:spawn_to_pool()
    local forename,surname = self.forename,self.surname
    local subtype = self.subtype
    bdsm:log("Spawning " .. subtype)
    
    --- TODO art set needed?
    cm:spawn_character_to_pool(faction_key, forename, surname, "", "", 50, true, "general", subtype, true, "")
    self.acquired = true
end

function mortarch:spawn()
    local x,y = self.pos.x, self.pos.y
    local starting_army = self.starting_army
    local forename,surname = self.forename,self.surname
    local subtype = self.subtype

    x,y = cm:find_valid_spawn_location_for_character_from_position(bdsm:get_faction_key(), x, y, true, 3)

    cm:create_force_with_general(
        bdsm:get_faction_key(),
        table.concat(starting_army, ","),
        self.pos.region,
        x,
        y,
        "general",
        subtype,
        forename,
        "",
        surname,
        "",
        false,
        function(cqi)
            -- anything?
        end
    )

    self.acquired = true
end

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

--- TODO pull in all of the shit necessary for tech stuff from VLib, for scripted unlocks and stuff? Or use the new BMen stuff?
    --- yes, use new BMen stuff. 
        --- cm:update_technology_unlock_progress_values(faction_key, technology_key, {table_of_values})
        --- cm:[un]lock_technology

--- TODO handle Mort acquisition and events and stuff through here as well
--- TODO fix up the PR UI within tech, right now it gets confused and says Canopic Jars on the tech node display.

--- TODO a table of all tech keys and their inner values.
    --- unlock conditions, texts, etc.

local tech_progress = {

}

--- All of the event techs begin locked, as do all Mort unlock techs
local locked_techs = {
    "nag_arkhan_event_1",
    "nag_arkhan_event_2",
    "nag_arkhan_event_3",
    "nag_luthor_event_1",
    "nag_luthor_event_2",
    "nag_luthor_event_3",
    "nag_mannfred_event_1",
    "nag_mannfred_event_2",
    "nag_mannfred_event_3",
    "nag_krell_event_1",
    "nag_krell_event_2",
    "nag_krell_event_3",
    "nag_neferata_event_1",
    "nag_neferata_event_2",
    "nag_neferata_event_3",
    "nag_vlad_event_1",
    "nag_vlad_event_2",
    "nag_vlad_event_3",

    "nag_arkhan_unlock",
    "nag_luthor_unlock",
    "nag_mannfred_unlock",
    "nag_krell_unlock",
    "nag_neferata_unlock",
    "nag_vlad_unlock",
}

--- First node for each Mortarch
local unlock_techs = {
    nag_arkhan_unlock = true,
    nag_luthor_unlock = true,
    nag_mannfred_unlock = true,
    nag_krell_unlock = true,
    nag_neferata_unlock = true,
    nag_vlad_unlock = true,
}
    
--- TODO VLIB tech stuff
--- TODO start up the listeners for each tech event.
--- TODO track values and shit.
local function init()
    logf("Mort init!")
    local vlib = get_vlib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    if cm:is_new_game() then
        logf("Is new game!")
        --- Start off every primary tech as locked!
        for tech,bool in pairs(unlock_techs) do
            -- cm:lock_technology(bdsm:get_faction_key(), tech)

            bdsm:logf("Pre- set_techs_lock_state")
            cc:set_techs_lock_state(tech, "locked", effect.get_localised_string(tech.."_locked"), {faction=bdsm:get_faction_key()})
            bdsm:logf("Post- set_techs_lock_state")
        end
    end

    --- When an "unlock" tech is researched, spawn the related Morty.
    core:add_listener(
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            return unlock_techs[context:technology()]
        end,
        function(context)
            local tech_key = context:technology()
            
            --- format "nag_arkhan_unlock" to "nag_mortarch_arkhan"

            -- mort_key is "arkhan" or "vlad" or whatever
            local mort_key = string.gsub(tech_key, "nag_", "")
            mort_key = string.gsub(mort_key, "_unlock", "")

            -- append the prefix
            mort_key = "nag_mortarch_"..mort_key

            -- get and spawn the mortarch
            bdsm:logf("Spawning %s", mort_key)

            --- TODO make sure mort:spawn() allows for spawning on map or spawning in pool
            local mort = bdsm:get_mortarch_with_key(mort_key)
            mort:spawn()

            --- lock each sub-tech
            local tech_key_cut = string.gsub(tech_key, "_unlock", "")
            for i = 1,3 do 
                local sub_tech_key = tech_key_cut .. "_event"..i
                local str = effect.get_localised_string("tech_lock_"..sub_tech_key)

                if sub_tech_key == "nag_luthor_event_1" then
                    str = string.format(str, 0)
                end

                cc:set_techs_lock_state(sub_tech_key, "locked", str, {faction=bdsm:get_faction_key()})
            end
        end,
        true
    )

    -- tech filter
    local bf = {faction=bdsm:get_faction_key()}
    local nk = bdsm:get_faction_key()

    --- TODO event message for unlocks!
    local function unlock(key)
        cc:set_techs_lock_state(key, "unlocked", "", nk)
    end

    ---@param tech_obj tech_class
    local function is_locked(tech_obj)
        return tech_obj and tech_obj:get_lock_state(nk) == "locked"
    end

    --- TODO track all tech progress!!
    do
        --- TODO all Mortarch unlock things
        ---@type tech_class
        local arkhan = cc:get_object("TechObj", "nag_arkhan_unlock")
        ---@type tech_class
        local luthor = cc:get_object("TechObj", "nag_luthor_unlock")
        ---@type tech_class
        local mannfred = cc:get_object("TechObj", "nag_mannfred_unlock")
        ---@type tech_class
        local krell = cc:get_object("TechObj", "nag_krell_unlock")
        ---@type tech_class
        local neffy = cc:get_object("TechObj", "nag_neferata_unlock")
        ---@type tech_class
        local vlad = cc:get_object("TechObj", "nag_vlad_unlock")

        --- arkhan unlock
        if is_locked(arkhan) then
            core:add_listener(
                "nag_arkhan_unlock",
                "MissionSucceeded",
                function(context)
                    return context:mission():mission_record_key() == "nagash_intro_5"
                end,
                function(context)
                    unlock("nag_arkhan_unlock")
                end,
                false
            )
        end

        --- neffy unlock
        if is_locked(neffy) then 
            core:add_listener(
                "nag_neferata_unlock",
                "BuildingCompleted",
                function(context)
                    return context:building():name() == "nag_outpost_special_nagashizzar_4"
                end,
                function(context)
                    unlock("nag_neferata_unlock")
                end,
                false
            )
        end

        --- krell unlock
        if is_locked(krell) then 
            --- TODO track if the Barrow Legion is destroyed
        end

        if is_locked(mannfred) then 
            --- TODO defeat Mannfred in battle, or unlock if his faction is destroyed
        end

        ---@param faction_obj FACTION_SCRIPT_INTERFACE
        local function any_armies(faction_obj)
            local character_list = faction_obj:character_list()
            for i = 0, character_list:num_items() -1 do 
                local character = character_list:item_at(i)
                if character:has_military_force() and not character:region():is_null_interface() then 
                    --- "is in empire"
                    local reg_key = character:region():name()

                    if reg_key:find("_reikland_") then 
                        -- we're in Reikland!
                        if character:military_force():active_stance() == "MILITARY_FORCE_ACTIVE_STANCE_TYPE_CHANNELING" then
                            return true
                        end
                    end
                end
            end

            return false
        end

        if is_locked(vlad) then 
            --- TODO any army channeling in the Empire has a 50% chance of finding the Carstein Ring
            core:add_listener(
                "nag_vlad_unlock",
                "FactionTurnStart",
                function(context)
                    local faction = context:faction()
                    if not faction:name() == bdsm:get_faction_key() then return false end

                    --- return "any army in the empire, is channeling, and passes chance"
                    return any_armies(faction) and cm:random_number(100) >= 50
                end,
                function(context)
                    unlock(vlad._key)
                end,
                false
            )
        end

        if is_locked(luthor) then 
            --- TODO make contact with his faction
        end
    end

    -- do 
    --     -- track Arkhan techs
    --     ---@type tech_class
    --     local t1 = cc:get_object("TechObj", "nag_arkhan_event_1")
    --     ---@type tech_class
    --     local t2 = cc:get_object("TechObj", "nag_arkhan_event_2")
    --     ---@type tech_class
    --     local t3 = cc:get_object("TechObj", "nag_arkhan_event_3")

    --     if is_locked(t1) then 
    --         core:add_listener(
    --             "nag_arkhan_event_1",
    --             "BlackPyramidRaised",
    --             true,
    --             function(context)
    --                 unlock(t1._key)
    --             end,
    --             false
    --         )
    --     end

    --     if is_locked(t2) then 
    --         core:add_listener(
    --             "nag_arkhan_event_2",
    --             "CharacterCompletedBattle",
    --             function(context)
    --                 return (
    --                     cm:pending_battle_cache_faction_is_defender(bdsm:get_faction_key()) and cm:pending_battle_cache_culture_is_attacker("wh2_dlc09_tmb_tomb_kings")
    --                     or
    --                     cm:pending_battle_cache_culture_is_attacker(bdsm:get_faction_key()) and cm:pending_battle_cache_faction_is_defender("wh2_dlc09_tmb_tomb_kings")
    --                 )
    --             end,
    --             function(context)
    --                 local total = cm:get_saved_value("nag_arkhan_event_2") or 0
    --                 total = total + 1

    --                 if total == 10 then 
    --                     unlock(t2._key)
    --                     core:remove_listener("nag_arkhan_event_2")
    --                 else
    --                     cm:set_saved_value("nag_arkhan_event_2", total)

    --                     cc:set_techs_lock_state(
    --                         "nag_arkhan_event_2",
    --                         "locked",
    --                         string.format(effect.get_localised_string("tech_lock_nag_arkhan_event_2"), total),
    --                         bf
    --                     )
    --                 end
    --             end,
    --             true
    --         )
    --     end

    --     if is_locked(t3) then 
    --         core:add_listener(
    --             "nag_arkhan_event_3",
    --             "CharacterRankUp",
    --             function(context)
    --                 return context:character():character_subtype_key() == "nag_mortarch_arkhan" and context:character():rank() >= 10
    --             end,
    --             function(context)
    --                 unlock(t3._key)
    --             end,
    --             false
    --         )
    --     end
    -- end

    -- do 
    --     -- Luthor techs
    --     ---@type tech_class
    --     local t1 = cc:get_object("TechObj", "nag_luthor_event_1")
    --     ---@type tech_class
    --     local t2 = cc:get_object("TechObj", "nag_luthor_event_2")
    --     ---@type tech_class
    --     local t3 = cc:get_object("TechObj", "nag_luthor_event_3")

    --     --- Track them one at a time!
    --     if is_locked(t1) then
    --         core:add_listener(
    --             "nag_luthor_event_1",
    --             "CharacterCompletedBattle",
    --             function(context)
    --                 --- track the number of battles Luthor has had AT SEA or AGAINST LM
    --                 return context:character():character_subtype_key() == "nag_mortarch_luthor" and 
    --                     (
    --                         cm:pending_battle_cache_culture_is_involved("wh2_main_lzd_lizardmen") 
    --                         or
    --                         context:character():is_at_sea()
    --                 )
    --             end,
    --             function(context)
    --                 -- update the lock string if it's not enough ; otherwise, unlock it

    --                 local total = cm:get_saved_value("nag_luthor_event") or 0
    --                 total = total + 1

    --                 if total == 5 then
    --                     -- unlock
    --                     unlock(t1._key)
    --                     core:remove_listener("nag_luthor_event_1")
    --                 else
    --                     cm:set_saved_value("nag_luthor_event", total)

    --                     cc:set_techs_lock_state(
    --                         "nag_luthor_event_1", 
    --                         "locked", 
    --                         string.format(effect.get_localised_string("tech_lock_nag_luthor_event_1"), total), -- format the string so it says "Won Total / 5 battles"
    --                         bf
    --                     )
    --                 end
    --             end,
    --             true
    --         )
    --     end
        
    --     if is_locked(t2) then
    --         core:add_listener(
    --             "nag_luthor_event_2",
    --             "ResearchCompleted",
    --             function(context)
    --                 return context:technology() == "nag_luthor_event_1"
    --             end,
    --             function(context)
    --                 unlock(t2)
    --             end,
    --             false
    --         )    
    --     end
        
    --     if is_locked(t3) then
    --         core:add_listener(
    --             "nag_luthor_event_3",
    --             "ResearchCompleted",
    --             function(context)
    --                 return context:technology() == "nag_luthor_event_2"
    --             end,
    --             function(context)
    --                 unlock(t3)
    --             end,
    --             false
    --         )  
    --     end
    -- end
end


cm:add_first_tick_callback(
    function()
        local ok, err = pcall(function()
        init()
        end) if not ok then bdsm:errorf(err) end

        logf("morts lua OK")
    end
)



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