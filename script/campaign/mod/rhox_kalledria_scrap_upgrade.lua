local kalledria_faction = "mixer_vmp_wailing_conclave"


cm:add_first_tick_callback(
    function()
        if cm:get_local_faction_name(true) == kalledria_faction then
            
            core:add_listener(
				"rhox_nagash_CharacterSelected_scrap_upgrade_button_shower",
				"CharacterSelected",
				function(context)
                    
					return context:character():faction():name() == kalledria_faction and context:character():character_type_key()=="general";
				end,
				function(context)
                    cm:callback(
                        function()
                            local upgrade_button = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "button_purchase_unit_upgrades");
                            if upgrade_button then
                                upgrade_button:SetVisible(true)
                            end
                        end,
                        0.1
                    )
				end,
				true
            )
            
            core:add_listener(
				"rhox_nagash_CharacterMoved_scrap_upgrade_shower",
				"CharacterFinishedMovingEvent",
				function(context)

					return context:character():faction():name() == kalledria_faction and context:character():character_type_key()=="general";
				end,
				function(context)
                    cm:callback(
                        function()
                            local upgrade_button = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "button_purchase_unit_upgrades");
                            if upgrade_button then
                                upgrade_button:SetVisible(true)
                            end
                        end,
                        0.1
                    )
				end,
				true
            )

            core:add_listener(
                'rhox_nagash_akkorak_clicked_upgrade_button',
                'ComponentLClickUp',
                function(context)
                    

                    return context.string == "button_purchase_unit_upgrades" 
                    
                end,
                function(context)
                    cm:callback(
                        function()
                            local upgrade_button = find_uicomponent(core:get_ui_root(), "units_panel_scrap_upgrades", "button_upgrade");
                            if upgrade_button then
                                upgrade_button:SetVisible(true)
                                upgrade_button:SetState("active")
                            end
                        end,
                        0.1
                    )
                    
                end,
                true
            )
        end
    end
)