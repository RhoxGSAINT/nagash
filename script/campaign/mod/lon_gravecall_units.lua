-- Adds extra units to Nagash's Grave Call (Necromancy recruitment) and locks them behind a Black Pyramid sigil.
-- Made by Druwski at Da Modding Den, re-use in mods as needed

-- Units to add. One row per unit:
--   unit    main_units key
--   group   the mercenary_unit_groups key you made for it (same key as in mercenary_pool_to_groups_junctions)
--   section which Grave Call column: 'tmb', 'cst' or 'vmp'
--   sigil   Black Pyramid sigil that unlocks it, or nil to have it unlocked from the start
local units = {
	{ unit = 'nag_skeleton_reaper', group = 'lon_nag_skeleton_reaper_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_skeleton_10' },
	{ unit = 'nag_sand_crawlies', group = 'lon_nag_sand_crawlies_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_beasts_1' },
    { unit = 'nag_nagashi_guard', group = 'lon_nag_nagashi_guard_halb_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_nagash_mid_8' },
    { unit = 'nag_nagashi_guard_halb', group = 'lon_nag_nagashi_guard_halb_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_nagash_mid_8' },
    { unit = 'nag_carrion_riders', group = 'lon_nag_carrion_riders_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_wraith_1' },
    { unit = 'nag_bone_thrower', group = 'lon_nag_bone_thrower_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_guards_6' },
    { unit = 'nag_bone_golems', group = 'lon_nag_bone_golems_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_construct_monstrous_7' },
    { unit = 'nag_warp_ghouls', group = 'lon_nag_warp_ghoul_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_zombies_10' },
    { unit = 'nag_undead_chariot_unit', group = 'lon_nag_undead_chariot_faction_pool', section = 'vmp', sigil = 'wh3_dlc29_black_pyramid_chariots_1' },
}

-- Change the prefix if you copy this file into another mod, so the saved flags don't clash.
local save_prefix = 'lon_gravecall_units_'

local faction_key = 'wh3_dlc29_nag_host_of_nagash'
local subculture_key = 'wh3_dlc29_sc_nag_undead_legions'
local sigil_set_key = 'wh3_dlc29_pyramid_initiative_set'
local pools = {
	tmb = 'wh3_dlc29_nag_raise_dead_tmb_faction_pool',
	cst = 'wh3_dlc29_nag_raise_dead_cst_faction_pool',
	vmp = 'wh3_dlc29_nag_raise_dead_vmp_faction_pool',
    lon = "wh3_dlc29_nag_raise_dead_lon_faction_pool",
}

-- CA's Grave Call script locks units by reading this table, so it has to be filled before the campaign starts
if black_pyramid and black_pyramid.gravecall then
	for _, u in ipairs(units) do
		local section = black_pyramid.gravecall.initiatives[u.section]
		local locks = u.sigil and section and section[u.sigil]
		if locks then
			table.insert(locks, u.unit)
		elseif u.sigil then
			out('gravecall units: no sigil ' .. u.sigil .. ' in section ' .. tostring(u.section) .. ', ' .. u.unit .. ' stays unlocked')
		end
	end
end

local defaults = {
    replen_chance = 100,
    max = 1,
    max_per_turn = 0.1,
    xp_level = 0,
    faction_restriction = "",
    subculture_restriction = "",
    tech_restriction = "",
    partial_replenishment = true,
}

local nagash_ror_units = {
    "nag_bone_colossus",
    "nag_virion_plaguecart",
    "nag_revenants",
    "nag_doomed_legion",
    "nag_blood_beasts",
    "nag_burning_dead",
    "nag_druthor"
}

cm:add_first_tick_callback_new(function()
	local faction = cm:get_faction(faction_key)
	if not faction then return end
	local sigils = faction:lookup_faction_initiative_set_by_key(sigil_set_key)
	for _, u in ipairs(units) do
        local pool = pools[u.section]
        cm:add_unit_to_faction_mercenary_pool(faction, u.unit, pool, 999999, 100, 999999, 100, '', subculture_key, '', false, u.group)
        -- on a save past turn 1 CA's lock has already run, so lock the new unit ourselves
        if u.sigil and cm:model():turn_number() > 1 and not sigils:lookup_initiative_by_key(u.sigil):is_active() then
            cm:add_event_restricted_unit_record_for_faction_and_source(u.unit, faction_key, pool, 'nagash_gravecall_lock_tooltip_' .. u.sigil)
        end
	end
	
	for _, unit_key in ipairs(nagash_ror_units) do
        cm:add_unit_to_faction_mercenary_pool(
            faction,
            unit_key,
            "wh3_main_regiments_of_renown_pool",
            1,
            defaults.replen_chance,
            defaults.max,
            defaults.max_per_turn,
            defaults.faction_restriction,
            defaults.subculture_restriction,
            defaults.tech_restriction,
            defaults.partial_replenishment,
            unit_key
        )
    end
    cm:add_event_restricted_unit_record_for_faction("nag_doomed_legion", faction_key, "rhox_nagash_doomed_legion_lock")
    
end)

core:add_listener(
    "rhox_nagash_krell_subjugated",
    "RitualCompletedEvent",
    function(context)
    return context:ritual():ritual_key() == "wh3_dlc29_nag_mortarchs_krell" and context:succeeded()
    end,
    function(context)
        cm:remove_event_restricted_unit_record_for_faction("nag_doomed_legion", faction_key)
    end,
    true
)