--- TODO details for a spawned army via the Dominion over Death
--- TODO random army generator

random_army_manager:new_force("nag_death")

--- Will always be 3 Nagashi Guard
random_army_manager:add_mandatory_unit("nag_death", "nag_nagashi_guard", 3)

--- Numbers here are "weights", which are pooled to determine chance.
random_army_manager:add_unit("nag_death", "nag_spirit_hosts", 1)
random_army_manager:add_unit("nag_death", "nag_bone_golems", 1)