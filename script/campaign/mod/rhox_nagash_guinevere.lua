rhox_nagash_guinevere_info={ --global so others can approach this too
    traits=nil, --trait, it will transfer to the next faction also
    rank=1, --rank, it will transfer to the next faction also
    previous_faction=nil, --she never visits two factions in a row
    remaining_turn=-100,
    trespass_immune_character_cqi =-1,
    bonus_turns =0,
    num_uses=0,
    fm_cqi = -1, --family member cqi, it stays valid while she is wounded and after the reassign
    current_faction=nil
}

local guin_base_turn = 20

local guin_culture={
    wh3_main_ksl_kislev = true,
    wh_main_brt_bretonnia = true,
    wh_main_emp_empire = true,
    wh_main_vmp_vampire_counts = true,
    mixer_teb_southern_realms = true,
    wh3_main_cth_cathay = true,
    mixer_nip_nippon = true
}

local function get_character_by_subtype(subtype, faction)
    local character_list = faction:character_list()

    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i)

        if character:character_subtype(subtype) then
            return character
        end
    end
    return false
end

local function rhox_nagash_guinevere_remove_trespass_immune()
    if rhox_nagash_guinevere_info.trespass_immune_character_cqi ~= -1 then
        local character = cm:get_character_by_cqi(rhox_nagash_guinevere_info.trespass_immune_character_cqi)
        cm:set_character_excluded_from_trespassing(character, false)
        out("Rhox Nagash Guin: Removing tresspass immune from guy with cqi: ".. rhox_nagash_guinevere_info.trespass_immune_character_cqi)
        rhox_nagash_guinevere_info.trespass_immune_character_cqi = -1
    end
end

local function rhox_nagash_guinevere_apply_trespass_immune(character)
    if character:has_skill("nag_skill_node_guinevere_diplo_01") == false then
        return --need skill
    end

    if character:is_embedded_in_military_force() then
        local mf = character:embedded_in_military_force()
        local general = mf:general_character()
        if not general then
            return
        end
        rhox_nagash_guinevere_info.trespass_immune_character_cqi = general:cqi()
        out("Rhox Nagash Guin: Applying tresspass immune to guy with cqi: ".. general:cqi())
        cm:set_character_excluded_from_trespassing(general, true)
    end
end

local function rhox_nagash_get_guin_by_fm_cqi(fm_cqi)
    if fm_cqi == -1 then
        return false
    end
    local fm = cm:get_family_member_by_cqi(fm_cqi)
    if not fm or fm:is_null_interface() then
        return false
    end
    local character = fm:character()
    if is_character(character) and character:character_subtype("nag_guinevere") then
        return character
    end
    return false
end

-- the stored fm_cqi first, then the whole world, so she is only spawned again when she is really dead
local function rhox_nagash_get_current_guin()
    local character = rhox_nagash_get_guin_by_fm_cqi(rhox_nagash_guinevere_info.fm_cqi)
    if character then
        return character
    end
    local all_factions = cm:model():world():faction_list()
    for i = 0, all_factions:num_items() - 1 do
        local character = get_character_by_subtype("nag_guinevere", all_factions:item_at(i))
        if character then
            return character
        end
    end
    return false
end

-- same as the mortarch script: next to the faction leader, otherwise next to the capital
local function rhox_nagash_get_guin_destination(guin_faction)
    local target_faction = guin_faction:name()
    local leader = guin_faction:faction_leader()
    local capital = guin_faction:home_region()

    if is_character(leader) and leader:is_wounded() == false then
        local x, y = cm:find_valid_spawn_location_for_character_from_character(target_faction, cm:char_lookup_str(leader), true, 10)
        if x > -1 then
            return x, y
        end
    end
    if is_region(capital) then
        local x, y = cm:find_valid_spawn_location_for_character_from_settlement(target_faction, capital:name(), false, true, 10)
        if x > -1 then
            return x, y
        end
    end
    return -1, -1
end

local function rhox_nagash_on_guin_arrived(new_character, guin_faction)
    local target_faction = guin_faction:name()
    rhox_nagash_guinevere_info.fm_cqi = new_character:family_member():command_queue_index()
    rhox_nagash_guinevere_info.current_faction = target_faction
    rhox_nagash_guinevere_info.bonus_turns = 0
    rhox_nagash_guinevere_info.num_uses = 0
    rhox_nagash_guinevere_info.remaining_turn = guin_base_turn
    cm:apply_effect_bundle("rhox_nagash_guinevere_remaining_turn_dummy", target_faction, rhox_nagash_guinevere_info.remaining_turn)

    if guin_faction:is_human() then --trigger incident
        cm:trigger_incident_with_targets(guin_faction:command_queue_index(), "rhox_nagash_guin_arrive", 0, 0, new_character:command_queue_index(), 0, 0, 0)
    end
end

-- first visit or she died somehow: spawn a new one with the stored traits and rank
local function rhox_nagash_spawn_new_guin(guin_faction, x, y)
    local target_faction = guin_faction:name()
    cm:spawn_agent_at_position(guin_faction, x, y, "dignitary", "nag_guinevere")
    local new_character = cm:get_most_recently_created_character_of_type(target_faction, "dignitary", "nag_guinevere")
    if not new_character then
        return
    end
    local forename = common:get_localised_string("names_name_1937224343")
    cm:change_character_custom_name(new_character, forename, "","","")
    ---aplying the previous bonuses
    local new_char_lookup = cm:char_lookup_str(new_character)
    local traits_to_copy = rhox_nagash_guinevere_info.traits
    if traits_to_copy then
        for i =1, #traits_to_copy do
            cm:force_add_trait(new_char_lookup, traits_to_copy[i])
        end
    end
    cm:add_agent_experience(new_char_lookup,rhox_nagash_guinevere_info.rank, true)
    rhox_nagash_on_guin_arrived(new_character, guin_faction)
end

local function rhox_nagash_send_guin()
    out("Rhox Nagash Guin: Sending Guin to somewhere")
    local all_factions = cm:model():world():faction_list();
    local visit_candidate ={}
    for i = 0, all_factions:num_items()-1 do
        local faction = all_factions:item_at(i);
        if guin_culture[faction:culture()] and faction:is_dead() == false and faction:has_faction_leader() and faction:faction_leader():has_military_force() then
            table.insert(visit_candidate, faction:name());
        end
    end;

    visit_candidate = cm:random_sort(visit_candidate);
    local target_faction = nil
    for i=1,#visit_candidate do
        if visit_candidate[i] ~= rhox_nagash_guinevere_info.previous_faction then
            target_faction = visit_candidate[i]
            break
        end
    end

    local lahmia_faction = cm:get_faction("wh3_dlc29_vmp_neferata")
    if cm:model():turn_number() ==5 and lahmia_faction and lahmia_faction:is_dead() ==false then
        target_faction = "wh3_dlc29_vmp_neferata"
    end

    if not target_faction then
        out("Rhox Nagash Guin: No available target faction found, ")
        return
    end
    local guin_faction = cm:get_faction(target_faction)
    local x, y = rhox_nagash_get_guin_destination(guin_faction)
    if x == -1 then
        out("Rhox Nagash Guin: No valid position in this faction, terminating the sending sequence")
        return
    end
    out("Rhox Nagash Guin: Guin going to ".. target_faction)

    rhox_nagash_guinevere_remove_trespass_immune()
    local guin = rhox_nagash_get_current_guin()

    if not guin then
        rhox_nagash_spawn_new_guin(guin_faction, x, y)
        return
    end

    -- keep traits and rank in case she has to be spawned again later
    rhox_nagash_guinevere_info.traits = guin:all_traits()
    rhox_nagash_guinevere_info.rank = guin:rank()

    -- same as the archaon subjugation: reassign by the character cqi, then end the convalescence so a wounded one comes back right away
    local guin_fm_cqi = guin:family_member():command_queue_index()
    if guin:faction():name() ~= target_faction then
        cm:reassign_character(guin:cqi(), guin_faction:command_queue_index())
    end
    if guin:is_wounded() then
        cm:stop_character_convalescing(guin:cqi())
    end
    cm:callback(
        function()
            local moved_guin = rhox_nagash_get_guin_by_fm_cqi(guin_fm_cqi) or get_character_by_subtype("nag_guinevere", guin_faction)
            if not moved_guin then
                out("Rhox Nagash Guin: Couldn't find her after the reassign")
                return
            end
            cm:teleport_to(cm:char_lookup_str(moved_guin), x, y)
            rhox_nagash_on_guin_arrived(moved_guin, guin_faction)
        end,
        0.1
    )
end

local function rhox_nagash_guinevere_check_depart(character, faction)

    rhox_nagash_guinevere_remove_trespass_immune()--this is last turn remove the trespass immune

    if rhox_nagash_guinevere_info.remaining_turn <= 0 then
        rhox_nagash_guinevere_info.previous_faction = faction:name()
        rhox_nagash_guinevere_info.remaining_turn = -100;

        local value = 500+ 1000*rhox_nagash_guinevere_info.num_uses

        if faction:is_human() then
            local incident_builder = cm:create_incident_builder("rhox_nagash_guin_leave")
            incident_builder:add_target("default", character)
            local payload_builder = cm:create_payload()
            payload_builder:treasury_adjustment(value)
            payload_builder:text_display("rhox_nagash_guinevere_departs")
            payload_builder:text_display("rhox_nagash_guinevere_presents")
            incident_builder:set_payload(payload_builder)
            cm:launch_custom_incident_from_builder(incident_builder, faction)

            rhox_nagash_send_guin() --human shouldn't keep her for the rest of the turn
        else
            cm:treasury_mod(faction:name(), value)--just add gold for the ai, WorldStartRound will move her
        end
    end
end

local function rhox_nagash_guinevere_apply_prostitute(character, faction)
    if character:bonus_values():scripted_value("rhox_nagash_guine_prostitute", "value") == 0 or not character:region() then
        return --don't do it
    end
    local region = character:region()
    local owning_faction = region:owning_faction()
    if not owning_faction then
        return
    end

    if owning_faction:has_effect_bundle("rhox_nagash_guinevere_relation_increased_hidden") then
        return --don't apply bonus again
    end

    if guin_culture[owning_faction:culture()] then
        cm:apply_effect_bundle("rhox_nagash_guinevere_relation_increased_hidden", owning_faction:name(), 5)
        local value = math.floor((character:bonus_values():scripted_value("rhox_nagash_guine_prostitute", "value")/5)  +0.2)  --doing this just in case
        out("Rhox Nagash Guin: Applying Prostitute bonus ".. value .. " to faction ".. owning_faction:name())
        cm:apply_dilemma_diplomatic_bonus(faction:name(), owning_faction:name(), value)
    end
end

local function rhox_nagash_guinevere_apply_high_vamp_corruption_bonus(character)
    if character:has_skill("nag_skill_node_guinevere_diplo_05") == false then
        return--don't do it if she don't have skill
    end
    if cm:get_corruption_value_in_region(character:region(), "wh3_main_corruption_vampiric") > 80 and character:is_embedded_in_military_force() then
        local mf = character:embedded_in_military_force()
        out("Rhox Nagash Guin: Applying high vamp corruption bonus to military force cqi: ".. mf:command_queue_index())
        cm:apply_effect_bundle_to_force("rhox_nagash_guinevere_high_corruption_bonus", mf:command_queue_index(), 2) --turn is 2 so players could see it
    end
end

local function rhox_nagash_guinevere_apply_bonus_duration(character, faction)
    local value = character:bonus_values():scripted_value("rhox_nagash_guine_longer_stay", "value")

    if value == rhox_nagash_guinevere_info.bonus_turns then --nothing to do
        return
    end

    local bonus_value = value - rhox_nagash_guinevere_info.bonus_turns

    out("Rhox Nagash Guin: Applying bonus remaining turn: ".. bonus_value)

    rhox_nagash_guinevere_info.bonus_turns= value
    rhox_nagash_guinevere_info.remaining_turn = rhox_nagash_guinevere_info.remaining_turn+ bonus_value
    cm:apply_effect_bundle("rhox_nagash_guinevere_remaining_turn_dummy", faction:name(), bonus_value)
end

local function rhox_nagash_guinevere_check_peace_broker(character, faction)
    if character:has_skill("nag_skill_node_guinevere_diplo_08") == false then
        return
    end
    if(cm:model():random_percent(90)) then --10% so return with 90% chance
        return
    end

    local war_list = faction:factions_at_war_with()
    local target_enemy_candidate = {}
    for j = 0, war_list:num_items() - 1 do
        local current_enemy = war_list:item_at(j);
        if guin_culture[current_enemy:culture()] then
            table.insert(target_enemy_candidate, current_enemy)
        end
    end

    if #target_enemy_candidate == 0 then
        return
    end

    target_enemy_candidate = cm:random_sort(target_enemy_candidate)

    local target_enemy = target_enemy_candidate[1]

    core:remove_listener("rhox_nagash_guinvere_peace_DilemmaChoiceMadeEvent")
    core:add_listener(
        "rhox_nagash_guinvere_peace_DilemmaChoiceMadeEvent",
        "DilemmaChoiceMadeEvent",
        function(context)
            return context:dilemma() == "rhox_nagash_guinevere_peace_broker"
        end,
        function(context)
            local choice = context:choice();

            if choice == 0 then
                out("Rhox Nagash Guin: Let's make peace!")
                cm:force_make_peace(faction:name(), target_enemy:name())
            end
        end,
        false
    )

    --trigger dilemma
    local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_guinevere_peace_broker");
    local payload_builder = cm:create_payload();

    payload_builder:text_display("rhox_nagash_guinevere_peace")
    payload_builder:treasury_adjustment(-5000)
    dilemma_builder:add_choice_payload("FIRST", payload_builder);
    payload_builder:clear();

    dilemma_builder:add_choice_payload("SECOND", payload_builder);

    dilemma_builder:add_target("default", target_enemy);
    dilemma_builder:add_target("target_faction_1", target_enemy);

    cm:launch_custom_dilemma_from_builder(dilemma_builder, faction);
end

core:add_listener(
    "rhox_nagash_guin_giving_turn_start",
    "WorldStartRound",
    function(context)
        if cm:model():turn_number() < 5 then --don't trigger it until the turn 5
            return false
        end

		if rhox_nagash_guinevere_info.remaining_turn ~= -100 then
			rhox_nagash_guinevere_info.remaining_turn = rhox_nagash_guinevere_info.remaining_turn -1
			out("Rhox Nagash Guin: Checking depart: Remaining turn ".. rhox_nagash_guinevere_info.remaining_turn)
		end

		if rhox_nagash_guinevere_info.remaining_turn < -1 then --it means Geinever faction is killed. If the player is using recruit defeated lords, Guin is executed or something like that
			rhox_nagash_guinevere_info.remaining_turn = -100
		end

        return rhox_nagash_guinevere_info.remaining_turn <= -100
    end,
    function(context)
        rhox_nagash_send_guin()
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
        out("Rhox Nagash Guin: Check GUIN abilities")
        rhox_nagash_guinevere_remove_trespass_immune()
        rhox_nagash_guinevere_apply_trespass_immune(character)

        rhox_nagash_guinevere_apply_prostitute(character, faction)
        rhox_nagash_guinevere_apply_high_vamp_corruption_bonus(character)
        rhox_nagash_guinevere_apply_bonus_duration(character, faction)
        rhox_nagash_guinevere_check_peace_broker(character, faction)

        cm:callback(function()
            rhox_nagash_guinevere_check_depart(character, faction)--do it last
            end,
        2)
    end,
    true
)

core:add_listener(
    "rhox_nagash_guin_embed_listener",
    "CharacterCharacterTargetAction",
    function(context)
        return context:agent_action_key() == "wh2_main_agent_action_dignitary_assist_army_replenish_troops" and context:character():character_subtype_key() == "nag_guinevere" and context:character():has_skill("nag_skill_node_guinevere_diplo_01") and rhox_nagash_guinevere_info.trespass_immune_character_cqi == -1 --last is to not apply to the two different mfs
    end,
    function(context)
        local character = context:character()
        rhox_nagash_guinevere_apply_trespass_immune(character)
    end,
    true
)

core:add_listener(
    "rhox_nagash_guin_settlement_listener",
    "CharacterGarrisonTargetAction",
    function(context)
        return context:character():character_subtype_key() == "nag_guinevere" and context:character():bonus_values():scripted_value("rhox_nagash_guine_settlement", "value") ~= 0 and (context:mission_result_critial_success() or context:mission_result_success())
    end,
    function(context)
        out("Rhox Nagash Guin: Garrison action Success!")
        local character = context:character()
        local faction = character:faction()
        local region = context:garrison_residence():region();
        local owning_faction = region:owning_faction()
        if not owning_faction then
            return--it's garrison target so they're likely to have it, but just in case
        end

        if owning_faction:has_effect_bundle("rhox_nagash_guinevere_relation_increased_hidden") then
            return --don't apply bonus again
        end

        if guin_culture[owning_faction:culture()] then
            cm:apply_effect_bundle("rhox_nagash_guinevere_relation_increased_hidden", owning_faction:name(), 5)
            local value = math.floor((character:bonus_values():scripted_value("rhox_nagash_guine_settlement", "value")/5)  +0.2)  --doing this just in case
            out("Rhox Nagash Guin: Applying settlement action diplo bonus ".. value .. " to faction ".. owning_faction:name())
            cm:apply_dilemma_diplomatic_bonus(faction:name(), owning_faction:name(), value)
        end
    end,
    true
)

---------------------------guin increase number of uses

core:add_listener(
    "rhox_nagash_guin_increase_num_character_action",
    "CharacterCharacterTargetAction",
    function(context)
        return context:character():character_subtype_key() == "nag_guinevere" and (context:mission_result_critial_success() or context:mission_result_success()) and context:agent_action_key() ~= "wh2_main_agent_action_dignitary_assist_army_replenish_troops" --shouldn't count the embedding one
    end,
    function(context)
        rhox_nagash_guinevere_info.num_uses = rhox_nagash_guinevere_info.num_uses+1
    end,
    true
)

core:add_listener(
    "rhox_nagash_guin_increase_num_settlement_action",
    "CharacterGarrisonTargetAction",
    function(context)
        return context:character():character_subtype_key() == "nag_guinevere" and (context:mission_result_critial_success() or context:mission_result_success())
    end,
    function(context)
        rhox_nagash_guinevere_info.num_uses = rhox_nagash_guinevere_info.num_uses+1
    end,
    true
)
core:add_listener(
    "rhox_nagash_guin_increase_num_battle",
    "CharacterCompletedBattle",
    function(context)
        local character = context:character()
        local faction = character:faction()
        local guin = get_character_by_subtype("nag_guinevere", faction)

        local pb = context:pending_battle();

        return pb:has_been_fought() and character:won_battle() and character:has_military_force() and guin and guin:is_embedded_in_military_force() and guin:embedded_in_military_force():command_queue_index() == character:military_force():command_queue_index()
    end,
    function(context)
        rhox_nagash_guinevere_info.num_uses = rhox_nagash_guinevere_info.num_uses+1
        out("Rhox Nagash Guin: Guin embedded army wins the battle, increasing the num to ".. rhox_nagash_guinevere_info.num_uses)
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
