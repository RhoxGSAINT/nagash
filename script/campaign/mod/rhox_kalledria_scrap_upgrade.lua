local kalledria_faction = "mixer_vmp_wailing_conclave"


local function rhox_loop_and_change_cost_text_color()
    local effects_parent = find_uicomponent(core:get_ui_root(), "units_panel_scrap_upgrades", "scrap_upgrades_parent", "list_box");
    if effects_parent then
        local childCount = effects_parent:ChildCount()
        for i=1, childCount - 1  do
            local child = UIComponent(effects_parent:Find(i))
            if not child then
                return
            end
            local scrap_component = find_uicomponent(child, "scrap_text")
            if not scrap_component then
                return
            end
            local scarap_cost_text= scrap_component:GetStateText()
            --out("Rhox Octopus check: "..scarap_cost_text)
            local scrap_cost = tonumber(scarap_cost_text)
            
            
            local pooled_resource_amount = cm:get_local_faction(true):pooled_resource_manager():resource("wh3_dlc24_ksl_spirit_essence"):value()
            
            if pooled_resource_amount >= scrap_cost then
                scrap_component:SetState("positive")
            end
        end
    end
end


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
                'rhox_nagash_clicked_button_purchase_unit_upgrades',
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
                            rhox_loop_and_change_cost_text_color()
                        end,
                        0.1
                    )
                end,
                true
            )
            
            core:add_listener(
                'rhox_nagash_clicked_upgrade_button',
                'ComponentLClickUp',
                function(context)
                    return context.string == "button_upgrade" 
                end,
                function(context)
                    cm:callback(
                        function()
                            rhox_loop_and_change_cost_text_color()
                        end,
                        0.1
                    )
                end,
                true
            )
            
            core:add_listener(
                'rhox_nagash_clicked_land_unit',
                'ComponentLClickUp',
                function(context)
                    return string.find(context.string, "LandUnit")
                end,
                function(context)
                    cm:callback(
                        function()
                            rhox_loop_and_change_cost_text_color()
                        end,
                        0.1
                    )
                end,
                true
            )
        end
    end
)