rhox_nagash_guinevere_info={ --global so others can approach this too
    traits=nil, --trait, it will transfer to the next faction also
    rank=1, --rank, it will transfer to the next faction also
    previous_faction=nil, --she never visits two factions in a row
    remaining_turn=-1 
}  


local guin_base_turn = 20

local guin_culture={
    wh3_main_ksl_kislev = true,
    wh_main_brt_bretonnia = true,
    wh_main_emp_empire = true,
    wh_main_vmp_vampire_counts = true
}


core:add_listener(
    "rhox_nagash_guin_giving_turn_start",
    "WorldStartRound",
    function(context)
        if cm:model():turn_number() < 5 then --don't trigger it until the turn 5
            return false
        end
    
        return rhox_nagash_guinevere_info.remaining_turn == -1 --character turn start would reduce this value
    end,
    function(context)
        local all_factions = cm:model():world():faction_list();
        local visit_candidate ={}
        for i = 0, all_factions:num_items()-1 do
            local faction = all_factions:item_at(i);
            if guin_culture[faction:culture()] and faction:is_dead() == false and faction:has_faction_leader() and faction:faction_leader():has_military_force() then --we're going to summon her to where the faction leader is, so faction leader must have military force
                table.insert(visit_candidate, faction:name());
            end
        end;
        
        visit_candidate = cm:random_sort(visit_candidate);
        local target_faction = nil
        for i=1,#visit_candidate do
            if visit_candidate[i] ~= previous_faction then
                target_faction = visit_candidate[i]
                break
            end
        end
        
        if cm:model():turn_number() ==5 then
            target_faction = "wh3_main_vmp_lahmian_sisterhood"
        end
        
        if not target_faction then
            out("Rhox Nagash Guin: No available target faction found, ")
            return
        end
        local guin_faction = cm:get_faction(target_faction)
        if guin_faction:is_human() then --trigger incident
            
        end
        
        out("Rhox Nagash Guin: Guin going to ".. target_faction)
        local x, y = cm:find_valid_spawn_location_for_character_from_character(target_faction, cm:char_lookup_str(guin_faction:faction_leader()), true, 10)
        cm:spawn_agent_at_position(guin_faction, x, y, "dignitary", "nag_guinevere")
        local new_character = cm:get_most_recently_created_character_of_type(target_faction, "dignitary", "nag_guinevere")
        if new_character then
            local forename = common:get_localised_string("names_name_1937224343")
            cm:change_character_custom_name(new_character, forename, "","","")
        end
        rhox_nagash_guinevere_info.remaining_turn = 20--TODO apply effect bundle
        
        
    end,
    true
)
core:add_listener(
    "rhox_nagash_guin_remaining_turn_check",
    "CharacterTurnStart",
    function(context)
        local character = context:character()
        return character:character_subtype_key() == "nag_guinevere"
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        
        rhox_nagash_guinevere_info.remaining_turn = rhox_nagash_guinevere_info.remaining_turn -1
        if rhox_nagash_guinevere_info.remaining_turn == 0 then
            rhox_nagash_guinevere_info.previous_faction = faction:name()
            rhox_nagash_guinevere_info.remaining_turn = -1;
            cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
            cm:suppress_immortality(character:family_member():command_queue_index(), true) --TODO 
            cm:kill_character(cm:char_lookup_str(character))
            
            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 0.2)
            
            if faction:is_human() then --trigger incident
            
            end
        end
    end,
    true
)

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_guinevere_info", rhox_nagash_guinevere_info, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			rhox_nagash_guinevere_info = cm:load_named_value("rhox_nagash_guinevere_info", rhox_nagash_guinevere_info, context)
		end
	end
)
