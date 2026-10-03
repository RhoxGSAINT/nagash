

cm:add_first_tick_callback(
    function()
        if cm:get_local_faction_name(true) == "wh3_dlc29_nag_host_of_nagash" then
            core:add_listener(
                "rhox_nagash_diplomacy_panel_open_listener",
                "ScriptEventPlayerOpensDiplomacyPanel",
                true,
                function()
                    --out("Rhox Nagash: I'm here?")
                    local parent_ui = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown", "faction_right_status_panel", "header", "porthole", "porthole_frame");
                    local result = core:get_or_create_component("rhox_nagash_vassal_button", "ui/campaign ui/rhox_nagash_vassal_button.twui.xml", parent_ui)
                    if not result then
                        script_error("Rhox Nagash: ".. "ERROR: could not create nagash diplo ui component? How can this be?");
                        return false;
                    end;
                    local button = find_uicomponent(result, "button_force_vassal")
                    if button then 
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",1)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",2)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",3)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",4)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",5)
                    end
                    --result:SetVisible(true)
                end,
                true
            )
            core:add_listener(
                "rhox_nagash_diplomacy_panel_open_listener2",
                "ScriptEventDiplomacyPanelOpened",
                true,
                function()
                    --out("Rhox Nagash: I'm here?")
                    local parent_ui = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown", "faction_right_status_panel", "header", "porthole", "porthole_frame");
                    local result = core:get_or_create_component("rhox_nagash_vassal_button", "ui/campaign ui/rhox_nagash_vassal_button.twui.xml", parent_ui)
                    if not result then
                        script_error("Rhox Nagash: ".. "ERROR: could not create nagash diplo ui component? How can this be?");
                        return false;
                    end;
                    local button = find_uicomponent(result, "button_force_vassal")
                    if button then 
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",1)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",2)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",3)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",4)
                        button:SetImagePath("ui/skins/mixer_nag_nagash/button_blank.png",5)
                    end
                    --result:SetVisible(true)
                end,
                true
            )
        end
        core:add_listener(
            "rhox_nagash_forced_vassal_ritual",
            "RitualCompletedEvent",
            function(context)
                local performing_faction = context:performing_faction()
                return context:ritual():ritual_category() == "FORCE_VASSAL_NAGASH" and performing_faction:name() == "wh3_dlc29_nag_host_of_nagash"
            end,
            function(context)
                local performing_faction = context:performing_faction()
                local target_faction = context:ritual_target_faction()

                cm:force_diplomacy("faction:"..performing_faction:name(), "faction:"..target_faction:name(), "vassal", true, true, false)

                cm:force_make_vassal(performing_faction:name(), target_faction:name(), true)
                
                local incident_key = "rhox_nagash_force_vassalised" --basic one for Vampire Coast
                if target_faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
                    incident_key = "rhox_nagash_force_vassalised_tk"
                elseif target_faction:culture() == "wh2_dlc11_cst_vampire_coast" then
                    incident_key = "rhox_nagash_force_vassalised_coast"
                elseif target_faction:culture() == "mixer_vmp_jade_vampires" or target_faction:name() == "wh3_dlc21_vmp_jiangshi_rebels" then
                    incident_key = "rhox_nagash_force_vassalised_jv"
                end
                
                


                
                local human_factions = cm:get_human_factions()
                for i = 1, #human_factions do
                    local incident_faction = cm:get_faction(human_factions[i])
                    cm:trigger_incident_with_targets(
                        incident_faction:command_queue_index(), 
                        incident_key, 
                        target_faction:command_queue_index(),
                        0,
                        0,
                        0,
                        0,
                        0
                    )
                end

            end,
            true
        )

    end
)

--locking vassal ritual for Mortarch and TK LL
cm:add_first_tick_callback_new(function()
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_followers_of_nagash", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh_main_vmp_schwartzhafen", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh_main_vmp_vampire_counts", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc11_cst_vampire_coast", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh3_dlc29_vmp_neferata", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_exiles_of_nehek", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_khemri", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_lybaras", "rhox_nagash_influence", "other", -100)
end)

