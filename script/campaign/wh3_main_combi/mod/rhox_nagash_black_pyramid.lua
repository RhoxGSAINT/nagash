local nagash_faction = "mixer_nag_nagash"




local old_char_details = {
    rank = nil,
    traits = nil
}

function set_current_ritual(key, turns)
    out("Rhox Nagash: Ritual setted")
    cm:set_saved_value("nag_ritual_turns_remaining", turns)
    cm:set_saved_value("nag_ritual_current", key)
end



local function rhox_nagash_begin_bp_raise()
    local ritual_flag = cm:get_saved_value("nag_bp_raise")

    if ritual_flag and ritual_flag == true then
        return false
    end
    --out("Rhox Nagash: In the function")
    cm:complete_scripted_mission_objective(nagash_faction, "nag_bp_raise", "nag_bp_raise", true)
    
    --- wound Nagash Husk and replace it. 
    -------------------------
    
    local leader = cm:get_faction(nagash_faction):faction_leader()
    local leader_lookup = cm:char_lookup_str(leader)
    out("Rhox Nagash: leader lookup string is: "..leader_lookup)
    --cm:remove_unit_from_character(leader_lookup, "nag_nagash_husk")
    --cm:suppress_immortality(leader:family_member():command_queue_index(), true)
    --cm:set_character_cannot_disband(leader, false)
    --cm:replace_general_in_force(leader:military_force(), "nag_traitor_king")
    
    --cm:remove_unit_from_character(leader_lookup, "nag_nagash_husk")
    local character = leader
    
    
    old_char_details.rank = character:rank()
    old_char_details.traits = character:all_traits()
    
    
    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
    local f_cqi = leader:command_queue_index()
    core:add_listener(
        "KillThem",
        "CharacterConvalescedOrKilled",
        function(context) return context:character():command_queue_index() == f_cqi end,
        function(context)
            cm:stop_character_convalescing(f_cqi)
            out("Rhox Nagash: Inside this convales function")
        end,
        false
    )

    cm:kill_character(f_cqi, false, true)
    cm:wound_character(leader_lookup, 999)
    cm:callback(function() cm:disable_event_feed_events(false, "", "", "wh_event_category_character") end, 0.2);

    --- trigger mission for "survive"
    local mm = mission_manager:new(nagash_faction, "nag_bp_survive")
    mm:add_new_objective("SCRIPTED")
    mm:add_condition("script_key nag_bp_survive")
    mm:add_condition("override_text mission_text_text_nag_bp_survive_5")
    mm:add_payload("money 1000")
    mm:trigger()

    cm:set_scripted_mission_text("nag_bp_survive", "nag_bp_survive", "mission_text_text_nag_bp_survive_5")

    cm:remove_effect_bundle("rhox_nagash_avail", nagash_faction)
    --[[
    local duration = cm:create_new_custom_effect_bundle("rhox_nagash_ongoing");
    duration:add_effect("rhox_nagash_remaining_turns", "faction_to_faction_own_unseen", 5)
	duration:set_duration(0);
    cm:apply_custom_effect_bundle_to_faction(duration, cm:get_faction(nagash_faction))
    --]] --it didn't work out very well
    cm:apply_effect_bundle("rhox_nagash_ongoing", nagash_faction, 5)
    rhox_nagash_check_pyramid_status() --remove the highlight
    
    
    
    
    --- set a composite scene on the settlement
    local region = cm:get_region("wh3_main_combi_region_black_pyramid_of_nagash")
    local garrison_residence = region:garrison_residence();
    local garrison_residence_CQI = garrison_residence:command_queue_index();
    --cm:add_garrison_residence_vfx(garrison_residence_CQI, "scripted_effect5", true);
    -- Make the Black Pyramid fly!
	cm:override_building_chain_display("wh2_dlc09_special_settlement_pyramid_of_nagash_tmb", "wh2_dlc09_special_settlement_pyramid_of_nagash_floating")
	cm:override_building_chain_display("nag_outpost_special_blackpyramid", "wh2_dlc09_special_settlement_pyramid_of_nagash_floating")
    out("Rhox Nagash: Added flying scene to the settlement")
        
    --cm:add_garrison_residence_vfx(cm:get_region("wh3_main_combi_region_black_pyramid_of_nagash"):garrison_residence():command_queue_index(), "scripted_effect3", true);
    cm:add_scripted_composite_scene_to_settlement("nag_bp_raise", "wh2_dlc16_wef_healing_ritual", region, 0, 0, false, true, false)

    

    local num = cm:random_number(5, 4)


    for i = 1, num do
        local x,y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, "wh3_main_combi_region_black_pyramid_of_nagash", false, true, cm:random_number(24, 12))
        local region_key = "wh3_main_combi_region_black_pyramid_of_nagash"
        local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
        local invasion_key = "nag_bp_raise".."_invasion_"..x.."_"..y.."_"..i

        local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, "wh2_main_sc_skv_skaven",  19, 2, true, false)

        local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nagash_faction, x, y, true)
        local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})

        invasion_object:set_target("REGION", region_key, nagash_faction)
        invasion_object:add_aggro_radius(25, {nagash_faction}, 1)
        invasion_object:apply_effect("wh_main_bundle_military_upkeep_free_force_siege_attacker", 10);
        invasion_object:apply_effect("wh2_dlc11_bundle_immune_all_attrition", 10);

        invasion_object:start_invasion(true,true,false,false)
    end

    --- set a timer for "survive 5/10 turns" and then complete the mission above
    set_current_ritual("nag_bp_raise", 5)
    cm:set_saved_value("nag_bp_raise", true)
end



function rhox_nagash_add_black_pyramid_listener()
    core:add_listener(
        "NagashBlackPyramidMission",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return mission:mission_record_key() == "nag_nagash_capture_settlement_black_pyramid"
        end,
        function(context)
            cm:remove_effect_bundle("rhox_nagash_disabled", nagash_faction)
            cm:apply_effect_bundle("rhox_nagash_avail", nagash_faction, 0)
            local mm = mission_manager:new(nagash_faction, "nag_bp_raise")

            mm:add_new_objective("SCRIPTED")
            mm:add_condition("script_key nag_bp_raise")
            mm:add_condition("override_text mission_text_text_nag_bp_raise")
            mm:add_payload("money 1000")
            mm:trigger()

            cm:set_saved_value("bp_ritual_available", true)
            rhox_nagash_check_pyramid_status() --to highlight stuff
        end,
        false --you don't have to listen for it twice
    )
    
     core:add_listener(
        "bp_button_leftclick",
        "ComponentLClickUp",
        function (context)
            return context.string == "icon_effect" and cm:get_faction(nagash_faction):has_effect_bundle("rhox_nagash_avail")
        end,
        function ()
            cm:treasury_mod(nagash_faction, 1)
            rhox_nagash_begin_bp_raise()
        end,
        true
     )
    
    core:add_listener(
		"RegionFactionChangeEventBlyramidLostRitual",
		"RegionFactionChangeEvent",
		function(context)
			return context:previous_faction():name() == nagash_faction and cm:get_faction(nagash_faction):has_effect_bundle("rhox_nagash_ongoing")
		end,
		function(context)
            out("Rhox Nagash lost a region")
			local bp = cm:get_region("wh3_main_combi_region_black_pyramid_of_nagash")
            local key = nagash_faction

            
            if bp and (bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key) then
                cm:remove_scripted_composite_scene("nag_bp_raise")
                cm:set_saved_value("nag_bp_raise", false)
                rhox_kill_faction(nagash_faction)
            end
		end,
		true
    )
    
    core:add_listener(
		"RegionAbandonedWithBuildingEventBlyramidLostRitual",
		"RegionAbandonedWithBuildingEvent",
		function(context)
			return context:abandoning_faction():name() == nagash_faction and cm:get_faction(nagash_faction):has_effect_bundle("rhox_nagash_ongoing")
		end,
		function(context)
            out("Rhox Nagash abandoned region")
			local bp = cm:get_region("wh3_main_combi_region_black_pyramid_of_nagash")
            local key = nagash_faction

            if bp and (bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key) then 
                cm:remove_scripted_composite_scene("nag_bp_raise")
                cm:set_saved_value("nag_bp_raise", false)
                rhox_kill_faction(nagash_faction)
            end
            
		end,
		true
    )

    
    core:add_listener(
        "NagTurnStartTimer",
        "FactionTurnStart",
        function(context)
            local t = cm:get_saved_value("nag_ritual_current") 
            return context:faction():name() == nagash_faction and is_string(t) and t ~= "" -- and cm:get_faction(nagash_faction):has_effect_bundle("rhox_nagash_ongoing") --I don't think we need effect bundle condition for this
        end,
        function(context)
            local current_ritual = cm:get_saved_value("nag_ritual_current")

            local t = cm:get_saved_value("nag_ritual_turns_remaining") -1
            out("Rhox Nagash Current turn: "..t)
            if current_ritual == "nag_bp_raise" then
                if t == 0 then
                    -- Complete!
                    complete_bp_raise()
                else
                    cm:set_scripted_mission_text("nag_bp_survive", "nag_bp_survive", "mission_text_text_nag_bp_survive_"..t)
                    set_current_ritual(current_ritual, t)--complete will do the saved states so it goes to here
                end
            end

            
        end,
        true
    )
end



function complete_bp_raise()
    cm:complete_scripted_mission_objective(nagash_faction, "nag_bp_survive", "nag_bp_survive", true)
    cm:remove_scripted_composite_scene("nag_bp_raise")
    
    cm:set_saved_value("nag_bp_ritual_completed", true)
    
    cm:set_saved_value("nag_ritual_turns_remaining", 0)
    cm:set_saved_value("nag_ritual_current", "")
    

    cm:remove_scripted_composite_scene("nag_bp_raise")
    
    cm:remove_effect_bundle("rhox_nagash_ongoing", nagash_faction)
    cm:apply_effect_bundle("rhox_nagash_woke", nagash_faction, 0)
    rhox_nagash_check_pyramid_status()
    
    
    local units = {
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_cav_nehekhara_horsemen_0",
        "nag_carrion_riders",
        "nag_nagashi_guard",
        "nag_nagashi_guard_halb",
    }

    
    
    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local region_key = "wh3_main_combi_region_black_pyramid_of_nagash"
    local is_at_sea = false
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, is_at_sea, true, 5)
    local new_character = nil
    cm:create_force_with_general(
        -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
        nagash_faction,
        table.concat(units, ","),
        region_key,
        new_x,
        new_y,
        "general",
        "nag_nagash_boss",
        "names_name_1937224328",
        "",
        "",
        "",
        true,
        function(cqi)
            out("Rhox Nagash: Nagash Revived")
            new_character = cm:get_character_by_cqi(cqi)
            local new_char_lookup = cm:char_lookup_str(cqi)
            local traits_to_copy = old_char_details.traits
            if traits_to_copy then
                for i =1, #traits_to_copy do
                    
                    local trait_to_copy = traits_to_copy[i]
                    out("Rhox Nagash: Currently Copying: "..trait_to_copy)
                    cm:force_add_trait(new_char_lookup, trait_to_copy)
                    
                end
                cm:force_remove_trait(new_char_lookup, "rhox_nagash_uber_husk") --from uber husk event 
            end
            out("Rhox Nagash: Previous rank was: "..old_char_details.rank)
            cm:add_agent_experience(new_char_lookup,old_char_details.rank, true)

            cm:replenish_action_points(cm:char_lookup_str(new_character))
        end); 
    
    --[[
    local character = nagash_character
    local old_char_details = {
        mf = character:military_force(),
        rank = character:rank(),
        fm_cqi = character:family_member():command_queue_index(),
        character_details = character:character_details(),
        faction_key = character:faction():name(),
        character_forename = character:get_forename(),
        character_surname = character:get_surname(),
        parent_force = character:embedded_in_military_force(),
        subtype = character:character_subtype_key(),
        traits = character:all_traits(),
        ap = character:action_points_remaining_percent()
    }
    --]]
    
    

    
    
    local forename = common:get_localised_string("names_name_1937224328")
    cm:change_character_custom_name(new_character, forename, "","","")

    --later
    local sentinels_key = "wh2_dlc09_tmb_the_sentinels"
    local bp_key = "wh3_main_combi_region_black_pyramid_of_nagash"

    cm:set_saved_value("nagash_intro_completed", true)



    local nag_fact = nagash_faction
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_black_pyramid_of_nagash")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_nagashizzar")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_morgheim")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_lahmia")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_khemri")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_the_awakening")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_castle_drakenhof")
    cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_ancient_city_of_quintex")
    
    local mm = mission_manager:new(nag_fact, "nag_endgame_capture")
    mm:add_new_objective("OWN_N_REGIONS_INCLUDING");
    mm:add_condition("region wh3_main_combi_region_black_pyramid_of_nagash");
    mm:add_condition("region wh3_main_combi_region_nagashizzar");
    mm:add_condition("region wh3_main_combi_region_morgheim");
    mm:add_condition("region wh3_main_combi_region_lahmia");
    mm:add_condition("region wh3_main_combi_region_khemri");
    mm:add_condition("region wh3_main_combi_region_the_awakening");
    mm:add_condition("region wh3_main_combi_region_castle_drakenhof");
    mm:add_condition("region wh3_main_combi_region_ancient_city_of_quintex");
    mm:add_condition("total 8");
    mm:add_payload("money 1000");
    mm:trigger()



    local mm_1 = mission_manager:new(nag_fact, "nag_waprstone_mines")
    mm_1:add_new_objective("OWN_N_REGIONS_INCLUDING");
    mm_1:add_condition("region wh3_main_combi_region_karak_zorn");
    mm_1:add_condition("region wh3_main_combi_region_karak_azul");
    mm_1:add_condition("region wh3_main_combi_region_crookback_mountain");
    mm_1:add_condition("region wh3_main_combi_region_flayed_rock");
    mm_1:add_condition("region wh3_main_combi_region_karak_izor");
    mm_1:add_condition("region wh3_main_combi_region_skavenblight");
    mm_1:add_condition("region wh3_main_combi_region_desolation_of_drakenmoor");
    mm_1:add_condition("region wh3_main_combi_region_hell_pit");
    mm_1:add_condition("region wh3_main_combi_region_kraka_drak");
    mm_1:add_condition("region wh3_main_combi_region_the_frozen_city");
    mm_1:add_condition("region wh3_main_combi_region_ancient_city_of_quintex");
    mm_1:add_condition("total 11");
    mm_1:add_payload("money 1000");
    mm_1:trigger()

    -- kill the Sentinels completely
    local sentinels = cm:get_faction(sentinels_key)
    do
        local char_list = sentinels:character_list()
        for i = 0, char_list:num_items() -1  do
            local char = char_list:item_at(i)
            local cqi = char:command_queue_index()

            cm:kill_character_and_commanded_unit("character_cqi:"..cqi, true, false)
        end
    end
    -- ruin the BP and set it as untargetable 
    --cm:set_region_abandoned(bp_key)
    --cm:cai_disable_targeting_against_settlement("settlement:"..bp_key)
    
    cm:override_building_chain_display("wh2_dlc09_special_settlement_pyramid_of_nagash_tmb", "wh2_dlc09_tmb_settlement_major")
    cm:override_building_chain_display("nag_outpost_special_blackpyramid", "wh2_dlc09_tmb_settlement_major")

    --cm:force_religion_factors(bp_key, "wh_main_religion_undeath", 1)

    local faction_key = nagash_faction
    local faction_obj = cm:get_faction(faction_key)
    local faction_leader = faction_obj:faction_leader()
    local cqi = faction_leader:command_queue_index()

    -- spawn the bone daddy
    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        faction_key,
        bp_key,
        false,
        true,
        5
    )

    local ax,ay = cm:find_valid_spawn_location_for_character_from_position(
        faction_key,
        x,
        y,
        true,
        5
    )
    
    --core:trigger_custom_event("BlackPyramidRaised", {})
    
    

    --below create agent causes error at some point so be cautious
    cm:create_agent(
        faction_key,
        "spy",
        "nag_morghasts_archai",
        ax,
        ay,
        false,
        function(cqi)

        end
    )
    
    
    cm:callback(function() cm:disable_event_feed_events(false, "", "", "wh_event_category_character") end, 0.2);
    cm:apply_dilemma_diplomatic_bonus(nagash_faction, "wh2_dlc09_tmb_khemri", -6)
    cm:apply_dilemma_diplomatic_bonus(nagash_faction, "wh2_dlc09_tmb_khemri", -6)
    trigger_mortarch_unlock_missions()
end



--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_old_char_details", old_char_details, context, true)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			old_char_details = cm:load_named_value("rhox_nagash_old_char_details", old_char_details, context, true)
		end
	end
)
