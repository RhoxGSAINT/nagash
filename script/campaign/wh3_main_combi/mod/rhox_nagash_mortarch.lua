local nagash_faction = "mixer_nag_nagash"

RHOX_NAGASH_MORTARCH={}

RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs = {
    nag_mortarch_arkhan_unlock = {
        "nag_arkhan_battle_1",
        "nag_arkhan_battle_2",
        "nag_arkhan_battle_3",
        "nag_mortarch_arkhan_event_1",
        "nag_mortarch_arkhan_event_2",
        "nag_mortarch_arkhan_event_3",
        "nag_mortarch_arkhan_unlock",
        "nag_arkhan_proclamation",
        "nag_arkhan_archai"
    },
    nag_mortarch_luthor_unlock = {
        "nag_luthor_battle_1",
        "nag_luthor_battle_2",
        "nag_luthor_battle_3",
        "nag_mortarch_luthor_event_1",
        "nag_mortarch_luthor_event_2",
        "nag_mortarch_luthor_event_3",
        "nag_mortarch_luthor_unlock",
        "nag_luthor_proclamation",
        "nag_luthor_archai"
    },
    nag_mortarch_mannfred_unlock = {
        "nag_mannfred_battle_1",
        "nag_mannfred_battle_2",
        "nag_mannfred_battle_3",
        "nag_mortarch_mannfred_event_1",
        "nag_mortarch_mannfred_event_2",
        "nag_mortarch_mannfred_event_3",
        "nag_mortarch_mannfred_unlock",
        "nag_mannfred_proclamation",
        "nag_mannfred_archai"
    },
    nag_mortarch_krell_unlock = {
        "nag_krell_battle_1",
        "nag_krell_battle_2",
        "nag_krell_battle_3",
        "nag_mortarch_krell_event_1",
        "nag_mortarch_krell_event_2",
        "nag_mortarch_krell_event_3",
        "nag_mortarch_krell_unlock",
        "nag_krell_proclamation",
        "nag_krell_archai"
    },
    nag_mortarch_neferata_unlock = {
        "nag_neferata_battle_1",
        "nag_neferata_battle_2",
        "nag_neferata_battle_3",
        "nag_mortarch_neferata_event_1",
        "nag_mortarch_neferata_event_2",
        "nag_mortarch_neferata_event_3",
        "nag_mortarch_neferata_unlock",
        "nag_neferata_proclamation",
        "nag_neferata_archai"
    },
    nag_mortarch_vlad_unlock = {
        "nag_vlad_battle_1",
        "nag_vlad_battle_2",
        "nag_vlad_battle_3",
        "nag_mortarch_vlad_event_1",
        "nag_mortarch_vlad_event_2",
        "nag_mortarch_vlad_event_3",
        "nag_mortarch_vlad_unlock",
        "nag_vlad_proclamation",
        "nag_vlad_archai"
    },
    nag_mortarch_dieter_unlock = {
        "nag_dieter_battle_1",
        "nag_dieter_battle_2",
        "nag_dieter_battle_3",
        "nag_mortarch_dieter_event_1",
        "nag_mortarch_dieter_event_2",
        "nag_mortarch_dieter_event_3",
        "nag_mortarch_dieter_unlock",
        "nag_dieter_proclamation",
        "nag_dieter_archai"
    },
    nag_mortarch_dk_unlock = {
        "nag_dk_battle_1",
        "nag_dk_battle_2",
        "nag_dk_battle_3",
        "nag_mortarch_dk_event_1",
        "nag_mortarch_dk_event_2",
        "nag_mortarch_dk_event_3",
        "nag_mortarch_dk_unlock",
        "nag_dk_proclamation",
        "nag_dk_archai"
    }

}

RHOX_NAGASH_MORTARCH.archai_tech_key_to_mortarch={
    nag_arkhan_archai="nag_mortarch_arkhan",
    nag_vlad_archai="nag_mortarch_vlad",
    nag_mannfred_archai="nag_mortarch_mannfred",
    nag_luthor_archai="nag_mortarch_luthor",
    nag_krell_archai="nag_mortarch_krell",
    nag_dieter_archai="nag_mortarch_dieter",
    nag_neferata_archai="nag_mortarch_neferata",
    nag_dk_archai="nag_mortarch_dk"
}


RHOX_NAGASH_MORTARCH.mort_key_to_faction_key ={
    ["nag_mortarch_arkhan"]="wh2_dlc09_tmb_followers_of_nagash",
    ["nag_mortarch_vlad"]="wh_main_vmp_schwartzhafen",
    ["nag_mortarch_mannfred"]="wh_main_vmp_vampire_counts",
    ["nag_mortarch_luthor"]="wh2_dlc11_cst_vampire_coast",
    ["nag_mortarch_dieter"]="mixer_vmp_helsnicht",
    ["nag_mortarch_azhag"]="wh2_dlc15_grn_bonerattlaz",
    ["nag_mortarch_neferata"]="wh3_main_vmp_lahmian_sisterhood",
    ["nag_mortarch_dk"]="ovn_tmb_dread_king",
}


RHOX_NAGASH_MORTARCH.mort_key_to_name ={
    ["nag_mortarch_arkhan"]="nag_nagash_name_arkhan",
    ["nag_mortarch_vlad"]="nag_nagash_name_vlad",
    ["nag_mortarch_mannfred"]="nag_nagash_name_mannfred",
    ["nag_mortarch_luthor"]="nag_nagash_name_luthor",
    ["nag_mortarch_neferata"]="nag_nagash_name_neferata",
    ["nag_mortarch_krell"]="nag_nagash_name_krell",
    ["nag_mortarch_dieter"]="nag_nagash_name_dieter",
    ["nag_mortarch_azhag"]="nag_nagash_name_azhag",
    ["nag_mortarch_dk"]="nag_nagash_name_dk"
    
}

RHOX_NAGASH_MORTARCH.mort_follower_key_to_name={
    ["nag_mortarch_isabella"]="nag_nagash_name_isabella",
    ["nag_mortarch_hand"]="nag_nagash_name_hand",
    ["nag_mortarch_drekla"]="nag_nagash_name_drekla"
}

RHOX_NAGASH_MORTARCH.mort_key_to_region ={
    ["nag_mortarch_arkhan"]="wh3_main_combi_region_quatar",
    ["nag_mortarch_vlad"]="wh3_main_combi_region_castle_drakenhof",
    ["nag_mortarch_mannfred"]="wh3_main_combi_region_ka_sabar",
    ["nag_mortarch_luthor"]="wh3_main_combi_region_the_awakening",
    ["nag_mortarch_neferata"]="wh3_main_combi_region_silver_pinnacle",
    ["nag_mortarch_krell"]="wh3_main_combi_region_morgheim",
    ["nag_mortarch_dieter"]="wh3_main_combi_region_aarnau",
    ["nag_mortarch_azhag"]="wh3_main_combi_region_nagashizzar",
    ["nag_mortarch_dk"]="wh3_main_combi_region_black_pyramid_of_nagash"
}


RHOX_NAGASH_MORTARCH.mort_key_to_success_chance ={
    ["nag_mortarch_arkhan"]=100,
    ["nag_mortarch_vlad"]=35,
    ["nag_mortarch_mannfred"]=35,
    ["nag_mortarch_luthor"]=35,
    ["nag_mortarch_dieter"]=35,
    ["nag_mortarch_neferata"] = 35,
    ["nag_mortarch_azhag"]=100, --AI won't use it this is for human to evade the script breaking
    ["nag_mortarch_dk"] = 10,
}

RHOX_NAGASH_MORTARCH.mort_key_to_units={
    ["nag_mortarch_arkhan"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_inf_nehekhara_warriors_0",
        "nag_vanilla_tmb_veh_skeleton_chariot_0",
        "nag_vanilla_tmb_mon_tomb_scorpion_0",
        "nag_nagashi_guard_halb",
        "nag_nagashi_guard_halb",
    },
    ["nag_mortarch_vlad"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_vmp_cav_black_knights_3",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_nagashi_guard_halb",
        "nag_vanilla_vmp_cav_blood_knights_0",
    },
    ["nag_mortarch_mannfred"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_cav_black_knights_0",
        "nag_vanilla_vmp_cav_black_knights_0",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_nagashi_guard",
    },
    ["nag_mortarch_luthor"]={
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_art_carronade",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_nagashi_guard_halb",
        "nag_vanilla_cst_mon_necrofex_colossus_0",
    },
    ["nag_mortarch_neferata"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_tmb_inf_tomb_guard_0",
        "nag_vanilla_tmb_inf_tomb_guard_0",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_nagashi_guard_halb",
        "nag_nagashi_guard_halb",
    },
    ["nag_mortarch_krell"]= {                               
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_nagashi_guard",
    },
    ["nag_mortarch_dieter"]= {                               
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_vanilla_vmp_mon_vargheists",
    },
    ["nag_mortarch_azhag"]={                               
        "vigpro_nagash_skeleton_orcs",
        "vigpro_nagash_skeleton_orcs",
        "vigpro_nagash_skeleton_goblin_range",
        "vigpro_nagash_skeleton_goblin_range",
        "vigpro_nagash_skeleton_goblin_melee",
        "vigpro_nagash_skeleton_goblin_melee",
        "vigpro_nagash_skeleton_troll_1h",
        "vigpro_nagash_skeleton_troll_2h",
        "vigpro_nagash_skeleton_giant",
    },
    ["nag_mortarch_dk"]={
        "ovn_dk_inf_skeleton_javelinmen_no_caps",
        "ovn_dk_inf_skeleton_javelinmen_no_caps",
        "ovn_dk_mon_skeleton_elephant",
        "ovn_dk_inf_skeleton_hoplites",
        "ovn_dk_inf_skeleton_hoplites",
        "ovn_dk_cav_royal_guard_lancers",
        "ovn_dk_inf_skeleton_pikemen",
        "ovn_dk_inf_tomb_guardian",
        "ovn_dk_inf_tomb_guardian_peltasts"
    }
}




RHOX_NAGASH_RAISE_DEAD_SEA_UNITS={
    nag_vanilla_cst_inf_zombie_gunnery_mob_0= {2, 20, 2},
    nag_vanilla_cst_inf_zombie_gunnery_mob_1= {1, 20, 1},
    nag_vanilla_cst_inf_zombie_deckhands_mob_1= {0, 10, 1},
    nag_vanilla_cst_inf_zombie_deckhands_mob_0= {1, 50, 3},
    nag_vanilla_cst_mon_bloated_corpse_0= {1, 35, 3}
}


local rhox_nagash_saved_agent_info={
}

--pass the faction key(string)
function rhox_kill_faction(faction_key)
	--check the faction key is a string
	if not is_string(faction_key) then
		script_error("ERROR: kill_faction() called but supplied faction key [" .. tostring(faction_key) .. "] is not a string");
		return false;
	end;
	
	local faction = cm:model():world():faction_by_key(faction_key); 
	
	if faction:is_null_interface() == false then
		cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
		cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
		
		cm:kill_all_armies_for_faction(faction);
		
		local region_list = faction:region_list();
		
		for j = 0, region_list:num_items() - 1 do
			local region = region_list:item_at(j):name();
			cm:set_region_abandoned(region);
		end;
		
		cm:callback(
			function() 
				cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "");
				cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
			end,
			0.5
		);
	end;
end;


function RHOX_NAGASH_MORTARCH:rhox_nagash_save_agent_info(mort_key, faction, old_agent_subtype)
    local character = nil
    local loop_char_list = faction:character_list()
    for i = 0, loop_char_list:num_items() - 1 do
        local looping = loop_char_list:item_at(i)
        --out("Rhox Nagash: Current character subtype: "..looping:character_subtype_key())
        if looping:character_subtype_key() == old_agent_subtype then
            out("Rhox Nagash: Found the ".. old_agent_subtype)
            character = looping
            break;
        end
    end
    if character then 
        rhox_nagash_saved_agent_info[mort_key]={
            mf = character:military_force(),
            rank = character:rank(),
            fm_cqi = character:family_member():command_queue_index(),
            character_details = character:character_details(),
            faction_key = character:faction():name(),
            character_forename = character:get_forename(),
            character_surname = character:get_surname(),
            parent_force = character:embedded_in_military_force(),
            subtype = character:character_subtype_key(),
            traits = character:all_traits(),
            ap = character:action_points_remaining_percent()
        }
        out("Rhox Nagash: Saved the guy")
    end
    return
end


function RHOX_NAGASH_MORTARCH:rhox_nagash_spawn_follower_hero(mort_key, mort_type_key, liege_key)
    local mort_character = nil
    
    local loop_char_list = cm:get_faction(nagash_faction):character_list()
    
	for i = 0, loop_char_list:num_items() - 1 do
		local looping = loop_char_list:item_at(i)
		--out("Rhox Nagash: Current character subtype: "..looping:character_subtype_key())
		if looping:character_subtype_key() == liege_key then
            out("Rhox Nagash: Found the liege")
			mort_character = looping
			break
		end
	end
	local new_x, new_y
	if mort_character and mort_character:has_military_force() then 
		new_x, new_y = cm:find_valid_spawn_location_for_character_from_character("mixer_nag_nagash", cm:char_lookup_str(mort_character), true, 10)
	else
		new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement("mixer_nag_nagash", self.mort_key_to_region[liege_key], false, true, 10)
	end


    local new_character= nil
    
    cm:spawn_agent_at_position(cm:get_faction(nagash_faction), new_x, new_y, mort_type_key, mort_key)
    new_character = cm:get_most_recently_created_character_of_type(nagash_faction, mort_type_key, mort_key)

    local old_char_details = rhox_nagash_saved_agent_info[mort_key]

    if old_char_details and new_character then
        out("Rhox Nagash: Found old character")
        
        
        local new_char_lookup = cm:char_lookup_str(new_character)
        local traits_to_copy = old_char_details.traits
        if traits_to_copy then
            for i =1, #traits_to_copy do
                
                local trait_to_copy = traits_to_copy[i]
                cm:force_add_trait(new_char_lookup, trait_to_copy)
            end
        end
        cm:add_agent_experience(new_char_lookup,old_char_details.rank, true)
    else --there wasn't an old character maybe a mod, recruit defeated or whatever
        out("Rhox Nagash: There wasn't an old character")
        local nagash_character = cm:get_faction(nagash_faction):faction_leader()
        local nagash_rank = nagash_character:rank()
        cm:add_agent_experience(cm:char_lookup_str(new_character:command_queue_index()), math.floor(nagash_rank), true)
    end
    
    local forename = common.get_localised_string(self.mort_follower_key_to_name[mort_key])
    cm:change_character_custom_name(new_character, forename, "","","")
    
    cm:replenish_action_points(cm:char_lookup_str(new_character))
end




function RHOX_NAGASH_MORTARCH:upgrade_into_mortarch(faction, faction_key, mort_key)
    out("Rhox Nagash Upgrading")
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(faction_key, "wh3_main_combi_region_nagashizzar", false, true, 5)
    
    local character = faction:faction_leader() --real leader before the change
    
    out("Rhox Nagash: This Mort's obedience chance is: "..RHOX_NAGASH_MORTARCH.mort_key_to_success_chance[mort_key])
    if cm:get_faction(nagash_faction):is_human() ==false and (faction:is_human() or cm:model():random_percent(100-RHOX_NAGASH_MORTARCH.mort_key_to_success_chance[mort_key])) then
        cm:force_declare_war(nagash_faction, faction_key, true, true) --declare war if mortarch was a player
        cm:set_saved_value("failed_to_get" .. mort_key, true)
        
        local incident_key = "rhox_nagash_declare_war" --basic one for Vampire Coast
        if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
            incident_key = "rhox_nagash_declare_war_tk"
        elseif faction:culture() == "wh2_dlc11_cst_vampire_coast" then
            incident_key = "rhox_nagash_declare_war_coast"
        elseif faction:culture() == "mixer_vmp_jade_vampires" then
            incident_key = "rhox_nagash_declare_war_jv"
        end
        
        local human_factions = cm:get_human_factions()
        for i = 1, #human_factions do
            cm:trigger_incident_with_targets(
                cm:get_faction(human_factions[i]):command_queue_index(),
                incident_key,
                faction:command_queue_index(),
                0,
                0,
                0,
                0,
                0
            )
        end
        return --and do nothing
    end
    

    
    
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    faction_key,
    "",
    "wh3_main_combi_region_nagashizzar",
    new_x,
    new_y,
    "general",
    "nag_nagash_husk",
    "",
    "",
    "",
    "",
    true);     --dummy leader we're going to kill him after
    out("Rhox Nagash: Spawned dummy leader!")
    local character_to_kill = faction:faction_leader() --fake leader to kill
    
    local old_char_details = {
        mf = character:military_force(),
        rank = character:rank(),
        fm_cqi = character:family_member():command_queue_index(),
        character_details = character:character_details(),
        faction_key = character:faction():name(),
        character_forename = character:get_forename(),
        character_surname = character:get_surname(),
        parent_force = character:embedded_in_military_force(),
        subtype = character:character_subtype_key(),
        traits = character:all_traits(),
        ap = character:action_points_remaining_percent()
    }
    --[[
    out("Rhox Nagash: old character details")
    for k, detail in pairs(old_char_details) do
        out(tostring(detail))
    end
    --]]

    
    local new_character

    --out("This leader does not have a military force. Maybe he is wounded")
    local region_key = self.mort_key_to_region[mort_key]
    local is_at_sea = false--nagash_character:is_at_sea()
    --out("Rhox Nagash: region key: "..region_key)
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, is_at_sea, true, 15)
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    nagash_faction,
    table.concat(RHOX_NAGASH_MORTARCH.mort_key_to_units[mort_key], ","),
    region_key,
    new_x,
    new_y,
    "general",
    mort_key,
    "",
    "",
    "",
    "",
    false,
    function(cqi)
        new_character = cm:get_character_by_cqi(cqi)
    end); 
    --out("Rhox Nagash character details: ")
    --out(old_char_details.character_forename)
    --out(old_char_details.character_surname)
    --new_character = cm:get_most_recently_created_character_of_type(nagash_faction):military_force()

    
    
    
    out("Rhox Nagash: Created a new character")
    if new_character then
		CUS:update_new_character(old_char_details, new_character, 1)
	end
    out("Rhox Nagash: Upgrading a new character")
    local forename = common.get_localised_string(self.mort_key_to_name[mort_key])
    cm:change_character_custom_name(new_character, forename, "","","")
    
    
    if mort_key == "nag_mortarch_vlad" then --save isabella info in case of Vlad
		self:rhox_nagash_save_agent_info("nag_mortarch_isabella", faction, "wh_pro02_vmp_isabella_von_carstein_hero")
		if cm:get_faction(nagash_faction):is_human()== false then
        	self:rhox_nagash_spawn_follower_hero("nag_mortarch_isabella","dignitary",mort_key);
		end
    end
    
    if mort_key == "nag_mortarch_dk" then --save hand info in the case of DK
		self:rhox_nagash_save_agent_info("nag_mortarch_hand", faction, "elo_hand_of_nagash")
		if cm:get_faction(nagash_faction):is_human()== false then
        	self:rhox_nagash_spawn_follower_hero("nag_mortarch_hand","champion",mort_key);
		end
    end
    
    if mort_key == "nag_mortarch_luthor" and vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua") then --spawn drekla too in case of Luthor and player owns the Mixu LL 
		self:rhox_nagash_save_agent_info("nag_mortarch_drekla", faction, "cst_drekla")
        self:rhox_nagash_spawn_follower_hero("nag_mortarch_drekla","dignitary",mort_key);
    end
    
    if mort_key == "nag_mortarch_neferata" and cm:get_faction(nagash_faction):is_human() then --only when Nagash is human
        rhox_nagash_guinevere_info.remaining_turn = 5000--she'll never leave Nagash. Also stop the killing function at once.
        cm:callback(--they might have just give Guin a new home
            function()
                rhox_nagash_kill_guin()
                local x, y = cm:find_valid_spawn_location_for_character_from_character(nagash_faction, cm:char_lookup_str(cm:get_faction(nagash_faction):faction_leader()), true, 10)
                cm:spawn_agent_at_position(cm:get_faction(nagash_faction), x, y, "dignitary", "nag_guinevere")
                local new_character = cm:get_most_recently_created_character_of_type(nagash_faction, "dignitary", "nag_guinevere")
                if new_character then
                    local forename = common:get_localised_string("names_name_1937224343")
                    cm:change_character_custom_name(new_character, forename, "","","")
                    ---aplying the previous bonuses
                    local new_char_lookup = cm:char_lookup_str(new_character)
                    local traits_to_copy = rhox_nagash_guinevere_info.traits
                    if traits_to_copy then
                        for i =1, #traits_to_copy do
                            local trait_to_copy = traits_to_copy[i]
                            cm:force_add_trait(new_char_lookup, trait_to_copy)
                        end
                    end
                    cm:add_agent_experience(new_char_lookup,rhox_nagash_guinevere_info.rank, true)
                    rhox_nagash_guinevere_info.current_faction = "mixer_nag_nagash"
                    rhox_nagash_guinevere_info.cqi = new_character:cqi()
                end
                rhox_nagash_guinevere_info.remaining_turn = 5000--she'll never leave Nagash. Also stop the killing function at once.
            end,
        4)
        
    end


    out("Rhox Nagash: After follower check")
    cm:callback(--so the finding thing can happen earlier
        function()
            if cm:get_faction(nagash_faction):is_human() then
                rhox_kill_faction(faction_key) -- if nagash is a human, destroy the faction
            else
                local human_factions = cm:get_human_factions()
                for i = 1, #human_factions do
                
                    local incident_key = "rhox_nagash_mortarch_notify" --basic one for Vampire Coast
                    if faction:culture() == "wh2_dlc09_tmb_tomb_kings" then
                        incident_key = "rhox_nagash_mortarch_notify_tk"
                    elseif faction:culture() == "wh2_dlc11_cst_vampire_coast" then
                        incident_key = "rhox_nagash_mortarch_notify_coast"
                    elseif faction:culture() == "mixer_vmp_jade_vampires" then
                        incident_key = "rhox_nagash_mortarch_notify_jv"
                    end
                    cm:trigger_incident_with_targets(
                        cm:get_faction(human_factions[i]):command_queue_index(),
                        incident_key,
                        faction:command_queue_index(),
                        0,
                        0,
                        0,
                        0,
                        0
                    )
                end
                
                cm:force_confederation(nagash_faction, faction_key) --make nagash siphon the mortarch if it's AI
                cm:suppress_immortality(character_to_kill:family_member():command_queue_index(), true)
                cm:kill_character(cm:char_lookup_str(character_to_kill), true)
                cm:remove_effect_bundle("wh_main_bundle_confederation_vmp", nagash_faction)
            end
        end,
        5
    );

    
        
end



function RHOX_NAGASH_MORTARCH:spawn_mortarch(mort_key) --ones without a faction, or faction already has died
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local nagash_rank = nagash_character:rank()
    
    --local new_x, new_y = cm:find_valid_spawn_location_for_character_from_position(nagash_faction, x, y, 5) --spawn him near Nagash
    
    local new_character
    --out("Rhox Nagash: new character subtype: "..mort_key)
    --local region_key = nagash_character:region():name()
    local region_key = self.mort_key_to_region[mort_key]
    --local is_at_sea = nagash_character:is_at_sea()
    --out("Rhox Nagash: region key: "..region_key)
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, false, true, 5)
    --out("New x: "..new_x)
    --out("New y: "..new_y)
    
    
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    nagash_faction,
    table.concat(RHOX_NAGASH_MORTARCH.mort_key_to_units[mort_key], ","),
    region_key,
    new_x,
    new_y,
    "general",
    mort_key,
    "",
    "",
    "",
    "",
    false,
    function(cqi)
        new_character = cm:get_character_by_cqi(cqi)
    end);
    
    
    
    --local new_character = cm:get_most_recently_created_character_of_type(nagash_faction)
    local forename = common.get_localised_string(self.mort_key_to_name[mort_key])
    cm:change_character_custom_name(new_character, forename, "","","")
    cm:add_agent_experience(cm:char_lookup_str(new_character:command_queue_index()), math.floor(nagash_rank), true)
    
    
    if mort_key == "nag_mortarch_vlad" and cm:get_faction(nagash_faction):is_human()==false then --spawn isabella too in case of Vlad and Nagash is AI
        self:rhox_nagash_spawn_follower_hero("nag_mortarch_isabella","dignitary",mort_key);
    end
    
    if mort_key == "nag_mortarch_dk" and cm:get_faction(nagash_faction):is_human()==false then --spawn hand too in the case of DK and Nagash is AI
        self:rhox_nagash_spawn_follower_hero("nag_mortarch_hand","champion",mort_key);
    end
    
    if mort_key == "nag_mortarch_luthor" and vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua") then --spawn drekla too in case of Luthor and player owns the Mixu LL 
        self:rhox_nagash_spawn_follower_hero("nag_mortarch_drekla","dignitary",mort_key);
    end
    
    if mort_key == "nag_mortarch_neferata" and cm:get_faction(nagash_faction):is_human() then --only when Nagash is human
        cm:callback(--they might have just give Guin a new home
            function()
                rhox_nagash_kill_guin()
                local x, y = cm:find_valid_spawn_location_for_character_from_character(nagash_faction, cm:char_lookup_str(cm:get_faction(nagash_faction):faction_leader()), true, 10)
                cm:spawn_agent_at_position(cm:get_faction(nagash_faction), x, y, "dignitary", "nag_guinevere")
                local new_character = cm:get_most_recently_created_character_of_type(nagash_faction, "dignitary", "nag_guinevere")
                if new_character then
                    local forename = common:get_localised_string("names_name_1937224343")
                    cm:change_character_custom_name(new_character, forename, "","","")
                    ---aplying the previous bonuses
                    local new_char_lookup = cm:char_lookup_str(new_character)
                    local traits_to_copy = rhox_nagash_guinevere_info.traits
                    if traits_to_copy then
                        for i =1, #traits_to_copy do
                            local trait_to_copy = traits_to_copy[i]
                            cm:force_add_trait(new_char_lookup, trait_to_copy)
                        end
                    end
                    cm:add_agent_experience(new_char_lookup,rhox_nagash_guinevere_info.rank, true)
                    rhox_nagash_guinevere_info.cqi = new_character:cqi()
                end
                rhox_nagash_guinevere_info.remaining_turn = 5000--she'll never leave Nagash.
            end,
        5)
        
    end
end

                           
function RHOX_NAGASH_MORTARCH:rhox_nagash_disable_mortarch_factions_seduction() --used in other script
    for mort_key, faction_key in pairs(RHOX_NAGASH_MORTARCH.mort_key_to_faction_key) do
        cm:faction_add_pooled_resource(faction_key, "rhox_nagash_influence", "other", -100)
    end
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_the_sentinels", "rhox_nagash_influence", "other", -100) --you have to defeat them
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_exiles_of_nehek", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_khemri", "rhox_nagash_influence", "other", -100)
    cm:faction_add_pooled_resource("wh2_dlc09_tmb_lybaras", "rhox_nagash_influence", "other", -100)

end
                           
function RHOX_NAGASH_MORTARCH:mortarch_unlock_listeners() --used in other script
    out("Rhox Nagash: Setting out Nagash Mortarch listeners")
    core:add_listener(
    --- When an "unlock" tech is researched, spawn the related Morty.
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            --out("Rhox Nagash: Researched technology: "..context:technology())
            return self.rhox_nagash_unlock_techs[context:technology()]
        end,
        function(context)
            out("Rhox Nagash: Hey, you unlocked a Mortarch technology!")
            
            local tech_key = context:technology()
            
            --- format "nag_mortarch_arkhan_unlock" to "nag_mortarch_arkhan"
            local mort_key = string.gsub(tech_key, "_unlock", "")
            
            local mort_clean_key = string.gsub(mort_key, "nag_mortarch", "nag")
            out("Mort key: "..mort_key)
            local nagash_interface = cm:get_faction(nagash_faction)

            
            
            local faction_key = self.mort_key_to_faction_key[mort_key]
            if faction_key ~= nil then --do something more if that Mortarch has faction
                out("faction key: "..faction_key)
                local faction = cm:get_faction(faction_key)
                if not faction:is_dead() then
                    self:upgrade_into_mortarch(faction, faction_key, mort_key)
                else
                    self:spawn_mortarch(mort_key)--just spawn one as the faction is already dead. Not going to get anything from the leader since recruit defeated lords might be affecting them
                end
            else
                self:spawn_mortarch(mort_key)--just spawn one as this one does not have a faction
            end
            

            
            if mort_key == "nag_mortarch_luthor" then --add cst units to the raise dead pool_setup his mind
                cm:set_saved_value("rhox_nagash_luthor_recruited", true)
                local faction = cm:get_faction(nagash_faction)
                local raise_dead_cap = faction:bonus_values():scripted_value("rhox_nagash_raisedead_cap", "value") --apply the cap bonus also
                local new_character = cm:get_most_recently_created_character_of_type(nagash_faction, "general", mort_key)
                if new_character then
                    rhox_nagash_setup_mortarch_harkon_mind(new_character)
                end
                local region_list = cm:model():world():region_manager():region_list()
                for i=0,region_list:num_items()-1 do
                    local region= region_list:item_at(i)
                    for key, unit in pairs(RHOX_NAGASH_RAISE_DEAD_SEA_UNITS) do
                        cm:add_unit_to_province_mercenary_pool(region, key, "raise_dead", unit[1], unit[2], unit[3]+raise_dead_cap, 1, "", "mixer_nag_nagash", "", false, "wh_main_vmp_province_pool")
                    end
                end
            end
            
            
                
        end,
        true
    )
    
    local mortarch_follower_hero_techs={
        ["nag_mortarch_vlad_event_1"] = {"nag_mortarch_isabella", "dignitary", "nag_mortarch_vlad"}, --subtype key, type key, his liege subtype key
        ["nag_mortarch_dk_event_1"] ={"nag_mortarch_hand", "champion", "nag_mortarch_dk"}
        
    }
    
    core:add_listener(
        "Mortarch_follower_hero_Unlock",
        "ResearchCompleted",
        function(context)
            return mortarch_follower_hero_techs[context:technology()]
        end,
        function(context)
            local tech_key = context:technology()
            local mort = mortarch_follower_hero_techs[tech_key]
            --out("Rhox Nagash: Mort Keys: ".. mort[1] .."/" .. mort[2] .. "/" .. mort[3])
			self:rhox_nagash_spawn_follower_hero(mort[1],mort[2],mort[3]);
        end,
        true
    )
    
    core:add_listener(
        "NagashMortunlockMissions",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs[mission:mission_record_key()] --mission and unlock has the same name
        end,
        function(context)
            out("Rhox Nagash: You finished the mission!")
            local mission = context:mission()
            local unlock_tech_table = RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs[mission:mission_record_key()]
            for i, technology in pairs(unlock_tech_table) do
                out("Rhox Nagash Current technology: "..technology)
                cm:unlock_technology(nagash_faction, technology)
            end
        end,
        true
    )
    
    core:add_listener(
        "NagashMortunlockMissions_cancelled",--failsafe
        "MissionCancelled",
        function(context)
            local mission = context:mission()
            return RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs[mission:mission_record_key()] --mission and unlock has the same name
        end,
        function(context)
            out("Rhox Nagash: Mission got cancelled, but you get the Mortarchs anyway!")
            local mission = context:mission()
            local unlock_tech_table = RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs[mission:mission_record_key()]
            for i, technology in pairs(unlock_tech_table) do
                out("Rhox Nagash Current technology: "..technology)
                cm:unlock_technology(nagash_faction, technology)
            end
        end,
        true
    )

    
    
    
    core:add_listener(
        "rhox_azhag_mission_success",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return mission:mission_record_key() == "rhox_nagash_get_azhag_mission" and cm:get_saved_value("rhox_nagash_mortarch_azhag_check") ~= true --don't call it if player already saw the garrison event
        end,
        function(context)
            out("Rhox Nagash: You finished the Azhag mission!")
            local mort_key = "nag_mortarch_azhag"
            
            
            
            local faction_key = self.mort_key_to_faction_key[mort_key]
            local faction = cm:get_faction(faction_key)
            if not faction:is_dead() then
                --fire incident
                cm:trigger_incident_with_targets(cm:get_faction(nagash_faction):command_queue_index(), "rhox_nagash_azhag_mortarch", 0,0,
                faction:faction_leader():cqi(), 0,0,0)
                self:upgrade_into_mortarch(faction, faction_key, mort_key)
            end
            cm:set_saved_value("rhox_nagash_mortarch_azhag_check", true)--for failsafe mission thing
        end,
        true
    )

    core:add_listener(--TODO remove it after the patch. This is to prevent players from getting two Azhag
        "rhox_azhag_failsafe_todo",
        "CharacterTurnStart",
        function(context)
            local character = context:character()
            return character:character_subtype_key() == "nag_mortarch_azhag"
        end,
        function(context)
            cm:set_saved_value("rhox_nagash_mortarch_azhag_check", true)--for failsafe mission thing
        end,
        true
    )


    core:add_listener(
        "rhox_nagash_enter_garrison",
        "CharacterEntersGarrison",
        function(context)
            local character = context:character()    
            local region_object = context:garrison_residence():region()
            local region_name = region_object:name()
            return character:character_subtype_key() == "nag_nagash_boss" and character:rank() >= 40 and region_name == "wh3_main_combi_region_khazid_irkulaz" and cm:get_saved_value("rhox_nagash_mortarch_azhag_check") ~= true and character:faction():is_human()
        end,
        function(context)
            cm:set_saved_value("rhox_nagash_mortarch_azhag_check", true)--set it true regardless of result
            local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_azhag_recruit");
            local payload_builder = cm:create_payload();
            
            
    
            payload_builder:text_display("nag_azhag_will_join")
            payload_builder:faction_pooled_resource_transaction("nag_warpstone", "nag_nagash_rituals", -40, true)
            dilemma_builder:add_choice_payload("FIRST", payload_builder);
            payload_builder:clear();
            
            dilemma_builder:add_choice_payload("SECOND", payload_builder);
            
            dilemma_builder:add_target("default", context:character());
            
            
            
            cm:launch_custom_dilemma_from_builder(dilemma_builder, context:character():faction());
        end,
        true
    )
    core:add_listener(
        "rhox_nagash_azhag_DilemmaChoiceMadeEvent", 
        "DilemmaChoiceMadeEvent",
        function(context)
            return context:dilemma() == "rhox_nagash_azhag_recruit"
        end,
        function(context)
            local choice = context:choice();

            
            if choice == 0 then    
                local mort_key = "nag_mortarch_azhag"
            
                local faction_key = self.mort_key_to_faction_key[mort_key]
                local faction = cm:get_faction(faction_key)
                if not faction:is_dead() then
                    --fire incident
                    self:upgrade_into_mortarch(faction, faction_key, mort_key)
                else
                    self:spawn_mortarch(mort_key)
                end    
            end
        end,
        false
    )
    
    
    
    core:add_listener(
    --- When an "unlock" tech is researched, spawn the related Morty.
        "MorghastArchai",
        "ResearchCompleted",
        function(context)
            return RHOX_NAGASH_MORTARCH.archai_tech_key_to_mortarch[context:technology()]
        end,
        function(context)            
            local mort_key = RHOX_NAGASH_MORTARCH.archai_tech_key_to_mortarch[context:technology()]
            local faction = context:faction()
            local mort_character = nil
            local loop_char_list = faction:character_list()
        
            for i = 0, loop_char_list:num_items() - 1 do
                local looping = loop_char_list:item_at(i)
                --out("Rhox Nagash: Current character subtype: "..looping:character_subtype_key())
                if looping:character_subtype_key() == mort_key then
                    mort_character = looping
                    break
                end
            end
            local x, y
            if mort_character and mort_character:has_military_force() then 
                x, y = cm:find_valid_spawn_location_for_character_from_character(faction:name(), cm:char_lookup_str(mort_character), true, 10)
            else
                x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction:name(), self.mort_key_to_region[mort_key], false, true, 10)
            end
            
            local archai = cm:create_agent(faction:name(), "spy", "nag_morghasts_archai",x,y,false,nil)
            if archai then
                cm:replenish_action_points(cm:char_lookup_str(archai))
            end
            
        end,
        true
    )

end

function RHOX_NAGASH_MORTARCH:rhox_nagash_add_ai_mortarch_mission()  --used in other script
    core:add_listener(
            "rhox_ai_nagash_faction_turn_start",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == nagash_faction
            end,
            function(context)
                out("Rhox Nagash: AI Nagash faction turn start")
                local faction = context:faction()
                for tech_key, contents in pairs(RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs) do
                    out("Rhox Nagash: looking at: "..tech_key)
                    if faction:has_technology(tech_key) and cm:get_saved_value("ai"..tech_key) ~= true then
                        out("Rhox Nagash: Nagash has researched: "..tech_key)
                        cm:set_saved_value("ai"..tech_key, true)
                        local mort_key = string.gsub(tech_key, "_unlock", "")
                        local faction_key = self.mort_key_to_faction_key[mort_key]
                        if faction_key ~= nil then --do something more if that Mortarch has faction
                            out("faction key: "..faction_key)
                            local faction = cm:get_faction(faction_key)
                            
                            if faction_key == "ovn_tmb_dread_king" and faction:is_human() then
                                return--OvN dread King has their plans. So don't declare war on them if they're human
                            end
                            
                            if not faction:is_dead() then
                                self:upgrade_into_mortarch(faction, faction_key, mort_key)
                            else
                                self:spawn_mortarch(mort_key)--just spawn one as the faction is already dead. Not going to get anything from the leader since recruit defeated lords might be affecting them
                            end
                        else
                            self:spawn_mortarch(mort_key)--just spawn one as this one does not have a faction
                        end
                        
                    end
                end
                for mort_key, faction_key in pairs(self.mort_key_to_faction_key) do
                    if cm:get_saved_value("failed_to_get" .. mort_key) == true and cm:get_faction(faction_key):is_dead() then --if they failed to summon but the faction is dead later, summon the Mortarchs,
                        self:spawn_mortarch(mort_key)
                        cm:set_saved_value("failed_to_get" .. mort_key, false) --do not trigger this again
                    end 
                end
            end,
            true
    )
end

function RHOX_NAGASH_MORTARCH:trigger_mortarch_unlock_missions()   --used in other script
    local key = nagash_faction
    local faction_handler = cm:get_faction(key)
    if faction_handler:is_human() then
        out("Rhox Nagash triggering mort unlock missions")

        -- Luthor's mission (go to Vampire Coast)   
        out("pre luthor")
        do
            local mort = "nag_mortarch_luthor"
            cm:trigger_mission(key, mort.."_unlock", true, false, true)
        end
    

        out("pre krell")
        --- Krell's mission
        do
            local mort = "nag_mortarch_krell"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("KILL_X_ENTITIES")
            mm:add_condition("total 15000")
            mm:add_payload("money 1000")
            mm:add_payload("text_display nag_mortarch_krell_technology");
            mm:trigger()
        end
        
        out("pre vlad")
        -- Vlad's mission (spend time Channeling near Altdorf)
        do
            local mort = "nag_mortarch_vlad"
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("MOVE_TO_REGION");
            mm:add_condition("region wh3_main_combi_region_castle_drakenhof");
            mm:add_payload("text_display nag_mortarch_vlad_technology");
            mm:add_payload("money 1000")

            mm:trigger()

        end
        
        out("pre manny")
        local volkmar_faction= cm:get_faction("wh3_main_emp_cult_of_sigmar")
        do
            local mort = "nag_mortarch_mannfred"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("DESTROY_FACTION");
            mm:add_condition("faction " .. "wh3_main_emp_cult_of_sigmar");
            mm:add_payload("text_display nag_mortarch_mannfred_technology");
            mm:add_payload("money 1000")

            mm:trigger()
        end--still trigger it even Volkmar is dead
        if not volkmar_faction or volkmar_faction:is_dead() then --fail safe unlock
            local unlock_tech_table = RHOX_NAGASH_MORTARCH.rhox_nagash_unlock_techs["nag_mortarch_mannfred_unlock"]
            for i, technology in pairs(unlock_tech_table) do
                cm:unlock_technology(nagash_faction, technology)
            end
        end
        
        out("pre neffy")
        --- Neffy's mission
        do
            local mort = "nag_mortarch_neferata"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
            mm:add_condition("faction " .. key);
            mm:add_condition("building_level nag_outpost_special_nagashizzar_3");
            mm:add_condition("total 1");
            mm:add_payload("text_display nag_mortarch_neferata_technology");
            mm:add_payload("money 1000")
            mm:trigger()
        end
        
        
        --dieter missions. Only if Mixu lords exist
        if vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua")then --mixer lords exist
            local mort = "nag_mortarch_dieter"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("DEFEAT_N_ARMIES_OF_FACTION");
            mm:add_condition("subculture wh_dlc08_sc_nor_norsca");
            mm:add_condition("total 1");
            mm:add_payload("text_display nag_mortarch_dieter_technology");
            mm:add_payload("money 1000")
            mm:trigger()
        end
        
        
    else
    end
end


core:add_listener(
    "rhox_nagash_mct_initialize",
    "MctInitialized",
    true,
    function(context)
        -- get the mct object
        local mct = context:mct()

        local my_mod = mct:get_mod_by_key("nag_nagash")

        -- get the mct_option object with the key "do_thing_one", and its finalized setting - reading from the mct_settings.lua file if it's a new game, or the save game file if it isn't
        local nag_mortarch_arkhan = my_mod:get_option_by_key("nag_mortarch_arkhan")
        local nag_mortarch_arkhan_setting = nag_mortarch_arkhan:get_finalized_setting()
        
        local nag_mortarch_vlad = my_mod:get_option_by_key("nag_mortarch_vlad")
        local nag_mortarch_vlad_setting = nag_mortarch_vlad:get_finalized_setting()
        
        local nag_mortarch_mannfred = my_mod:get_option_by_key("nag_mortarch_mannfred")
        local nag_mortarch_mannfred_setting = nag_mortarch_mannfred:get_finalized_setting()
        
        local nag_mortarch_luthor = my_mod:get_option_by_key("nag_mortarch_luthor")
        local nag_mortarch_luthor_setting = nag_mortarch_luthor:get_finalized_setting()
        
        local nag_mortarch_neferata = my_mod:get_option_by_key("nag_mortarch_neferata")
        local nag_mortarch_neferata_setting = nag_mortarch_neferata:get_finalized_setting()
        
        local nag_mortarch_dieter = my_mod:get_option_by_key("nag_mortarch_dieter")
        local nag_mortarch_dieter_setting = nag_mortarch_dieter:get_finalized_setting()
        
        local nag_mortarch_dk = my_mod:get_option_by_key("nag_mortarch_dk")
        local nag_mortarch_dk_setting = nag_mortarch_dk:get_finalized_setting()

        
    
        

        
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_arkhan"]=nag_mortarch_arkhan_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_vlad"]=nag_mortarch_vlad_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_mannfred"]=nag_mortarch_mannfred_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_luthor"]=nag_mortarch_luthor_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_neferata"]=nag_mortarch_neferata_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dieter"]=nag_mortarch_dieter_setting
        RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dk"]=nag_mortarch_dk_setting

        
        out("Rhox Nagash: Mortarch percentages")
        out("Arkhan: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_arkhan"])
        out("Vlad: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_vlad"])
        out("Mannfred: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_mannfred"])
        out("Luthor: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_luthor"])
        out("Neferata: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_neferata"])
        out("Dieter: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dieter"])
        out("Dread King: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dk"])

        

    end,
    true
)


cm:add_first_tick_callback(
	function()
        core:add_listener(
            "rhox_nagash_mct_setting_change",
            "MctOptionSettingFinalized",
            true,
            function(context)
                -- get the mct object
                local mct = context:mct()

                local my_mod = mct:get_mod_by_key("nag_nagash")

                -- get the mct_option object with the key "do_thing_one", and its finalized setting - reading from the mct_settings.lua file if it's a new game, or the save game file if it isn't
                local nag_mortarch_arkhan = my_mod:get_option_by_key("nag_mortarch_arkhan")
                local nag_mortarch_arkhan_setting = nag_mortarch_arkhan:get_finalized_setting()
                
                local nag_mortarch_vlad = my_mod:get_option_by_key("nag_mortarch_vlad")
                local nag_mortarch_vlad_setting = nag_mortarch_vlad:get_finalized_setting()
                
                local nag_mortarch_mannfred = my_mod:get_option_by_key("nag_mortarch_mannfred")
                local nag_mortarch_mannfred_setting = nag_mortarch_mannfred:get_finalized_setting()
                
                local nag_mortarch_luthor = my_mod:get_option_by_key("nag_mortarch_luthor")
                local nag_mortarch_luthor_setting = nag_mortarch_luthor:get_finalized_setting()
                
                
                local nag_mortarch_neferata = my_mod:get_option_by_key("nag_mortarch_neferata")
                local nag_mortarch_neferata_setting = nag_mortarch_neferata:get_finalized_setting()
                
                local nag_mortarch_dieter = my_mod:get_option_by_key("nag_mortarch_dieter")
                local nag_mortarch_dieter_setting = nag_mortarch_dieter:get_finalized_setting()
                
                local nag_mortarch_dk = my_mod:get_option_by_key("nag_mortarch_dk")
                local nag_mortarch_dk_setting = nag_mortarch_dk:get_finalized_setting()


                
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_arkhan"]=nag_mortarch_arkhan_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_vlad"]=nag_mortarch_vlad_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_mannfred"]=nag_mortarch_mannfred_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_luthor"]=nag_mortarch_luthor_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_neferata"]=nag_mortarch_neferata_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dieter"]=nag_mortarch_dieter_setting
                RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dk"]=nag_mortarch_dk_setting
                
                out("Rhox Nagash: Mortarch percentages")
                out("Arkhan: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_arkhan"])
                out("Vlad: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_vlad"])
                out("Mannfred: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_mannfred"])
                out("Luthor: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_luthor"])
                out("Neferata: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_neferata"])
                out("Dieter: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dieter"])
                out("Dread King: ".. RHOX_NAGASH_MORTARCH.mort_key_to_success_chance["nag_mortarch_dk"])

                
                
                if nag_mortarch_arkhan_setting == 105 then --for debug
                    RHOX_NAGASH_MORTARCH:rhox_nag_debug_function()
                end
                
                if nag_mortarch_arkhan_setting == 106 then --for debug
                    RHOX_NAGASH_MORTARCH:rhox_nag_debug_summon_bone_daddy()
                end
            end,
            true
        )
	end
)




function RHOX_NAGASH_MORTARCH:rhox_nag_debug_function()
    for mort_key, faction_key in pairs(self.mort_key_to_name) do
        out("Rhox Nagash: Spawning: ".. mort_key)
        self:spawn_mortarch(mort_key)
    end
end


function RHOX_NAGASH_MORTARCH:rhox_nag_debug_summon_bone_daddy()
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local region_key = "wh3_main_combi_region_black_pyramid_of_nagash"
    local is_at_sea = false
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, is_at_sea, true, 5)
    cm:create_force_with_general(
        -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
        nagash_faction,
        "",
        region_key,
        new_x,
        new_y,
        "general",
        "nag_nagash_boss",
        "names_name_1937224328",
        "",
        "",
        "",
        true,
        function(cqi)
            out("Rhox Nagash: Nagash Revived")
            local new_character = cm:get_character_by_cqi(cqi)
            cm:replenish_action_points(cm:char_lookup_str(new_character))
            local forename = common:get_localised_string("names_name_1937224328")
            cm:change_character_custom_name(new_character, forename, "","","")
        end); 
end




--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_saved_agent_info", rhox_nagash_saved_agent_info, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			rhox_nagash_saved_agent_info = cm:load_named_value("rhox_nagash_saved_agent_info", rhox_nagash_saved_agent_info, context)
		end
	end
)