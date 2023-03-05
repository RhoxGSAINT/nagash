local nagash_faction = "mixer_nag_nagash"

local rite_status = {
    nag_winds = false,
    nag_death = false,
    nag_divinity = false,
    nag_man = false
}


--- unlock rite + show event message
local function unlock_rite(rite_key)
    if rite_status[rite_key] == nil then
        return out("Trying to unlock rite %s but it's not a valid Nagash rite!", tostring(rite_key))
    end

    if rite_status[rite_key] == true then 
        return out("Trying to unlock rite %s but it's already available!", rite_key)
    end

    local faction_key = nagash_faction
    local faction = cm:get_faction(nagash_faction)

    cm:unlock_ritual(faction, rite_key, 0)
    rite_status[rite_key] = true

    cm:callback(
		function()
			cm:show_message_event(
				faction_key,
				"event_feed_strings_text_wh2_event_feed_string_scripted_event_rite_unlocked_primary_detail",
				"rituals_display_name_" .. rite_key,
				"rituals_description_" .. rite_key,
				true,
				902,
				nil,
				nil,
				true
			);
		end,
		0.2
	);
end



function unlock_rites_listeners()
    out("Rhox Nagash Rite listener")
    if not rite_status.nag_winds then
        -- build the BP Obelisk
        core:add_listener(
            "NagWinds",
            "MilitaryForceBuildingCompleteEvent",
            function(context)
                return context:building() == "nag_bpyramid_main_obelisk_4";
            end,
            function(context)
--                 out("Rhox Nagash Nagwinds")
                if not rite_status.nag_winds then
                    self:logf("MilitaryForceBuildingCompleteEvent!")
                    unlock_rite("nag_winds")
                    rite_status.nag_winds = true
                end
            end,
            false
	    )

    end

    if not rite_status.nag_death then
        core:add_listener(
            "NagDeathTurns",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == nagash_faction and cm:turn_number() >= 35
            end,
            function(context)
                out("Rhox Nagash Death")
                if not rite_status.nag_death then
                    unlock_rite("nag_death")
                    rite_status.nag_death = true
                end
            end,
            false
        )
    end

    if not rite_status.nag_divinity then
        --- Nag level
        core:add_listener(
            "NagDivinity",
            "CharacterRankUp",
            function(context)
                local character = context:character()
                return character:faction():name() == nagash_faction and (character:character_subtype_key() == "nag_nagash_husk" or character:character_subtype_key() == "nag_nagash_boss") and character:rank() >= 8
            end,
            function(context)
                out("Rhox Nagash Nagdivinity")
                if not rite_status.nag_divinity then
                    unlock_rite("nag_divinity")
                    rite_status.nag_divinity = true
                end
            end,
            false
        )
    end

    if not rite_status.nag_man then
        core:add_listener(
            "NagMan",
            "RegionFactionChangeEvent",
            function(context)
                local faction = context:region():owning_faction()
                return not faction:is_null_interface() and faction:name() == nagash_faction and faction:region_list():num_items() >= 10
            end,
            function(context)
                out("Rhox Nagash Nagman")
                if not rite_status.nag_man then
                    unlock_rite("nag_man")
                    rite_status.nag_man = true
                end
            end,
            false
        )
    end
end




--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_rite_status", rite_status, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			rite_status = cm:load_named_value("rhox_nagash_rite_status", rite_status, context)
		end
	end
)