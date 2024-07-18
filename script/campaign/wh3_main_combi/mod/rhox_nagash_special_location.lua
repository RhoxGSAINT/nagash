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
    if not parent_ui then 
        return
    end
    --out("Rhox Nagash: Child count is: ".. child_num)
    
    for region_key, _ in pairs(rhox_placeofdeath_region_group) do
        local child = find_uicomponent(parent_ui, "label_settlement:"..region_key, "list_parent", "icon_holder");
        if child then
            core:get_or_create_component("rhox_place_of_death_holder", "ui/campaign ui/rhox_nagash_place_of_death.twui.xml", child)
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