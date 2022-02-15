--- TODO details for a spawned army via the Dominion over Death
--- TODO random army generator

random_army_manager:new_force("nag_death")

--- Will always be 1 Nagashi Guard
random_army_manager:add_mandatory_unit("nag_death", "nag_nagashi_guard", 1)

--- Numbers here are "weights", which are pooled to determine chance.
random_army_manager:add_unit("nag_death", "nag_spirit_hosts", 2)
random_army_manager:add_unit("nag_death", "nag_vanilla_tmb_cav_skeleton_horsemen_0", 2)
random_army_manager:add_unit("nag_death", "nag_vanilla_tmb_inf_skeleton_archers_0", 2)
random_army_manager:add_unit("nag_death", "nag_vanilla_tmb_inf_skeleton_spearmen_0", 6)
random_army_manager:add_unit("nag_death", "nag_vanilla_vmp_inf_zombie", 6)


--- TODO armies for each ritual!