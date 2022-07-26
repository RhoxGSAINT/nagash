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

---@class mortarch: mort_db
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

--- trigger each event mission for each Mortarch
function mortarch:trigger_event_missions()
    --- TODO temp disable
    do return end
    local events = self.events

    for i, event in ipairs(events) do 
        local key = event.key
        if key then 
            cm:trigger_mission(bdsm:get_faction_key(), key, true, false, true)
        else
            key = mortarch.subtype .. "_event_"..i
            local mm = mission_manager:new(bdsm:get_faction_key(), key)
            mm:add_new_objective(event.objective)

            for j,condition in ipairs(event.conditions) do 
                mm:add_condition(condition)
            end

            for j,payload in ipairs(event.payloads) do 
                mm:add_payload(payload)
            end

            mm:trigger()
        end
    end

    --- TODO set a lock state on each event tech saying "Complete [Mission Name]"
end

function mortarch:spawn()
    if self.acquired then return end
    
    -- local x,y = self.pos.x, self.pos.y
    local starting_army = self.starting_army
    local forename,surname = self.forename,self.surname
    local subtype = self.subtype

    local is_sea = self.pos.is_sea or false
    local dist = self.pos.dist or 20

    local region = cm:get_region(self.pos.region)

    local x,y = region:settlement():logical_position_x(), region:settlement():logical_position_y()
    ---@cast x number
    ---@cast y number

    local function test_coords()
        x = x + math.random(-5, 5)
        y = y + math.random(-5, 5)
        
        local tx,ty = cm:find_valid_spawn_location_for_character_from_position(
            bdsm:get_faction_key(),
            x,
            y,
            false,
            dist
        )

        if tx == -1 then
            return test_coords()
        end

        return tx,ty
    end

    test_coords()

    local faction_human_test = cm:get_faction(bdsm:get_faction_key())
    local xp_to_apply = bdsm:get_xp()

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
            if not faction_human_test:is_human() then
                cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force_special_character", cqi, 0, true);
            end

            cm:add_agent_experience("character_cqi:"..cqi, xp_to_apply, true)

            --- Spawn Isabella w/ Vlad
            if subtype == "nag_mortarch_vlad" then
                x = x + 1
                y = y + 1
                test_coords()

                cm:create_agent(
                    faction_key,
                    "dignitary",
                    "nag_mortarch_isabella",
                    x,
                    y,
                    false,
                    function(cqi)
            
                    end
                )  
            end
        end
    )

    self.acquired = true
    self:trigger_event_missions()
end

--- The XP used on the spawning of the Mortarchs / Big Nag.
function bdsm:get_xp()
    local last = cm:get_saved_value("nag_xp_boost")
    if not last then last = 3 end
    cm:set_saved_value("nag_xp_boost", last + 3)

    return last
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
    -- "nag_mortarch_arkhan_event_1",
    -- "nag_mortarch_arkhan_event_2",
    -- "nag_mortarch_arkhan_event_3",
    -- "nag_mortarch_luthor_event_1",
    -- "nag_mortarch_luthor_event_2",
    -- "nag_mortarch_luthor_event_3",
    -- "nag_mortarch_mannfred_event_1",
    -- "nag_mortarch_mannfred_event_2",
    -- "nag_mortarch_mannfred_event_3",
    -- "nag_mortarch_krell_event_1",
    -- "nag_mortarch_krell_event_2",
    -- "nag_mortarch_krell_event_3",
    -- "nag_mortarch_neferata_event_1",
    -- "nag_mortarch_neferata_event_2",
    -- "nag_mortarch_neferata_event_3",
    -- "nag_mortarch_vlad_event_1",
    -- "nag_mortarch_vlad_event_2",
    -- "nag_mortarch_vlad_event_3",

    "nag_mortarch_arkhan_unlock",
    "nag_mortarch_luthor_unlock",
    "nag_mortarch_mannfred_unlock",
    "nag_mortarch_krell_unlock",
    "nag_mortarch_neferata_unlock",
    "nag_mortarch_vlad_unlock",
}

--- First node for each Mortarch
local unlock_techs = {
    nag_mortarch_arkhan_unlock = true,
    nag_mortarch_luthor_unlock = true,
    nag_mortarch_mannfred_unlock = true,
    nag_mortarch_krell_unlock = true,
    nag_mortarch_neferata_unlock = true,
    nag_mortarch_vlad_unlock = true,
}

--- lock all Mortarch Unlock techs
local function lock_starting_techs()
    local vlib = get_vlib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    local mortarch_techs = {
        nag_mortarch_arkhan_unlock = true,
        nag_mortarch_luthor_unlock = true,
        nag_mortarch_mannfred_unlock = true,
        nag_mortarch_krell_unlock = true,
        nag_mortarch_neferata_unlock = true,
        nag_mortarch_vlad_unlock = true,
    }

    for tech_key,_ in pairs(mortarch_techs) do 
        cm:lock_technology(bdsm:get_faction_key(), tech_key)
    end
end

--- TODO consider multiple objectives per mission? maybe?
local function trigger_mortarch_unlock_missions()
    local key = bdsm:get_faction_key()
    local faction_handler = cm:get_faction(key)
    if faction_handler:is_human() then
        logf("triggerin mort unlock missions")

        -- Luthor's mission (go to Vampire Coast)   
        logf("pre luthor")
        do
            local mort = "nag_mortarch_luthor"
            cm:trigger_mission(key, mort.."_unlock", true, false, true)
            -- local mm = mission_manager:new(key, mort.."_unlock")
            -- mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
            -- mm:add_condition("faction " .. key);
            -- mm:add_condition("building_level nag_outpost_main_port_1");
            -- mm:add_condition("total 1");
            
            -- mm:add_payload("money 1000")
            -- mm:trigger()
        end
        
        logf("pre neffy")
        --- Neffy's mission
        do
            local mort = "nag_mortarch_neferata"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
            mm:add_condition("faction " .. key);
            mm:add_condition("building_level nag_outpost_special_nagashizzar_3");
            mm:add_condition("total 1");
            
            mm:add_payload("money 1000")
            mm:trigger()
        end
        
        
        logf("pre krell")
        --- Krell's mission
        do
            local mort = "nag_mortarch_krell"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("KILL_X_ENTITIES")
            mm:add_condition("total 5000")
            mm:add_payload("money 1000")
            
            mm:trigger()
        end
        
        logf("pre vlad")
        -- Vlad's mission (spend time Channeling near Altdorf)
        do
            local mort = "nag_mortarch_vlad"
            cm:trigger_mission(key, mort.."_unlock", true, false, true)
        end
        
        logf("pre manny")
        --- TODO needs a failsafe?
        --- Manny's mission
        do 
            local mort = "nag_mortarch_mannfred"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("OWN_N_REGIONS_INCLUDING");
            mm:add_condition("region " .. "wh_main_eastern_sylvania_castle_drakenhof");
            -- mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
            -- mm:add_condition("faction " .. key);
            -- mm:add_condition("building_level nag_bpyramid_main_obelisk_2");
            mm:add_condition("total 1");
            -- mm:add_new_objective("DESTROY_FACTION")
            -- mm:add_condition("faction wh_main_vmp_vampire_counts")
            -- mm:add_condition("confederation_valid false");

            mm:add_payload("money 1000")

            mm:trigger()
        end
    else
        -- bdsm:logf("not spawning mostarch nag_mortarch_arkhan")
        -- local mort = bdsm:get_mortarch_with_key("nag_mortarch_arkhan")
        -- mort:spawn()
        -- bdsm:logf(" finished spawn mostarch nag_mortarch_arkhan")
    end
end

local function mortarch_unlock_listeners()
    local vlib = get_vlib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    local filter = {faction=bdsm:get_faction_key()}
    local function unlock(key)
        --- TODO don't do the unlock if it's already unlocked
        -- cc:set_techs_lock_state(key, "unlocked", "", filter)

        cm:unlock_technology(bdsm:get_faction_key(), key)

        cm:show_message_event(
            bdsm:get_faction_key(),
            "event_feed_strings_text_nag_tech_unlocked",
            "technologies_onscreen_name_"..key,
            "technologies_short_description_"..key,
            true,
            902,
            nil,
            nil,
            true
        )
    end

    --- Unlock the related technology after the mission is completed!
    core:add_listener(
        "MortarchUnlock",
        "MissionSucceeded",
        function(context)
            local key = context:mission():mission_record_key()
            return key:find("_mortarch_") and key:find("_unlock")
        end,
        function(context)
            local key = context:mission():mission_record_key()
            unlock(key)
            -- if key == "nag_mortarch_vlad_unlock" then
            --     local fact = bdsm:get_faction()
            --     local nagash = bdsm:get_faction_leader()
            --     local nag_mf = nagash:military_force()
            --     x = 691,
            --     y = 419
            --     cm:spawn_agent_at_military_force(fact, nag_mf, "dignitary", "nag_mortarch_isabella")
            -- end
            -- --- Unlock the tech!
            -- cc:set_techs_lock_state(key, "unlocked", "", {faction=bdsm:get_faction_key()})
        end,
        true
    )
    -- bdsm:logf("Tech researched "%s", context:technology()")
    core:add_listener(
    --- When an "unlock" tech is researched, spawn the related Morty.
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            -- bdsm:logf("Tech researched %s", context:technology())
            return unlock_techs[context:technology()]
        end,
        function(context)
            local tech_key = context:technology()
            
            --- format "nag_mortarch_arkhan_unlock" to "nag_mortarch_arkhan"
            local mort_key = string.gsub(tech_key, "_unlock", "")
            --- format "nag_mortarch_arkhan_unlock" to "nag_arkhan"
            local mort_clean_key = string.gsub(mort_key, "nag_mortarch", "nag")
            -- get and spawn the mortarch
            -- bdsm:logf("Spawning mort_key %s", mort_key)
            -- bdsm:logf("Spawning mort_clean_key %s", mort_clean_key)

            --- TODO change how this works for AI/played Mortarch and AI/played Nagash
            local function offer_choice(faction_key, forced)
                local faction = cm:get_faction(faction_key)
                if faction and not faction:is_dead() then
                    if not faction:is_human()  then
                        local chance = cm:random_number(100)
                        if chance >= 50 or forced then
                            -- Perma forced vassalge
                            cm:force_make_vassal(bdsm:get_faction_key(), faction_key)
                            cm:force_diplomacy("faction:"..bdsm:get_faction_key(), "faction:"..faction_key, "break vassal", false, false, true, false)
                            cm:force_diplomacy("faction:"..bdsm:get_faction_key(), "faction:"..faction_key, "war", false, false, true, false)
                        else
                            --- Perma forced war
                            cm:force_declare_war(bdsm:get_faction_key(), faction_key, false, true)
                            cm:force_diplomacy("faction:"..bdsm:get_faction_key(), "faction:"..faction_key, "peace", false, false, true, false)
                            cm:force_diplomacy("faction:"..bdsm:get_faction_key(), "faction:"..faction_key, "all", false, false, true, false)
                        end
                    else
                        --- TODO offer a Dilemma to the played Mortarch faction
                    end
                end
            end
            
            --- TODO make sure mort:spawn() allows for spawning on map or spawning in pool
            local mort = bdsm:get_mortarch_with_key(mort_key)

            -- If Nagash is AI, offer a choice to the factions to either ally or war
            if not bdsm:get_faction():is_human() then
                if mort_key == "nag_mortarch_arkhan" then
                    offer_choice("wh2_dlc09_tmb_followers_of_nagash", true)
                elseif mort_key == "nag_mortarch_vlad" then
                    offer_choice("wh_main_vmp_schwartzhafen")
                elseif mort_key == "nag_mortarch_mannfred" then
                    offer_choice("wh_main_vmp_vampire_counts")
                elseif mort_key == "nag_mortarch_luthor" then
                    offer_choice("wh2_dlc11_cst_vampire_coast")
                else
                    --- Spawn Krell / Neffy!
                    mort:spawn()
                end
            else
                mort:spawn()

                if mort_key == "nag_mortarch_arkhan" then
                    kill_faction("wh2_dlc09_tmb_followers_of_nagash")
                elseif mort_key == "nag_mortarch_vlad" then
                    kill_faction("wh_main_vmp_schwartzhafen")
                elseif mort_key == "nag_mortarch_mannfred" then
                    kill_faction("wh_main_vmp_vampire_counts")
                elseif mort_key == "nag_mortarch_luthor" then
                    kill_faction("wh2_dlc11_cst_vampire_coast")
                end
            end
        end,
        true
    )


    local faction_human_test = cm:get_faction(bdsm:get_faction_key())
    if not faction_human_test:is_human() then
        core:add_listener(
            "Nagash_AI_research_T800",
            "FactionTurnStart",
            function(context)
                -- bdsm:logf("Nagash_AI_research_T800 faction %s", context:faction():name())
                return context:faction():name() == bdsm:get_faction_key()
            end,
            function(context)
                -- cm:treasury_mod(bdsm:get_faction_key(), 2000)
                -- bdsm:logf("Nagash_AI_research_T800 faction %s turn %d ", context:faction():name(), cm:turn_number())
                if cm:turn_number() == 20  then
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_arkhan")
                    mort:spawn()
                    kill_faction("wh2_dlc09_tmb_followers_of_nagash")   
                end

                if cm:turn_number() == 40 then
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_krell")
                    mort:spawn()
                end
                
                if cm:turn_number() == 60 then
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_neferata")
                    mort:spawn()
                end

                if cm:turn_number() == 80 then
                    kill_faction("wh_main_vmp_schwartzhafen")  
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_vlad")
                    mort:spawn()  
                    local faction_key = bdsm:get_faction_key()
                    local faction_obj = cm:get_faction(faction_key)
                    local faction_leader = faction_obj:faction_leader()
                    local cqi = faction_leader:command_queue_index()
                    local ax,ay = cm:find_valid_spawn_location_for_character_from_position(
                                        faction_key,
                                        691,
                                        419,
                                        true,
                                        5
                                    )   
                    cm:create_agent(
                                        faction_key,
                                        "dignitary",
                                        "nag_mortarch_isabella",
                                        ax,
                                        ay,
                                        false,
                                        function(cqi)
                                
                                        end
                                    )  
                                        -- local fact = bdsm:get_faction()
                                        -- local nagash = bdsm:get_faction_leader()
                                        -- local nag_mf = nagash:military_force()
                                        -- x = 691,
                                        -- y = 419
                                        -- cm:spawn_agent_at_military_force(fact, nag_mf, "dignitary", "nag_mortarch_isabella")
        
                end
                if cm:turn_number() == 100 then
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_mannfred")
                    mort:spawn()
                    kill_faction("wh_main_vmp_vampire_counts")  
                end
                
                if cm:turn_number() == 120 then
                    local mort = bdsm:get_mortarch_with_key("nag_mortarch_luthor")
                    mort:spawn()
                    kill_faction("wh2_dlc11_cst_vampire_coast")   
                end
                
                 
            end,
            true
        )
    end
end


local function mortarch_event_listeners()
    -- tech filter
    local bf = {faction=bdsm:get_faction_key()}
    local nk = bdsm:get_faction_key()

    local vlib = get_vandy_lib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    ---@param tech_obj tech_class
    local function is_locked(tech_obj)
        return tech_obj and tech_obj:get_lock_state(nk) >= 2
    end

    ---@return tech_class
    local function get_tech(key)
        return cc:get_object("TechObj", key)
    end

    --- TODO urgent vvvv
    --- TODO only trigger these listeners if the tech ISN'T RESEARCHED and the MORTARCH IS SPAWNED. Use a saved value?
    --- NEXT ^^^^^

    core:add_listener(
        "nag_mortarch_arkhan_event_1",
        "BlackPyramidRaised",
        true,
        function(context)
            cm:complete_scripted_mission_objective("nag_mortarch_arkhan_event_1", "nag_mortarch_arkhan_event_1", true)
        end,
        false
    )

    core:add_listener(
        "nag_mortarch_luthor_event_1",
        "CharacterCompletedBattle",
        function(context)
            --- track the number of battles Luthor has had AT SEA or AGAINST LM
            return context:character():character_subtype_key() == "nag_mortarch_luthor" and
                (
                    cm:pending_battle_cache_culture_is_involved("wh2_main_lzd_lizardmen")
                    or
                    context:character():is_at_sea()
            )
        end,
        function(context)
            -- update the lock string if it's not enough ; otherwise, unlock it

            local total = cm:get_saved_value("nag_mortarch_luthor_event_1") or 0
            total = total + 1

            if total == 5 then
                -- unlock
                -- unlock("nag_mortarch_luthor_event_1")
                core:remove_listener("nag_mortarch_luthor_event_1")
                cm:complete_scripted_mission_objective("nag_mortarch_luthor_event_1", "nag_mortarch_luthor_event_1", true)
            else
                cm:set_saved_value("nag_mortarch_luthor_event_1", total)
                cm:set_scripted_mission_text("nag_mortarch_luthor_event_1", "nag_mortarch_luthor_event_1", "nag_mortarch_luthor_event_1_"..total)
            end
        end,
        true
    )

    core:add_listener(
        "nag_mortarch_krell_event_2",
        "CharacterCompletedBattle",
        function(context)
            return context:character():character_subtype_key() == "nag_mortarch_krell" and context:character():won_battle()
        end,
        function(context)
            local num_won = cm:get_saved_value("nag_mortarch_krell_event_2") or 0
            num_won = num_won + 1

            if num_won >= 5 then
                cm:complete_scripted_mission_objective("nag_mortarch_krell_event_2", "nag_mortarch_krell_event_2", true)
            else
                cm:set_saved_value("nag_mortarch_krell_event_2", num_won)
                cm:set_scripted_mission_text("nag_mortarch_krell_event_2", "nag_mortarch_krell_event_2", "nag_mortarch_krell_event_2_"..num_won)
            end
        end,
        true
    )

    ---@param faction_obj FACTION_SCRIPT_INTERFACE
    local function num_guards(faction_obj)
        local character_list = faction_obj:character_list()
        local t = 0

        for i = 0, character_list:num_items() -1 do
            local character = character_list:item_at(i)

            if character:has_military_force() then 
                local unit_list = character:military_force():unit_list()
                for j = 0, unit_list:num_items() -1 do 
                    local unit = unit_list:item_at(j)
                    local key = unit:unit_key()
                    if key:find("_guard") and not key:find("depth_guard") then
                        t = t + 1
                    end
                end
            end
        end

        return t
    end

    core:add_listener(
        "nag_mortarch_krell_event_3",
        "FactionTurnStart",
        function(context)
            local f = context:faction()
            return f:name() == bdsm:get_faction_key()
        end,
        function(context)
            local total = num_guards(context:faction())

            if total >= 10 then
                cm:complete_scripted_mission_objective("nag_mortarch_krell_event_3", "nag_mortarch_krell_event_3", true)
            else
                cm:set_scripted_mission_text("nag_mortarch_krell_event_3", "nag_mortarch_krell_event_3", "nag_mortarch_krell_event_3_"..total)
            end
        end,
        true
    )

    --- TODO
    -- --- Neferata events
    -- do 
    --     local t1 = get_tech("nag_mortarch_neferata_event_1")
    --     local t2 = get_tech("nag_mortarch_neferata_event_2")
    --     local t3 = get_tech("nag_mortarch_neferata_event_3")

    --     if is_locked(t1) then 
    --         --- TODO something like "destroy Court of Lybaras", but flavored as "kill TK" or some shit, idk
    --         -- core:add_listener(
    --         --     "nag_mortarch_neferata_event_1",
    --         -- )
    --     end

    --     if is_locked(t2) then 
    --         --- Own Lahmia
    --         --- TODO test if already owned!
    --         core:add_listener(
    --             "nag_mortarch_neferata_event_2",
    --             "RegionFactionChangeEvent",
    --             function(context)
    --                 local reg = context:region()
    --                 local own = reg:owning_faction()
    --                 return reg:name() == "wh2_main_devils_backbone_lahmia" and not own:is_null_interface() and own:name() == bdsm:get_faction_key()
    --             end,
    --             function(context)
    --                 unlock(t2._key)
    --             end,
    --             false
    --         )
    --     end

    --     if is_locked(t3) then 
    --         --- Reach level X
    --         core:add_listener(
    --             "nag_mortarch_neferata_event_3",
    --             "CharacterRankUp",
    --             function(context)
    --                 local c = context:character()
    --                 return c:character_subtype("nag_mortarch_neferata") and c:rank() >= 10
    --             end,
    --             function(context)
    --                 unlock(t3)
    --             end,
    --             false
    --         )
    --     end
    -- end

    
end
    
--- TODO VLIB tech stuff
--- TODO start up the listeners for each tech event.
--- TODO track values and shit.
local function init()
    logf("Mort init!")

    if cm:is_new_game() then
        logf("Is new game!")
        lock_starting_techs()
    end


    mortarch_unlock_listeners()
    mortarch_event_listeners()

    core:add_listener(
        "MortarchMissionsTrigger",
        "BlackPyramidRaised",
        true,
        function(context)
            -- Trigger all Mortarch Unlock missions when the BP is raised.
            --- TODO ^ wait a turn?
            --- TODO inform Player w/ event feed
            trigger_mortarch_unlock_missions()
        end,
        false
    )
end

--- A debug check to see if the player has researched a mort tech but doesn't have that character in their faction
local function morts_error_fix()
    local f = bdsm:get_faction()
    local cl = f:character_list()

    --- loop through all mortarch types
    ---@param mort mortarch
    for i,mort in ipairs(bdsm._mortarchs) do 
        local t = mort.tech_key

        -- test if we have this technology researched!
        if f:has_technology(t) then
            -- test if we have this character!
            local has = false
            for j = 0, cl:num_items() -1 do 
                local c = cl:item_at(j)

                -- we do have this character!
                if c:character_subtype_key() == mort.subtype then
                    has = true
                end
            end

            -- if we have the tech and don't have the character, spawn them!
            if not has then
                mort:spawn()
            end
        end
    end
end

--- TODO do this only if player is Nag
cm:add_first_tick_callback(
    function()
        init()

        --- Backwards compat for Mort spawn fail stuff
        if not cm:get_saved_value("bdsm_morts_error_fix") then
            if not cm:is_new_game() then
                morts_error_fix()
            end
            cm:set_saved_value("bdsm_morts_error_fix", true)
        end
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