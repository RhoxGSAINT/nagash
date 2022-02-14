---@class mort_db
local valid_fields = {
    ---@type string the agent_subtypes key
    subtype = "",
    
    ---@type string the loc key from names.loc
    forename = "",

    ---@type string the loc key from names.loc
    surname = "", 

    ---@type string the tech key used to unlock this mort
    tech_key = "", 

    ---@type {x:number,y:number,region:string} Starting position. Guesstimate for the x/y (engine will properly calculate a working spot), starting region needs to be right
    pos = {
        x = 0,
        y = 0,
        region = "",
    },

    ---@type {key?:string,objective?:string, conditions?:string[],payloads?:string[]}[] Mission events table. Either a single key for the mission to trigger, OR an objective+condition[s]+payload[s].
    events = {

    }

    --- TODO anything else needed, ie. starting ancillaries or traits or what the fuck ever
}
-- cataph: budget army currently at 4k plus a nagashi guard unit as liaison, each mort should thus tank you around 1500 upkeep total

---@type mort_db
local luthor = {
    subtype = "nag_mortarch_luthor",
    forename = "names_name_1937224331",
    surname = "names_name_1777692417",


     pos = { --sea next to Awakening
        x = 255,
        y = 136, 
        region = "wh2_main_vampire_coast_the_awakening",
        is_sea = true,
        dist = 30,
    },

    starting_army = {
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_art_carronade",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_nagashi_guard_halb",
    },

    events = {
        --- First event mission (fight 5 battles AT SEA OR against Lizardmen)
        {
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_luthor_event_1",
                "overide_text mission_text_text_nag_mortarch_luthor_event_1_0",
            },
            payloads = {
                "money 1000",
            },
        },
        --- TODO, either repeat the above with a higher cost or just wait for above to be researched

        
        {
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_luthor_event_2",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
        {
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_luthor_event_3",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
    }
}

---@type mort_db
local vlad = {
    subtype = "nag_mortarch_vlad",
    forename = "names_name_1937224329",
    surname = "names_name_1777692415",

    pos = { --should be nearby of Drakenhof
        x = 678,
        y = 417,
        region = "wh_main_eastern_sylvania_castle_drakenhof",
    },


    starting_army = {
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_vmp_cav_black_knights_3",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_nagashi_guard_halb",
    },

    events = {
        { --- Unlock Isabella (unlock TBD)
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_vlad_event_1",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
        { --- Conquer Altdorf
            objective = "CAPTURE_REGIONS",
            conditions = {
                "region wh_main_reikland_altdorf"
            },
            payloads = {
                "money 1000",
            }
        },
        {   --- TODO Defeat sigmarish factions?
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_vlad_event_3",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
    }
}

---@type mort_db
local mannfred = {
    subtype = "nag_mortarch_mannfred",
    forename = "names_name_1937224330",
    surname = "names_name_1777692416",
    pos = {
        x = 691,
        y = 419, --same pos as pos manny starts
        region = "wh_main_eastern_sylvania_castle_drakenhof",
    },
    starting_army = {
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_cav_black_knights_0",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_nagashi_guard",
    },

    events = {
        { --- Conquer Drakenhof
            objective = "CAPTURE_REGIONS",
            conditions = {
                "region wh_main_eastern_sylvania_castle_drakenhof"
            },
            payloads = {
                "money 1000",
            }
        },
        {   --- TODO TBD
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_mannfred_event_2",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
        {   --- Reach level 15
            key = "nag_mortarch_mannfred_event_3"
        }
    }
}

---@type mort_db
local arkhan = {
    subtype = "nag_mortarch_arkhan",
    forename = "names_name_1937224332",
    surname = "names_name_1777692418",
    pos = {
        x = 699,
        y = 133,
        region = "wh2_main_ash_river_quatar",
    },
        starting_army = {
            "nag_vanilla_vmp_inf_skeleton_warriors_0",
            "nag_vanilla_vmp_inf_skeleton_warriors_0",
            "nag_vanilla_tmb_inf_nehekhara_warriors_0",
            "nag_vanilla_tmb_veh_skeleton_chariot_0",
            "nag_vanilla_tmb_mon_tomb_scorpion_0",
            "nag_nagashi_guard_halb",
            "nag_nagashi_guard_halb",
        },

    events = {
        --- First event mission (raise the BP)
        {
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_arkhan_event_1",
                "overide_text mission_text_text_nag_mortarch_arkhan_event_1",
            },
            payloads = {
                "money 1000",
            },
        },
        --- Second event mission (fight X battles against TK)
        {
            key = "nag_mortarch_arkhan_event_2",
        },
        --- Reach level X with Arkhan
        {
            key = "nag_mortarch_arkhan_event_3",
        },
    }
}

---@type mort_db
local neferata = {
    subtype = "nag_mortarch_neferata",
    forename = "names_name_1937224334",
    surname = "names_name_1777692420",
    -- tech_key = "nag_neferata_unlock",

    pos = {  --should be south of Desonagash, on top of a beach that can lead her to Lahmia
        x = 819,
        y = 214,
        region = "wh2_main_the_broken_teeth_desolation_of_nagash",
    },

    starting_army = {
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_tmb_inf_tomb_guard_0",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_vmp_cav_blood_knights_0",
        "nag_nagashi_guard_halb",
    },

    events = {
        {   --- TODO TBD
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_neferata_event_1",
                "overide_text mission_text_text_TBD",
            },
            payloads = {
                "money 1000",
            },
        },
        {   --- Conquer Lahmia
            objective = "CAPTURE_REGIONS",
            conditions = {
                "region wh_main_eastern_sylvania_castle_drakenhof"
            },
            payloads = {
                "money 1000",
            }
        },
        {   --- reach level 15
            key = "nag_mortarch_neferata_event_3"
        },
    }
}

---@type mort_db
local krell = {
    subtype = "nag_mortarch_krell",
    forename = "names_name_1937224333",
    surname = "names_name_1777692419",

    pos = { --around Mourkain
        x = 654,
        y = 227,
        region = "wh2_main_marshes_of_madness_morgheim",
    },

    starting_army = {                               
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_nagashi_guard",
    },

    events = {
        {  --- Raze or Sack X regions
            key = "nag_mortarch_krell_event_1",
        },
        {  --- Win X battles as Krell
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_krell_event_2",
                "override_text mission_text_text_nag_mortarch_krell_event_2_0",
            },
            payloads = {
                "money 1000",
            },
        },
        {  --- Own N Guard units in all armies
            objective = "SCRIPTED",
            conditions = {
                "script_key nag_mortarch_krell_event_3",
                "override_text mission_text_text_nag_mortarch_krell_event_3_0",
            },
            payloads = {
                "money 1000",
            }
        }
    }
}

--- Order doesn't matter
return {
    luthor,
    vlad,
    mannfred,
    arkhan,
    neferata,
    krell
}