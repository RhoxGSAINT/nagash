--- Starting data for turn 1 Nagash.
---@class NagHuskDB
local db =  {
    --- starting position, make sure is valid
    pos = {
        x = 861,
        y = 204,
    },

    starting_units = { -- populate this field with every unit for the starting army
        "nag_bone_golems",
        "nag_nagashi_guard",
        "nag_nagashi_guard",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_tmb_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_inf_skeleton_spearmen_0",
        "nag_vanilla_tmb_inf_skeleton_spearmen_0",
        "nag_vanilla_tmb_inf_skeleton_spearmen_0",
    },

    -- forename/surname. keep names_name_ in it
    forename = "names_name_1937224327",
    surname = "names_name_1777692414",

    -- agent subtype key
    subtype = "nag_nagash_husk",

    --- start with 3 books and boner staff
    ancillaries = {
        "nag_anc_talisman_books_of_nagash_book_one",
        "nag_anc_talisman_books_of_nagash_book_two",
        "nag_anc_talisman_books_of_nagash_book_three",
        "nag_anc_arcane_item_alakanash_staff_of_power",
    },

    horde_buildings = { -- any starting buildings for Nagash's horde
       -- "building_level_key",
    },

    nagashizzar_buildings = { -- any extra starting buildings for Nagashizzar
       "nag_outpost_special_nagashizzar_1",
    },
}

return db