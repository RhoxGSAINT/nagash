local new_tech_list={
    ["nag_dieter_archai"] =true,
    ["nag_dieter_battle_1"] =true,
    ["nag_dieter_battle_2"] =true,
    ["nag_dieter_battle_3"] =true,
    ["nag_dieter_proclamation"] =true,
    ["nag_mortarch_dieter_event_1"] =true,
    ["nag_mortarch_dieter_event_2"] =true,
    ["nag_mortarch_dieter_event_3"] =true,
    ["nag_mortarch_dieter_unlock"] =true
}


function rhox_nagash_remove_dieter_tech_listener()
    core:add_listener(
        "rhox_nagash_technology_panel_open",
        "PanelOpenedCampaign",
        function(context)	
            return context.string == "technology_panel" --and cm:get_local_faction_name(true) == "mixer_nag_nagash" --it'll be only called when Nagash is a human faction
        end,
        function()
            local parent_ui = find_uicomponent(core:get_ui_root(), "technology_panel", "technology_list", "list_clip", "list_box", "tech_template");
            if not parent_ui then
                return --to prevent script break
            end
            local group_ui = find_uicomponent(parent_ui, "building_group_parent");
            group_ui:SetVisible(false) --It's UI We don't want to see this
            
            local technology_parent = find_uicomponent(parent_ui, "tree_parent", "slot_parent");
            local arrow_parent = find_uicomponent(parent_ui, "tree_parent", "branch_parent");
            cm:callback(
                function()
    --remove all the nodes and arrows and links that are not in the Marienburg one
                    local total_nodes = technology_parent:ChildCount()
                    for i=0,total_nodes-1 do
                        local node = find_child_uicomponent_by_index(technology_parent, i)
                        local node_key = node:Id()
                        --out("Rhox Nagash: Node Id: "..node_key)
                        if new_tech_list[node_key] then
                            --out("Rhox Nagash: Setting this node invisible")
                            node:SetVisible(false)
                        end
                    end
                    
                    local total_arrows = arrow_parent:ChildCount()
                    for i=0,total_arrows-1 do
                        local arrow = find_child_uicomponent_by_index(arrow_parent, i)
                        local parent_node = arrow:GetContextObject("CcoTreeLink")
                        local parent_node_key = parent_node:Call("ParentContext.NodeKey")
                        if new_tech_list[parent_node_key] then
                            arrow:SetVisible(false)
                        end
                        --out("Rhox Nagash: "..tostring(i).."th value: "..tostring(parent_node_key))
                    end
                    
                end,
                0.1
            )
        end,
        true
    )
end