local rhox_placeofdeath_region_group={
    wh3_main_combi_region_nagashizzar =true,
    wh3_main_combi_region_morgheim =true,
    wh3_main_combi_region_ancient_city_of_quintex =true,
    wh3_main_combi_region_castle_drakenhof =true,
    wh3_main_combi_region_the_awakening =true,
    wh3_main_combi_region_khemri =true,
    wh3_main_combi_region_lahmia =true
}






local function rhox_nagash_setup_settlement_label()
    local parent_ui = find_uicomponent(core:get_ui_root(), "3d_ui_parent");
    local child_num = parent_ui:ChildCount()
    
    --out("Rhox Nagash: Child count is: ".. child_num)
    
    for i=0,child_num-1 do 
        local child = find_child_uicomponent_by_index(parent_ui, i)
        --out("Rhox wonka: Id is: " .. child:Id())
        if child:Id():starts_with("label_settlement:") then
            local icon_holder = find_uicomponent(child, "list_parent", "icon_holder");
            local region_key= string.gsub(child:Id(), "label_settlement:", "")
            --out("Rhox Nagash: Region key is: " .. region_key)
            if rhox_placeofdeath_region_group[region_key] then
                --out("Rhox Nagash: It's a hit!")
                local result = core:get_or_create_component("rhox_place_of_death_holder", "ui/campaign ui/rhox_nagash_place_of_death.twui.xml", icon_holder)
                if not result then
                    script_error("Rhox Nagash: ".. "ERROR: could not create place of death ui component? How can this be?");
                    return false;
                end;
                
            end
            
        end
    end
end



cm:add_first_tick_callback(
    function()
        if cm:get_local_faction_name(true) == "mixer_nag_nagash" then
            out("Rhox Nagash: First tick")
            core:remove_listener("rhox_nagash_realtime_settlement_label")
            core:add_listener(
                "rhox_nagash_realtime_settlement_label",
                "RealTimeTrigger",
                function(context)
                    return context.string == "rhox_nagash_settlement_real_time"
                end,
                function()
                    rhox_nagash_setup_settlement_label()    
                end,
                true
            )
            real_timer.unregister("rhox_nagash_settlement_real_time")
            real_timer.register_repeating("rhox_nagash_settlement_real_time", 1000)
        end
    end
);