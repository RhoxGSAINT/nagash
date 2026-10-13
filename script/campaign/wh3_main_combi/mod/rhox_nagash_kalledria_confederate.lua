local kalledria_mission_key = "rhox_nagash_vmp_mission_confederate_lord_kalledria"

vampire_bloodlines.confederation_missions[kalledria_mission_key]={
			target_faction = "mixer_vmp_wailing_conclave",
			ritual_key = "rhox_nagash_vmp_ritual_confederate_lord_kalledria",
			lord_subtype = "nag_vmp_kalledria",
			limit_power_objective = true,
			payload = {
				"text_display dummy_confederate_lord_kalledria"
			},
			unique_objectives_config = {
				banshee_count = 1,
				banshee_rank = 30,
				banshee_subtype = "wh_main_vmp_banshee",
				scripted_banshee_key = "rhox_nagash_vmp_scripted_kalledria_banshee_rank",
				banshee_override_text = "mission_text_text_rhox_nagash_vmp_kalledria_banshee_rank",

				forest_count = 1,
				forest_climate = "climate_magicforest",
				scripted_forest_key = "rhox_nagash_vmp_scripted_kalledria_magic_forest",
				forest_override_text = "mission_text_text_rhox_nagash_vmp_kalledria_magic_forest",
			},

			add_unique_objectives = function(faction_key, mm, mission_data, mission_key)
				local objective_data = mission_data.unique_objectives_config

				local objectives = {
					generate_SCRIPTED_MISSION_objective(
						objective_data.scripted_banshee_key,
						objective_data.banshee_override_text,
						objective_data.banshee_count,
						0,
						false
					),

					generate_SCRIPTED_MISSION_objective(
						objective_data.scripted_forest_key,
						objective_data.forest_override_text,
						objective_data.forest_count,
						0,
						false
					),
				}

				vampire_bloodlines:add_non_scripted_objectives(mm, objectives)
			end,

			post_trigger_callback = function(faction_key, mission_data, mission_key)
				vampire_bloodlines:rhox_update_kalledria_confederation_objectives(faction_key)
			end
		}
vampire_bloodlines.confederation_rituals["rhox_nagash_vmp_ritual_confederate_lord_kalledria"]="mixer_vmp_wailing_conclave"

function vampire_bloodlines:rhox_update_kalledria_confederation_objectives(faction_key)
	local mission_data = self.confederation_missions[kalledria_mission_key]
	local objective_data = mission_data.unique_objectives_config
	local faction = cm:get_faction(faction_key)

	if not faction or faction:is_null_interface() then
		return
	end

	-- Banshee hero rank

	local banshee_completed_saved_value_key = faction_key .. "_kalledria_confederation_banshee_completed"
	local banshee_completed = cm:get_saved_value(banshee_completed_saved_value_key) or false

	if not banshee_completed then
		local banshee_count = 0
		local character_list = faction:character_list()

		for i = 0, character_list:num_items() - 1 do
			local character = character_list:item_at(i)

			if character:character_subtype(objective_data.banshee_subtype)
				and character:rank() >= objective_data.banshee_rank
			then
				banshee_count = banshee_count + 1
			end
		end

		local current_banshee_count = math.min(banshee_count, objective_data.banshee_count)

		cm:set_scripted_mission_text(
			kalledria_mission_key,
			objective_data.scripted_banshee_key,
			objective_data.banshee_override_text,
			current_banshee_count,
			objective_data.banshee_count
		)

		if current_banshee_count >= objective_data.banshee_count then
			cm:complete_scripted_mission_objective(
				faction_key,
				kalledria_mission_key,
				objective_data.scripted_banshee_key,
				true
			)

			cm:set_saved_value(banshee_completed_saved_value_key, true)
		end
	end

	-- Magical forest regions

	local forest_completed_saved_value_key = faction_key .. "_kalledria_confederation_forest_completed"
	local forest_completed = cm:get_saved_value(forest_completed_saved_value_key) or false

	if not forest_completed then
		local forest_count = 0
		local region_list = faction:region_list()

		for i = 0, region_list:num_items() - 1 do
			local region = region_list:item_at(i)

			if region:settlement():get_climate() == objective_data.forest_climate then
				forest_count = forest_count + 1
			end
		end

		local current_forest_count = math.min(forest_count, objective_data.forest_count)

		cm:set_scripted_mission_text(
			kalledria_mission_key,
			objective_data.scripted_forest_key,
			objective_data.forest_override_text,
			current_forest_count,
			objective_data.forest_count
		)

		if current_forest_count >= objective_data.forest_count then
			cm:complete_scripted_mission_objective(
				faction_key,
				kalledria_mission_key,
				objective_data.scripted_forest_key,
				true
			)

			cm:set_saved_value(forest_completed_saved_value_key, true)
		end
	end
end

local function is_valid_kalledria_confederation_faction(faction)
	local mission_data = vampire_bloodlines.confederation_missions[kalledria_mission_key]
	local target_faction = cm:get_faction(mission_data.target_faction)

	return faction
		and faction:is_null_interface() == false
		and faction:is_human()
		and faction:subculture() == "wh_main_sc_vmp_vampire_counts"
		and faction:name() ~= mission_data.target_faction
		and target_faction
		and target_faction:is_human() == false
end

-- Kalledria - Update when a Banshee ranks up
core:add_listener(
	"RhoxVampireBloodlinesKalledriaBansheeRankUp",
	"CharacterRankUp",
	function(context)
		local objective_data = vampire_bloodlines.confederation_missions[kalledria_mission_key].unique_objectives_config
		local character = context:character()

		return is_valid_kalledria_confederation_faction(character:faction())
			and character:character_subtype(objective_data.banshee_subtype)
			and character:rank() >= objective_data.banshee_rank
	end,
	function(context)
		vampire_bloodlines:rhox_update_kalledria_confederation_objectives(context:character():faction():name())
	end,
	true
)

-- Kalledria - Update when a region changes hands
core:add_listener(
	"RhoxVampireBloodlinesKalledriaRegionChange",
	"RegionFactionChangeEvent",
	function(context)
		local region = context:region()

		-- razed/abandoned regions have no owner, so owning_faction() is a null interface
		return region:is_abandoned() == false
			and region:owning_faction():is_null_interface() == false
			and is_valid_kalledria_confederation_faction(region:owning_faction())
	end,
	function(context)
		local faction_key = context:region():owning_faction():name()

		cm:callback(
			function()
				vampire_bloodlines:rhox_update_kalledria_confederation_objectives(faction_key)
			end,
			0.1
		)
	end,
	true
)

-- Kalledria - Fallback/state refresh
core:add_listener(
	"RhoxVampireBloodlinesKalledriaTurnStartUpdate",
	"FactionTurnStart",
	function(context)
		return is_valid_kalledria_confederation_faction(context:faction())
	end,
	function(context)
		vampire_bloodlines:rhox_update_kalledria_confederation_objectives(context:faction():name())
	end,
	true
)
