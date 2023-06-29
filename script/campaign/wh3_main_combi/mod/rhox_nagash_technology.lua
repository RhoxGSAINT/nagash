local dieter_tech_list={
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

local dk_tech_list={
    ["nag_dk_archai"] =true,
    ["nag_dk_battle_1"] =true,
    ["nag_dk_battle_2"] =true,
    ["nag_dk_battle_3"] =true,
    ["nag_dk_proclamation"] =true,
    ["nag_mortarch_dk_event_1"] =true,
    ["nag_mortarch_dk_event_2"] =true,
    ["nag_mortarch_dk_event_3"] =true,
    ["nag_mortarch_dk_unlock"] =true
}


local function rhox_nagash_remove_the_techs_visibility()
    local parent_ui = find_uicomponent(core:get_ui_root(), "technology_panel", "technology_list", "list_clip", "list_box", "tech_template");
    if not parent_ui then
        return --to prevent script break
    end
    --local group_ui = find_uicomponent(parent_ui, "building_group_parent");
    --group_ui:SetVisible(false) 
    
    local technology_parent = find_uicomponent(parent_ui, "tree_parent", "slot_parent");
    local arrow_parent = find_uicomponent(parent_ui, "tree_parent", "branch_parent");
    cm:callback(
        function()
            local total_nodes = technology_parent:ChildCount()
            for i=0,total_nodes-1 do
                local node = find_child_uicomponent_by_index(technology_parent, i)
                local node_key = node:Id()
                --out("Rhox Nagash: Node Id: "..node_key)
                if dieter_tech_list[node_key] and not vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua") then
                    --out("Rhox Nagash: Setting this node invisible")
                    node:SetVisible(false)
                end
                
                if dk_tech_list[node_key] and not vfs.exists("script/frontend/mod/ovn_dread_king_frontend.lua") then
                    --out("Rhox Nagash: Setting this node invisible")
                    node:SetVisible(false)
                end
            end
            
            local total_arrows = arrow_parent:ChildCount()
            for i=0,total_arrows-1 do
                local arrow = find_child_uicomponent_by_index(arrow_parent, i)
                local parent_node = arrow:GetContextObject("CcoTreeLink")
                local parent_node_key = parent_node:Call("ParentContext.NodeKey")
                if dieter_tech_list[parent_node_key] and not vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua") then
                    arrow:SetVisible(false)
                end
                
                if dk_tech_list[parent_node_key] and not vfs.exists("script/frontend/mod/ovn_dread_king_frontend.lua") then
                    arrow:SetVisible(false)
                end
                --out("Rhox Nagash: "..tostring(i).."th value: "..tostring(parent_node_key))
            end
            
        end,
        0.1
    )
end





function rhox_nagash_remove_other_mod_mortarch_tech_listener()
    core:add_listener(
        "rhox_nagash_dieter_technology_mortarch_button_click",
        "ComponentLClickUp",
        function(context)	
            return context.string == "CcoTechnologyUiTabRecordnagash_mortarch" 
        end,
        function()
            rhox_nagash_remove_the_techs_visibility()
        end,
        true
    )
    
    core:add_listener(
        "rhox_nagash_dieter_technology_mortarch_button_click2",
        "ComponentLClickUp",
        function(context)	
            return context.string == "CcoTechnologyUiTabRecordnagash_ritual" 
        end,
        function()
            rhox_nagash_remove_the_techs_visibility()
        end,
        true
    )
    
    core:add_listener(
        "rhox_nagash_dieter_technology_mortarch_panel_open",
        "PanelOpenedCampaign",
        function(context)	
            return context.string == "technology_panel"
        end,
        function()
            rhox_nagash_remove_the_techs_visibility()
        end,
        true
    )
end


local nagash_tech_to_function={
    ["nag_krell_battle_1"] = 
        function() 
            cm:apply_effect_bundle("nag_krell_battle_1_azhag_hidden", "mixer_nag_nagash", 0) 
        end,
    ["nag_mortarch_krell_event_1"] = 
        function() 
            cm:remove_event_restricted_unit_record_for_faction("nag_doomed_legion", "mixer_nag_nagash") 
        end,
    ["nag_mortarch_vlad_event_2"] = 
        function()  
            cm:add_unit_to_faction_mercenary_pool(cm:get_faction("mixer_nag_nagash"), "nag_thrall_crossbowmen", "renown", 4, 20, 4, 0.1, "", "", "", true, "nag_thrall_crossbowmen")
            cm:add_unit_to_faction_mercenary_pool(cm:get_faction("mixer_nag_nagash"), "nag_thrall_handgunners", "renown", 1, 20, 1, 0.1, "", "", "", true, "nag_thrall_handgunners")
        end
}


function rhox_nagash_start_tech_effect_listeners()
    core:add_listener(
        "rhox_nagash_azhag_effect_bundle_giver", --this is to hide the Azhag's unit set from the players
        "ResearchCompleted",
        function(context)
            return nagash_tech_to_function[context:technology()]
        end,
        function(context)            
            nagash_tech_to_function[context:technology()]()
        end,
        true
    )
end




        

