-------------------------------------------------------------------------------------------------
------------------------------------------- KEY INFO --------------------------------------------
-------------------------------------------------------------------------------------------------
-- Nagash mod
-- blyramid rising
-- Attacker
-------------------------------------------------------------------------------------------------
------------------------------------------- PRELOADS --------------------------------------------
-------------------------------------------------------------------------------------------------
load_script_libraries();

bm = battle_manager:new(empire_battle:new());
local gc = generated_cutscene:new(true);

--generated_cutscene:add_element(sfx_name, subtitle, camera, min_length, wait_for_vo, wait_for_camera, loop_camera)
gc:add_element(nil, "battle_blyramid_rising_speech_01", "gc_slow_army_pan_front_right_to_front_left_close_medium_01", 5000, true, false, false);
gc:add_element(nil, "battle_blyramid_rising_speech_02", "gc_fast_commander_back_medium_medium_to_close_low_01", 8000, false, false, false);
gc:add_element(nil, "battle_blyramid_rising_speech_03", "gc_medium_enemy_army_pan_back_right_to_back_left_far_high_01", 7000, false, false, false);
gc:add_element(nil, "battle_blyramid_rising_speech_04", "gc_medium_army_pan_front_right_to_front_left_close_medium_01", 4000, false, false, false);

gb = generated_battle:new(
	true,                                      		-- screen starts black
	true,                                     		-- prevent deployment for player
	false,                                      	-- prevent deployment for ai
	function() gb:start_generated_cutscene(gc) end, -- intro cutscene function
	false                                      		-- debug mode
);

gb:set_cutscene_during_deployment(true);
local forest_warning = 0;
-------------------------------------------------------------------------------------------------
---------------------------------------- INTRO VO & SUBS ----------------------------------------
-------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------
------------------------------------------ ARMY SETUP -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_player = gb:get_army(gb:get_player_alliance_num(), 1, ""); -- player attacker 

ga_battle_blyramid_rising_army_wh2_main_qb_def_malekith_destroyer_stage_3_vauls_anvil_attacker_dreadlord = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_qb_def_malekith_destroyer_stage_3_vauls_anvil_attacker_dreadlord");
ga_battle_blyramid_rising_army_wh2_dlc09_qb_tmb_final_battle_tomb_prince = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_qb_tmb_final_battle_tomb_prince");
ga_battle_blyramid_rising_army_wh_dlc15_qb_hef_eltharion_final_battle_grn_orc_shaman = gb:get_army(gb:get_non_player_alliance_num(),"wh_dlc15_qb_hef_eltharion_final_battle_grn_orc_shaman");

ga_battle_blyramid_rising_army_wh_dlc06_grn_inf_nasty_skulkers_0_tier_2 = gb:get_army(gb:get_non_player_alliance_num(),"wh_dlc06_grn_inf_nasty_skulkers_0_tier_2");
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_big_uns_tier_3 = gb:get_army(gb:get_non_player_alliance_num(),"wh_main_grn_inf_orc_big_uns_tier_3");
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_boyz_tier_1 = gb:get_army(gb:get_non_player_alliance_num(),"wh_main_grn_inf_orc_boyz_tier_1");
ga_battle_blyramid_rising_army_wh_main_grn_inf_savage_orcs_tier_1 = gb:get_army(gb:get_non_player_alliance_num(),"wh_main_grn_inf_savage_orcs_tier_1");
ga_battle_blyramid_rising_army_wh_main_grn_mon_arachnarok_spider_0_tier_4 = gb:get_army(gb:get_non_player_alliance_num(),"wh_main_grn_mon_arachnarok_spider_0_tier_4");

ga_battle_blyramid_rising_army_wh2_dlc09_tmb_inf_skeleton_archers_0 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_tmb_inf_skeleton_archers_0");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_inf_tomb_guard_0 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_tmb_inf_tomb_guard_0");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_sepulchral_stalkers_0 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_tmb_mon_sepulchral_stalkers_0");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_tomb_scorpion_0 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_tmb_mon_tomb_scorpion_0");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_ushabti_0_tier_5 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_dlc09_tmb_mon_ushabti_0_tier_5");

ga_battle_blyramid_rising_army_wh2_main_def_art_reaper_bolt_thrower = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_def_art_reaper_bolt_thrower");
ga_battle_blyramid_rising_army_wh2_main_def_cav_cold_one_chariot = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_def_cav_cold_one_chariot");
ga_battle_blyramid_rising_army_wh2_main_def_inf_shades_1 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_def_inf_shades_1");
ga_battle_blyramid_rising_army_wh2_main_def_inf_darkshards_1 = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_def_inf_darkshards_1");
ga_battle_blyramid_rising_army_wh2_main_def_mon_war_hydra = gb:get_army(gb:get_non_player_alliance_num(),"wh2_main_def_mon_war_hydra");


-------------------------------------------------------------------------------------------------
------------------------------------------ ORDERS -------------------------------------------
-------------------------------------------------------------------------------------------------
ga_battle_blyramid_rising_army_wh2_dlc09_qb_tmb_final_battle_tomb_prince:message_on_alliance_not_active_on_battlefield("wh2_dlc09_qb_tmb_final_battle_tomb_prince_died");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_inf_skeleton_archers_0:message_on_alliance_not_active_on_battlefield("wh2_dlc09_tmb_inf_skeleton_archers_0_died");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_inf_tomb_guard_0:message_on_alliance_not_active_on_battlefield("wh2_dlc09_tmb_inf_tomb_guard_0_died");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_sepulchral_stalkers_0:message_on_alliance_not_active_on_battlefield("wh2_dlc09_tmb_mon_sepulchral_stalkers_0_died");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_tomb_scorpion_0:message_on_alliance_not_active_on_battlefield("wh2_dlc09_tmb_mon_tomb_scorpion_0_died");
ga_battle_blyramid_rising_army_wh2_dlc09_tmb_mon_ushabti_0_tier_5:message_on_alliance_not_active_on_battlefield("wh2_dlc09_tmb_mon_ushabti_0_tier_5_died");

gb:message_on_all_messages_received("army_01_reinforce", "wh2_dlc09_qb_tmb_final_battle_tomb_prince_died", "wh2_dlc09_tmb_inf_skeleton_archers_0_died", "wh2_dlc09_tmb_inf_tomb_guard_0_died", "wh2_dlc09_tmb_mon_sepulchral_stalkers_0_died", "wh2_dlc09_tmb_mon_tomb_scorpion_0_died", "wh2_dlc09_tmb_mon_ushabti_0_tier_5_died");

ga_battle_blyramid_rising_army_wh_dlc15_qb_hef_eltharion_final_battle_grn_orc_shaman:reinforce_on_message("army_01_reinforce", 500);
ga_battle_blyramid_rising_army_wh_dlc06_grn_inf_nasty_skulkers_0_tier_2:reinforce_on_message("army_01_reinforce", 500);
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_big_uns_tier_3:reinforce_on_message("army_01_reinforce", 500);
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_boyz_tier_1:reinforce_on_message("army_01_reinforce", 500);
ga_battle_blyramid_rising_army_wh_main_grn_inf_savage_orcs_tier_1:reinforce_on_message("army_01_reinforce", 500);
ga_battle_blyramid_rising_army_wh_main_grn_mon_arachnarok_spider_0_tier_4:reinforce_on_message("army_01_reinforce", 500);

ga_battle_blyramid_rising_army_wh_dlc15_qb_hef_eltharion_final_battle_grn_orc_shaman:message_on_alliance_not_active_on_battlefield("wh_dlc15_qb_hef_eltharion_final_battle_grn_orc_shaman_died");
ga_battle_blyramid_rising_army_wh_dlc06_grn_inf_nasty_skulkers_0_tier_2:message_on_alliance_not_active_on_battlefield("wh_dlc06_grn_inf_nasty_skulkers_0_tier_2_died");
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_big_uns_tier_3:message_on_alliance_not_active_on_battlefield("wh_main_grn_inf_orc_big_uns_tier_3_died");
ga_battle_blyramid_rising_army_wh_main_grn_inf_orc_boyz_tier_1:message_on_alliance_not_active_on_battlefield("wh_main_grn_inf_orc_boyz_tier_1_died");
ga_battle_blyramid_rising_army_wh_main_grn_inf_savage_orcs_tier_1:message_on_alliance_not_active_on_battlefield("wh_main_grn_inf_savage_orcs_tier_1_died");
ga_battle_blyramid_rising_army_wh_main_grn_mon_arachnarok_spider_0_tier_4:message_on_alliance_not_active_on_battlefield("wh_main_grn_mon_arachnarok_spider_0_tier_4_died");

-- gb:message_on_all_messages_received("army_02_reinforce", "army_01_reinforce", "wh_main_grn_inf_orc_big_uns_tier_3_died", "wh_main_grn_inf_orc_boyz_tier_1_died", "wh_main_grn_inf_savage_orcs_tier_1_died", "wh_main_grn_mon_arachnarok_spider_0_tier_4_died");
gb:message_on_time_offset("army_02_reinforce", 600000, "army_01_reinforce");

ga_battle_blyramid_rising_army_wh2_main_qb_def_malekith_destroyer_stage_3_vauls_anvil_attacker_dreadlord:reinforce_on_message("army_02_reinforce", 500);
ga_battle_blyramid_rising_army_wh2_main_def_art_reaper_bolt_thrower:reinforce_on_message("army_02_reinforce", 500);
ga_battle_blyramid_rising_army_wh2_main_def_cav_cold_one_chariot:reinforce_on_message("army_02_reinforce", 500);
ga_battle_blyramid_rising_army_wh2_main_def_inf_shades_1:reinforce_on_message("army_02_reinforce", 500);
ga_battle_blyramid_rising_army_wh2_main_def_inf_darkshards_1:reinforce_on_message("army_02_reinforce", 500);
ga_battle_blyramid_rising_army_wh2_main_def_mon_war_hydra:reinforce_on_message("army_02_reinforce", 500);


-- -------------------------------------------------------------------------------------------------
-- ----------------------------------------- USEFUL FUNCTIONS --------------------------------------
-- -------------------------------------------------------------------------------------------------
-- function battle_start_teleport_units(unitgroup, coordinates)
--     for i = 1, unitgroup.sunits:count() do
--        local current_sunit = unitgroup.sunits:item(i);
--        current_sunit.uc:teleport_to_location(coordinates, 0, 27);
--     end;
-- end;

-- function battle_start_teleport_unit(unitgroup, index, coordinates)
--     local current_sunit = unitgroup.sunits:item(index);
--     current_sunit.uc:teleport_to_location(coordinates, 0, 27);
-- end;

-- function battle_command_queue(unitgroup, coordinates)
--     for i = 1, unitgroup.sunits:count() do
--        local current_sunit = unitgroup.sunits:item(i);
--        current_sunit.uc:goto_location(coordinates, true)
--     end;
-- end;

-- function battle_command_attack(unitgroup, target_unitgroup)
--     local target_sunit = target_unitgroup.sunits:item(1);
--     for i = 1, unitgroup.sunits:count() do
--        local current_sunit = unitgroup.sunits:item(i);
--        current_sunit.uc:attack_unit(target_sunit.unit, true, true)
--     end;
-- end;

-- function proximity_test(coordinates, range, army)

--     local closest_unit = get_closest_standing_unit(ga_player.sunits, coordinates);
--     if closest_unit and closest_unit:position():distance(coordinates) < range then
--                 forest_warning = 1;
--                 gb.sm:trigger_message("forest_entry_01");
--                 gb.sm:block_message("forest_entry_01", true);

--                 local current_pos = closest_unit:position();
--                 army:use_special_ability("wh_main_spell_bst_camp_forest_traps", current_pos, d_to_r(0))
--     end;
-- end;

-------------------------------------------------------------------------------------------------
------------------------------------------- OBJECTIVES ------------------------------------------
-------------------------------------------------------------------------------------------------

gb:set_objective_on_message("deployment_started", "mission_nagash_blyramid_rising_objective_1_tooltip"); 
gb:set_objective_on_message("army_01_reinforce", "mission_nagash_blyramid_rising_objective_2_tooltip"); 
gb:set_objective_on_message("army_02_reinforce", "mission_nagash_blyramid_rising_objective_3_tooltip"); 

-- -------------------------------------------------------------------------------------------------
-- --------------------------------------------- HINTS/MESSAGES ---------------------------------------------
-- -------------------------------------------------------------------------------------------------

gb:queue_help_on_message("army_01_reinforce", "mission_nagash_blyramid_rising_objective_1_message", 12000, 500, 1000);
gb:queue_help_on_message("army_02_reinforce", "mission_nagash_blyramid_rising_objective_2_message", 15000, 500, 1000);
