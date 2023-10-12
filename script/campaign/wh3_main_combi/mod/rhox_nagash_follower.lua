local followers = {
	{
		["follower"] = "nag_anc_follower_hat_makers_maker",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return character:rank() >=20 and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_death_doctor",
		["event"] = "CharacterRazedSettlement",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_keeper_of_tomes",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return character:rank() >=20 and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_warpstone_hunter",
		["event"] = "CharacterSackedSettlement",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_haunted_hostler",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                
                return faction_key =="mixer_nag_nagash" and character:won_battle() and cm:count_char_army_has_unit_category(character, "cavalry") > 3;
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_carrion",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return character:has_region() and cm:get_total_corruption_value_in_region(character:region()) < 15 and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 15
	},
	{
		["follower"] = "nag_anc_follower_ghoul_scavanger",
		["event"] = "CharacterTurnStart",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return character:has_region() and character:turns_in_own_regions() >= 1 and cm:region_has_chain_or_superchain(character:region(), "nag_outpost_secondary_fields") and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 15
	},
	{
		["follower"] = "nag_anc_follower_lich",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return character:has_region() and cm:get_total_corruption_value_in_region(character:region()) > 80 and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 5
	},
	{
		["follower"] = "nag_anc_follower_handmaiden",
		["event"] = "CharacterCharacterTargetAction",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
				return (context:mission_result_success() or context:mission_result_critial_success()) and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 5
	},
	{
		["follower"] = "nag_anc_follower_blood_bag",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                
                return faction_key =="mixer_nag_nagash" and (cm:character_won_battle_against_culture(context:character(), "wh3_main_cth_cathay") or cm:character_won_battle_against_culture(context:character(), "wh3_main_ksl_kislev") or cm:character_won_battle_against_culture(context:character(), "wh_main_brt_bretonnia") or cm:character_won_battle_against_culture(context:character(), "wh_main_emp_empire") or cm:character_won_battle_against_culture(context:character(), "mixer_teb_southern_realms") or cm:character_won_battle_against_culture(context:character(), "ovn_albion") or cm:character_won_battle_against_culture(context:character(), "ovn_amazon"))

			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_captain_deceased",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                local region_data = context:character():region_data();
				return not region_data:is_null_interface() and region_data:is_sea() and faction_key == "mixer_nag_nagash";
			end,
		["chance"] = 5
	},
	{
		["follower"] = "nag_anc_follower_ushabti_bodyguard",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                
                return faction_key =="mixer_nag_nagash" and cm:character_won_battle_against_culture(context:character(), "wh2_dlc09_tmb_tomb_kings")

			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_undead_bard",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                local region_data = context:character():region_data();
				return faction_key == "mixer_nag_nagash" and character:offensive_battles_won() > 5;
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_fan",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local faction = context:character():faction()
                local character = context:character()
                local faction = character:faction()
                local faction_key = faction:name()
                
                return faction_key =="mixer_nag_nagash" and character:offensive_battles_won() > 19;

			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_black_cat",
		["event"] = "CharacterCreated",
		["condition"] =
			function(context)
                local character = context:character()
            
				return character:character_subtype_key() == "nag_mortarch_neferata" or character:character_subtype_key() == "nag_lahmia_neferata"

			end,
		["chance"] = 100
	},
	{
		["follower"] = "nag_anc_follower_black_cat",--can use same name as a listener again. Only will be problematic if we stop the listener by function
		["event"] = "CharacterCreated",
		["condition"] =
			function(context)
                local character = context:character()
            
				return character:character_type_key() == "dignitary" and character:faction():name() =="mixer_nag_nagash" and character:character_subtype_key() ~= "nag_mortarch_drekla"

			end,
		["chance"] = 50
	},
	{
		["follower"] = "nag_anc_follower_warlock",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and context:pending_battle():ambush_battle();
			end,
		["chance"] = 25
	},
	{
		["follower"] = "nag_anc_follower_corpse_caravan",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and character:won_battle();
			end,
		["chance"] = 1
	},
	{
		["follower"] = "nag_anc_follower_death_cultist",
		["event"] = "CharacterPostBattleCaptureOption",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and context:get_outcome_key() == "enslave" and cm:char_is_general_with_army(context:character());

			end,
		["chance"] = 5
	},
	{
		["follower"] = "nag_anc_follower_siren",
		["event"] = "CharacterTurnEnd",
		["condition"] =
			function(context)
				local character = context:character();
				return character:faction():name() =="mixer_nag_nagash" and character:has_region() and character:action_points_remaining_percent() > 75 and (character:region():building_exists("nag_outpost_main_port_1"));
			end,
		["chance"] = 6
	},
	{
		["follower"] = "nag_anc_follower_poltergeist",
		["event"] = "CharacterPostBattleCaptureOption",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and context:get_outcome_key() == "release" and cm:char_is_general_with_army(context:character());
			end,
		["chance"] = 5
	},
	{
		["follower"] = "nag_anc_follower_necromancers_apprentice",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local character = context:character();
				if character:has_region() then
					local region = character:region();
					return region:owning_faction() == character:faction() and character:faction():name() =="mixer_nag_nagash";
				end;
			end,
		["chance"] = 15
	},
	{
		["follower"] = "nag_anc_follower_embalmer",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local character = context:character();
				return character:turns_in_enemy_regions() > 0 and character:faction():name() =="mixer_nag_nagash";
			end,
		["chance"] = 8
	},
	{
		["follower"] = "nag_anc_follower_powder_monkey",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and character:won_battle() and cm:char_army_has_unit(character, {"nag_vanilla_cst_inf_deck_gunners_0"});
			end,
		["chance"] = 10
	},
	{
		["follower"] = "nag_anc_follower_cursed_necrotect",
		["event"] = "CharacterCompletedBattle",
		["condition"] =
			function(context)
                local character = context:character()
				local faction = character:faction()
                local faction_key = faction:name()
				return character:faction():name() =="mixer_nag_nagash" and character:won_battle() and cm:character_won_battle_against_culture(context:character(), {"wh2_dlc11_cst_vampire_coast", "wh2_dlc09_tmb_tomb_kings", "wh_main_vmp_vampire_counts", "mixer_vmp_jade_vampires", "mixer_nag_nagash"});

			end,
		["chance"] = 25
	},
	{
		["follower"] = "nag_anc_follower_the_ravenous_dead",
		["event"] = "CharacterRankUp",
		["condition"] =
			function(context)
                local character = context:character();
				return character:faction():name() =="mixer_nag_nagash" and character:has_military_force() and character:military_force() and character:military_force():contains_mercenaries();
			end,
		["chance"] = 15
	},
};


local function rhox_nagash_load_followers()
	for i = 1, #followers do
		core:add_listener(
			followers[i].follower,
			followers[i].event,
			followers[i].condition,
			function(context)
				local character = context:character();
				local chance = followers[i].chance;
				
				if not character:character_type("colonel") and cm:random_number(100) <= chance then
					cm:force_add_ancillary(context:character(), followers[i].follower, false, false);
				end;
			end,
			true
		);
	end;
end;


cm:add_first_tick_callback(function() rhox_nagash_load_followers() end)