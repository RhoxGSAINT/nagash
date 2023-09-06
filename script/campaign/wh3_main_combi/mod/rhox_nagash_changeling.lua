local mortarch_to_original={
    nag_nagash_boss = "nag_nagash_husk",
    nag_mortarch_neferata ="nag_lahmia_neferata",
    nag_mortarch_vlad ="wh_dlc04_vmp_vlad_con_carstein",
    nag_mortarch_mannfred ="wh_main_vmp_mannfred_von_carstein",
    nag_mortarch_luthor ="wh2_dlc11_cst_harkon",
    nag_mortarch_arkhan ="wh2_dlc09_tmb_arkhan",
    nag_mortarch_isabella ="wh_pro02_vmp_isabella_von_carstein",
    nag_mortarch_dieter ="vmp_dieter_helsnicht",
    nag_mortarch_azhag ="wh_main_grn_azhag_the_slaughterer",
    nag_mortarch_dk ="Dread_King",
    nag_mortarch_hand ="elo_hand_of_nagash",
    nag_mortarch_drekla ="cst_drekla"
}





core:add_listener(
    "rhox_nagash_the_changeling_formless_horror_defeated_in_battle_nagash_minors",
    "CharacterCompletedBattle",
    function(context)
        local character = context:character()
        return character:character_subtype("wh3_dlc24_tze_the_changeling") and character:won_battle()
    end,
    function(context)
        local enemy_agent_subtype = the_changeling_features:get_enemy_subtypes()
        local the_changeling_faction_cqi = context:character():faction():command_queue_index()
        
        for i = 1, #enemy_agent_subtype do
            local old_self = mortarch_to_original[enemy_agent_subtype[i]]
            if old_self then
                out("Rhox Nagash: Found the old self")
                the_changeling_features:grant_formless_horror_form(old_self, the_changeling_faction_cqi)
            end
        end
    end,
true
)
