local kalledria = {
    key = "mixer_vmp_wailing_conclave",
    first_lair = "wh3_main_combi_region_waili_village",
    lair_pools = {
        {key = "close", distance = 35000, lair_count = 2}, -- Distance set at the value at which at least 50 regions are within range
        {key = "medium", distance = 240000, lair_count = 2}, -- Distance set at the value at which 50% of all regions are within range
        {key = "far", distance = 400000, lair_count = 3}, -- Distance set at the value at which 75% of all region are within range
        {key = "random", distance = 9999999, lair_count = 3}, -- All regions are valid at this distance
    }
}

table.insert(vampire_lairs.lair_spawning_data.factions, kalledria)	

table.insert(vampire_technology.locked_techs_necromancers.factions, "mixer_vmp_wailing_conclave")
table.insert(vampire_technology.locked_techs_necromancers.factions, "mixer_vmp_wailing_conclave")


table.insert(vampire_technology.starting_vampire_techs, {faction = "mixer_vmp_wailing_conclave", tech = "wh3_main_tech_vmp_vampires_main_1"})
table.insert(vampire_technology.starting_necromancer_techs, {faction = "mixer_vmp_wailing_conclave", tech = "wh3_main_tech_vmp_necromancers_0"})


cm:add_first_tick_callback(
    function()
        campaign_traits.legendary_lord_defeated_traits["nag_vmp_kalledria"] ="rhox_nagash_kalledria_defeat_trait"
        campaign_traits.legendary_lord_defeated_traits["nag_mortarch_krell"] ="rhox_nagash_krell_defeat_trait"
    end
)