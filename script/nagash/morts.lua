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
    local dist = self.pos.dist or 8

    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        bdsm:get_faction_key(),
        self.pos.region,
        is_sea,
        true,
        dist
    )

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
    self:trigger_event_missions()
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
    "nag_mortarch_arkhan_event_1",
    "nag_mortarch_arkhan_event_2",
    "nag_mortarch_arkhan_event_3",
    "nag_mortarch_luthor_event_1",
    "nag_mortarch_luthor_event_2",
    "nag_mortarch_luthor_event_3",
    "nag_mortarch_mannfred_event_1",
    "nag_mortarch_mannfred_event_2",
    "nag_mortarch_mannfred_event_3",
    "nag_mortarch_krell_event_1",
    "nag_mortarch_krell_event_2",
    "nag_mortarch_krell_event_3",
    "nag_mortarch_neferata_event_1",
    "nag_mortarch_neferata_event_2",
    "nag_mortarch_neferata_event_3",
    "nag_mortarch_vlad_event_1",
    "nag_mortarch_vlad_event_2",
    "nag_mortarch_vlad_event_3",

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
        -- nag_arkhan_unlock = true,
        nag_mortarch_luthor_unlock = true,
        nag_mortarch_mannfred_unlock = true,
        nag_mortarch_krell_unlock = true,
        nag_mortarch_neferata_unlock = true,
        nag_mortarch_vlad_unlock = true,
    }

    local filter = {faction=bdsm:get_faction_key()}

    cc:set_techs_lock_state("nag_mortarch_arkhan_unlock", "locked", effect.get_localised_string("tech_lock_nag_mortarch_arkhan_unlock"), filter)

    for tech_key,_ in pairs(mortarch_techs) do
        cc:set_techs_lock_state(tech_key, "locked", effect.get_localised_string("tech_lock_unavailable_bp"), filter)
    end
end

--- TODO consider multiple objectives per mission? maybe?
local function trigger_mortarch_unlock_missions()
    local key = bdsm:get_faction_key()

    logf("triggerin mort unlock missions")

    -- Luthor's mission (go to Vampire Coast)

    logf("pre luthor")
    do
        local mort = "nag_mortarch_luthor"
        cm:trigger_mission(key, mort.."_unlock", true, false, true)
    end
    
    logf("pre neffy")
    --- Neffy's mission
    do
        local mort = "nag_mortarch_neferata"
        
        local mm = mission_manager:new(key, mort.."_unlock")
        mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
        mm:add_condition("faction " .. key);
        mm:add_condition("building_level nag_outpost_special_nagashizzar_4");
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
        mm:add_new_objective("DESTROY_FACTION")
        mm:add_condition("faction wh_main_vmp_vampire_counts")
        mm:add_condition("confederation_valid false");

        mm:add_payload("money 1000")

        mm:trigger()
    end
end

local function mortarch_unlock_listeners()
    local vlib = get_vlib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    local filter = {faction=bdsm:get_faction_key()}
    local function unlock(key)
        --- TODO don't do the unlock if it's already unlocked
        cc:set_techs_lock_state(key, "unlocked", "", filter)

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

            -- --- Unlock the tech!
            -- cc:set_techs_lock_state(key, "unlocked", "", {faction=bdsm:get_faction_key()})
        end,
        true
    )

    core:add_listener(
    --- When an "unlock" tech is researched, spawn the related Morty.
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            return unlock_techs[context:technology()]
        end,
        function(context)
            local tech_key = context:technology()
            
            --- format "nag_mortarch_arkhan_unlock" to "nag_mortarch_arkhan"
            local mort_key = string.gsub(tech_key, "_unlock", "")

            -- get and spawn the mortarch
            bdsm:logf("Spawning %s", mort_key)

            --- TODO make sure mort:spawn() allows for spawning on map or spawning in pool
            local mort = bdsm:get_mortarch_with_key(mort_key)

            if mort_key ~= "nag_mortarch_arkhan" then
                mort:spawn()
            end

            if mort_key == "nag_mortarch_vlad" then
                kill_faction("wh_main_vmp_schwartzhafen")
            end
            if mort_key == "nag_mortarch_mannfred" then
                kill_faction("wh_main_vmp_vampire_counts")
            end
            if mort_key == "nag_mortarch_luthor" then
                kill_faction("wh2_dlc11_cst_vampire_coast")
            end


            --- BETA temp disable
            do return end

            --- lock each sub-tech
            for i = 1,3 do 
                local sub_tech_key = mort_key .. "_event"..i
                local str = effect.get_localised_string("tech_lock_"..sub_tech_key)

                if str:find("%%d") then
                    str = string.format(str, 0)
                end

                cc:set_techs_lock_state(sub_tech_key, "locked", str, {faction=bdsm:get_faction_key()})
            end
        end,
        true
    )
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
    local vlib = get_vlib()
    ---@type vlib_camp_counselor
    local cc = vlib:get_module("camp_counselor")

    if cm:is_new_game() then
        logf("Is new game!")
        lock_starting_techs()

        trigger_mortarch_unlock_missions()
    end

    mortarch_unlock_listeners()
    mortarch_event_listeners()

    if not cm:get_saved_value("nag_another_issue") then
        --- lock techs that have completed missions already
    end


    --- BETA temp disabled
    -- core:add_listener(
    --     "MortarchMissionsTrigger",
    --     "BlackPyramidRaised",
    --     true,
    --     function(context)
    --         -- Trigger all Mortarch Unlock missions when the BP is raised.
    --         --- TODO ^ wait a turn?
    --         trigger_mortarch_unlock_missions()
    --     end,
    --     false
    -- )
end

--- TODO do this only if player is Nag
cm:add_first_tick_callback(
    function()
        logf("morts lua start")
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