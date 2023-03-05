local nagash_faction = "mixer_nag_nagash"



local function rhox_nagash_init_setting()
    cm:transfer_region_to_faction("wh3_main_combi_region_nagashizzar", nagash_faction)
    cm:transfer_region_to_faction("wh3_main_combi_region_desolation_of_nagash", "wh3_main_skv_clan_carrion")
    
    local capital_region = cm:get_region("wh3_main_combi_region_nagashizzar")
    cm:heal_garrison(capital_region:cqi());
    
    cm:heal_garrison(cm:get_region("wh3_main_combi_region_desolation_of_nagash"):cqi());
    
    local faction = cm:get_faction(nagash_faction);
    local faction_leader_cqi = faction:faction_leader():command_queue_index();
    
    local nagash_character
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    nagash_faction,
    "wh2_dlc09_tmb_mon_necrosphinx_0,wh2_dlc09_tmb_mon_necrosphinx_ror,wh2_dlc09_tmb_mon_khemrian_warsphinx_0,wh2_dlc09_tmb_mon_heirotitan_0,wh_main_vmp_mon_terrorgheist,wh2_dlc11_cst_mon_rotting_leviathan_0, wh2_dlc11_cst_mon_necrofex_colossus_0,wh2_dlc09_tmb_art_casket_of_souls_0,wh2_dlc09_tmb_mon_ushabti_1,wh2_dlc09_tmb_mon_ushabti_ror,wh2_dlc09_tmb_mon_ushabti_0,wh2_dlc09_tmb_mon_tomb_scorpion_0,wh2_dlc11_cst_art_queen_bess,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_grave_guard_1,wh_dlc04_vmp_veh_mortis_engine_0",
    "wh3_main_combi_region_nagashizzar",
    853,
    400,
    "general",
    "nag_nagash_husk",
    "names_name_1937224327",
    "",
    "",
    "",
    true,
    function(cqi)
        nagash_character = cm:get_character_by_cqi(cqi)
    end);
    local forename = common:get_localised_string("names_name_1937224327")
    cm:change_character_custom_name(nagash_character, forename, "","","") --damn it's not working on faction leaders
    
    
    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
    cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), false);          
    cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true)
    
    local new_faction_leader = faction:faction_leader()
    cm:change_character_custom_name(new_faction_leader, common:get_localised_string("cultures_name_nag_nagash"), "", "", "")
    
    cm:force_declare_war(nagash_faction, "wh3_main_skv_clan_carrion", false, false)
    
    if cm:get_local_faction_name(true) == nagash_faction then
        local mm = mission_manager:new(nagash_faction, "nagash_intro_1")
        mm:set_mission_issuer("CLAN_ELDERS")
        mm:add_new_objective("ENGAGE_FORCE")
        mm:add_condition("cqi "..cm:get_faction("wh3_main_skv_clan_carrion"):faction_leader():military_force():command_queue_index())
        mm:add_condition("requires_victory")
        mm:add_payload("money 1000");
        mm:set_turn_limit(0);
        
        mm:set_should_whitelist(true)
        mm:trigger()
    end
    
    
end

local function add_nagash_listener()
    core:add_listener(
        "NagashIntroChain",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return string.find(mission:mission_record_key(), "nagash_intro_")
        end,
        function(context)
            out("In NagashIntroChain")
            local mission_key = context:mission():mission_record_key()
            local num = string.gsub(mission_key, "nagash_intro_", "")

            num = tonumber(num)

            local nag_fact = nagash_faction
            local nagash_interface = cm:get_faction(nagash_faction)
            ---------------------------------------------------------------------------Initial 5 quests
            if num == 5 then
                out("Rhox Nagash number 5")
                --- last mission, TP through
                cm:teleportation_network_close_node("rhox_nagash_combi_province_the_desolation_of_nagash");
                cm:teleportation_network_close_node("rhox_nagash_combi_province_barrier_idols");
                cm:unlock_technology(nag_fact, "nag_mortarch_arkhan_unlock")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_black_pyramid_of_nagash")
                cm:set_saved_value("nagash_intro_completed", true)
                core:remove_listener("NagashIntroChain")
        
                local mm = mission_manager:new(nag_fact, "nag_nagash_capture_settlement_black_pyramid")
                mm:add_new_objective("CAPTURE_REGIONS");
                mm:add_condition("region wh3_main_combi_region_black_pyramid_of_nagash");
                mm:add_payload("money 1000");
                mm:trigger()
    
                --[[
                --teleport Arkhan to Nagash's location
                local nagash_character = cm:get_faction(nagash_faction):faction_leader()
                local leader_x = nagash_character:logical_position_x();
                local leader_y = nagash_character:logical_position_y();

                local new_x, new_y = cm:find_valid_spawn_location_for_character_from_position("wh2_dlc09_tmb_followers_of_nagash", leader_x, leader_y, false, 5);
    
                local arkhan_character = cm:get_faction("wh2_dlc09_tmb_followers_of_nagash"):faction_leader()
                if arkhan_character:has_military_force() then --you can only teleport him when he has the army
                    out("Rhox Nagash: This guy has military force!")
                    cm:teleport_to(cm:char_lookup_str(arkhan_character), new_x, new_y)
                end
                --]]

            elseif num == 4 then 
                out("Rhox Nagash number 4")
                cm:trigger_mission(nag_fact, "nagash_intro_5", true, false)
                cm:teleportation_network_open_node("rhox_nagash_combi_province_the_desolation_of_nagash");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_barrier_idols");


            elseif num == 3 then
                out("Rhox Nagash number 3")             
                
                local mm = mission_manager:new(nag_fact, "nagash_intro_4")
                mm:add_new_objective("CAPTURE_REGIONS");
                mm:add_condition("region wh3_main_combi_region_desolation_of_nagash");
                mm:add_payload("money 1000");
                mm:trigger()
        
                
            elseif num == 2 then 
                -- trigger num 3
                cm:trigger_mission(nag_fact, "nagash_intro_3", true, false)
                out("Rhox Nagash number 2")
            elseif num == 1 then 
                out("Rhox Nagash number 1")
                -- trigger num 2
                cm:trigger_mission(nag_fact, "nagash_intro_2", true, false)
                
            end
    
    
    
        end,
        true
    )
    core:add_listener(
		"nagash_character_uses_nagash_rift",
		"TeleportationNetworkMoveCompleted",
		function(context)
			local character = context:character():character();
			if not character:is_null_interface() and context:success() and context:from_record():network_key() == "rhox_nagash_teleportation_network" then
				local faction = character:faction();
				
				return faction:is_human();
			end;
		end,
		function(context)
			local cached_x, cached_y, cached_d, cached_b, cached_h = cm:get_camera_position();
			local character = context:character():character();
			
			cm:scroll_camera_from_current(true, 1, {character:display_position_x(), character:display_position_y(), 13, cached_b, 10});
		end,
		true
	);
end



local function rhox_nagash_swith_skarbrand_arkhan()
    local ska_faction = "wh3_main_kho_exiles_of_khorne"
    local arkhan_faction = "wh2_dlc09_tmb_followers_of_nagash"
    
    cm:force_make_peace(ska_faction, "wh_main_grn_top_knotz")
    cm:force_make_peace(arkhan_faction, "wh2_main_brt_knights_of_the_flame")
    cm:force_declare_war(arkhan_faction, "wh_main_grn_top_knotz", false, false)
    cm:force_declare_war(ska_faction, "wh2_main_brt_knights_of_the_flame", false, false)
    
    
    cm:transfer_region_to_faction("wh3_main_combi_region_deff_gorge", arkhan_faction)
    cm:transfer_region_to_faction("wh3_main_combi_region_sorcerers_islands", ska_faction)
    cm:transfer_region_to_faction("wh3_main_combi_region_wizard_caliphs_palace", ska_faction)
    
    local loop_char_list = cm:get_faction(ska_faction):character_list()
				
    for i = 0, loop_char_list:num_items() - 1 do
        local looping = cm:char_lookup_str(loop_char_list:item_at(i))
        local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(ska_faction, "wh3_main_combi_region_wizard_caliphs_palace", false, true, 5)
        cm:teleport_to(looping, new_x, new_y)
    end
    
    
    
    local loop_char_list2 = cm:get_faction(arkhan_faction):character_list()
				
    for i = 0, loop_char_list2:num_items() - 1 do
        local looping = cm:char_lookup_str(loop_char_list2:item_at(i))
        local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(arkhan_faction, "wh3_main_combi_region_deff_gorge", false, true, 5)
        cm:teleport_to(looping, new_x, new_y)
    end
end


local ror_units = {
    "nag_bone_colossus",
    "nag_virion_plaguecart",
    "nag_revenants",
    "nag_shade_haunts",
};

local unit_count = 1
local rcp = 20
local max_units = 1
local murpt = 0.1
local frr = ""
local srr = ""
local trr = ""


cm:add_first_tick_callback(
	function()
        pcall(function()
            mixer_set_faction_trait("mixr_nag_nagash", "wh2_main_lord_trait_vmp_nagash", true)
        end)
		if cm:is_new_game() then
            local nagash_interface = cm:get_faction(nagash_faction)
            for i = 1, #ror_units do
                local ror_unit = ror_units[i]
                cm:add_unit_to_faction_mercenary_pool(nagash_interface, ror_unit, "renown", unit_count, rcp, max_units, murpt, frr, srr, trr, true, ror_unit)
            end


			rhox_nagash_init_setting()
            

            --add script lock to technologies
            cm:lock_technology(nagash_faction, "nag_mortarch_arkhan_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_luthor_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_mannfred_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_krell_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_neferata_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_vlad_unlock")
            if cm:get_local_faction_name(true) == nagash_faction then
                --rhox_nagash_swith_skarbrand_arkhan()
                cm:apply_effect_bundle("rhox_nagash_disabled", nagash_faction, 0)
                cm:set_saved_value("bp_ritual_available", false)
            end
		end

        if cm:get_local_faction_name(true) == nagash_faction then
			add_nagash_listener()
            mortarch_unlock_listeners()
            rhox_nagash_add_black_pyramid_listener()
            unlock_rites_listeners() --unlock rite with conditions
            rhox_nagash_add_teleport_listener() --add teleport network if quintax is controlled, and spawn Damon army when the player uses them.


            local parent_ui = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
            local result = core:get_or_create_component("rhox_nagash_black_pyramid_holder", "ui/campaign ui/black_pyramid_holder.twui.xml", parent_ui)
            if not result then
                script_error("Rhox Nagash: ".. "ERROR: could not create black pyramid ui component? How can this be?");
                return false;
            end;


            
            
		end
        
	end
)

cm:add_post_first_tick_callback(
    function()
        if cm:is_new_game() and #endgame.scenarios > 0 then --there is something in the end game scenarios
            for i=1, #endgame.scenarios do
                local value = endgame.scenarios[i]
                if value == "endgame_pyramid_of_nagash" then
                    table.remove(endgame.scenarios, i) --remove black pryramid
                    break
                end
            end
            --out("Rhox Nagash: end time check!")
            --endgame:choose_scenario() --this is for debug comment it out before releasing!



        end
    end
)




--------------------for pooled resource


local pooled_resource_key = "nag_warpstone"

local factions_with_pooled_resource = {
    ["mixer_nag_nagash"] = true
}

local function get_or_create_pooled_resource_ui()
    -- :root:hud_campaign:resources_bar_holder:resources_bar
    local resource_bar = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar")
    if not resource_bar then
        out("Could not find resource bar")
        return
    end
    local existing_prui = find_uicomponent(resource_bar, pooled_resource_key.."_holder")
    if existing_prui then
        out("Found existing pooled resource UI")
    else
        out("Creating a PR UI for "..pooled_resource_key)
        local prui = UIComponent(resource_bar:CreateComponent(pooled_resource_key.."_holder", "ui/campaign ui/warpstone_holder"))
        prui:SetContextObject(cco("CcoCampaignFaction", cm:get_local_faction_name(true)))
        prui:SetVisible(true)
    end
end

local function pooled_resource_check_callback()
    local local_faction = cm:get_local_faction_name(true)
    if factions_with_pooled_resource[local_faction] then
        local ok, err = pcall(get_or_create_pooled_resource_ui)
        if not ok then
            out("Error in pooled_resource_check_callback: "..tostring(err))
        end
    end
end

cm:add_first_tick_callback(function ()
    --[[core:progress_on_loading_screen_dismissed(function ()
        cm:real_callback(pooled_resource_check_callback, 50, "add_pooled_resource_ui")
    end)]]--
    cm:real_callback(pooled_resource_check_callback, 50, "add_pooled_resource_ui")
    core:add_listener(
        "rhox_nagash_pooled_resource_check",
        "FactionTurnStart",
        function (context)
            return context:faction():name() == cm:get_local_faction_name(true)
        end,
        pooled_resource_check_callback,
        true)
end)