----------------------------------Harkon persnoality
local nagash_faction_key = "wh3_dlc29_nag_host_of_nagash"
local harkon_subtype = "wh2_dlc11_cst_harkon"

local harkon_personality = {
	turns_until_swap = 5,
	current = "",
	new = "",
	initiative1_complete=false,
	initiative2_complete=false,
	initiative3_complete=false,
	restored = false
}

local function rhox_nagash_harkon_personality_trait_replace(character)

    local faction =character:faction()
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_traits", "")

	cm:force_remove_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_" .. harkon_personality.current)

	cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_traits", "") end, 0.2)

	if faction:is_human() then
        if harkon_personality.new == "restored" then
            cm:trigger_incident_with_targets(faction:command_queue_index(), "rhox_nagash_harkon_restoed_incident", 0, 0, character:command_queue_index(), 0, 0, 0)
        else
            cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc11_cst_harkon_mind_change_" .. harkon_personality.new, 0, 0, character:command_queue_index(), 0, 0, 0)
        end
	end

	harkon_personality.current = harkon_personality.new
end

local function rhox_nagash_search_for_harkon(faction)
    local loop_char_list = faction:character_list()
    for i = 0, loop_char_list:num_items() - 1 do
        local looping = loop_char_list:item_at(i)
        if looping:character_subtype_key() == harkon_subtype then
            return looping;
        end
    end
    return false
end

local function rhox_nagash_harkon_personality_restored(faction)
	if harkon_personality.initiative1_complete and harkon_personality.initiative2_complete and harkon_personality.initiative3_complete then
        local harkon = rhox_nagash_search_for_harkon(faction)
        if not harkon then --he'll get restored when he comes back, flags are already set
            return
        end
		harkon_personality.restored = true
		harkon_personality.new = "restored"
		rhox_nagash_harkon_personality_trait_replace(harkon)
	end
end



local luthor_initiative={
    wh3_dlc29_black_pyramid_luthor_1 = "initiative1_complete",
    wh3_dlc29_black_pyramid_luthor_2 = "initiative2_complete",
    wh3_dlc29_black_pyramid_luthor_3 = "initiative3_complete"
}

function rhox_nag_add_harkon_listener()
    core:add_listener(
        "rhox_nagash_harkon_personality_swap",
        "CharacterTurnStart",
        function(context)
            local character = context:character()
            local faction = character:faction()
            -- faction check so this doesn't run together with the vanilla swap for a human Vampire Coast Harkon
            return character:character_subtype_key() == harkon_subtype and faction:name() == nagash_faction_key and character:has_military_force() and faction:is_human() and not harkon_personality.restored
        end,
        function(context)
            local character = context:character()
            if harkon_personality.current =="" then --for initial
                cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_mad", false, 1)
                harkon_personality.current = "mad"
            end
            harkon_personality.turns_until_swap = harkon_personality.turns_until_swap - 1

            if harkon_personality.turns_until_swap <= 0 then
                harkon_personality.turns_until_swap = 5 + cm:random_number(5) -- next swap between 5 and 10 turns

                local new_personalities = {
                    "coward",
                    "mad",
                    "prideful",
                    "hateful"
                }

                -- remove the current personality and select a random new one
                for i = 1, #new_personalities do
                    if new_personalities[i] == harkon_personality.current then
                        table.remove(new_personalities, i)
                        break
                    end
                end

                harkon_personality.new = new_personalities[cm:random_number(#new_personalities)]


                rhox_nagash_harkon_personality_trait_replace(character)
            end
        end,
        true
    )



    core:add_listener(
        "rhox_nagash_Luthor_initiatives",
        "FactionInitiativeActivationChangedEvent",
        function(context)
            --out("Rhox Nagash: Initiative key: ".. context:initiative():record_key())
            return luthor_initiative[context:initiative():record_key()] and context:faction():name() == nagash_faction_key and not harkon_personality.restored
        end,
        function(context)
            out("Rhox Nagash: Initiative key: ".. context:initiative():record_key())
            harkon_personality[luthor_initiative[context:initiative():record_key()]] = true
            rhox_nagash_harkon_personality_restored(context:faction()) --check if player has researched all initiatives
        end,
        true
    )

end

function rhox_nagash_setup_mortarch_harkon_mind(character)
    if character:faction():is_human() then
        if harkon_personality.restored then --already restored through the initiatives before he came
            cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_restored", false, 1)
            harkon_personality.current = "restored"
            return
        end
        cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_mad", false, 1)
        harkon_personality.current = "mad"
        rhox_nagash_harkon_personality_restored(character:faction()) --initiatives might be done already
    else --AI gets just better Harkon
        cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_restored", false, 1)
        harkon_personality.restored = true
		harkon_personality.new = "restored"
        harkon_personality.current = "restored"
    end
end

core:add_listener(
    "rhox_nagash_harkon_subjugated",
    "RitualCompletedEvent",
    function(context)
        return context:ritual():ritual_key() == "wh3_dlc29_nag_mortarchs_luthor" and context:succeeded()
    end,
    function(context)
        local faction = context:performing_faction()
        cm:callback( --vanilla reassigns him in the same event, give it a moment
            function()
                local harkon = rhox_nagash_search_for_harkon(faction)
                if not harkon then --he's with another human or not on the map, vanilla doesn't bring him then
                    return
                end
                rhox_nagash_setup_mortarch_harkon_mind(harkon)
            end,
            0.5
        )
    end,
    true
)


cm:add_first_tick_callback(
    function()
     local faction = cm:get_faction(nagash_faction_key)
     if faction and faction:is_human() then
         rhox_nag_add_harkon_listener()
     end
    end
)

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_harkon_personality", harkon_personality, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			harkon_personality = cm:load_named_value("rhox_nagash_harkon_personality", harkon_personality, context)
		end
	end
)
