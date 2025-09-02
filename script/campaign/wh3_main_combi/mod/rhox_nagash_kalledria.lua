rhox_nagash_kalledria = {
	kalledria_faction = "mixer_vmp_wailing_conclave",
	high_corruption_bundle_key = "rhox_nagash_kalledria_high_vampiric_corruption",
	corruption_threshold = 20,
	spirit_essence = "wh3_dlc24_ksl_spirit_essence",
	hex_ritual_category = "KALLEDRIA_HEX_RITUAL",
	hex_6_key = "rhox_nagash_kalledria_ritual_hex_6",
	hex_6_story_panel_key = "rhox_nagash_kalledria_story_panel_hex_6",
	hex_data = {
		rhox_kalledria_purification_chant = {
			mission =  "wh3_main_camp_narrative_shared_defeat_initial_enemy_01",
			spirit_essence_requirement = false,
			hex = "rhox_nagash_kalledria_ritual_hex_5",
			story_panel = "rhox_nagash_kalledria_story_panel_hex_5",
			tech = "rhox_nagash_kalledria_hex_upgrade_5",
			incident = "rhox_nagash_kalledria_story_panel_hex_5",
			incident_received = false,
			remove_bundle = "rhox_nagash_kalledria_ritual_hex_5",
		},
		rhox_kalledria_covens_cursemark = {
			hex = "rhox_nagash_kalledria_ritual_hex_1",
			spirit_essence_requirement = 100,
			story_panel = "rhox_nagash_kalledria_story_panel_hex_1",
			tech = "rhox_nagash_kalledria_hex_upgrade_1",
			incident = "rhox_nagash_kalledria_performed_hex_1",
			incident_received = "rhox_nagash_kalledria_performed_hex_1_received",
			persistent_vfx_duration = 5,
		},
		rhox_kalledria_jinxed_land = {
			hex = {
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_the_witchwood",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_forest_of_gloom",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_gaean_vale",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_gryphon_wood",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_heart_of_the_jungle",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_jungles_of_chian",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_laurelorn_forest",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_oak_of_ages",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_the_haunted_forest",
				"wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_the_sacred_pools",
			},
			spirit_essence_requirement = 200,
			story_panel = "rhox_nagash_kalledria_story_panel_hex_2",
			tech = "rhox_nagash_kalledria_hex_upgrade_2",
			incident = "rhox_nagash_kalledria_performed_hex_2",
			incident_received = "rhox_nagash_kalledria_performed_hex_2_received",
			remove_bundle = "rhox_nagash_kalledria_ritual_hex_2",
		},
		rhox_kalledria_bewitching_allure = {
			hex = "rhox_nagash_kalledria_ritual_hex_4",
			spirit_essence_requirement = 400,
			story_panel = "rhox_nagash_kalledria_story_panel_hex_4",
			tech = "rhox_nagash_kalledria_hex_upgrade_4",
			incident = "rhox_nagash_kalledria_story_panel_hex_4",
			incident_received = "rhox_nagash_kalledria_performed_hex_4_received",
			persistent_vfx_duration = 5,
		},
		rhox_kalledria_recreant_spirit = {
			hex = "rhox_nagash_kalledria_ritual_hex_3",
			spirit_essence_requirement = 1000,
			story_panel = "rhox_nagash_kalledria_story_panel_hex_3",
			tech = "rhox_nagash_kalledria_hex_upgrade_3",
			incident = "rhox_nagash_kalledria_performed_hex_3",
			incident_received = "rhox_nagash_kalledria_performed_hex_3_received",
		}
	}
}

function rhox_nagash_kalledria:initialise()
	local kalledria_faction_obj = cm:get_faction(self.kalledria_faction)
	if not kalledria_faction_obj then return false end
	
	if cm:is_new_game() then
		-- tracks the spirit essence pooled resource for the faction
		cm:start_pooled_resource_tracker_for_faction(self.kalledria_faction)
        for hex, data in pairs(self.hex_data) do
            --out("Rhox Kalledria faction key: ".. self.kalledria_faction .. "// Tech Key: ".. data.tech)
			cm:lock_technology(self.kalledria_faction, data.tech)
		end

	end
	
	self:update_hex_spirit_essence_requirements()
	

	
	if kalledria_faction_obj:is_human() then
		-- unlock hex when mission completes
		core:add_listener(
			"rhox_nagash_kalledria_hex_unlock_mission",
			"MissionSucceeded",
			function(context)
				return context:faction():name() == self.kalledria_faction
			end,
			function(context)
				local mission_key = context:mission():mission_record_key()
				local unlocked_hex_data = false
				
				-- lookup the respective hex data
				for hex, data in pairs(self.hex_data) do
					if data.mission == mission_key then
						unlocked_hex_data = data
						break
					end
				end
				
				if unlocked_hex_data then
					local faction = context:faction()
					local faction_name = faction:name()
					local count = cm:get_saved_value("rhox_kalledria_hexes_unlocked_count") or 0
					
					self:unlock_hex(unlocked_hex_data.hex)
					
					cm:unlock_technology(faction_name, unlocked_hex_data.tech)
					
					cm:trigger_incident(faction_name, unlocked_hex_data.story_panel, true, true)
					count = count + 1
					cm:set_saved_value("rhox_kalledria_hexes_unlocked_count", count)
					
					if count == 5 then
						cm:callback(function() cm:trigger_incident(faction_name, self.hex_6_story_panel_key, true, true) end, 0.2)
						cm:unlock_ritual(faction, self.hex_6_key)
					end
				end
			end,
			true
		)
		
	end
	
	core:add_listener(
		"rhox_nagash_kalledria_turn_start",
		"FactionTurnStart",
		function(context)
			return context:faction():name() == self.kalledria_faction
		end,
		function(context)
			local faction = context:faction()
			
			if faction:num_provinces()<1 then
                return
			end
			
			-- add spirit essence when a province has low corruption
			for _, province in model_pairs(faction:provinces()) do
				local region = province:regions():item_at(0)
				
				if province:has_effect_bundle(self.high_corruption_bundle_key) then
					cm:remove_effect_bundle_from_faction_province(self.high_corruption_bundle_key, region)
				end
				
				if cm:get_corruption_value_in_region(region, "wh3_main_corruption_vampiric") > self.corruption_threshold then
					cm:apply_effect_bundle_to_faction_province(self.high_corruption_bundle_key, region, 2)--so it will cancel out itself on next turn
				end

			end
		end,
		true
	)
	
	-- tracks the pooled resource spent
	core:add_listener(
		"rhox_nagash_kalledria_spirit_essence_spent",
		"PooledResourceChanged",
		function(context)
			return context:resource():key() == self.spirit_essence and context:faction():name() == self.kalledria_faction
		end,
		function(context)
            local faction = context:faction()
			self:update_hex_spirit_essence_requirements()
			
			local spirit_essence_value = self:get_total_spirit_essence_consumed()
			
			for hex, data in pairs(self.hex_data) do
				local save_value = cm:get_saved_value(hex .. "_mission_triggered") or 0
				
				if data.spirit_essence_requirement and spirit_essence_value >= data.spirit_essence_requirement and save_value < 1 then
					self:unlock_hex(data.hex)
                    cm:unlock_technology(faction:name(), data.tech)
					cm:set_saved_value(hex .. "_mission_triggered", 2)
					
					local count = cm:get_saved_value("rhox_kalledria_hexes_unlocked_count") or 0
					count = count + 1
					cm:set_saved_value("rhox_kalledria_hexes_unlocked_count", count)
					
					if count == 5 then
                        local incident_builder = cm:create_incident_builder(self.hex_6_story_panel_key)
						cm:callback(function() cm:launch_custom_incident_from_builder(incident_builder, faction) end, 0.2)
						cm:unlock_ritual(faction, self.hex_6_key)
					end
				end
			end
		end,
		true
	)
	
	core:add_listener(
		"rhox_nagash_kalledria_hex_performed",
		"RitualCompletedEvent",
		function(context)
			return context:ritual():ritual_category() == self.hex_ritual_category
		end,
		function(context)
			-- pan camera to target when ritual completes
			local faction = context:performing_faction()
			local faction_cqi = faction:command_queue_index()
			local is_local_faction = faction:name() == cm:get_local_faction_name(true)
			local ritual = context:ritual()
			local ritual_key = ritual:ritual_key():gsub("_empowered", "") -- ensure the ritual key isn't the empowered version
			local ritual_target = ritual:ritual_target()
			local target_type = ritual_target:target_type()
			local cached_x, cached_y, cached_d, cached_b, cached_h = cm:get_camera_position()
			local target_faction_cqi = 0
			local region_cqi = 0
			local region_name = false
			local character_cqi = 0
			
			if target_type == "REGION" then
				local region = ritual_target:get_target_region()
				local settlement = region:settlement()
				region_cqi = region:cqi()
				region_name = region:name()
				target_faction_cqi = region:owning_faction():command_queue_index()
				
				if is_local_faction then
					cm:scroll_camera_from_current(true, 1, {settlement:display_position_x(), settlement:display_position_y(), cached_d, cached_b, cached_h})
				end
				
				cm:add_scripted_composite_scene_to_settlement("wh3_dlc24_campaign_mother_ostankya_hex", "wh3_dlc24_campaign_mother_ostankya_hex", region, 0, 0, true, true, true)
			elseif target_type == "MILITARY_FORCE" then
				local mf = ritual_target:get_target_force()
				
				if mf:has_general() then
					target_faction_cqi = mf:faction():command_queue_index()
					character_cqi = mf:general_character():command_queue_index()
					
					cm:callback(
						function()
							local character = cm:get_character_by_cqi(character_cqi)
							
							if character then
								if is_local_faction then
									cm:scroll_camera_from_current(true, 1, {character:display_position_x(), character:display_position_y(), cached_d, cached_b, cached_h})
								end
								
								cm:add_scripted_composite_scene_to_logical_position("wh3_dlc24_campaign_mother_ostankya_hex", "wh3_dlc24_campaign_mother_ostankya_hex", character:logical_position_x(), character:logical_position_y(), 0, 0, true, true, true)
							end
						end,
						0.2
					)
				end
			end
			
			local incident = false
			local incident_received = false
			local remove_bundle = false
			local persistent_vfx_duration = false
			
			-- look up the hex data based on the ritual performed
			local function get_performed_hex_data(data)
				local found_remove_bundle = false
				local found_persistent_vfx_duration = false
				
				if data.remove_bundle then
					found_remove_bundle = data.remove_bundle
				end
				if data.persistent_vfx_duration then
					found_persistent_vfx_duration = data.persistent_vfx_duration
				end
				
				return data.incident, data.incident_received, found_remove_bundle, found_persistent_vfx_duration
			end
			for hex, data in pairs(self.hex_data) do
				if is_table(data.hex) then
					for i = 1, #data.hex do
						if data.hex[i] == ritual_key then
							incident, incident_received, remove_bundle, persistent_vfx_duration = get_performed_hex_data(data)
							break
						end
					end
				elseif data.hex == ritual_key then
					incident, incident_received, remove_bundle, persistent_vfx_duration = get_performed_hex_data(data)
					break
				end
			end
			
			-- remove any effect bundles applied by the ritual payload
			if remove_bundle then
				if region_name then
					cm:remove_effect_bundle_from_region(remove_bundle, region_name)
				else
					cm:remove_effect_bundle_from_characters_force(remove_bundle, character_cqi)
				end
			end
			
			if incident then
				cm:trigger_incident_with_targets(faction_cqi, incident, 0, 0, character_cqi, 0, region_cqi, 0)
			end
			
			if incident_received and faction_cqi ~= target_faction_cqi then
				cm:trigger_incident_with_targets(target_faction_cqi, incident_received, 0, 0, character_cqi, 0, region_cqi, 0)
			end
			
			-- trigger the final battle when hex 6 is performed
			if ritual_key == self.hex_6_key then
                local culture = context:ritual_target_faction():culture()
                local faction_list = cm:get_factions_by_culture(culture)
                if not faction_list then return end --because of error showing
                for i = 1, #faction_list do
                    local current_faction = faction_list[i]
                    
                    if not current_faction:is_dead() then
                        cm:apply_effect_bundle(self.hex_6_key, current_faction:name(), 5)--it's not infinite like the vanilla
                    end
                end
			end
			
			-- remove corruption from province when hex 5 is performed
			if ritual_key:starts_with(self.hex_data.rhox_kalledria_purification_chant.hex) then
				local corruption_types = {
					"chaos",
					"skaven",
					"khorne",
					"nurgle",
					"slaanesh",
					"tzeentch",
				}
				
				local prm = ritual_target:get_target_region():province():pooled_resource_manager()
				
				for i = 1, #corruption_types do
					cm:pooled_resource_factor_transaction(prm:resource("wh3_main_corruption_" .. corruption_types[i]), "local_populace", -100)
				end
                cm:pooled_resource_factor_transaction(prm:resource("wh3_main_corruption_vampiric"), "local_populace", 100)
			end
			
			-- add persistent vfx if needed
			if persistent_vfx_duration then
				if character_cqi > 0 then
					cm:add_character_vfx(character_cqi, "scripted_effect27", false)
					cm:add_turn_countdown_event(cm:get_character_by_cqi(character_cqi):faction():name(), persistent_vfx_duration, "ScriptEventOstankyaCharacterVFXExpires", tostring(character_cqi))
				elseif region_name then
					local garrison_residence = cm:get_region(region_name):garrison_residence()
					local garrison_residence_cqi = garrison_residence:command_queue_index()
					cm:add_garrison_residence_vfx(garrison_residence_cqi, "scripted_effect27", false)
					cm:add_turn_countdown_event(garrison_residence:faction():name(), persistent_vfx_duration, "ScriptEventOstankyaRegionVFXExpires", region_name)
				end
			end
		end,
		true
	)
	
	-- remove persistent vfx when it expires
	core:add_listener(
		"rhox_nagash_kalledria_remove_vfx",
		"ScriptEventOstankyaCharacterVFXExpires",
		true,
		function(context)
			cm:remove_character_vfx(tonumber(context.string), "scripted_effect27")
		end,
		true
	)
	core:add_listener(
		"rhox_nagash_kalledria_remove_vfx",
		"ScriptEventOstankyaRegionVFXExpires",
		true,
		function(context)
			cm:remove_garrison_residence_vfx(cm:get_region(context.string):garrison_residence():command_queue_index(), "scripted_effect27")
		end,
		true
	)

    -- spawn disciple armies for mother ostankya
	core:add_listener(
		"rhox_nagash_kalledria_create_disciple_army",
		"FactionTurnStart",
		function(context)
			return context:faction():name() == self.kalledria_faction
		end,
		function()
			for _, faction in model_pairs(cm:model():world():faction_list()) do
				local bv = cm:get_factions_bonus_value(faction, "rhox_nagash_kalledria_disciple_army")
				
				if bv > 0 then
					local save_value = faction:name() .. "_create_disciple_army_kalledria"
					
					if cm:get_saved_value(save_value) then
						cm:set_saved_value(save_value, false)
					else
						local region_list = faction:region_list()
						local region_to_spawn_in = region_list:item_at(cm:random_number(region_list:num_items()) - 1):name()
						local x, y = cm:find_valid_spawn_location_for_character_from_settlement(self.kalledria_faction, region_to_spawn_in, false, true, 12)
						
						if x > 0 then
							local units = "wh2_dlc11_cst_inf_syreens,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_cav_hexwraiths,wh_main_vmp_inf_cairn_wraiths"
							
							if bv > 1 then
								units = "wh2_dlc11_cst_inf_syreens,wh2_dlc11_cst_inf_syreens,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_cav_hexwraiths,wh_main_vmp_cav_hexwraiths,wh_main_vmp_inf_cairn_wraiths,wh_main_vmp_inf_cairn_wraiths"
							end
							
							cm:create_force_with_general(
								self.kalledria_faction,
								units,
								region_to_spawn_in,
								x,
								y,
								"general",
								"rhox_nagash_banshee_summoned",
								"",
								"",
								"",
								"",
								false,
								function(cqi)
									cm:apply_effect_bundle_to_characters_force("wh3_dlc24_bundle_ksl_mother_ostankya_disciple_army", cqi, 0)
									cm:replenish_action_points(cm:char_lookup_str(cqi))
								end
							)
						end
						
						cm:set_saved_value(save_value, true)
					end
				end
			end
		end,
		true
	)


end


function rhox_nagash_kalledria:unlock_hex(hex)
	local faction = cm:get_faction(self.kalledria_faction)
	
	if is_table(hex) then
		for i = 1, #hex do
			cm:unlock_ritual(faction, hex[i])
		end
	else
		cm:unlock_ritual(faction, hex)
	end
end

function rhox_nagash_kalledria:update_hex_spirit_essence_requirements()
	if not cm:get_faction(self.kalledria_faction):is_human() then return end
	
	local spirit_essence_value = self:get_total_spirit_essence_consumed()
	
	for hex, data in pairs(self.hex_data) do
		local hex = data.hex
		
		-- find the first available ritual in the list
		if is_table(hex) then
			for i = 1, #hex do
				if not cco("CcoCampaignFaction", self.kalledria_faction):Call("UnlockableRitualList.Filter(RitualContext.Key == \"" .. hex[i] .. "\").IsEmpty") then
					hex = hex[i]
					break
				end
			end
		end
		
		if data.spirit_essence_requirement then
			common.set_context_value(hex .. "_spirit_essence_remaining", math.max(data.spirit_essence_requirement - spirit_essence_value, 0))
		end
	end
end

function rhox_nagash_kalledria:get_total_spirit_essence_consumed()
	return cm:get_total_pooled_resource_spent_for_faction(self.kalledria_faction, self.spirit_essence, "hexes") + cm:get_total_pooled_resource_spent_for_faction(self.kalledria_faction, self.spirit_essence, "witchs_hut_brews")
end



cm:add_first_tick_callback(
    function()
        if cm:model():campaign_name_key() == "cr_combi_expanded" then
            table.insert(rhox_nagash_kalledria.hex_data.rhox_kalledria_jinxed_land.hex, "wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_the_far_place")
            table.insert(rhox_nagash_kalledria.hex_data.rhox_kalledria_jinxed_land.hex, "wh3_dlc24_ritual_ksl_hex_2_kalledria_ie_aranyas_glade")
        end
        rhox_nagash_kalledria:initialise()
        if cm:get_local_faction_name(true) == rhox_nagash_kalledria.kalledria_faction then           
        
            local parent_ui = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
            local result1 = core:get_or_create_component("rhox_nagash_nagash_kalledria_resource_holder", "ui/campaign ui/rhox_nagash_kalledria_pooled_resource.twui.xml", parent_ui)
            local result2 = core:get_or_create_component("rhox_nagash_nagash_kalledria_hex_holder", "ui/campaign ui/rhox_nagash_kalledria_hex_holder.twui.xml", parent_ui)
            
            if result2 then
                local kalledriaCCO = cco('CcoCampaignFaction', tostring(cm:get_local_faction(true):command_queue_index()))
                result2:SetContextObject(kalledriaCCO)
            end

        end
    end
)