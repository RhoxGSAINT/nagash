local rhox_nagash_used_teleport = false

local rhox_settlement_candidate_table={}

local choice_string ={
    "FIRST",
    "SECOND",
    "THIRD",
    "FOURTH",
    "FIFTH",
    "CANCEL"
}


local function rhox_nagash_find_closest_settlements_and_trigger_dilemma(character)
    rhox_settlement_candidate_table={} --initialize it
    
    
	
	local pos_x = character:logical_position_x()
	local pos_y = character:logical_position_y()
	
    local region_list = cm:model():world():region_manager():region_list()
    for i=0,region_list:num_items()-1 do
        local region= region_list:item_at(i)
        local settlement= region:settlement()
        local reg_pos_x = settlement:logical_position_x()
        local reg_pos_y = settlement:logical_position_y()
        local distance = distance_squared(pos_x, pos_y, reg_pos_x, reg_pos_y);
        if distance < 1600 then 
            local x ={
                name= region:name(),
                distance= distance
            }
            table.insert(rhox_settlement_candidate_table, x)
        --[[elseif distance < 3200 then
            out("Rhox Nagash: this was a candidate: ".. region:name() .. "/distance: " ..distance)]]
        end
	end
    table.sort(rhox_settlement_candidate_table, function(a,b) return a.distance > b.distance end)

    if #rhox_settlement_candidate_table >0 then
        local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_bp_fly");
        local payload_builder = cm:create_payload();
        payload_builder:faction_pooled_resource_transaction("nag_warpstone", "nag_nagash_rituals", -1, true)
        local count =5 
        if #rhox_settlement_candidate_table < 5 then
            count = #rhox_settlement_candidate_table
        end

        for i=1,count do
            dilemma_builder:add_choice_payload(choice_string[i], payload_builder);
        end
        payload_builder:clear();
        dilemma_builder:add_choice_payload(choice_string[6], payload_builder);
        cm:launch_custom_dilemma_from_builder(dilemma_builder, cm:get_faction("mixer_nag_nagash"));
    end
end









cm:add_first_tick_callback(
    function()
        core:add_listener(
            "bp_button_leftclick",
            "ComponentLClickUp",
            function (context)
                return context.string == "icon_effect" and cm:get_faction("mixer_nag_nagash"):has_effect_bundle("rhox_nagash_woke") and cm:get_faction("mixer_nag_nagash"):faction_leader():has_military_force() and rhox_nagash_used_teleport == false
            end,
            function ()
                rhox_nagash_find_closest_settlements_and_trigger_dilemma(cm:get_faction("mixer_nag_nagash"):faction_leader())
            end,
            true
        )
        
        core:add_listener(
            "rhox_nagash_fly_dilemma_choice_made",
            "DilemmaChoiceMadeEvent",
            function(context)
                local dilemma = context:dilemma();
                local choice = context:choice();
                return dilemma == "rhox_nagash_bp_fly" and choice ~=5 and choice < #rhox_settlement_candidate_table; --choice starts from 0 --second is to prevent giving the trait in the case of Chaos wastes
            end,
            function(context)
                rhox_nagash_used_teleport = true
                local choice = context:choice();
                
                --local target_region = cm:get_region(rhox_settlement_candidate_table[i+1].name)
                local x,y = cm:find_valid_spawn_location_for_character_from_settlement("mixer_nag_nagash", rhox_settlement_candidate_table[choice+1].name, false, true, 10)
                if x ~= -1 and y ~= -1 then
                    local nagash = cm:get_faction("mixer_nag_nagash"):faction_leader()
                    cm:teleport_to(cm:char_lookup_str(nagash), x, y)
                end
            end,
            true
        );
        
        core:add_listener(
            "rhox_nagash_fly_dilemma_issued",
            "DilemmaIssuedEvent",
            function(context)
                return context:dilemma() == "rhox_nagash_bp_fly"
            end,
            function(context)
                out("Rhox Nagash: Dilemma issued calling changing the choice listener")
                core:add_listener(
                "rhox_nagash_dilemma_panel_listener",
                "PanelOpenedCampaign",
                function(context)
                    return (context.string == "events")
                end,
                function(context)

                    cm:callback(function()
                        local dilemma_choice_count=5
                        if #rhox_settlement_candidate_table < 5 then
                            dilemma_choice_count= #rhox_settlement_candidate_table
                        end
                    
                        for i=1,dilemma_choice_count do 
                            --out("Rhox Nagash: Target region: "..rhox_settlement_candidate_table[i].name)
                            local region_string = (common.get_localised_string("regions_onscreen_"..rhox_settlement_candidate_table[i].name))
                            out("Rhox Nagash: region string: "..region_string)
                            local dilemma_location = find_uicomponent(core:get_ui_root(),"events", "event_layouts", "dilemma_active", "dilemma", "background","dilemma_list", "CcoCdirEventsDilemmaChoiceDetailRecordrhox_nagash_bp_fly"..choice_string[i], "choice_button", "button_txt")
                            if dilemma_location then
                                dilemma_location:SetText(region_string)
                            end
                        end

                    end,
                    0.3
                    )

                end,
                false --see you next time
            )
            end,
            true
        )
        
        core:add_listener(
            "rhox_nagash_teleport_reset",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == "mixer_nag_nagash"
            end,
            function(context)
                rhox_nagash_used_teleport = false
            end,
            true
        )
    end
);



--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_used_teleport", rhox_nagash_used_teleport, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			rhox_nagash_used_teleport = cm:load_named_value("rhox_nagash_used_teleport", rhox_nagash_used_teleport, context)
		end
	end
)