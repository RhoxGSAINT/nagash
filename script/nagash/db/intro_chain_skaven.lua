--- TODO the db file for the starting skaven armies and buildings and shit

---@class intro_chain_skaven
local db = {
    ---@NOTE Very important - make sure if you edit this, you edit the line in cdir_events_mission_option_junctions - nagash_intro_1 -> GEN_CND_FACTION.
    ---@type string The faction this army will belong to.
    faction_key = "wh2_main_skv_clan_mordkin",

    ---@type {x:number,y:number} The starting position for this army. Approximates, if this spot is taken it'll move a bit.
    pos = {
        x = 855,
        y = 204,
    },

    --- main_units keys
    units = {
        "wh2_main_skv_inf_skavenslaves_0",
        "wh2_main_skv_inf_skavenslaves_0",
    },

    ---@type string Their starting region.
    owned_region = "wh2_main_the_broken_teeth_desolation_of_nagash",

    ---@type number The level for Desolation of Nagash
    owned_region_starting_level = 2,

    ---@type string[] List of building_levels to add to their starting settlement.
    buildings = {

    },
}

return db