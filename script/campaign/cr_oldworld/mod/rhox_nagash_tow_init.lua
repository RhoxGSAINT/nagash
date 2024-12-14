local nagash_faction = "mixer_nag_nagash"

local nagash_ai_bonus =100
local enable_ai_nagash=true
local nagash_ai_level_bonus =30
local nagash_ai_building_tier =5

local nagash_block_ai_research = 15;

local function rhox_nagash_init_setting()

    if not enable_ai_nagash and cm:get_faction(nagash_faction):is_human()==false then
        rhox_kill_faction(nagash_faction)
        return; --kill AI Nagash and return
    end

    cm:transfer_region_to_faction("cr_oldworld_region_nagashizzar", nagash_faction)
    
    local capital_region = cm:get_region("cr_oldworld_region_nagashizzar")
    cm:heal_garrison(capital_region:cqi());
    

    local nagash_character_type = "nag_nagash_husk"
    
    cm:override_building_chain_display("wh_main_VAMPIRES_settlement_major", "cr_nag_special_settlement_nagashizzar", "cr_oldworld_region_nagashizzar")
    
    
    
    local faction = cm:get_faction(nagash_faction);
    local faction_leader_cqi = faction:faction_leader():command_queue_index();
    
    
    local x, y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, "cr_oldworld_region_nagashizzar", false, true, 10)
    
    local nagash_character
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    nagash_faction,
    "nag_bone_golems,nag_nagashi_guard,nag_nagashi_guard,nag_vanilla_vmp_mon_fell_bats,nag_vanilla_vmp_mon_fell_bats,nag_skeleton_reaper,nag_vanilla_tmb_inf_skeleton_warriors_0,nag_vanilla_tmb_inf_skeleton_spearmen_0,nag_vanilla_tmb_inf_skeleton_spearmen_0,nag_vanilla_tmb_inf_skeleton_spearmen_0,nag_bone_thrower",
    "cr_oldworld_region_nagashizzar",
    x,
    y,
    "general",
    nagash_character_type,
    "names_name_1937224327",
    "",
    "",
    "",
    true,
    function(cqi)
        cm:callback(
			function()
				nagash_character = cm:get_character_by_cqi(cqi)
                local forename = common:get_localised_string("names_name_1937224327")
                cm:change_character_custom_name(nagash_character, forename, "","","") --damn it's not working on faction leaders
			end,
			0.5
		)
		cm:set_character_unique(cm:char_lookup_str(cqi),true)
    end);
    
    local ax,ay = cm:find_valid_spawn_location_for_character_from_position(
        nagash_faction,
        x,
        y,
        true,
        5
    )

    local wight = cm:create_agent(
        nagash_faction,
        "champion",
        "nag_wight_king",
        ax,
        ay,
        false,
        function(cqi)

        end
    )
    if wight then
        cm:replenish_action_points(cm:char_lookup_str(wight))
    end
    
    cm:unlock_ritual(faction, "nag_winds", 0)--he don't have access to this building

   
    
    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
    cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), false);          
    cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true)
    cm:callback(function() cm:disable_event_feed_events(false, "", "", "wh_event_category_character") end, 0.2);
    --local new_faction_leader = faction:faction_leader()
    --cm:change_character_custom_name(new_faction_leader, common:get_localised_string("cultures_name_nag_nagash"), "", "", "")
    
  

    
    
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_followers_of_nagash", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh_main_vmp_schwartzhafen", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh_main_vmp_vampire_counts", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc11_cst_vampire_coast", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("mixer_vmp_helsnicht", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh3_main_vmp_lahmian_sisterhood", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("ovn_tmb_dread_king", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("mixer_vmp_wailing_conclave", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_the_sentinels", "rhox_nagash_influence", "other", -100) --you have to defeat them
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_exiles_of_nehek", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_khemri", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_lybaras", "rhox_nagash_influence", "other", -100)
    
    

    
    cm:callback(
        function() 
            if cm:get_faction(nagash_faction):is_human() then

            
            
                local faction_name = nagash_faction
                local title = "event_feed_strings_text_wh2_scripted_event_how_they_play_title";
                local primary_detail = "factions_screen_name_" .. faction_name;
                local secondary_detail = "event_feed_strings_text_nag_scripted_event_how_they_play_nagasha_tow";
                local pic = 905;--campaign_group_member_criteria_values
                
                cm:show_message_event(
                    faction_name,
                    title,
                    primary_detail,
                    secondary_detail,
                    true,
                    pic
                );
            
            end
        end, 
    3);

end






local ror_units = {
    "nag_blood_beasts",
    "nag_bone_colossus",
    "nag_virion_plaguecart",
    "nag_revenants",
    "nag_shade_haunts",
    "nag_burning_dead",
    "nag_throne_guard",
    "nag_doom_knights",
    "nag_druthor"
};

local unit_count = 1
local rcp = 20
local max_units = 1
local murpt = 0.1
local frr = ""
local srr = ""
local trr = ""


-----------------this is to remove the black pyramid and vampire rise endgame
cm:add_post_first_tick_callback(
    function()
        cm:callback(
			function()
                if #endgame.scenarios > 0 then --there is something in the end game scenarios
                    for i=1, #endgame.scenarios do
                        local value = endgame.scenarios[i]
                        if value == "endgame_pyramid_of_nagash" or value == "endgame_vampires_rise" then
                            table.remove(endgame.scenarios, i) --remove black pryramid or vampire rise
                            break
                        end
                    end
                end
            end,
			2
		)
    end
)



RHOX_NAGASH_BASIC_RAISE_DEAD_UNITS={
    nag_vanilla_tmb_inf_skeleton_archers_0= {1, 20, 2},
    nag_vanilla_tmb_inf_skeleton_spearmen_0= {1, 20, 2},
    nag_vanilla_tmb_inf_skeleton_warriors_0= {1, 20, 2},
    nag_vanilla_tmb_inf_nehekhara_warriors_0= {0, 10, 1},
    nag_vanilla_vmp_inf_skeleton_warriors_0= {0, 20, 0},
    nag_vanilla_vmp_inf_skeleton_warriors_1= {0, 20, 0},
    nag_vanilla_vmp_inf_zombie= {2, 35, 3},
    nag_vanilla_vmp_mon_dire_wolves= {0, 20, 2},
    nag_vanilla_vmp_mon_fell_bats= {1, 20, 2}
}


cm:add_first_tick_callback(
	function()
        pcall(function()
            mixer_set_faction_trait(nagash_faction, "wh2_main_lord_trait_vmp_nagash", true)
        end)

		if cm:is_new_game() then
            local nagash_interface = cm:get_faction(nagash_faction)
            for i = 1, #ror_units do
                local ror_unit = ror_units[i]
                cm:add_unit_to_faction_mercenary_pool(nagash_interface, ror_unit, "renown", unit_count, rcp, max_units, murpt, frr, srr, trr, true, ror_unit)
            end


			rhox_nagash_init_setting()
			
			

            
            --They're not doing it in TOW so just call it
            cm:lock_technology(nagash_faction, "nag_mortarch_arkhan_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_luthor_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_mannfred_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_krell_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_neferata_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_vlad_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_dieter_unlock")
            cm:lock_technology(nagash_faction, "nag_mortarch_dk_unlock")
            cm:lock_technology(nagash_faction, "nag_nagash_ultimate")

            
            local region_list = cm:model():world():region_manager():region_list()
            for i=0,region_list:num_items()-1 do
                local region= region_list:item_at(i)
                for key, unit in pairs(RHOX_NAGASH_BASIC_RAISE_DEAD_UNITS) do
                    cm:add_unit_to_province_mercenary_pool(region, key, "raise_dead", unit[1], unit[2], unit[3], 1, "", "mixer_nag_nagash", "", false, "wh_main_vmp_province_pool")
                end
            end
            
		end
		
		if cm:get_local_faction_name(true) == nagash_faction then --ui things should go here
            local parent_ui = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
            local result2 = core:get_or_create_component("rhox_nagash_warpstone_holder", "ui/campaign ui/warpstone_holder.twui.xml", parent_ui)
            if not result2 then
                script_error("Rhox Nagash: ".. "ERROR: could not create warpstone ui component? How can this be?");
                return false;
            end;
		end

        if cm:get_faction(nagash_faction):is_human() then
            rhox_nagash_rites_listeners() --unlock rite with conditions, and rite complete script
		end
		
	end
)


core:add_listener(
    "rhox_nagash_AI_bonus_mct_initialize",
    "MctInitialized",
    true,
    function(context)
        -- get the mct object
        local mct = context:mct()

        local my_mod = mct:get_mod_by_key("nag_nagash")

        -- get the mct_option object with the key "do_thing_one", and its finalized setting - reading from the mct_settings.lua file if it's a new game, or the save game file if it isn't
        local nag_ai_bonus = my_mod:get_option_by_key("nag_ai_bonus")
        nagash_ai_bonus = nag_ai_bonus:get_finalized_setting()
        
        local nag_enable_ai = my_mod:get_option_by_key("enable_ai_nagash")
        enable_ai_nagash = nag_enable_ai:get_finalized_setting()
        
        local nag_ai_level_bonus = my_mod:get_option_by_key("nag_ai_level_bonus")
        nagash_ai_level_bonus = nag_ai_level_bonus:get_finalized_setting()
        
        local nag_ai_building_tier = my_mod:get_option_by_key("nag_ai_building_tier")
        nagash_ai_building_tier = nag_ai_building_tier:get_finalized_setting()
    
        local nag_block_ai_research = my_mod:get_option_by_key("nag_block_ai_research")
        nagash_block_ai_research = nag_block_ai_research:get_finalized_setting()

        
    end,
    true
)


