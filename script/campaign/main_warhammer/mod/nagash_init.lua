---@class bdsm
local bdsm = get_bdsm()

local mct
local vlib = get_vlib()

local log,logf,err,errf = vlib:get_log_functions("[nag_init]")

if is_function(get_mct) then
    mct = get_mct()
end


local mission_short_victory = [[
    
 		mission
		{
			victory_type wh_main_victory_type_short;
			key wh_main_short_victory;
			issuer CLAN_ELDERS;
			primary_objectives_and_payload
			{
				objective
				{
					type OWN_N_REGIONS_INCLUDING;
					total 5;
					region wh2_main_the_broken_teeth_nagashizar;
					region wh2_main_marshes_of_madness_morgheim;
					region wh2_main_devils_backbone_lahmia;
					region wh2_main_land_of_the_dead_khemri;
                    region wh_main_eastern_sylvania_castle_drakenhof;
				}

				payload
				{
					game_victory;
				}
			}
		}
    ]]
    

local mission_long_victory = 
    [[
 		mission
		{
			victory_type wh_main_victory_type_long;
			key wh_main_long_victory;
			issuer CLAN_ELDERS;
			primary_objectives_and_payload
			{                
                objective
				{
					type RESEARCH_N_TECHS_INCLUDING;
					total 1;
					technology nag_nagash_ultimate;
				}
				payload
				{
					game_victory;
				}
			}
		}
    ]]


local faction_key = bdsm._faction_key

local function init_listeners()
    --- TODO test that this prevents ogre camp spawning!
    Ogre_Camp.ogre_camp_cooldowns[faction_key] = 999

    cm:remove_effect_bundle("wh_main_effect_religion_undeath_public_order", faction_key)
    
    --- Whenever a settlement is occupied by Nagash, auto-set the level to 1.
    -- core:add_listener(
    --     "NagashWimp",
    --     "RegionFactionChangeEvent",
    --     function(context)
    --         local reg = context:region()
    --         local daddy = reg:owning_faction()
    --         return not reg:is_abandoned() and not daddy:is_null_interface() and daddy:name() == faction_key --and reg:settlement():primary_slot():building():building_level() > 1
    --     end,
    --     function (context)
    --         local reg = context:region()
    --         cm:instantly_set_settlement_primary_slot_level(reg:settlement(), 1)
    --         self:logf("++++++NagashWimp !")
    --         if reg:name() == bdsm._bp_key then 
    --             self:logf("++++++NagashWimp trigger !")
    --             --- trigger the "Raise the BP!" mission
    --             bdsm:trigger_bp_raise_mission()
    --             bdsm:check_bp_button()
    --         end
    --     end,
    --     true
    -- )

    ---@param building_name string
    local function is_warpstone_mine(building_name)
        local mines = {
            nag_outpost_special_nagashizzar_2 = true,
            nag_outpost_special_nagashizzar_4 = true,
            nag_outpost_primary_warpstone_1 = true,
        }
        return mines[building_name]
    end

    ---@param region REGION_SCRIPT_INTERFACE
    local function has_warpstone_mine(region)
        local mines = {
            nag_outpost_special_nagashizzar_2 = true,
            nag_outpost_special_nagashizzar_3 = true,
            nag_outpost_special_nagashizzar_4 = true,
            nag_outpost_special_nagashizzar_5 = true,
            nag_outpost_primary_warpstone_1 = true,
        }

        for building_key,_ in pairs(mines) do
            if region:building_exists(building_key) then return true end
        end
        return false
    end

    local function has_bad_undeath_corruption_bundle(region)
        local bundles = {
            "wh_main_bundle_region_vampiric_corruption_attrition_bad",
            "wh_main_bundle_region_vampiric_corruption_low",
            "wh_main_bundle_region_vampiric_corruption_medium",
            "wh_main_bundle_region_vampiric_corruption_high",
        }
    end

    ---@param region REGION_SCRIPT_INTERFACE
    local function adjust_attrition(region)
        local bundles = {
            "wh_main_bundle_region_vampiric_corruption_low_good",
            "wh_main_bundle_region_vampiric_corruption_medium_good",
            "wh_main_bundle_region_vampiric_corruption_high_good"
        }

        local bad_bundles = {
            "wh_main_bundle_region_vampiric_corruption_low",
            "wh_main_bundle_region_vampiric_corruption_medium",
            "wh_main_bundle_region_vampiric_corruption_high"
        }

        local good_attrition = "wh_main_bundle_region_vampiric_corruption_attrition"
        local bad_attrition = "wh_main_bundle_region_vampiric_corruption_attrition_bad"

        local vampiric = region:religion_proportion("wh_main_religion_undeath");
        local name = region:name()

        remove_corruption_effect_bundles(name, bad_bundles)
    
        local game = cm:get_game_interface()
        game:remove_effect_bundle_from_region(bad_attrition, name);

        if vampiric >= 0.01 then
            game:apply_effect_bundle_to_region(good_attrition, name, 0)
            apply_corruption_effect_bundle(vampiric, name, bundles)
        else
            remove_corruption_effect_bundles(name, bundles);
        end
    end

    --- do corruption bundle stuff
    core:add_listener(
        "NagashCorruption",
        "ScriptEventHumanFactionTurnStart",
        function(context)
            return context:faction():name() == bdsm:get_faction_key()
        end,
        function(context)

            local faction = context:faction()
            local region_list = faction:region_list()

            for i = 0, region_list:num_items() -1 do
                adjust_attrition(region_list:item_at(i))
            end
        end,
        true
    )

    local function determine_attrition(region)
        local majority = region:majority_religion();
        
        if majority == vampiric_corruption_string then
            adjust_attrition(region);
        end;
    end;
    
    core:add_listener(
		"NagCorruptionOccupied",
		"GarrisonOccupiedEvent",
		function(context)
            return context:garrison_residence():region():owning_faction():name() == bdsm:get_faction_key()
        end,
		function(context)
			local region = context:garrison_residence():region();
			
			determine_attrition(region);
		end,
		true
	);

    core:add_listener(
        "NagashWarpstone",
        "RegionTurnStart",
        function(context)
            local region = context:region()
            local owner = region:owning_faction()
            return not owner:is_null_interface() and owner:name() == bdsm:get_faction_key()
        end,
        function(context)
            local region = context:region()

            if has_warpstone_mine(region) then
                --- TODO calculate chance
                local chance = 20
    
                local val = cm:random_number(100)
                if val <= chance then
                --if true then
                    cm:faction_add_pooled_resource(bdsm:get_faction_key(), "nag_warpstone", "nag_warpstone_buildings", 1)
                end
                
                --- TODO "soak up" mechanic, ie. apply a permanent bundle to a region when it's gotten enough Warpstone.
            end
        end,
        true
    )

    --- TODO find a better way of doing this.
    --- disable negative vampire traits
    core:add_listener(
        "NagRemoveBadTraits",
        "CharacterTurnStart",
        function(context)
           local c = context:character()
           return c:faction():name() == bdsm:get_faction_key() and c:has_trait("wh2_main_trait_corrupted_vampire")
        end,
        function(context)
            cm:force_remove_trait("character_cqi:"..context:character():command_queue_index(), "wh2_main_trait_corrupted_vampire")
        end,
        true
    )

    --- Give Traitor Kings a horde!
    core:add_listener(
        "NagTraitorKing",
        "CharacterCreated",
        function(context)
            local c = context:character()
            return c:faction():name() == bdsm:get_faction_key() and c:character_subtype_key() == "nag_traitor_king" and c:has_military_force()
        end,
        function(context)
            --- Provide horde IF NOT a Shambling Horde (how to detect????)
            local c = context:character()
            local mf = c:military_force()

            --- This should prevent Shambling Horde conversions (there's no Shambling Horde -> Traitor King Horde direct conversion)
            cm:convert_force_to_type(mf, "nag_traitor_horde")
        end,
        true
    )

    -- core:add_listener(
    --     "CharacterReplacingGeneralNagTraitorKing",
    --     "CharacterReplacingGeneral",
    --     function(context)
    --         local c = context:character()
    --         return c:faction():name() == bdsm:get_faction_key() and c:character_subtype_key() == "nag_traitor_king" and c:has_military_force()
    --     end,
    --     function(context)
    --         --- Provide horde IF NOT a Shambling Horde (how to detect????)
    --         local c = context:character()
    --         local mf = c:military_force()

    --         --- This should prevent Shambling Horde conversions (there's no Shambling Horde -> Traitor King Horde direct conversion)
    --         cm:convert_force_to_type(mf, "nag_traitor_horde")
    --     end,
    --     true
    -- )
    

    --- implement the DoW on all living for Nagash's skill
    core:add_listener(
        "NagDoW",
        "CharacterSkillPointAllocated",
        function(context)
            return context:skill_point_spent_on() == "nag_skill_personal_nagash_world_at_peace"
        end,
        function(context)
            -- local char = context:character()
            local exempt = {
                nag_nagash = true,
                wh2_dlc09_tmb_tomb_kings = true,
                wh2_dlc11_cst_vampire_coast = true,
                wh_main_vmp_vampire_counts = true,
                wh2_main_rogue = true,
                --- TODO any modded subcultures? Hi OvN
            }

            ---@type FACTION_LIST_SCRIPT_INTERFACE
            local faction_list = cm:model():world():faction_list()
            local nag_key = bdsm:get_faction_key()

            for i = 0, faction_list:num_items() -1 do
                local f = faction_list:item_at(i)
                local f_key = f:name()
                local cult = f:culture()

                if not exempt[cult] and not f:is_human() and not f:is_dead() then
                    cm:force_declare_war(nag_key, f_key, false, false, false)
                end
            end
        end,
        false
    )


    --- TODO the listeners for ritual interactive markers
    core:add_listener(
        "NagTurnStartTimer",
        "FactionTurnStart",
        function(context)
            local t = cm:get_saved_value("nag_ritual_turns_remaining") 
            return context:faction():name() == bdsm:get_faction_key() and not is_nil(t) and t > 0
        end,
        function(context)            
            -- TODO interupt ritual
            -- self:logf("++++++NagTurnStartTimer 01 cast!")
			-- local bp = cm:get_region(bdsm._bp_key)
            -- local key = bdsm:get_faction_key()
            -- if bp or bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key then 
            --     self:logf("++++++NagTurnStartTimer 02 cast!")
            --     cm:remove_scripted_composite_scene("nag_bp_raise")
    
            --     cm:set_saved_value("nag_bp_ritual_completed", true)

            --     self:reset_current_ritual()

            --     cm:remove_scripted_composite_scene("nag_bp_raise")
            -- end
            -- self:logf("++++++NagTurnStartTimer 01 cast!")

            local current_ritual = cm:get_saved_value("nag_ritual_current")

            local t = cm:get_saved_value("nag_ritual_turns_remaining") -1
            --- TODO if it's been X turns **AND** all of the invading armies have been dealt with
            if t == 0 then 
                -- Complete!
                if current_ritual == "nag_bp_raise" then
                    bdsm:complete_bp_raise()
                end
            end

            cm:set_saved_value("nag_ritual_turns_remaining", t)
        end,
        true
    )

    -- core:add_listener(
	-- 	"RegionFactionChangeEventBlyramidLostRitual",
	-- 	"RegionFactionChangeEvent",
	-- 	function(context)
	-- 		return context:previous_faction():subculture() == "nag_nagash"
	-- 	end,
	-- 	function(context)
    --         self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 01 cast!")
	-- 		local bp = cm:get_region(bdsm._bp_key)
    --         local key = bdsm:get_faction_key()
    --         if bp or bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key then 
    --             self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 02 cast!")
    --             self:reset_current_ritual()
    --             cm:remove_scripted_composite_scene("nag_bp_raise")
    --         end
    --         self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 01 cast!")
	-- 	end,
	-- 	true
    -- )
    

    -- core:add_listener(
	-- 	"RegionAbandonedWithBuildingEventBlyramidLostRitual",
	-- 	"RegionAbandonedWithBuildingEvent",
	-- 	function(context)
	-- 		return true
	-- 	end,
	-- 	function(context)
    --         self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 01 cast!")
	-- 		local bp = cm:get_region(bdsm._bp_key)
    --         local key = bdsm:get_faction_key()
    --         if bp or bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key then 
    --             self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 02 cast!")
    --             self:reset_current_ritual()
    --             cm:remove_scripted_composite_scene("nag_bp_raise")
    --         end
    --         self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 01 cast!")
	-- 	end,
	-- 	true
    -- )

        

    -- trigger battle
    -- core:add_listener(
    --     "nag_ritual_army_interaction",
    --     "nag_ritual_army_interaction",
    --     true,
    --     ---@param context {stored_table:table}
    --     function(context)
	-- 		local marker_ref = context.stored_table.marker_ref
	-- 		local instance_ref = context.stored_table.instance_ref

    --         local interacting_character = context:character()
    --         local force_cqi = interacting_character:military_force():command_queue_index()
    --         local region = interacting_character:region()

    --         --- TODO pick invasion army based on the region
    --         local invasion_faction_key = "wh2_dlc13_skv_skaven_invasion"
    --         local invasion_faction = cm:get_faction(invasion_faction_key)

    --         --- TODO scale up army size based on turns since this marker spawned
    --         --- TODO scale up the army modifier based on how many rituals have been completed
    --         Forced_Battle_Manager:trigger_forced_battle_with_generated_army(
    --             force_cqi,
    --             invasion_faction_key,
    --             invasion_faction:subculture(),
    --             cm:random_number(15, 12),
    --             1,
    --             false,
    --             false,
    --             true,
    --             nil,
    --             nil,
    --             nil,
    --             nil,
    --             nil,
    --             nil
    --         )
    --     end,
    --     true
    -- )

        --[[
        on_battle_trigger_callback =
		function(self, character, marker_info) 
			Worldroots:set_up_generic_encounter_forced_battle(character, "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven", true, 8 + cm:turn_number(),"wh2_main_skv_grey_seer_plague")		
		end,
		on_expiry_callback = 
		function(self, marker_info) 
			local naggaroth_glade = Worldroots:get_forest_by_string("witchwood")
			local instance_ref = marker_info.instance_ref
			local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)
			Worldroots:trigger_invasion(naggaroth_glade, x, y, 16)
		end
    ]]

    -- TODO trigger invasion on expiry
    -- core:add_listener(
    --     "nag_ritual_army_expired",
    --     "nag_ritual_army_expired",
    --     true,
    --     function(context)
    --         local marker_ref = context.stored_table.marker_ref
	-- 		local instance_ref = context.stored_table.instance_ref
    --         local nag_key = bdsm:get_faction_key()

	-- 		--use the instance ref to grab the x-y-coords so we know where to spawn
	-- 		local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

    --         --- TODO trigger invasion!
    --         local current_ritual = cm:get_saved_value("nag_ritual_current")

    --         --- TODO use the same stuff for "force size / faction / units / etc." between invasion and generated battle
    --         --- TODO get all these details in a nicer fashion
    --         --- TODO target BP
    --         if current_ritual == "nag_bp_raise" then
    --             local region_key = bdsm._bp_key
    --             local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
    --             local invasion_key = current_ritual.."_invasion_"..x.."_"..y

    --             local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, "wh2_main_sc_skv_skaven",  19, 2, true, false)

    --             local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nag_key, x, y, true)
    --             local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})
    --             -- invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
    --             invasion_object:set_target("REGION", region_key, nag_key)
    --             invasion_object:add_aggro_radius(25, {nag_key}, 1)
    --             invasion_object:start_invasion(true,true,false,false)
    --         end
    --     end,
    --     true
    -- )

    -- local function tech_army_spawner(context, location_key)
    --     local marker_ref = context.stored_table.marker_ref
    --     local instance_ref = context.stored_table.instance_ref
    --     local nag_key = bdsm:get_faction_key()

    --     --use the instance ref to grab the x-y-coords so we know where to spawn
    --     local x,y = Interactive_Marker_Manager:get_coords_from_instance_ref(instance_ref)

    --     --- TODO trigger invasion!
    --     -- local current_ritual = cm:get_saved_value("nag_ritual_current")

    --     --- TODO use the same stuff for "force size / faction / units / etc." between invasion and generated battle
    --     --- TODO get all these details in a nicer fashion
    --     --- TODO target BP
    --     bdsm:logf("++++++tech invasions tech_army_spawner 02 !")
    --     -- current_ritual = location_key
    --     local region_key = location_key
    --     local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
    --     local invasion_key = "nag_bp_raise".."_invasion_"..x.."_"..y

    --     local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, "wh2_main_sc_skv_skaven",  19, 5, true, false)

    --     local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nag_key, x, y, true)
    --     local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})
    --     -- invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
    --     invasion_object:set_target("REGION", region_key, nag_key)
    --     invasion_object:add_aggro_radius(25, {nag_key}, 1)
    --     invasion_object:start_invasion(true,true,false,false)
    --     bdsm:logf("++++++tech invasions region_key = %s;nag_key = %s", region_key, nag_key)
    --     bdsm:logf("++++++tech invasions tech_army_spawner 03 !")
    -- end

    -- return context:technology() == "nag_nagash_ultimate" or
    -- context:technology() == "nag_location_nagashizzar"
    -- context:technology() == "nag_location_mourkain"
    -- context:technology() == "nag_location_lahmia"
    -- context:technology() == "nag_location_khemri"
    -- context:technology() == "nag_location_awakening"
    -- context:technology() == "nag_location_drakenhof"
    -- context:technology() == "nag_location_quintex"

    -- wh2_main_great_mortis_delta_black_pyramid_of_nagash = false,
    -- wh2_main_the_broken_teeth_nagashizar = false,
    -- wh2_main_marshes_of_madness_morgheim = false,
    -- wh2_main_devils_backbone_lahmia = false,
    -- wh2_main_land_of_the_dead_khemri = false,
    -- wh2_main_vampire_coast_the_awakening = false,
    -- wh_main_eastern_sylvania_castle_drakenhof = false,
    -- wh2_main_titan_peaks_ancient_city_of_quintex = false,

    -- core:add_listener(
    --     "nag_location_nagashizzar",
    --     "nag_location_nagashizzar",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_the_broken_teeth_nagashizar 01 !")
    --         tech_army_spawner(context, "wh2_main_the_broken_teeth_nagashizar")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_mourkain",
    --     "nag_location_mourkain",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_marshes_of_madness_morgheim 01 !")
    --         tech_army_spawner(context, "wh2_main_marshes_of_madness_morgheim")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_lahmia",
    --     "nag_location_lahmia",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_devils_backbone_lahmia 01 !")
    --         tech_army_spawner(context, "wh2_main_devils_backbone_lahmia")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_khemri",
    --     "nag_location_khemri",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_land_of_the_dead_khemri 01 !")
    --         tech_army_spawner(context, "wh2_main_land_of_the_dead_khemri")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_awakening",
    --     "nag_location_awakening",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_vampire_coast_the_awakening 01 !")
    --         tech_army_spawner(context, "wh2_main_vampire_coast_the_awakening")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_drakenhof",
    --     "nag_location_drakenhof",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh_main_eastern_sylvania_castle_drakenhof 01 !")
    --         tech_army_spawner(context, "wh_main_eastern_sylvania_castle_drakenhof")
    --     end,
    --     true
    -- )

    -- core:add_listener(
    --     "nag_location_quintex",
    --     "nag_location_quintex",
    --     true,
    --     function(context)
    --         bdsm:logf("++++++tech invasions wh2_main_titan_peaks_ancient_city_of_quintex 01 !")
    --         tech_army_spawner(context, "wh2_main_titan_peaks_ancient_city_of_quintex")
    --     end,
    --     true
    -- )

    --- handle the mission chains!
    if not cm:get_saved_value("nagash_intro_completed") then
        core:add_listener(
            "NagashIntroChain",
            "MissionSucceeded",
            function(context)
                local mission = context:mission()
                bdsm:logf("Completed %s", mission:mission_record_key())
                return string.find(mission:mission_record_key(), "nagash_intro_")
            end,
            ---@param context MissionSucceeded
            function(context)
                bdsm:logf("In NagashIntroChain")
                local mission_key = context:mission():mission_record_key()
                local num = string.gsub(mission_key, "nagash_intro_", "")

                bdsm:logf("Mission num is %s", num)
                num = tonumber(num)
                bdsm:logf("Tonumber is %d", num)

                local nag_fact = bdsm:get_faction_key()

                bdsm:logf("???")
                
                if num == 5 then
                    bdsm:logf("5")
                    --- last mission, TP through
                    local nag = bdsm:get_faction_leader()
                    local nag_str = cm:char_lookup_str(nag)
                    
                    local nx,ny = cm:find_valid_spawn_location_for_character_from_position(bdsm:get_faction_key(), 718, 187, true, 3)
                    bdsm:logf("Trying to find a spot to spawn from (%d, %d); pos is (%d, %d); char str is %s", 718, 187, nx, ny, nag_str)

                    --- TP to the other side
                    cm:callback(function()
                        cm:teleport_to(
                            nag_str,
                            nx,
                            ny,
                            false
                        )

                        cm:zero_action_points(nag_str)
                        
                        -- local mort = bdsm:get_mortarch_with_key("nag_mortarch_arkhan")
                        -- mort:spawn()
                        -- kill_faction("wh2_dlc09_tmb_followers_of_nagash")
                        -- local filter = {faction=bdsm:get_faction_key()}
                        -- cc:set_techs_lock_state("nag_mortarch_arkhan_unlock", "unlocked", "", filter)
                        cm:unlock_technology(nag_fact, "nag_mortarch_arkhan_unlock")
                        -- mort:spawn()

                        --- make BP visible
                        cm:make_region_visible_in_shroud(nag_fact, "wh2_main_great_mortis_delta_black_pyramid_of_nagash")

                        --- TODO trigger Chapter 1 objectives (include BP conquer and raising as a part of that)
                        local mm = mission_manager:new(nag_fact, "nag_nagash_capture_settlement_black_pyramid")
                        mm:add_new_objective("CAPTURE_REGIONS");
                        mm:add_condition("region wh2_main_great_mortis_delta_black_pyramid_of_nagash");
                        mm:add_payload("money 1000");
                        mm:trigger()
                    end, 0.5)


                    --- remove interactive marker
                    cm:remove_interactable_campaign_marker("nagash_intro_5")

                    cm:set_saved_value("nagash_intro_completed", true)
                    core:remove_listener("NagashIntroChain")
                elseif num == 4 then 
                    bdsm:logf("4")
                    -- trigger num 5
                    cm:trigger_mission(nag_fact, "nagash_intro_5", true, false, true)
                    
                    --- spawn an interactive marker!
                    cm:add_interactable_campaign_marker(
                        "nagash_intro_5",
                        "nagash_intro_5",
                        800, -- ALSO SET IN cdir_events_mission_option_junctions!!!
                        206, -- DITTO
                        5,
                        nag_fact,
                        ""
                    )
                elseif num == 3 then
                    bdsm:logf("3")
                    -- trigger num 4
                    local mm = mission_manager:new(nag_fact, "nagash_intro_4")
                    mm:add_new_objective("CAPTURE_REGIONS");
                    mm:add_condition("region wh2_main_the_broken_teeth_desolation_of_nagash");
                    mm:add_payload("money 1000");
                    mm:trigger()
                    
                elseif num == 2 then 
                    bdsm:logf("2")
                    -- trigger num 3
                    local mm = mission_manager:new(nag_fact, "nagash_intro_3")
                    mm:add_new_objective("OWN_N_UNITS");
                    
                    mm:add_condition("total 15");
                    mm:add_payload("money 1000");
                    mm:trigger()
                elseif num == 1 then 
                    bdsm:logf("Creating new mission 2")
                    -- trigger num 2
                    local mm = mission_manager:new(nag_fact, "nagash_intro_2")

                    mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
                    mm:add_condition("faction " .. nag_fact);
                    mm:add_condition("building_level nag_outpost_special_nagashizzar_2");
                    mm:add_condition("total 1");
                    mm:add_payload("money 1000")
                    mm:trigger()
                end
            end,
            true
        )
    end
end

local function init()
    if cm:is_new_game() then
        cm:set_saved_value("nagash_stuff_loaded", false)
    end
    if cm:get_saved_value("nagash_stuff_loaded") then
        cm:set_saved_value("nagash_stuff_loaded", false)
        bdsm:setup_structures()        
    end
    local faction = cm:get_faction(faction_key)
    --- player only
    if not faction:is_human() then return end

    bdsm:setup_rites()

    local option = "intro"
    local all_morts = false
    -- if mct then
    --     option = mct:get_mod_by_key("nagash_dev"):get_option_by_key("start_choice"):get_finalized_setting()
    --     all_morts = mct:get_mod_by_key("nagash_dev"):get_option_by_key("morts"):get_finalized_setting()
    -- end

    local f = nil

    bdsm:logf("Starting the intro, first_turn_begin()!")
        f = bdsm.first_turn_begin
    -- if option == "intro" then
    --     bdsm:logf("Starting the intro, first_turn_begin()!")
    --     f = bdsm.first_turn_begin
    -- elseif option == "bp" then
    --     bdsm:logf("Starting the intro, mid_game_start()!")
    --     f = bdsm.mid_game_start
    -- elseif option == "domination" then
    --     bdsm:logf("Starting the intro, world_domination_start()!")
    --     f = bdsm.world_domination_start
    -- end

    if cm:is_new_game() then
        -- spawn units, set buildings, etc.
        -- intro battle triggered after the rest
        local ok, err = pcall(function()
            bdsm:logf("Starting first turn")
            f(bdsm)
            bdsm:logf("Ending first turn")
        end) if not ok then bdsm:errorf(err) end
        
        cm:trigger_custom_mission_from_string(faction_key, mission_short_victory);
        cm:trigger_custom_mission_from_string(faction_key, mission_long_victory);
        -- if all_morts then
        --     bdsm:all_morts()
        -- end
    else
        -- if option == "intro" then
            if not cm:get_saved_value("bdsm_first_turn_completed") and cm:get_saved_value("bdsm_intro_battle_completed") then
                -- trigger post-battle stuff
                bdsm:post_intro_battle()
            end
        -- end
    end

    local ok, err = pcall(function()
        init_listeners()
    end) if not ok then bdsm:errorf(err) end

    vlib:load_module("armies", bdsm._default_module_path)
end

cm:add_first_tick_callback(
    function()
        local ok, err = pcall(function()
        init()

        --- BETA
        if not cm:get_saved_value("vandy_fix_pls") then 
            cm:transfer_region_to_faction(bdsm._izar_key, bdsm._faction_key)
            cm:set_saved_value("vandy_fix_pls", true)
        end
        end) if not ok then bdsm:errorf(err) end

        bdsm:logf("nagash_init OK")
    end
)