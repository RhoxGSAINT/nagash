Rhox_Nagash_Lahmia_Coven_Influence = {
	-- POOLED RESOURCE CONSTANTS
	SI_resource_key = "rhox_nagash_lahmia_coven_influence",
	SI_resource_factor_diplomacy = "rhox_nagash_diplomacy_with_lahmia",
	SI_resource_factor_battles = "rhox_nagash_battles_against_lahmia",
	SI_vassal_unlock_threshold = "rhox_nagash_lahmia_pooled_resource_coven_influence_effects_max",

	--- POOLED RESOURCE VALUES
	SI_on_signing_treaty = 20,		-- immediate amount granted from signing any deal with Slaanesh
	SI_per_gift = 100,				-- gift amount divided by this value is the immediate amount granted by any gift accepted by Slaanesh
	SI_per_gift_max = 50,			-- maximum amount of SI granted for a gift
	SI_per_active_treaty = 5,		-- per turn SI given for having treaties with Slaanesh
	SI_per_battle = 10,				-- immediate amount granted from any battle with Slaanesh
	SI_capacity_per_region = 10,	-- amount SI capacity goes up per region owned
	SI_resistance_per_region = -1,	-- amount SI capacity goes down per turn per region owned

	--RITUAL CONSTANTS
	FORCE_VASSAL_ritual_category = "FORCE_VASSAL_LAHMIA",

	---SUBCULTURE CONSTANTS
	seducible_factions_set_key = "rhox_nagash_lahmia_target",
	seducible_factions = {},-- populated automatically on startup as a model list
    player_faction = "wh3_main_vmp_lahmian_sisterhood",
    
}




function Rhox_Nagash_Lahmia_Coven_Influence:initialise()
	self.seducible_factions = cm:model():world():lookup_factions_from_faction_set(self.seducible_factions_set_key)

	self:setup_faction_turn_start_listeners()
	self:setup_resource_threshold_listeners()
	self:setup_diplomatic_action_listeners()
	self:setup_vassalise_ritual_listener()
	self:setup_battle_and_occupation_listeners()
    cm:disable_event_feed_events(true, "", "", "faction_character_tag_added") --it always says something about slaanesh, so remove it
end



function Rhox_Nagash_Lahmia_Coven_Influence:setup_faction_turn_start_listeners()

	for k, faction_interface in model_pairs(self.seducible_factions) do
		local faction_key = faction_interface:name()
		cm:add_faction_turn_start_listener_by_name(
			"rhox_nagash_lahmia_seducible_faction_turn_start_" .. faction_key,
			faction_key,
			function(context)
				self:apply_bonus_resistance_from_regions(context:faction())
			end,
			true
		);
	end

    local faction_interface= cm:get_local_faction(true)
	
    local faction_key = faction_interface:name()
    cm:add_faction_turn_start_listener_by_name(
        "rhox_nagash_lahmia_faction_turn_start_" .. faction_key,
        faction_key,
        function(context)
            self:apply_regular_diplomatic_seduction(context:faction())
        end,
        true
    );
end

function Rhox_Nagash_Lahmia_Coven_Influence:setup_panel_open_listeners()
    core:add_listener(
        "rhox_nagash_lahmia_diplomacy_panel_open_listener",
        "ScriptEventPlayerOpensDiplomacyPanel",
        true,
        function()
            
            local parent_ui = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown", "faction_right_status_panel", "header", "porthole", "porthole_frame");
            if not parent_ui then
                return
            end
            local result = core:get_or_create_component("rhox_nagash_lahmia_coven_influence_holder", "ui/campaign ui/rhox_nagash_lahmia_coven_influence.twui.xml", parent_ui)
            if not result then
                script_error("Rhox Nagash: ".. "ERROR: could not create coven influence ui component? How can this be?");
                return false;
            end;
            --result:SetVisible(true)
        end,
        true
    )
   core:add_listener(
        "rhox_nagash_lahmia_diplomacy_panel_open_listener2",
        "ScriptEventDiplomacyPanelOpened",
        true,
        function()
            
            local parent_ui = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown", "faction_right_status_panel", "header", "porthole", "porthole_frame");
            if not parent_ui then
                return
            end
            local result = core:get_or_create_component("rhox_nagash_lahmia_coven_influence_holder", "ui/campaign ui/rhox_nagash_lahmia_coven_influence.twui.xml", parent_ui)
            if not result then
                script_error("Rhox Nagash: ".. "ERROR: could not create coven influence ui component? How can this be?");
                return false;
            end;
            --result:SetVisible(true)
        end,
        true
    )
end







function Rhox_Nagash_Lahmia_Coven_Influence:setup_resource_threshold_listeners()
	core:add_listener(
		"rhox_nagash_lahmia_slaanesh_seductive_influence_threshold_triggers",
		"PooledResourceEffectChangedEvent",
		function(context)
			return context:resource():key() == self.SI_resource_key
		end,
		function(context)
			local faction = context:faction();
			local faction_key = faction:name()
			local new_effect = context:new_effect()

			if new_effect == self.SI_vassal_unlock_threshold and not faction:is_vassal() then
				self:fire_vassal_available_incident(faction_key)
			end
		end,
		true
	)
end

function Rhox_Nagash_Lahmia_Coven_Influence:setup_diplomatic_action_listeners()
  --changed
	core:add_listener(
		"rhox_nagash_lahmia_slaanesh_diplomacy_event_positive",
		"PositiveDiplomaticEvent",
		function(context)
			local slaanesh_involved = self:faction_is_lahmia(context:recipient()) or self:faction_is_lahmia(context:proposer())
			local seducible_faction_involved = self:faction_is_seducible(context:recipient()) or self:faction_is_seducible(context:proposer())
			return slaanesh_involved and seducible_faction_involved
		end,
		function(context)
			local seducible_faction = context:recipient()
			if self:faction_is_lahmia(context:recipient()) then
				seducible_faction = context:proposer()
			end

			local resource_change = self.SI_on_signing_treaty

			if context:is_vassalage() then 
				resource_change = 9999
			end 

			if context:is_state_gift() then
				local gift_amount = context:state_gift_amount()
				
				if gift_amount >= 500 then
					resource_change = math.min(math.round(gift_amount / self.SI_per_gift), self.SI_per_gift_max)
				else
					resource_change = 0
				end
			end
			
			if resource_change > 0 then
				cm:faction_add_pooled_resource(seducible_faction:name(), self.SI_resource_key, self.SI_resource_factor_diplomacy, resource_change)
			end
		end,
		true
	)
    

end

function Rhox_Nagash_Lahmia_Coven_Influence:setup_vassalise_ritual_listener()
	core:add_listener(
		"rhox_nagash_lahmia_slaanesh_forced_vassal_ritual",
		"RitualCompletedEvent",
		function(context)
            local performing_faction = context:performing_faction()
			return context:ritual():ritual_category() == self.FORCE_VASSAL_ritual_category and performing_faction:name() == self.player_faction
		end,
		function(context)
			local performing_faction = context:performing_faction()
			local target_faction = context:ritual_target_faction()

			cm:force_diplomacy("faction:"..performing_faction:name(), "faction:"..target_faction:name(), "vassal", true, true, false)

			cm:force_make_vassal(performing_faction:name(), target_faction:name(), true)
			
			--cm:force_diplomacy("faction:"..performing_faction:name(), "faction:"..target_faction:name(), "form confederation", true, true, false) --this does not works
			
            local human_factions = cm:get_human_factions()
			for i = 1, #human_factions do
				local incident_faction = cm:get_faction(human_factions[i])
				cm:trigger_incident_with_targets(
					incident_faction:command_queue_index(), 
					"rhox_nagash_lahmia_force_vassalised", 
					target_faction:command_queue_index(),
					0,
					0,
					0,
					0,
					0
				)
			end

		end,
		true
	)
end


function Rhox_Nagash_Lahmia_Coven_Influence:setup_battle_and_occupation_listeners()
 
	core:add_listener(
   --changed
		"rhox_nagash_lahmia_post_battle_pooled_resource",
		"CharacterCompletedBattle",
		function(context)
			return cm:pending_battle_cache_faction_is_involved(self.player_faction)
		end,
		function(context)
			local num_attackers = cm:pending_battle_cache_num_attackers()
			local num_defenders =  cm:pending_battle_cache_num_defenders()
			
			for i = 1, num_attackers  do
				local char_cqi, mf_cqi, faction_key = cm:pending_battle_cache_get_attacker(i)
				local faction_interface = cm:get_faction(faction_key)
				if self:faction_is_seducible(faction_interface) then
					cm:faction_add_pooled_resource(faction_key, self.SI_resource_key, self.SI_resource_factor_battles, self.SI_per_battle)
				end
			end

			for i = 1, num_defenders do
				local char_cqi, mf_cqi, faction_key = cm:pending_battle_cache_get_defender(i)
				local faction_interface = cm:get_faction(faction_key)
				if self:faction_is_seducible(faction_interface) then
					cm:faction_add_pooled_resource(faction_key, self.SI_resource_key, self.SI_resource_factor_battles, self.SI_per_battle)
				end
			end
		end,
		true
	)

	core:add_listener(
		"rhox_nagash_lahmia_slaanesh_vassal_liberated",
		"FactionBecomesLiberationVassal",
		function(context)
			return self:faction_is_lahmia(context:liberating_character():faction())
		end,
		function(context)
			local liberated_faction= context:faction()
		
			if self:faction_is_seducible(liberated_faction) then
				cm:faction_add_pooled_resource(liberated_faction:name(), self.SI_resource_key, "other", 1000)
			end
		end,
		true
	);
end

function Rhox_Nagash_Lahmia_Coven_Influence:faction_is_seducible(faction_interface)
	return is_faction(faction_interface) and not faction_interface:is_null_interface() and not faction_interface:pooled_resource_manager():resource(self.SI_resource_key):is_null_interface()
end

function Rhox_Nagash_Lahmia_Coven_Influence:faction_is_lahmia(faction_interface)
   --changed
	return is_faction(faction_interface) and not faction_interface:is_null_interface() and faction_interface:name()==self.player_faction
end


function Rhox_Nagash_Lahmia_Coven_Influence:apply_bonus_resistance_from_regions(faction_interface)
	local region_count = faction_interface:region_list():num_items()
	local resistance_bundle = cm:create_new_custom_effect_bundle("wh3_main_bundle_seductive_influence_capacity_modifier")

	resistance_bundle:add_effect("rhox_nagash_lahmia_effect_pooled_resource_coven_influence_capacity_mod", "faction_to_faction_own_unseen", region_count*self.SI_capacity_per_region)
	resistance_bundle:add_effect("rhox_nagash_lahmia_effect_pooled_resource_coven_influence_resistance", "faction_to_faction_own_unseen", region_count*self.SI_resistance_per_region)
	
	resistance_bundle:set_duration(0);
	cm:apply_custom_effect_bundle_to_faction(resistance_bundle, faction_interface);
end

function Rhox_Nagash_Lahmia_Coven_Influence:apply_regular_diplomatic_seduction(faction_interface)
	local treaty_partners_lists = {
		faction_interface:factions_non_aggression_pact_with(),
		faction_interface:factions_trading_with(),
		faction_interface:factions_military_allies_with(),
		faction_interface:factions_defensive_allies_with(),
		faction_interface:vassals()
	}

	for index, partners in ipairs(treaty_partners_lists) do
		if partners:num_items() > 0 then
			for i, faction in model_pairs(partners) do
				if self:faction_is_seducible(faction) then
					cm:faction_add_pooled_resource(faction:name(), self.SI_resource_key, self.SI_resource_factor_diplomacy, self.SI_per_active_treaty)
				end
			end
		end
	end
end

function Rhox_Nagash_Lahmia_Coven_Influence:fire_vassal_available_incident(faction_key)
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		local incident_faction = cm:get_faction(human_factions[i])

		if not self:faction_is_lahmia(incident_faction) then
			return
		end

		local potential_vassal_cqi = cm:get_faction(faction_key):command_queue_index()

		local factions_met =  incident_faction:factions_met();

		local target_met = false

		for k, met_faction in model_pairs(factions_met) do
			if met_faction:name() == faction_key then
				target_met = true
				break
			end
		end

		if target_met then
			cm:trigger_incident_with_targets(
				incident_faction:command_queue_index(),
				"rhox_nagash_lahmia_faction_available_for_vassalisation", 
				potential_vassal_cqi,
				0,
				0,
				0,
				0,
				0
			);
		end

	end
end




cm:add_first_tick_callback(
    function() 
        if cm:get_faction(Rhox_Nagash_Lahmia_Coven_Influence.player_faction) and cm:get_faction(Rhox_Nagash_Lahmia_Coven_Influence.player_faction):is_human() then
            Rhox_Nagash_Lahmia_Coven_Influence:initialise() 
        end
    end
);












local function coven_visibility()
    --- get UI components
    local settlement_list = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list")
    if not settlement_list then
        return
    end
    local childCount = settlement_list:ChildCount()
    
    --- Turn on visibility in every settlement
    for i=1, childCount - 1  do
        local child = UIComponent(settlement_list:Find(i))
        if not child then
            return
        end
        local vampire_coven = find_uicomponent(child, "settlement_view", "hostile_views", "wh3_dlc25_emp_empire")
        if not vampire_coven then 
            return
        end
        vampire_coven:SetVisible(true)
    end
end

local function rhox_nagash_lahmia_start_coven_sight_listener()
    --- Trigger check for visibility when settlement is selected
    core:add_listener(
        "rhox_nagash_lahmia_less_vampire_coven_trigger",
        "SettlementSelected",
        true,
        function()
            core:get_tm():real_callback(function()
                coven_visibility()
            end, 1)
        end,
        true
    )


    --- Trigger whenever vampire coven slot is pressed
    core:add_listener(
        "rhox_nagash_lahmia_coven_click_trigger_1",
        "ComponentLClickUp",
        function (context)
            return context.string == "button_expand_slot"
        end,
        function()
            core:get_tm():real_callback(function()
                coven_visibility()
            end, 100)
        end,
        true
    )


    --- Trigger whenever vampire coven slot is pressed
    core:add_listener(
        "rhox_nagash_lahmia_coven_click_trigger_2",
        "ComponentLClickUp",
        function (context)
            return context.string == "square_building_button"
        end,
        function()
            core:get_tm():real_callback(function()
                coven_visibility()
            end, 100)
        end,
        true
    )
end



--do extra things when they establish a coven. Should apply to AI also
core:add_listener(
    "rhox_nagash_lahmia_CharacterGarrisonTargetAction",
    "CharacterGarrisonTargetAction",
    function(context)
        return context:agent_action_key() == "rhox_nagash_lahmia_agent_action_dignitary_hinder_settlement_establish_pirate_cove" and (context:mission_result_critial_success() or context:mission_result_success())
    end,
    function(context)
        local faction = context:character():faction()
        local faction_name = faction:name()
        local character = context:character()
        
    
        cm:apply_effect_bundle("rhox_nagash_lahmia_bundle_pirate_cove_created", faction_name, 15) --you won't get another agent while this effect bundle is on
        
        
    end,
    true
)



cm:add_first_tick_callback(
    function() 
        if cm:get_local_faction_name(true) == "wh3_main_vmp_lahmian_sisterhood" then --ui things should be local
            rhox_nagash_lahmia_start_coven_sight_listener()
            Rhox_Nagash_Lahmia_Coven_Influence:setup_panel_open_listeners()
        end
    end
);