local lahmia_faction = "wh3_main_vmp_lahmian_sisterhood"

local levies ={
    "rhox_nagash_lahmia_emp_art_helstorm_rocket_battery",
    "rhox_nagash_lahmia_emp_art_helblaster_volley_gun",
    "rhox_nagash_lahmia_brt_cav_questing_knights_0",
    "rhox_nagash_lahmia_brt_cav_knights_of_the_realm",
    "rhox_nagash_lahmia_cth_inf_dragon_guard_0",
    "rhox_nagash_lahmia_cth_inf_dragon_guard_crossbowmen_0",
    "rhox_nagash_lahmia_ksl_veh_heavy_war_sled_0",
    "rhox_nagash_lahmia_ksl_cav_war_bear_riders_1",
    "rhox_nagash_lahmia_nor_mon_war_mammoth_1",
    "rhox_nagash_lahmia_nor_inf_marauder_berserkers_0",
    "rhox_nagash_lahmia_hef_inf_swordmasters_of_hoeth_0",
    "rhox_nagash_lahmia_hef_inf_white_lions_of_chrace_0",
    "rhox_nagash_lahmia_def_inf_shades_2",
    "rhox_nagash_lahmia_def_cav_cold_one_knights_1",
    "rhox_nagash_lahmia_wef_inf_waywatchers_0",
    "rhox_nagash_lahmia_wef_inf_wardancers_0",
    "rhox_nagash_lahmia_dwf_inf_dwarf_warrior_0",
    "rhox_nagash_lahmia_dwf_art_flame_cannon",
    "rhox_nagash_lahmia_chd_inf_chaos_dwarf_blunderbusses",
    "rhox_nagash_lahmia_chd_veh_dreadquake_mortar",
    "rhox_nagash_lahmia_ogr_inf_ironguts_0",
    "rhox_nagash_lahmia_ogr_cav_crushers_0"
}

local function rhox_nagash_lahmia_init_setting()
    local region_name = "wh3_main_combi_region_silver_pinnacle"

    if cm:get_campaign_name() == "cr_oldworld" then 
        region_name = "cr_oldworld_region_silver_pinnacle"
    end
    
    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        lahmia_faction,
        region_name,
        false,
        true,
        5
    )
    
    cm:faction_add_pooled_resource("wh3_main_vmp_lahmian_sisterhood", "vmp_blood_kiss", "faction", 1)
    
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    lahmia_faction,
    "wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_veh_black_coach,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_inf_zombie,wh_main_vmp_cav_black_knights_3,wh_main_vmp_mon_dire_wolves",
    region_name,
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
    
    
    for i=1,#levies do
        local faction = cm:get_faction(lahmia_faction)
        local unit = levies[i]
        cm:add_unit_to_faction_mercenary_pool(faction, unit, "rhox_nagash_lahmia_levy", 0, 0, 20, 0, "", "", "", true, unit)
    end

    
end






cm:add_first_tick_callback(
	function()
        if cm:get_campaign_name() ~= "main_warhammer" and cm:get_campaign_name() ~= "cr_oldworld" then 
            return--only for IE, IEE, and ToW
        end
        if not vfs.exists("script/frontend/mod/lah1_start.lua")then --don't do this if Dust's one is already
            pcall(function()
                mixer_set_faction_trait(lahmia_faction, "rhox_lahmia_neferata_lord_trait", true)
            end)
        end

		if cm:is_new_game() then
            rhox_nagash_lahmia_init_setting()
        end
	end
)
