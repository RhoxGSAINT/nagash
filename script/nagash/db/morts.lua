---@class mort_db
local valid_fields = {
    subtype = "", -- the agent_subtypes key
    forename = "", -- the loc key from names.loc
    surname = "", -- ditto
    tech_key = "", -- the tech key used to unlock this mort

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

local luthor = {
    subtype = "nag_mortarch_luthor",
    forename = "names_name_1937224331",
    surname = "names_name_1777692417",

    --- TODO
    -- pos = {
    --     x = 699,
    --     y = 133,
    --     region = "wh2_main_ash_river_quatar",
    -- },

    --- TODO
    -- starting_army = {
    --     "",
    -- },

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

local vlad = {
    subtype = "nag_mortarch_vlad",
    forename = "names_name_1937224329",
    surname = "names_name_1777692415",

    --- TODO
    -- pos = {
    --     x = 699,
    --     y = 133,
    --     region = "wh2_main_ash_river_quatar",
    -- },

    --- TODO
    -- starting_army = {
    --     "",
    -- },

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

local mannfred = {
    subtype = "nag_mortarch_mannfred",
    forename = "names_name_1937224330",
    surname = "names_name_1777692416",

    --- TODO
    -- pos = {
    --     x = 699,
    --     y = 133,
    --     region = "wh2_main_ash_river_quatar",
    -- },

    --- TODO
    -- starting_army = {
    --     "",
    -- },

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

local arkhan = {
    subtype = "nag_mortarch_arkhan",
    forename = "names_name_1937224332",
    surname = "names_name_1777692418",
    pos = {
        x = 699,
        y = 133,
        region = "wh2_main_ash_river_quatar",
    },

    --- TODO any starting units with Arkhan
    starting_army = {
        "",
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

local neferata = {
    subtype = "nag_mortarch_neferata",
    forename = "names_name_1937224334",
    surname = "names_name_1777692420",
    -- tech_key = "nag_neferata_unlock",

    -- pos = {
    --     x = 699,
    --     y = 133,
    --     region = "wh2_main_ash_river_quatar",
    -- },

    -- --- TODO any starting units with Arkhan
    -- starting_army = {
    --     "",
    -- },

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

local krell = {
    subtype = "nag_mortarch_krell",
    forename = "names_name_1937224333",
    surname = "names_name_1777692419",

    --- TODO
    -- pos = {
    --     x = 699,
    --     y = 133,
    --     region = "wh2_main_ash_river_quatar",
    -- },

    -- --- TODO any starting units with Arkhan
    -- starting_army = {
    --     "",
    -- },

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