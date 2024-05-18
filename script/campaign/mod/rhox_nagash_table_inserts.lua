
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

