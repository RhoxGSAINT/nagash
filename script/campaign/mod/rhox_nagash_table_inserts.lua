
------------this is the part for every first tick regardless of AI or human
table.insert(campaign_traits.trait_exclusions["culture"]["wh2_main_trait_corrupted_vampire"],"mixer_nag_nagash") --so they shouldn't get it
waaagh.rewards["undead"].culture["mixer_nag_nagash"]=true --waaagh thing


--Grudge things
book_of_grudges.grudge_culture_modifiers["mixer_nag_nagash"]="medium"
grudge_cycle.factors.culture_actions["mixer_nag_nagash"]="undead_actions"
grudge_cycle.cultural_modifiers["mixer_nag_nagash"] = grudge_modifiers.high
grudge_cycle.cultures.moc_cultures["mixer_nag_nagash"]=true


---------mistwalker
if (type(lair_action_effects) == "table") then
    table.insert(lair_action_effects, "wh2_dlc15_hef_dungeon_mistwalker_upgrade_nagash")
end

if (type(lair_culture_to_effects) == "table") then
    lair_culture_to_effects["mixer_nag_nagash"]= "wh2_dlc15_hef_eltharion_dungeon_reward_nagash"
end



cm:add_first_tick_callback(
	function()
		campaign_traits.legendary_lord_defeated_traits["nag_nagash_boss"] ="rhox_nagash_nagash_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_nagash_husk"] ="rhox_nagash_nagash_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_neferata"] ="rhox_nagash_neferata_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_lahmia_neferata"] ="rhox_nagash_neferata_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_krell"] ="rhox_nagash_krell_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_vlad"] ="wh2_main_trait_defeated_vlad_von_carstein"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_mannfred"] ="wh2_main_trait_defeated_mannfred_von_carstein"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_luthor"] ="wh2_dlc11_trait_defeated_luthor_harkon"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_arkhan"] ="wh2_dlc09_trait_defeated_arkhan"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_dieter"] ="mixu_defeated_trait_vmp_dieter_helsnicht"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_azhag"] ="wh2_main_trait_defeated_azhag_the_slaughterer"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_dk"] ="ovn_Dread_King_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_mortarch_kalledria"] ="rhox_nagash_kalledria_defeat_trait"
		campaign_traits.legendary_lord_defeated_traits["nag_vmp_kalledria"] ="rhox_nagash_kalledria_defeat_trait"
	end
)

local nagash_mortarch_without_transformation={ --because it's tied to main character and custom battle. Ugh
    nag_mortarch_dk=true,
    nag_mortarch_dieter=true,
}
core:add_listener(
	"rhox_nagash_character_completed_battle_grail_vow",
	"BattleCompleted",
	true,
	function()
		if cm:pending_battle_cache_attacker_victory() then
			for i = 1, cm:pending_battle_cache_num_attackers() do
				local attacker_fm = cm:get_family_member_by_cqi(cm:pending_battle_cache_get_attacker_fm_cqi(i))
				
				if attacker_fm then
					-- Check the family member has a character interface, as a non-legendary reinforcing character can both win and die
					local attacker_character = attacker_fm:character()
					if not attacker_character:is_null_interface() and attacker_character:faction():culture() == "wh_main_brt_bretonnia" then
						for j = 1, cm:pending_battle_cache_num_defenders() do
							local defender_character = cm:get_family_member_by_cqi(cm:pending_battle_cache_get_defender_fm_cqi(j)):character()
							
                            if not defender_character:is_null_interface() and defender_character:faction():culture() == "mixer_nag_nagash" and 
                            (cm:is_agent_transformation_available(defender_character:character_subtype_key()) or nagash_mortarch_without_transformation[defender_character:character_subtype_key()]) then
                                add_vow_progress(attacker_character, "wh_dlc07_trait_brt_grail_vow_untaint_pledge", false, true)
                            end
                            
							
						end
					end
				end
			end
		elseif cm:pending_battle_cache_defender_victory() then
			for i = 1, cm:pending_battle_cache_num_defenders() do
				local defender_fm = cm:get_family_member_by_cqi(cm:pending_battle_cache_get_defender_fm_cqi(i))
				
				if defender_fm then
					-- Check the family member has a character interface, as a non-legendary reinforcing character can both win and die
					local defender_character = defender_fm:character()
					if not defender_character:is_null_interface() and defender_character:faction():culture() == "wh_main_brt_bretonnia" then

						for j = 1, cm:pending_battle_cache_num_attackers() do
							local attacker_character = cm:get_family_member_by_cqi(cm:pending_battle_cache_get_attacker_fm_cqi(j)):character()
							
							if not attacker_character:is_null_interface() and attacker_character:faction():culture() == "mixer_nag_nagash" and 
                            (cm:is_agent_transformation_available(attacker_character:character_subtype_key()) or nagash_mortarch_without_transformation[attacker_character:character_subtype_key()]) then
                                add_vow_progress(defender_character, "wh_dlc07_trait_brt_grail_vow_untaint_pledge", false, true)
                            end
						end
					end
				end
			end
		end
	end,
	true
)
