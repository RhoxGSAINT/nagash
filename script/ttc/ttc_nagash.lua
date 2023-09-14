local modded_units_nagash_compatch = {

    ----Legions of Nagashizzar----
    
    
    ----Nagashizzar units
    
    --Core
    {"nag_sand_crawlies", "core"},
    {"nag_undead_chariot_unit", "core"},
    {"nag_skeleton_reaper", "core"},
    {"nag_burning_dead", "core"},

    --Special
    {"nag_nagashi_guard", "special", 1},
    {"nag_nagashi_guard_halb", "special", 1},
    {"nag_warp_ghouls", "special", 1},
    {"nag_spirit_hosts", "special", 1},
    {"nag_spectre_swarm", "special", 2},
    {"nag_shade_haunts", "special", 2},
    {"nag_bone_golems", "special", 2},
    {"nag_thrall_crossbowmen", "special", 2},    
    {"nag_virion_plaguecart", "special", 3},
    {"nag_throne_guard", "special", 2},

    --Rare
    {"nag_bone_thrower", "rare", 1},
    {"nag_revenants", "rare", 1},
    {"nag_doomed_legion", "rare", 1},
    {"nag_thrall_handgunners", "rare", 1},    
    {"nag_blood_beasts", "rare", 2},
    {"nag_morghasts", "rare", 2},
    {"nag_carrion_riders", "rare", 2},
    {"nag_bone_colossus", "rare", 2},
    {"nag_mortis_engine", "rare", 3},
    {"nag_nagashi_knights", "rare", 1},  
    {"nag_doom_knights", "rare", 2},  
    {"nag_druthor", "rare", 3},

    
    ----Tomb Kings units
    
    --Core
    {"nag_vanilla_tmb_inf_skeleton_archers_0", "core"},
    {"nag_vanilla_tmb_inf_skeleton_spearmen_0", "core"},
    {"nag_vanilla_tmb_inf_skeleton_warriors_0", "core"},
    {"nag_vanilla_tmb_inf_nehekhara_warriors_0", "core"},
    {"nag_vanilla_tmb_cav_skeleton_horsemen_0", "core"},
    {"nag_vanilla_tmb_cav_skeleton_horsemen_archers_0", "core"},
    {"nag_vanilla_tmb_veh_skeleton_archer_chariot_0", "core"},
    {"nag_vanilla_tmb_veh_skeleton_chariot_0", "core"},
    
    --Special
    {"nag_vanilla_tmb_inf_tomb_guard_0", "special", 1},
    {"nag_vanilla_tmb_inf_tomb_guard_1", "special", 1},
    {"nag_vanilla_tmb_cav_nehekhara_horsemen_0", "special", 1},
    {"nag_vanilla_tmb_cav_necropolis_knights_0", "special", 2},
    {"nag_vanilla_tmb_cav_necropolis_knights_1", "special", 2},
    {"nag_vanilla_tmb_mon_ushabti_0", "special", 2},
    {"nag_vanilla_tmb_mon_ushabti_1", "special", 2},
    {"nag_vanilla_tmb_mon_sepulchral_stalkers_0", "special", 2},
    
    --Rare
    {"nag_vanilla_tmb_art_screaming_skull_catapult_0", "rare", 1},
    {"nag_vanilla_tmb_mon_tomb_scorpion_0", "rare", 1},
    {"nag_vanilla_tmb_mon_bone_giant_0", "rare", 2},
    {"nag_vanilla_tmb_mon_khemrian_warsphinx_0", "rare", 2},
    {"nag_vanilla_tmb_mon_necrosphinx_0", "rare", 3},
    {"nag_vanilla_tmb_art_casket_of_souls_0", "rare", 3},
    
    
    ----Vampire Coast units
    
    --Core
    {"nag_vanilla_cst_inf_zombie_deckhands_mob_0", "core"},
    {"nag_vanilla_cst_inf_zombie_deckhands_mob_1", "core"},
    {"nag_vanilla_cst_inf_zombie_gunnery_mob_0", "core"},
    {"nag_vanilla_cst_inf_zombie_gunnery_mob_1", "core"},
    {"nag_vanilla_cst_mon_bloated_corpse_0", "core"},

    --Special
    {"nag_vanilla_cst_inf_deck_gunners_0", "special", 1},
    {"nag_vanilla_cst_inf_depth_guard_0", "special", 2},
    {"nag_vanilla_cst_art_carronade", "special", 2},

    --Rare
    {"nag_vanilla_cst_mon_terrorgheist", "rare", 3},
    {"nag_vanilla_cst_mon_necrofex_colossus_0", "rare", 3},


    ----Vampire Counts units     
    
    --Core
    {"nag_vanilla_vmp_inf_zombie", "core"},
    {"nag_vanilla_vmp_inf_skeleton_warriors_0", "core"},
    {"nag_vanilla_vmp_inf_skeleton_warriors_1", "core"},
    {"nag_vanilla_vmp_inf_crypt_ghouls", "core"},
    {"nag_vanilla_vmp_mon_dire_wolves", "core"},
    {"nag_vanilla_vmp_mon_fell_bats", "core"},

    --Special
    {"nag_vanilla_vmp_inf_grave_guard_0", "special", 1},
    {"nag_vanilla_vmp_inf_grave_guard_1", "special", 1},
    {"nag_vanilla_vmp_cav_black_knights_0", "special", 2},
    {"nag_vanilla_vmp_cav_black_knights_3", "special", 2},
    {"nag_vanilla_vmp_cav_hexwraiths", "special", 2},
    {"nag_vanilla_vmp_mon_vargheists", "special", 2},
    {"nag_vanilla_vmp_mon_crypt_horrors", "special", 2},
    {"nag_vanilla_vmp_veh_corpse_cart_1", "special", 3},
    {"nag_vanilla_vmp_veh_corpse_cart_2", "special", 3},
    
    --Rare
    {"nag_vanilla_vmp_inf_cairn_wraiths", "rare", 1},
    {"nag_vanilla_vmp_cav_blood_knights_0", "rare", 2},
    {"nag_vanilla_vmp_mon_varghulf", "rare", 2},
    
        
    ----Speshul units
    
    --Core
    {"vigpro_nagash_skeleton_orcs", "core"},
    {"vigpro_nagash_skeleton_goblin_range", "core"},
    {"vigpro_nagash_skeleton_goblin_melee", "core"},
    
    --Special
    {"vigpro_nagash_skeleton_troll_1h", "special", 2},
    {"vigpro_nagash_skeleton_troll_2h", "special", 2},
    
    --Rare
    {"vigpro_nagash_skeleton_giant", "rare", 2},

    
}

local ttc = core:get_static_object("tabletopcaps")
if ttc then
    ttc.add_setup_callback(function()
        ttc.add_unit_list(modded_units_nagash_compatch)
    end)
end