local nagash_faction = "mixer_nag_nagash"


local skill_to_anc ={
    nag_skill_unique_nagash_alakanash = "nag_anc_arcane_item_alakanash_staff_of_power",
    nag_skill_unique_nagash_book_two = "nag_anc_talisman_books_of_nagash_book_two",
    nag_skill_unique_nagash_book_three = "nag_anc_talisman_books_of_nagash_book_three",
    nag_skill_unique_nagash_book_eight = "nag_anc_talisman_books_of_nagash_book_eight"
} --husk and boss both have these skill, so to remove the duplicate ancillary
	

core:add_listener(
	"rhox_nagash_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		local character = context:character()
		local faction = character:faction()
		return skill_to_anc[skill]
	end,
	function(context)
		local skill = context:skill_point_spent_on()
		local anc = skill_to_anc[skill]
		local character = context:character()
		local faction = character:faction()
		
		
		if faction:ancillary_exists(anc) ==false then
            cm:force_add_ancillary(
                context:character(),
                anc,
                true,
                false
            )
        end
	end,
	true
)



core:add_listener(
    "rhox_nagash_uber_husk",
    "CharacterRankUp",
    function(context)
        local character = context:character()
        return character:character_subtype("nag_nagash_husk") and character:rank() >= 30 and cm:get_saved_value("rhox_nag_uber_husk") ~=true
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        if faction:is_human() then
            cm:trigger_incident_with_targets(faction:command_queue_index(), "rhox_nagash_uber_husk", 0, 0, character:command_queue_index(), 0, 0, 0)
            cm:set_saved_value("grand_spell_status_nag_grand_spell_01", true)
            cm:set_saved_value("grand_spell_status_nag_grand_spell_02", true)
            cm:set_saved_value("grand_spell_status_nag_grand_spell_03", true)
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_01", "nag_grand_spell_01_recharge", 20)
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_02", "nag_grand_spell_02_recharge", 20)
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_03", "nag_grand_spell_03_recharge", 20)
            rhox_nagash_grandspell_ui()
        end
        cm:set_saved_value("rhox_nag_uber_husk", true)
    end,
    false
) 
----------------------------------Harkon persnoality
local harkon_personality = {
	turns_until_swap = 5,
	current = "",
	new = "",
	tech1_complete=false,
	tech2_complete=false,
	tech3_complete=false,
	restored = false
}

local function rhox_nagash_harkon_personality_trait_replace(character)

    local faction =character:faction()
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_traits", "")
	
	cm:force_remove_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_" .. harkon_personality.current)
	
	cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_traits", "") end, 0.2)
	
	if faction:is_human() then
		cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc11_cst_harkon_mind_change_" .. harkon_personality.new, 0, 0, character:command_queue_index(), 0, 0, 0)
	end
	
	harkon_personality.current = harkon_personality.new
end

local function rhox_nagash_harkon_personality_restored(faction)
	if harkon_personality.tech1_complete and harkon_personality.tech2_complete and harkon_personality.tech3_complete then
		harkon_personality.restored = true
		harkon_personality.new = "restored"
		cm:callback(
			function()
				local loop_char_list = faction:character_list()
				for i = 0, loop_char_list:num_items() - 1 do
					local looping = loop_char_list:item_at(i)
					if looping:character_subtype_key() == "nag_mortarch_luthor" then
						rhox_nagash_harkon_personality_trait_replace(looping)--loop the character list and finish it!
						break
					end
				end
			end,
			0.5
		)
		
	end
end



local luthor_techs={
    nag_mortarch_luthor_event_1 = "tech1_complete",
    nag_mortarch_luthor_event_2 = "tech2_complete",
    nag_mortarch_luthor_event_3 = "tech3_complete"
}

function rhox_nag_add_harkon_listener()
    core:add_listener(
        "rhox_nagash_harkon_personality_swap",
        "CharacterTurnStart",
        function(context)
            local character = context:character()
            
            return character:character_subtype_key() == "nag_mortarch_luthor" and character:has_military_force() and not harkon_personality.restored
        end,
        function(context)
            local character = context:character()
            if harkon_personality.current =="" then --for initial
                cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_mad", false, 1)
                harkon_personality.current = "mad"
            end
            harkon_personality.turns_until_swap = harkon_personality.turns_until_swap - 1
            
            if harkon_personality.turns_until_swap == 0 then
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
        "Luthor_techs",
        "ResearchCompleted",
        function(context)
            return luthor_techs[context:technology()]
        end,
        function(context)
            harkon_personality[luthor_techs[context:technology()]] = true
            rhox_nagash_harkon_personality_restored(context:faction()) --check if player has researched all technology
        end,
        true
    )

end


--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nag_harkon_personality", harkon_personality, context)
	end
)

cm:add_loading_game_callback(
	function(context)
		harkon_personality = cm:load_named_value("rhox_nag_harkon_personality", harkon_personality, context)
	end
)