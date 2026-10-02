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
    {"nag_bone_golems", "special", 2},  
    {"nag_virion_plaguecart", "special", 3},

    --Rare
    {"nag_bone_thrower", "rare", 1},
    {"nag_revenants", "rare", 1},
    {"nag_doomed_legion", "rare", 1},   
    {"nag_blood_beasts", "rare", 2},
    {"nag_carrion_riders", "rare", 2},
    {"nag_bone_colossus", "rare", 2},
    {"nag_druthor", "rare", 3},
}

local ttc = core:get_static_object("tabletopcaps")
if ttc then
    ttc.add_setup_callback(function()
        ttc.add_unit_list(modded_units_nagash_compatch)
    end)
end