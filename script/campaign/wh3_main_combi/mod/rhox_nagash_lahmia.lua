local lahmia_faction = "wh3_main_vmp_lahmian_sisterhood"

local function rhox_nagash_lahmia_init_setting()
    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        lahmia_faction,
        "wh3_main_combi_region_silver_pinnacle",
        false,
        true,
        5
    )
    
    cm:faction_add_pooled_resource("wh3_main_vmp_lahmian_sisterhood", "vmp_blood_kiss", "faction", 1)
    
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    lahmia_faction,
    "wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_veh_black_coach,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_cav_black_knights_3,wh_main_vmp_mon_dire_wolves",
    "wh3_main_combi_region_silver_pinnacle",
    x,
    y,
    "general",
    "nag_lahmia_neferata",
    "names_name_1937224339",
    "",
    "",
    "",
    true,
    function(cqi)
        
        cm:callback(
			function()
				local neferata_character = cm:get_character_by_cqi(cqi)
                local forename = common:get_localised_string("names_name_1937224339")
                cm:change_character_custom_name(neferata_character, forename, "","","") --damn it's not working on faction leaders
			end,
			0.5
		)
    end);
    local agent_x, agent_y = cm:find_valid_spawn_location_for_character_from_position(faction:name(), x, y, false, 5);
    cm:create_agent(lahmia_faction, "dignitary", "wh_dlc05_vmp_vampire_shadow", agent_x, agent_y);       
    
    
    

    
end



cm:add_first_tick_callback(
	function()
        --[[
        if not vfs.exists("script/frontend/mod/lah1_start.lua")then --use this function if you don't want to run a code if the player is using Dust's mod
        end
        --]]
        pcall(function()
            mixer_set_faction_trait(lahmia_faction, "rhox_lahmia_neferata_lord_trait", true)
        end)
        

		if cm:is_new_game() then
            rhox_nagash_lahmia_init_setting()
        end
	end
)
