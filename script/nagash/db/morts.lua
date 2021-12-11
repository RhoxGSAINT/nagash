local valid_fields = {
    subtype = "", -- the agent_subtypes key
    forename = "", -- the loc key from names.loc
    surname = "", -- ditto
    tech_key = "", -- the tech key used to unlock this mort

    --- TODO anything else needed, ie. starting ancillaries or traits or what the fuck ever
}

return {
    {   -- Luthor
        subtype = "nag_mortarch_luthor",
        forename = "names_name_1937224331",
        surname = "names_name_1777692417",
        tech_key = "nag_luthor_unlock",
    },
    {   -- Vladdy daddy
        subtype = "nag_mortarch_vlad",
        forename = "names_name_1937224329",
        surname = "names_name_1777692415",
        tech_key = "nag_vlad_unlock",
    },
    {   -- man boy
        subtype = "nag_mortarch_mannfred",
        forename = "names_name_1937224330",
        surname = "names_name_1777692416",
        tech_key = "nag_mannfred_unlock",
    },
    {   -- batman
        subtype = "nag_mortarch_arkhan",
        forename = "names_name_1937224332",
        surname = "names_name_1777692418",
        tech_key = "nag_arkhan_unlock",
    },
    {   -- you get it by now
        subtype = "nag_mortarch_neferata",
        forename = "names_name_1937224334",
        surname = "names_name_1777692420",
        tech_key = "nag_neferata_unlock",
    },
    {
        subtype = "nag_mortarch_krell",
        forename = "names_name_1937224333",
        surname = "names_name_1777692419",
        tech_key = "nag_krell_unlock",
    }
}