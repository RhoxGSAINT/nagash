local nagash_faction = "mixer_nag_nagash"


local skill_to_anc ={
    nag_skill_unique_nagash_alakanash = "nag_anc_arcane_item_alakanash_staff_of_power"
} --husk and boss both have this skill, so to remove the duplicate ancillary
	

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
        if harkon_personality.new == "restored" then
            cm:trigger_incident_with_targets(faction:command_queue_index(), "rhox_nagash_harkon_restoed_incident", 0, 0, character:command_queue_index(), 0, 0, 0)
        else
            cm:trigger_incident_with_targets(faction:command_queue_index(), "wh2_dlc11_cst_harkon_mind_change_" .. harkon_personality.new, 0, 0, character:command_queue_index(), 0, 0, 0)
        end
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
            local faction = character:faction()
            return character:character_subtype_key() == "nag_mortarch_luthor" and character:has_military_force() and faction:is_human() and not harkon_personality.restored
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

function rhox_nagash_setup_mortarch_harkon_mind(character)
    if character:faction():is_human() then
        cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_mad", false, 1)
        harkon_personality.current = "mad"
    else --AI gets just better Harkon
        cm:force_add_trait(cm:char_lookup_str(character), "wh2_dlc11_trait_harkon_personality_restored", false, 1)
        harkon_personality.restored = true
		harkon_personality.new = "restored"
    end
end



local nagash_defeat_LL = {
	["nag_nagash_boss"] = "rhox_nagash_nagash_defeat_trait",
	["nag_nagash_husk"] = "rhox_nagash_nagash_defeat_trait",
	["nag_mortarch_neferata"] = "rhox_nagash_neferata_defeat_trait",
	["nag_mortarch_krell"] = "rhox_nagash_krell_defeat_trait",
	["nag_mortarch_vlad"] = "wh2_main_trait_defeated_vlad_von_carstein",
	["nag_mortarch_mannfred"] = "wh2_main_trait_defeated_mannfred_von_carstein",
	["nag_mortarch_luthor"] = "wh2_dlc11_trait_defeated_luthor_harkon",
	["nag_mortarch_arkhan"] = "wh2_dlc09_trait_defeated_arkhan",
	["nag_mortarch_dieter"] = "mixu_defeated_trait_vmp_dieter_helsnicht",
    ["nag_mortarch_azhag"] = "wh2_main_trait_defeated_azhag_the_slaughterer",
    ["nag_lahmia_neferata"] = "rhox_nagash_neferata_defeat_trait",
    ["nag_mortarch_dk"] = "ovn_Dread_King_defeat_trait"
}


local function rhox_nagash_get_enemy_legendary_lords_in_last_battle(character)
	local pb = cm:model():pending_battle()
	local LL_attackers = {}
	local LL_defenders = {}
	local was_attacker = false

	local num_attackers = cm:pending_battle_cache_num_attackers()
	local num_defenders = cm:pending_battle_cache_num_defenders()

	if pb:night_battle() == true or pb:ambush_battle() == true then
		num_attackers = 1
		num_defenders = 1
	end
	
	for i = 1, num_attackers do
		local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i)
		local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)
		
		if this_char_cqi == character:cqi() then
			was_attacker = true
			break
		end
		
		if char_obj:is_null_interface() == false then
			local char_subtype = char_obj:character_subtype_key()
			
			if nagash_defeat_LL[char_subtype] then
				table.insert(LL_attackers, char_subtype)
			end
		end
	end
	
	if was_attacker == false then
		return LL_attackers
	end
	
	for i = 1, num_defenders do
		local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i)
		local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)
		
		if char_obj:is_null_interface() == false then
			local char_subtype = char_obj:character_subtype_key()
			
			if nagash_defeat_LL[char_subtype] then
				table.insert(LL_defenders, char_subtype)
			end
		end
	end
	return LL_defenders
end



core:add_listener(
	"rhox_nagash_defeat_LL_listener",
	"CharacterCompletedBattle",
	true,
	function(context)
		local character = context:character()
		if cm:char_is_general_with_army(character) and character:won_battle() then
			local enemy_LL = rhox_nagash_get_enemy_legendary_lords_in_last_battle(character)
			
			for i = 1, #enemy_LL do
				local LL_details = nagash_defeat_LL[enemy_LL[i]]
				--out("Rhox Nagash: defeat traits ".. LL_details)
				if LL_details ~= nil then
					local trait = LL_details			
					cm:force_add_trait(cm:char_lookup_str(character), trait, true)
				end
			end
		end
	end,
	true
)


------------------------------------------------------------------------------------------------raise dead cap update
local raise_dead_cap = 0

local function rhox_nagash_update_raise_dead_pool()
    local region_list = cm:model():world():region_manager():region_list()
    for i=0,region_list:num_items()-1 do
        local region= region_list:item_at(i)
        for key, unit in pairs(RHOX_NAGASH_BASIC_RAISE_DEAD_UNITS) do
            cm:add_unit_to_province_mercenary_pool(region, key, "raise_dead", unit[3]+raise_dead_cap-1, unit[2], unit[3]+raise_dead_cap, 1, "", "mixer_nag_nagash", "", false, "wh_main_vmp_province_pool")
        end
        if cm:get_saved_value("rhox_nagash_luthor_recruited") == true then--it means Luthor has been recruited, update the sea pool also
            for key, unit in pairs(RHOX_NAGASH_RAISE_DEAD_SEA_UNITS) do
                cm:add_unit_to_province_mercenary_pool(region, key, "raise_dead", unit[3]+raise_dead_cap-1, unit[2], unit[3]+raise_dead_cap, 1, "", "mixer_nag_nagash", "", false, "wh_main_vmp_province_pool")
            end
        end
    end
end





core:add_listener(
    "rhox_nagash_turn_start_raise_dead_cap_update",
    "FactionTurnStart",
    function(context)
        local new_raise_dead_cap = context:faction():bonus_values():scripted_value("rhox_nagash_raisedead_cap", "value")
        return context:faction():name() == nagash_faction and raise_dead_cap ~= new_raise_dead_cap --trigger only if new raise dead cap is differenct from before
    end,
    function(context)
        local new_raise_dead_cap = context:faction():bonus_values():scripted_value("rhox_nagash_raisedead_cap", "value")
        
        out("Rhox Nagash: old raise dead cap: ".. raise_dead_cap)
        out("Rhox Nagash: new raise dead cap: ".. new_raise_dead_cap)
        raise_dead_cap = new_raise_dead_cap;
        
        rhox_nagash_update_raise_dead_pool()
    end,
    true
)

core:add_listener(
	"rhox_nagash_raise_dead_CharacterSkillPointAllocated",
	"CharacterSkillPointAllocated",
	function(context)
		local skill = context:skill_point_spent_on()
		local character = context:character()
		local faction = character:faction()
		local new_raise_dead_cap = faction:bonus_values():scripted_value("rhox_nagash_raisedead_cap", "value")
		return skill == "nag_lord_unique_necromancer_raising_dead" and raise_dead_cap ~= new_raise_dead_cap --trigger only if new raise dead cap is differenct from before
	end,
	function(context)
        out("Rhox Nagash: Raisedead cap skill allocated")		
        local character = context:character()
		local faction = character:faction()
		local new_raise_dead_cap = faction:bonus_values():scripted_value("rhox_nagash_raisedead_cap", "value")
		out("Rhox Nagash: old raise dead cap: ".. raise_dead_cap)
        out("Rhox Nagash: new raise dead cap: ".. new_raise_dead_cap)
        raise_dead_cap = new_raise_dead_cap;
        
        rhox_nagash_update_raise_dead_pool()
		
	end,
	true
)


--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nag_harkon_personality", harkon_personality, context)
		cm:save_named_value("rhox_nag_raise_dead_cap", raise_dead_cap, context)
	end
)

cm:add_loading_game_callback(
	function(context)
		harkon_personality = cm:load_named_value("rhox_nag_harkon_personality", harkon_personality, context)
		raise_dead_cap = cm:load_named_value("rhox_nag_raise_dead_cap", raise_dead_cap, context)
	end
)