-- the scripted mechanics revolving around the raising of the BP and what not

-- TODO "unlock ritual" when the BP is occupied by Nagash (or upgraded to a certain level? some other criterion?)
-- TODO spawn intervention armies (use the welf system) when the ritual begins
-- TODO set the ritual in some cute UI, something floating on the BP region?

--- TODO the end game ritual

--- TODO all of the rituals

---@class bdsm
local bdsm = get_bdsm()

bdsm._bp_settlement_key = "settlement:wh2_main_land_of_the_dead_pyramid_of_nagash"
local rite_status = {
    nag_winds = false, -- TODO
    nag_death = false,
    nag_divinity = false,
    nag_man = false,
    nag_nagash = false,
}

local quests_unlocked = {
    nag_rise_blyramid = false, 
}

local revealed_objectives = {
    wh2_main_great_mortis_delta_black_pyramid_of_nagash = false,
    wh2_main_the_broken_teeth_nagashizar = false,
    wh2_main_marshes_of_madness_morgheim = false,
    wh2_main_devils_backbone_lahmia = false,
    wh2_main_land_of_the_dead_khemri = false,
    wh2_main_vampire_coast_the_awakening = false,
    wh_main_eastern_sylvania_castle_drakenhof = false,
    wh2_main_titan_peaks_ancient_city_of_quintex = false,
}

local grand_spell_status = {
    nag_grand_spell_01 = false,
    nag_grand_spell_02 = false,
    nag_grand_spell_03 = false,
}
function bdsm:setup_structures()
    rite_status.nag_winds = cm:get_saved_value("rite_status_nag_winds")
    rite_status.nag_death = cm:get_saved_value("rite_status_nag_death")
    rite_status.nag_divinity = cm:get_saved_value("rite_status_nag_divinity")
    rite_status.nag_man = cm:get_saved_value("rite_status_nag_man")
    rite_status.nag_nagash = cm:get_saved_value("rite_status_nag_nagash")

    quests_unlocked.nag_rise_blyramid = cm:get_saved_value("quests_unlocked_nag_rise_blyramid")

    revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash = cm:get_saved_value("revealed_objectives_wh2_main_great_mortis_delta_black_pyramid_of_nagash")
    revealed_objectives.wh2_main_the_broken_teeth_nagashizar = cm:get_saved_value("revealed_objectives_wh2_main_the_broken_teeth_nagashizar")
    revealed_objectives.wh2_main_marshes_of_madness_morgheim = cm:get_saved_value("revealed_objectives_wh2_main_marshes_of_madness_morgheim")
    revealed_objectives.wh2_main_devils_backbone_lahmia = cm:get_saved_value("revealed_objectives_wh2_main_devils_backbone_lahmia")
    revealed_objectives.wh2_main_land_of_the_dead_khemri = cm:get_saved_value("revealed_objectives_wh2_main_land_of_the_dead_khemri")
    revealed_objectives.wh2_main_vampire_coast_the_awakening = cm:get_saved_value("revealed_objectives_wh2_main_vampire_coast_the_awakening")
    revealed_objectives.wh_main_eastern_sylvania_castle_drakenhof = cm:get_saved_value("revealed_objectives_wh_main_eastern_sylvania_castle_drakenhof")
    revealed_objectives.wh2_main_titan_peaks_ancient_city_of_quintex = cm:get_saved_value("revealed_objectives_wh2_main_titan_peaks_ancient_city_of_quintex")
    
    bdsm:logf("++++++ grand_spell_status_nag_grand_spell_01 load = %s", tostring(cm:get_saved_value("grand_spell_status_nag_grand_spell_01")))
    grand_spell_status.nag_grand_spell_01 = cm:get_saved_value("grand_spell_status_nag_grand_spell_01")
    grand_spell_status.nag_grand_spell_02 = cm:get_saved_value("grand_spell_status_nag_grand_spell_02")
    grand_spell_status.nag_grand_spell_03 = cm:get_saved_value("grand_spell_status_nag_grand_spell_03")
end
-- rite_status = {
--     nag_winds = false, -- TODO
--     nag_death = false,
--     nag_divinity = false,
--     nag_man = false,
--     nag_nagash = false,
-- }

-- quests_unlocked = {
--     nag_rise_blyramid = false, 
-- }

-- revealed_objectives = {
--     wh2_main_great_mortis_delta_black_pyramid_of_nagash = false,
--     wh2_main_the_broken_teeth_nagashizar = false,
--     wh2_main_marshes_of_madness_morgheim = false,
--     wh2_main_devils_backbone_lahmia = false,
--     wh2_main_land_of_the_dead_khemri = false,
--     wh2_main_vampire_coast_the_awakening = false,
--     wh_main_eastern_sylvania_castle_drakenhof = false,
--     wh2_main_titan_peaks_ancient_city_of_quintex = false,
-- }

-- grand_spell_status = {
--     nag_grand_spell_01 = false,
--     nag_grand_spell_02 = false,
--     nag_grand_spell_03 = false,
-- }
-- grand spells stuff
local grand_spells_effect_bundle_key = {	"nag_ability_enable_endless_tomb",
                            "nag_ability_enable_batocalypse",
                            "nag_ability_enable_blyramid_bombardment"
};

local grand_spells_ability_key = {	"nag_army_abilities_endless_tomb",
                            "nag_army_abilities_batocalypse",
                            "nag_army_abilities_blyramid_bombardment_00"
};


local nagash_faction_cqi = 0
local grand_spell_cost = 20

local function add_scroll_bar()
    core:add_listener(
        "AddScrollBar",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "rituals_panel" and cm:get_local_faction_name(true) == bdsm:get_faction_key()
        end,
        function(context)
            local uic = UIComponent(context.component)
            local rituals_list = find_uicomponent(uic, "panel_frame", "rituals_list")
            local dummy = core:get_or_create_component("rituals_dummy", "ui/campaign ui/script_dummy")
            local killer_dummy = core:get_or_create_component("killer_dummy", "ui/campaign ui/script_dummy")

            -- force all rituals onto a new invisible parent while I create the horizontal list view
            local addresses = {}
            for i = 0, rituals_list:ChildCount() -1 do
                local child_uic = UIComponent(rituals_list:Find(i))
                addresses[#addresses+1] = child_uic:Address()
            end

            for i = 1, #addresses do
                rituals_list:Divorce(addresses[i])
                dummy:Adopt(addresses[i])
            end

            -- create and grab the horizontal list view
            local killed = core:get_or_create_component("new_killed", "ui/campaign ui/building_browser", core:get_ui_root())
            local listview = find_uicomponent(killed, "listview")

            -- add horlistview onto the rituals list
            rituals_list:Adopt(listview:Address())

            -- kill the building browser created
            killer_dummy:Adopt(killed:Address())

            local lview = find_uicomponent(rituals_list, "listview")

            -- destroy unneeded details
            local killed2 = find_uicomponent(lview, "list_clip", "list_box", "building_tree")
            killer_dummy:Adopt(killed2:Address())
            killer_dummy:DestroyChildren()

            -- set lview size to the rituals_list
            local x, y = rituals_list:Position()
            local w, h = rituals_list:Bounds()

            lview:SetCanResizeWidth(true) lview:SetCanResizeHeight(true)
            lview:Resize(w -75, h -50)
            lview:SetCanResizeWidth(false) lview:SetCanResizeHeight(false)

            -- minor buffer between the corner
            lview:MoveTo(x + 20, y + 20)

            local lbox = find_uicomponent(lview, "list_clip", "list_box")

            -- readd the rituals to the lview
            for j = 1, #addresses do
                local child_uic = UIComponent(addresses[j])

                dummy:Divorce(addresses[j])
                lbox:Adopt(addresses[j])
            end

            -- kill the dummies
            dummy:Adopt(killer_dummy:Address())
            dummy:DestroyChildren()
        end,
        true
    )
end

--- TODO create a button on the topbar that is used for interacting with the Black Pyramid
function bdsm:add_bp_button()
    local parent = find_uicomponent(core:get_ui_root(), "layout", "resources_bar", "topbar_list_parent")

    if parent then
        local uic = find_uicomponent(parent, "icon_black_pyramid")
        if not uic then
            uic = core:get_or_create_component("icon_black_pyramid", "ui/templates/custom_image")
    
            local pos = 1
            -- remove all other children of the parent bar, except for the treasury, so the new PR will be to the right of the treasury holder
            for i = 0, parent:ChildCount() - 1 do
                local child = UIComponent(parent:Find(i))
                if child:Id() == "treasury_holder" then
                    -- dummy:Adopt(child:Address())
                    pos = i
                    break
                end
            end
    
            parent:Adopt(uic:Address(), pos+1)
        end

        uic:SetInteractive(true)
        
        local state = "disabled"

        -- if we've risen the BP, 
        if cm:get_saved_value("nag_bp_ritual_completed") then
            state = "woke"
        elseif bdsm:is_bp_rite_available() then
            state = "avail"
        elseif cm:get_saved_value("nag_ritual_current") then
            state = "ongoing"
        end

        local img = string.format("ui/skins/nag_nagash/nag_skull_top_blyramid_%s.png", state)
        local tt = string.format("nag_nagash_icon_black_pyramid_%s", state)

        --- default w/h
        local dw,dh = 127,80

        -- ratio to multiply height by to get width
        local r = dw / dh
        local h = parent:Height() * 2.1
        local w = h * r

        uic:SetImagePath(img, 0)
        uic:SetTooltipText(effect.get_localised_string(tt), true)
        uic:SetState("custom_state_1")
        uic:Resize(w, h)

        uic:SetCanResizeWidth(false)
        uic:SetCanResizeHeight(false)

        if state == "avail" then
            uic:StartPulseHighlight(3)
        else
            uic:StopPulseHighlight()
        end
    end
end

--- unlock rite + show event message
local function unlock_rite(rite_key)
    if rite_status[rite_key] == nil then
        return bdsm:logf("Trying to unlock rite %s but it's not a valid Nagash rite!", tostring(rite_key))
    end

    if rite_status[rite_key] == true then 
        return bdsm:logf("Trying to unlock rite %s but it's already available!", rite_key)
    end

    local faction_key = bdsm:get_faction_key()
    local faction = bdsm:get_faction()

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

function bdsm:unlock_all_rites()
    for k,_ in pairs(rite_status) do 
        unlock_rite(k)
    end
end

function bdsm:add_warpstone(amount, factor_key)
    if not is_string(factor_key) then factor_key = "nag_warpstone_buildings" end
    if not is_number(amount) then amount = 1 end

    local key = self:get_faction_key()
    cm:faction_add_pooled_resource(key, "nag_warpstone", factor_key, amount)
end

local vlib = get_vandy_lib()

---@type vlib_camp_counselor
local cc = vlib:get_module("camp_counselor")

--- trigger a "Start the BP Ritual, fam" mission when you capture BP
function bdsm:trigger_bp_raise_mission()
    if not quests_unlocked.nag_rise_blyramid then
        quests_unlocked.nag_rise_blyramid = true
        cm:set_saved_value("quests_unlocked_nag_rise_blyramid", quests_unlocked.nag_rise_blyramid)
        local mm = mission_manager:new(bdsm:get_faction_key(), "nag_bp_raise")

        mm:add_new_objective("SCRIPTED")
        mm:add_condition("script_key nag_bp_raise")
        mm:add_condition("override_text mission_text_text_nag_bp_raise")
        mm:add_payload("money 1000")
        mm:trigger()
    end
end

function bdsm:begin_bp_raise()
    local v = cm:get_saved_value("nag_bp_raise")

    -- if v and v == true then
    --     return false
    -- end
    if not self:is_bp_rite_available() then
        return false
    end
    -- ###
    cm:complete_scripted_mission_objective("nag_bp_raise", "nag_bp_raise", true)
    cm:perform_ritual(bdsm:get_faction_key(), "", "nag_bp_raise")

    --- trigger mission for "survive"
    local mm = mission_manager:new(bdsm:get_faction_key(), "nag_bp_survive")
    mm:add_new_objective("SCRIPTED")
    mm:add_condition("script_key nag_bp_survive")
    mm:add_condition("override_text mission_text_text_nag_bp_survive")
    mm:add_payload("money 1000")
    mm:trigger()

    --- wound Nagash Husk for 999 turns, replace him with a Traitor King
    local f_leader = self:get_faction_leader()
    local f_cqi = f_leader:command_queue_index()
    local rank = f_leader:rank()

    local function clamp(x, min, max)
        if is_number(x) then
            if not is_number(max) and not is_number(min) then return x end
    
            return x >= max and max or
            x <= min and min or
            x
        end
    end

    cm:set_saved_value("nag_last_xp", clamp(rank - 3, 1, 5))

    core:add_listener(
        "KillThem",
        "CharacterConvalescedOrKilled",
        function(context) return context:character():command_queue_index() == f_cqi end,
        function(context)
            cm:stop_character_convalescing(f_cqi)
        end,
        false
    )

    cm:kill_character(f_cqi, false, true)
    
    --- set a composite scene on the settlement
    cm:add_scripted_composite_scene_to_settlement("nag_bp_raise", "wh2_dlc16_wef_healing_ritual", bdsm._bp_settlement_key, 0, 0, false, true, false)

    --- start up some interactive markers
    --- TODO change number of armies based on difficulty?
    local num = cm:random_number(5, 4)
    local nag_key = bdsm:get_faction_key()


    for i = 1, num do
        local x,y = cm:find_valid_spawn_location_for_character_from_settlement(bdsm:get_faction_key(), "wh2_main_great_mortis_delta_black_pyramid_of_nagash", false, true, cm:random_number(24, 12))
        -- marker:spawn(tech_key..i, x, y)
        local region_key = "wh2_main_great_mortis_delta_black_pyramid_of_nagash"
        local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
        local invasion_key = "nag_bp_raise".."_invasion_"..x.."_"..y.."_"..i

        local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, "wh2_main_sc_skv_skaven",  19, 2, true, false)

        local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nag_key, x, y, true)
        local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})
        -- invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
        invasion_object:set_target("REGION", region_key, nag_key)
        invasion_object:add_aggro_radius(25, {nag_key}, 1)
        invasion_object:apply_effect("wh_main_bundle_military_upkeep_free_force_siege_attacker", 10);
        invasion_object:apply_effect("wh2_dlc11_bundle_immune_all_attrition", 10);

        invasion_object:start_invasion(true,true,false,false)
    end

    --- set a timer for "survive 5/10 turns" and then complete the mission above
    self:set_current_ritual("nag_bp_raise", 5)
    cm:set_saved_value("nag_bp_raise", true)


    local label = find_uicomponent("3d_ui_parent", "label_"..bdsm._bp_settlement_key) -- IT'S NOT THE REGION KEY BECAUSE THE SETTLEMENT KEY IS DIFFERENT FUCK
            if label and label:Visible() then
                local icon_holder = find_uicomponent(label, "list_parent", "icon_holder")
                local test = find_uicomponent(icon_holder, "bp_button")
                if test and test:Visible() then
                    test:SetVisible(false)
                end
            end
    vlib:remove_callback("add_bp_button")
end

function bdsm:reset_current_ritual()
    cm:set_saved_value("nag_ritual_turns_remaining", 0)
    cm:set_saved_value("nag_ritual_current", "")
end

function bdsm:set_current_ritual(key, turns)
    cm:set_saved_value("nag_ritual_turns_remaining", turns)
    cm:set_saved_value("nag_ritual_current", key)
end

function bdsm:complete_bp_raise()
    cm:complete_scripted_mission_objective("nag_bp_survive", "nag_bp_survive", true)
    cm:remove_scripted_composite_scene("nag_bp_raise")
    
    cm:set_saved_value("nag_bp_ritual_completed", true)
    
    self:reset_current_ritual()

    cm:remove_scripted_composite_scene("nag_bp_raise")

    -- TODO raise ###
    local sentinels_key = "wh2_dlc09_tmb_the_sentinels"
    local bp_key = "wh2_main_great_mortis_delta_black_pyramid_of_nagash"

    cm:set_saved_value("nagash_intro_completed", true)


    revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash = false
    revealed_objectives.wh2_main_the_broken_teeth_nagashizar = true
    revealed_objectives.wh2_main_marshes_of_madness_morgheim = true
    revealed_objectives.wh2_main_devils_backbone_lahmia = true
    revealed_objectives.wh2_main_land_of_the_dead_khemri = true
    revealed_objectives.wh2_main_vampire_coast_the_awakening = true
    revealed_objectives.wh_main_eastern_sylvania_castle_drakenhof = true
    revealed_objectives.wh2_main_titan_peaks_ancient_city_of_quintex = true
    cm:set_saved_value("revealed_objectives_wh2_main_great_mortis_delta_black_pyramid_of_nagash", revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash)
    cm:set_saved_value("revealed_objectives_wh2_main_the_broken_teeth_nagashizar", revealed_objectives.wh2_main_the_broken_teeth_nagashizar)
    cm:set_saved_value("revealed_objectives_wh2_main_marshes_of_madness_morgheim", revealed_objectives.wh2_main_marshes_of_madness_morgheim)
    cm:set_saved_value("revealed_objectives_wh2_main_devils_backbone_lahmia", revealed_objectives.wh2_main_devils_backbone_lahmia)
    cm:set_saved_value("revealed_objectives_wh2_main_land_of_the_dead_khemri", revealed_objectives.wh2_main_land_of_the_dead_khemri)
    cm:set_saved_value("revealed_objectives_wh2_main_vampire_coast_the_awakening", revealed_objectives.wh2_main_vampire_coast_the_awakening)
    cm:set_saved_value("revealed_objectives_wh_main_eastern_sylvania_castle_drakenhof", revealed_objectives.wh_main_eastern_sylvania_castle_drakenhof)
    cm:set_saved_value("revealed_objectives_wh2_main_titan_peaks_ancient_city_of_quintex", revealed_objectives.wh2_main_titan_peaks_ancient_city_of_quintex)
    
    local nag_fact = bdsm:get_faction_key()
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_great_mortis_delta_black_pyramid_of_nagash")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_the_broken_teeth_nagashizar")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_marshes_of_madness_morgheim")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_devils_backbone_lahmia")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_land_of_the_dead_khemri")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_vampire_coast_the_awakening")
    cm:make_region_visible_in_shroud(nag_fact, "wh_main_eastern_sylvania_castle_drakenhof")
    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_titan_peaks_ancient_city_of_quintex")
    
    local mm = mission_manager:new(nag_fact, "nag_endgame_capture")
    mm:add_new_objective("OWN_N_REGIONS_INCLUDING");
    mm:add_condition("region wh2_main_great_mortis_delta_black_pyramid_of_nagash");
    mm:add_condition("region wh2_main_the_broken_teeth_nagashizar");
    mm:add_condition("region wh2_main_marshes_of_madness_morgheim");
    mm:add_condition("region wh2_main_devils_backbone_lahmia");
    mm:add_condition("region wh2_main_land_of_the_dead_khemri");
    mm:add_condition("region wh2_main_vampire_coast_the_awakening");
    mm:add_condition("region wh_main_eastern_sylvania_castle_drakenhof");
    mm:add_condition("region wh2_main_titan_peaks_ancient_city_of_quintex");
    mm:add_condition("total 8");
    mm:add_payload("money 1000");
    mm:trigger()


    local mm_1 = mission_manager:new(nag_fact, "nag_waprstone_mines")
    mm_1:add_new_objective("OWN_N_REGIONS_INCLUDING");
    mm_1:add_condition("region wh2_main_southlands_worlds_edge_mountains_karak_zorn");
    mm_1:add_condition("region wh_main_desolation_of_nagash_karak_azul");
    mm_1:add_condition("region wh2_main_the_wolf_lands_crookback_mountain");
    mm_1:add_condition("region wh2_main_gnoblar_country_flayed_rock");
    mm_1:add_condition("region wh_main_the_vaults_karak_izor");
    mm_1:add_condition("region wh2_main_skavenblight_skavenblight");
    mm_1:add_condition("region wh2_main_southern_dark_lands_desolation_of_drakenmoor");
    mm_1:add_condition("region wh2_main_hell_pit_hell_pit");
    mm_1:add_condition("region wh_main_gianthome_mountains_kraka_drak");
    mm_1:add_condition("region wh2_main_deadwood_the_frozen_city");
    mm_1:add_condition("region wh2_main_titan_peaks_ancient_city_of_quintex");
    mm_1:add_condition("total 11");
    mm_1:add_payload("money 1000");
    mm_1:trigger()

    -- kill the Sentinels completely
    local sentinels = cm:get_faction(sentinels_key)
    do
        local char_list = sentinels:character_list()
        for i = 0, char_list:num_items() -1  do
            local char = char_list:item_at(i)
            local cqi = char:command_queue_index()

            cm:kill_character_and_commanded_unit("character_cqi:"..cqi, true, false)
        end
    end

    -- ruin the BP and set it as untargetable -- TODO figure out if that fucks any other mods or functionalities
    cm:set_region_abandoned(bp_key)
    cm:cai_disable_targeting_against_settlement("settlement:"..bp_key)

    cm:force_religion_factors(bp_key, "wh_main_religion_undeath", 1)

    local faction_key = bdsm:get_faction_key()
    local faction_obj = cm:get_faction(faction_key)
    local faction_leader = faction_obj:faction_leader()
    local cqi = faction_leader:command_queue_index()

    -- spawn the bone daddy
    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        faction_key,
        bp_key,
        false,
        true,
        5
    )

    local ax,ay = cm:find_valid_spawn_location_for_character_from_position(
        faction_key,
        x,
        y,
        true,
        5
    )

    bdsm:log("getting coords:")
    bdsm:log(x)
    bdsm:log(y)

    local units = {
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_cav_nehekhara_horsemen_0",
        "nag_carrion_riders",
        "nag_nagashi_guard",
        "nag_nagashi_guard_halb",
    }

    cm:create_force_with_general(
        faction_key,
        table.concat(units, ","),
        bp_key,
        x,
        y,
        "general",
        "nag_nagash_boss",
        "names_name_1937224328",
        "",
        "names_name_1777692413",
        "",
        true,
        function(cqi)
            local rank = cm:get_saved_value("nag_last_xp")

            cm:add_agent_experience("character_cqi:"..cqi, rank, true)
        end
    )
    
    core:trigger_custom_event("BlackPyramidRaised", {})

    cm:create_agent(
        faction_key,
        "spy",
        "nag_morghasts_archai",
        ax,
        ay,
        false,
        function(cqi)

        end
    )
    cm:apply_dilemma_diplomatic_bonus("nag_nagash", "wh2_dlc09_tmb_khemri", -6)
    cm:apply_dilemma_diplomatic_bonus("nag_nagash", "wh2_dlc09_tmb_khemri", -6)

end

--- add in Black Pyramid raising rite
function bdsm:is_bp_rite_available()
    local f = self:get_faction()
    local v = cm:get_saved_value("nag_bp_raise")
    local owns = false

    local r_list = f:region_list()
    -- self:logf("++++++is_bp_rite_available 01 !")
    if v and v == true then
        -- self:logf("++++++is_bp_rite_available 02 !")
        return false
    end

    for i = 0, r_list:num_items() -1 do
        local region = r_list:item_at(i)

        if region:name() == self._bp_key then
            owns = true
            -- self:logf("++++++is_bp_rite_available 03 !")
        end
    end

    local val = cm:get_saved_value("nag_bp_ritual_completed")
    -- self:logf("++++++is_bp_rite_available 04 !")
    return owns and not val
end

function bdsm:unlock_rites_listeners()
    if not cm:get_saved_value("nag_rites_lock") then
        rite_status.nag_death = false -- partially working
        rite_status.nag_winds = false -- working
        rite_status.nag_divinity = false -- working
        rite_status.nag_man = false -- working
        rite_status.nag_nagash = false -- working
        cm:set_saved_value("rite_status_nag_winds", rite_status.nag_winds)
        cm:set_saved_value("rite_status_nag_death", rite_status.nag_death)
        cm:set_saved_value("rite_status_nag_divinity", rite_status.nag_divinity)
        cm:set_saved_value("rite_status_nag_man", rite_status.nag_man)
        cm:set_saved_value("rite_status_nag_nagash", rite_status.nag_nagash)

        local f = self:get_faction()

        for key,_ in pairs(rite_status) do
            cm:lock_ritual(f, key)
        end

        cm:set_saved_value("nag_rites_lock", true)
    end

    if not rite_status.nag_winds then
        -- build the BP Obelisk
        core:add_listener(
            "NagWinds",
            "MilitaryForceBuildingCompleteEvent",
            function(context)
                return context:building() == "nag_bpyramid_main_obelisk_4";
            end,
            function(context)
                if not rite_status.nag_winds then
                    self:logf("MilitaryForceBuildingCompleteEvent!")
                    unlock_rite("nag_winds")
                    cm:set_saved_value("rite_status_nag_winds", rite_status.nag_winds)
                end
            end,
            true
	    )

    end

    if not rite_status.nag_death then
        core:add_listener(
            "NagDeathTurns",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == bdsm:get_faction_key() and cm:turn_number() >= 35
            end,
            function(context)
                if not rite_status.nag_death then
                    unlock_rite("nag_death")
                    cm:set_saved_value("rite_status_nag_death", rite_status.nag_death)
                end
            end,
            false
        )
        --- Win 5 battles with Nagash
        -- core:add_listener(
        --     "NagDeath",
        --     "CharacterCompletedBattle",
        --     function(context)
        --         --- TODO "and nagash won"
        --         local character = context:character()
        --         return (character:character_subtype_key() == "nag_nagash_husk" or character:character_subtype_key() == "nag_nagash_boss") and character:won_battle()
        --     end,
        --     function(context)
        --         if not rite_status.nag_death then
        --             local total = cm:get_saved_value("nag_death_total") or 0
        --             total = total + 1

        --             if total >= 5 then
        --                 unlock_rite("nag_death")
        --                 cm:set_saved_value("rite_status_nag_death", rite_status.nag_death)

        --             else
        --                 --- TODO display in the ritual panel?
        --                 cm:set_saved_value("nag_death_total", total)
        --             end
        --         end
        --     end,
        --     false
        -- )
    end

    if not rite_status.nag_divinity then
        --- Nag level
        core:add_listener(
            "NagDivinity",
            "CharacterRankUp",
            function(context)
                local character = context:character()
                return character:faction():name() == bdsm:get_faction_key() and (character:character_subtype_key() == "nag_nagash_husk" or character:character_subtype_key() == "nag_nagash_boss") and character:rank() >= 8
            end,
            function(context)
                if not rite_status.nag_divinity then
                    unlock_rite("nag_divinity")
                    cm:set_saved_value("rite_status_nag_divinity", rite_status.nag_divinity)
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
                return not faction:is_null_interface() and faction:name() == bdsm:get_faction_key() and faction:region_list():num_items() >= 10
            end,
            function(context)
                if not rite_status.nag_man then
                    unlock_rite("nag_man")
                    cm:set_saved_value("rite_status_nag_man", rite_status.nag_man)
                end
            end,
            false
        )
    end

    if not rite_status.nag_nagash then
        core:add_listener(
            "NagNagash",
            "BlackPyramidRaised",
            true,
            function(context)
                local faction = self:get_faction()
                if faction:is_human() then 
                    if not rite_status.nag_nagash then
                        unlock_rite("nag_nagash")
                        cm:set_saved_value("rite_status_nag_nagash", rite_status.nag_nagash)
                    end
                else
                    unlock_rite("nag_winds")
                    cm:set_saved_value("rite_status_nag_winds", rite_status.nag_winds)
                    unlock_rite("nag_death")
                    cm:set_saved_value("rite_status_nag_death", rite_status.nag_death)
                    unlock_rite("nag_divinity")
                    cm:set_saved_value("rite_status_nag_divinity", rite_status.nag_divinity)
                    unlock_rite("nag_man")
                    cm:set_saved_value("rite_status_nag_man", rite_status.nag_man)
                end
            end,
            false
        )
        
        core:add_listener(
            "NagNagash",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == bdsm:get_faction_key() and cm:turn_number() >= 50
            end,
            function(context)
                if not rite_status.nag_nagash then
                    unlock_rite("nag_nagash")
                    cm:set_saved_value("rite_status_nag_nagash", rite_status.nag_nagash)
                end
            end,
            false
        )

        core:add_listener(
		"RegionFactionChangeEventRemoveSupergrowth",
		"RegionFactionChangeEvent",
		function(context)
			return context:previous_faction():subculture() == "nag_nagash"
		end,
		function(context)
			local region = context:region()
			local region_key = region:name()
			cm:remove_effect_bundle_from_region("nag_nagash_rite_bundle_region_super_growth", region_key);
		end,
		true
	    )

    end
end

--- TODO scripted effects
function bdsm:trigger_rites_listeners()
    --- TODO on rite completed, select a Nemesis faction to target. can do this programmatically with a dilemma, yay
    --- nag_divinity
    core:add_listener(
        "nag_divinity",
        "RitualCompletedEvent",
        function(context)
            return context:ritual():ritual_key() == "nag_divinity"
        end,
        function(context)

            local region_list = cm:model():world():region_manager():region_list();
            
            for i = 0, region_list:num_items() - 1 do
                local current_region = region_list:item_at(i);
                
                if current_region:is_province_capital() then
                    cm:apply_effect_bundle_to_region("nag_divinity_rite_bundle_region_undead_rises", current_region:name(), 10);
                end;
            end;


            --- TODO some way to select a Nemesis faction to target, decide
        end,
        true
    )

    core:add_listener(
        "nag_divinity",
        "RitualCompletedEvent",
        function(context)
            return context:ritual():ritual_key() == "nag_winds"
        end,
        function(context)
            -- TODO
            local key = self:get_faction_key()            
            if grand_spell_status.nag_grand_spell_01 then
                cm:faction_add_pooled_resource(key, "nag_grand_spell_01", "nag_grand_spell_01_recharge", grand_spell_cost)  
            end
            if grand_spell_status.nag_grand_spell_02 then
                cm:faction_add_pooled_resource(key, "nag_grand_spell_02", "nag_grand_spell_02_recharge", grand_spell_cost)  
            end
            if grand_spell_status.nag_grand_spell_03 then
                cm:faction_add_pooled_resource(key, "nag_grand_spell_03", "nag_grand_spell_03_recharge", grand_spell_cost)  
            end
        end,
        true
    )

    core:add_listener(
        "nag_nagash",
        "RitualCompletedEvent",
        function(context)
            return context:ritual():ritual_key() == "nag_nagash"
        end,
        function(context)
            -- ###
           --- spawn a death army at Nagash, at BP, or at a random Mortarch, or at a random settlement, in that order.
           local nag = bdsm:get_faction_leader()
           local key = bdsm:get_faction_key()
           local key_self = self:get_faction_key()
           local region
           if nag:has_military_force() and nag:region():is_null_interface() == false then
            --    x,y = cm:find_valid_spawn_location_for_character_from_character(key, "character_cqi:"..nag:command_queue_index(), true, 5)
               region = nag:region():name()
               region_interface = nag:region()
               local province = region_interface:province_name();

            --    region_faction = nag:region():owning_faction():name()
               if (nag:region():owning_faction():is_null_interface() == false and nag:region():owning_faction():name() == key and 
                    province ~= "wh2_main_the_broken_teeth" and 
                    province ~= "wh2_main_marshes_of_madness" and 
                    province ~= "wh2_main_devils_backbone" and 
                    province ~= "wh2_main_land_of_the_dead" and 
                    province ~= "wh2_main_vampire_coast" and 
                    province ~= "wh_main_eastern_sylvania" and 
                    province ~= "wh2_main_titan_peaks") then
                -- apply super growth on generic settlement
                    -- cm:apply_effect_bundle_to_region("nag_nagash_rite_bundle_region_super_growth", region, 0);
                    cm:apply_effect_bundle_to_faction_province("nag_nagash_rite_bundle_region_super_growth",region_interface,0)
                else
                    cm:faction_add_pooled_resource(key_self, "nag_warpstone", "nag_warpstone_refund", 1)
               end
           else
                cm:faction_add_pooled_resource(key_self, "nag_warpstone", "nag_warpstone_refund", 1)
           end

        end,
        true
    )

    --- Breaks ATM
    -- -- nag_death
    -- bdsm:load_db("nag_death")

    local function get_random_mortarch()
        local morts = {}
        local char_list = self:get_faction():character_list()
        for i = 0, char_list:num_items() -1 do
            local char = char_list:item_at(i)
            if char:has_military_force() and char:region():is_null_interface() == false and char:character_subtype_key():find("_mortarch_") then 
                morts[#morts+1] = char
            end
        end

        if #morts == 0 then return nil end

        return morts[cm:random_number(#morts)]
    end

    core:add_listener(
        "NagDeath",
        "RitualCompletedEvent",
        function(context)
            return context:ritual():ritual_key() == "nag_death"
        end,
        function(context)
            
            --- spawn a death army at Nagash, at BP, or at a random Mortarch, or at a random settlement, in that order.
            local nag = bdsm:get_faction_leader()
            local key = bdsm:get_faction_key()
            local x,y,region
            if nag:has_military_force() and nag:region():is_null_interface() == false then
                x,y = cm:find_valid_spawn_location_for_character_from_character(key, "character_cqi:"..nag:command_queue_index(), true, 5)
                region = nag:region():name()
            else
                -- check BP
                local bp = cm:get_region(bdsm._bp_key)
                if bp and bp:owning_faction():is_null_interface() == false and bp:owning_faction():name() == key then 
                    x,y = cm:find_valid_spawn_location_for_character_from_settlement(key, bdsm._bp_key, false, true, 5)
                    region = bp
                else
                    -- check for a random mortarch
                    local random_mort = get_random_mortarch()
                    if random_mort then
                        x,y = cm:find_valid_spawn_location_for_character_from_character(key, "character_cqi:"..random_mort:command_queue_index(), true, 5)
                        region = random_mort:region():name()
                    else
                        -- check for a random settlement
                        local settlement_list = bdsm:get_faction():region_list()
                        local random_settlement = settlement_list:item_at(cm:random_number(settlement_list:num_items()-1, 0))

                        x,y = cm:find_valid_spawn_location_for_character_from_settlement(key, random_settlement:name(), false, true, 5)
                        region = random_settlement:name()
                    end
                end
            end

            --- spawn the army
            cm:create_force(
                key,
                random_army_manager:generate_force("nag_death", 19, false),
                region,
                x,
                y,
                true,
                function(char_cqi, mf_cqi)
                    local mf = cm:get_military_force_by_cqi(mf_cqi)
                    --- TODO apply EB for the duration of the ritual
                    local eb_key = "nag_death_shambling_horde"
                    cm:apply_effect_bundle_to_force(eb_key, mf_cqi, 5)

                    -- cm:convert_force_to_type(mf, "nag_shambling_horde")
                end,
                false
            )

            --- TODO add an event message
        end,
        true
    )
    -- grand spells ###
    function get_pooled_resource(resource_name)
        -- get amount of pooled resource
        local faction = cm:get_faction(bdsm:get_faction_key())
        local pr = faction:pooled_resource(resource_name)
        return pr:value()
    end
    
    local function update_grand_spells_availability()
        local nuke_resource_amount  = get_pooled_resource("nag_grand_spell_01")
        if nuke_resource_amount < grand_spell_cost then
            --resource is bellow cost remove spell
            cm:remove_effect_bundle(grand_spells_effect_bundle_key[1], bdsm:get_faction_key());
        else
            --resource is above cost unlock spell
            cm:apply_effect_bundle(grand_spells_effect_bundle_key[1], bdsm:get_faction_key(), 0)
        end
        local nuke_resource_amount  = get_pooled_resource("nag_grand_spell_02")
        if nuke_resource_amount < grand_spell_cost then
            --resource is bellow cost remove spell
            cm:remove_effect_bundle(grand_spells_effect_bundle_key[2], bdsm:get_faction_key());
        else
            --resource is above cost unlock spell
            cm:apply_effect_bundle(grand_spells_effect_bundle_key[2], bdsm:get_faction_key(), 0)
        end
        local nuke_resource_amount  = get_pooled_resource("nag_grand_spell_03")
        if nuke_resource_amount < grand_spell_cost then
            --resource is bellow cost remove spell
            local f_leader = self:get_faction_leader()
            cm:remove_effect_bundle_from_character(grand_spells_effect_bundle_key[3],f_leader)
        else
            --resource is above cost unlock spell
            local f_leader = self:get_faction_leader()
            cm:apply_effect_bundle_to_character(grand_spells_effect_bundle_key[3],f_leader,0)
        end
    end
            
    core:add_listener(
        "nagash_grand_spells_availability",
        "FactionTurnStart",
        function(context)
            return context:faction():name() == bdsm:get_faction_key() --and context:faction():is_human()
        end,
        function(context)
            update_grand_spells_availability()
        end,
        true
    )

    core:add_listener(
        "nagash_grand_spells_on_resource_change",
        "PooledResourceEffectChangedEvent",
        function(context)
            return context:faction():name() == bdsm:get_faction_key() and 
            (context:resource():key() == "nag_grand_spell_01" or context:resource():key() == "nag_grand_spell_02" or context:resource():key() == "nag_grand_spell_03") 
        end,
        function(context)            
            update_grand_spells_availability()
        end,
        true
    )

    core:add_listener(
        "nagash_battle_grand_spells_used",
        "BattleCompleted",
        true,
        function(context)                
            self:logf("++++++battle completed!")
            local key = self:get_faction_key()
            if cm:pending_battle_cache_faction_is_involved(bdsm:get_faction_key()) and 
                    (cm:model():pending_battle():get_how_many_times_ability_has_been_used_in_battle(nagash_faction_cqi, grand_spells_ability_key[1]) > 0) then                
                cm:faction_add_pooled_resource(key, "nag_grand_spell_01", "nag_grand_spell_01_recharge", - grand_spell_cost)
                self:logf("grand spell 01 cast!")
            end
            if cm:pending_battle_cache_faction_is_involved(bdsm:get_faction_key()) and 
                    (cm:model():pending_battle():get_how_many_times_ability_has_been_used_in_battle(nagash_faction_cqi, grand_spells_ability_key[2]) > 0) then                
                cm:faction_add_pooled_resource(bdsm:get_faction_key(), "nag_grand_spell_02", "nag_grand_spell_02_recharge", - grand_spell_cost)
                self:logf("grand spell 02 cast!!")
            end
            if cm:pending_battle_cache_faction_is_involved(bdsm:get_faction_key()) and 
                    (cm:model():pending_battle():get_how_many_times_ability_has_been_used_in_battle(nagash_faction_cqi, grand_spells_ability_key[3]) > 0) then                
                cm:faction_add_pooled_resource(bdsm:get_faction_key(), "nag_grand_spell_03", "nag_grand_spell_03_recharge", - grand_spell_cost)
                self:logf("grand spell 03 cast!!")
            end
        end,
        true
    )

    -- build the BP main 3
    core:add_listener(
        "nag_grand_spell_01_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_3";
        end,
        function(context)
            self:logf("nag_grand_spell_01_unlocking!")
            local key = self:get_faction_key()
            cc:add_pr_uic("nag_grand_spell_01", "ui/battle ui/ability_icons/nag_army_abilities_endless_tomb.png", bdsm:get_faction_key())
            cm:faction_add_pooled_resource(key, "nag_grand_spell_01", "nag_grand_spell_01_recharge", grand_spell_cost)            
            grand_spell_status.nag_grand_spell_01 = true
            cm:set_saved_value("grand_spell_status_nag_grand_spell_01", grand_spell_status.nag_grand_spell_01)
        end,
        true
    )
    
    -- build the BP obelisk 4
    core:add_listener(
        "nag_grand_spell_02_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_obelisk_4";
        end,
        function(context)
            self:logf("nag_grand_spell_02_unlocking!")
            local key = self:get_faction_key()
            cc:add_pr_uic("nag_grand_spell_02", "ui/battle ui/ability_icons/nag_army_abilities_batocalypse.png", bdsm:get_faction_key())
            cm:faction_add_pooled_resource(key, "nag_grand_spell_02", "nag_grand_spell_02_recharge", grand_spell_cost)            
            grand_spell_status.nag_grand_spell_02 = true
            cm:set_saved_value("grand_spell_status_nag_grand_spell_02", grand_spell_status.nag_grand_spell_02)
        end,
        true
    )

    -- build the BP main 5
    core:add_listener(
        "nag_grand_spell_03_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_5";
        end,
        function(context)
            self:logf("nag_grand_spell_03_unlocking!")
            local key = self:get_faction_key()
            cc:add_pr_uic("nag_grand_spell_03", "ui/battle ui/ability_icons/nag_army_abilities_pyramid_bombardment.png", bdsm:get_faction_key())
            cm:faction_add_pooled_resource(key, "nag_grand_spell_03", "nag_grand_spell_03_recharge", grand_spell_cost)            
            grand_spell_status.nag_grand_spell_03 = true
            cm:set_saved_value("grand_spell_status_nag_grand_spell_03", grand_spell_status.nag_grand_spell_03)
        end,
        true
    )

    core:add_listener(
		"RegionFactionChangeEventBlyramidLostRitual",
		"RegionFactionChangeEvent",
		function(context)
			return context:previous_faction():subculture() == "nag_nagash"
		end,
		function(context)
            -- self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 01 cast!")
			local bp = cm:get_region(bdsm._bp_key)
            local key = bdsm:get_faction_key()
            if bp and (bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key) then 
                -- self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 02 cast!")
                self:reset_current_ritual()
                cm:remove_scripted_composite_scene("nag_bp_raise")
                cm:set_saved_value("nag_bp_raise", false)
                self:check_bp_button()
            end
            -- self:logf("++++++RegionFactionChangeEventBlyramidLostRitual 01 cast!")
		end,
		true
    )
    

    core:add_listener(
		"RegionAbandonedWithBuildingEventBlyramidLostRitual",
		"RegionAbandonedWithBuildingEvent",
		function(context)
			return true
		end,
		function(context)
            -- self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 01 cast!")
			local bp = cm:get_region(bdsm._bp_key)
            local key = bdsm:get_faction_key()

            if bp and (bp:owning_faction():is_null_interface() ~= false or bp:owning_faction():name() ~= key) then 
                -- self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 02 cast!")
                self:reset_current_ritual()
                cm:remove_scripted_composite_scene("nag_bp_raise")
                cm:set_saved_value("nag_bp_raise", false)
                self:check_bp_button()
            end
            
            -- self:logf("++++++RegionAbandonedWithBuildingEventBlyramidLostRitual 01 cast!")
		end,
		true
    )

    core:add_listener(
        "CharacterReplacingGeneralNagTraitorKing",
        "CharacterReplacingGeneral",
        function(context)
            local c = context:character()
            -- self:logf("++++++CharacterReplacingGeneralNagTraitorKing 01 !")
            -- self:logf("++++++CharacterReplacingGeneralNagTraitorKing 01 %s !", c:character_subtype_key())
            return c:faction():name() == bdsm:get_faction_key() and (c:character_subtype_key() == "nag_traitor_king") and c:has_military_force()
        end,
        function(context)
            -- self:logf("++++++CharacterReplacingGeneralNagTraitorKing 02 !")
            --- Provide horde IF NOT a Shambling Horde (how to detect????)
            local c = context:character()
            local mf = c:military_force()

            --- This should prevent Shambling Horde conversions (there's no Shambling Horde -> Traitor King Horde direct conversion)
            cm:convert_force_to_type(mf, "nag_traitor_horde")
        end,
        true
    )

    core:add_listener(
        "NagashWimp",
        "RegionFactionChangeEvent",
        function(context)
            local reg = context:region()
            local daddy = reg:owning_faction()
            return not reg:is_abandoned() and not daddy:is_null_interface() and daddy:name() == bdsm:get_faction_key() --and reg:settlement():primary_slot():building():building_level() > 1
        end,
        function (context)
            local reg = context:region()
            cm:instantly_set_settlement_primary_slot_level(reg:settlement(), 1)
            -- self:logf("++++++NagashWimp !")
            if reg:name() == bdsm._bp_key and bdsm:is_bp_rite_available() then 
                -- self:logf("++++++NagashWimp trigger !")
                --- trigger the "Raise the BP!" mission
                bdsm:trigger_bp_raise_mission()
                bdsm:check_bp_button()
            end
        end,
        true
    )

    core:add_listener(
            "NagNagash",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == bdsm:get_faction_key()
            end,
            function(context)
                
                local nag_fact = bdsm:get_faction_key()
                revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash = cm:get_saved_value("nagash_intro_completed")
                
                if revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_great_mortis_delta_black_pyramid_of_nagash")
                end
                if revealed_objectives.wh2_main_the_broken_teeth_nagashizar then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_the_broken_teeth_nagashizar")
                end
                if revealed_objectives.wh2_main_marshes_of_madness_morgheim then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_marshes_of_madness_morgheim")
                end
                if revealed_objectives.wh2_main_devils_backbone_lahmia then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_devils_backbone_lahmia")
                end
                if revealed_objectives.wh2_main_land_of_the_dead_khemri then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_land_of_the_dead_khemri")
                end
                if revealed_objectives.wh2_main_vampire_coast_the_awakening then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_vampire_coast_the_awakening")
                end
                if revealed_objectives.wh_main_eastern_sylvania_castle_drakenhof then
                    cm:make_region_visible_in_shroud(nag_fact, "wh_main_eastern_sylvania_castle_drakenhof")
                end
                if revealed_objectives.wh2_main_titan_peaks_ancient_city_of_quintex then
                    cm:make_region_visible_in_shroud(nag_fact, "wh2_main_titan_peaks_ancient_city_of_quintex")
                end
            end,
            true
    )
    
    local function throw_enemies_at_settlement(setttlement_key, tech_key, invasion_faction, faction_type)
        -- spawns markers which will later spawn invasion armies
        -- self:logf("++++++tech invasions throw_enemies_at_settlement !")
        local num = cm:random_number(3, 2)
        local nag_key = bdsm:get_faction_key()


        --- TODO add despawn event feed

        for i = 1, num do
            local x,y = cm:find_valid_spawn_location_for_character_from_settlement(bdsm:get_faction_key(), setttlement_key, false, true, cm:random_number(24, 12))
            -- marker:spawn(tech_key..i, x, y)
            local region_key = setttlement_key
            -- local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
            local invasion_key = region_key.."_invasion_"..x.."_"..y
    
            local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, faction_type, 19, 7, true, false)
    
            local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nag_key, x, y, true)
            local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})
            -- invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
            invasion_object:set_target("REGION", region_key, nag_key)
            invasion_object:apply_effect("wh_main_bundle_military_upkeep_free_force_siege_attacker", 10);
            invasion_object:apply_effect("wh2_dlc11_bundle_immune_all_attrition", 10);            
            invasion_object:add_aggro_radius(25, {nag_key}, 1)
            invasion_object:start_invasion(true,true,false,false)
        end



    end

    core:add_listener(
    --- When the end game tech is researched, do stuff.
        "NagashEndWorldTechs",
        "ResearchCompleted",
        function(context)
            return context:technology() == "nag_nagash_ultimate_preprartion" or
            context:technology() == "nag_location_nagashizzar" or
            context:technology() == "nag_location_mourkain" or
            context:technology() == "nag_location_lahmia" or
            context:technology() == "nag_location_khemri" or
            context:technology() == "nag_location_awakening" or
            context:technology() == "nag_location_drakenhof" or
            context:technology() == "nag_location_quintex"
        end,
        function(context)
            -- self:logf("++++++tech invasions !")
            tech_key = context:technology()

            if tech_key == "nag_location_nagashizzar" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_the_broken_teeth_nagashizar", "nag_location_nagashizzar", "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven")
            end
            if tech_key == "nag_location_mourkain" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_marshes_of_madness_morgheim", "nag_location_mourkain", "wh2_dlc13_grn_greenskins_invasion", "wh_main_sc_grn_greenskins")
            end
            if tech_key == "nag_location_lahmia" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_devils_backbone_lahmia", "nag_location_lahmia", "wh2_dlc13_bst_beastmen_invasion", "wh_dlc03_sc_bst_beastmen")
            end
            if tech_key == "nag_location_khemri" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_land_of_the_dead_khemri", "nag_location_khemri", "wh2_dlc16_grn_savage_invasion", "wh_main_sc_grn_savage_orcs")
            end
            if tech_key == "nag_location_awakening" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_vampire_coast_the_awakening", "nag_location_awakening", "wh2_dlc16_emp_colonist_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_drakenhof" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh_main_eastern_sylvania_castle_drakenhof", "nag_location_drakenhof", "wh2_dlc16_emp_empire_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_quintex" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh2_main_titan_peaks_ancient_city_of_quintex", "nag_location_quintex", "wh2_dlc13_nor_norsca_invasion", "wh_main_sc_nor_norsca")
            end
         
        end,
        true
    )


end


function bdsm:setup_rites()
    --- TODO causes CTD on load game (:
    cc:add_pr_uic("nag_warpstone", "ui/skins/default/icon_warpstone.png", bdsm:get_faction_key())

    if grand_spell_status.nag_grand_spell_01 then
        cc:add_pr_uic("nag_grand_spell_01", "ui/battle ui/ability_icons/nag_army_abilities_endless_tomb.png", bdsm:get_faction_key())
    end
    if grand_spell_status.nag_grand_spell_02 then
        cc:add_pr_uic("nag_grand_spell_02", "ui/battle ui/ability_icons/nag_army_abilities_batocalypse.png", bdsm:get_faction_key())
    end
    if grand_spell_status.nag_grand_spell_03 then
        cc:add_pr_uic("nag_grand_spell_03", "ui/battle ui/ability_icons/nag_army_abilities_pyramid_bombardment.png", bdsm:get_faction_key())
    end

    nagash_faction_cqi = cm:model():world():faction_by_key(bdsm:get_faction_key()):command_queue_index()
    add_scroll_bar()

    self:unlock_rites_listeners()
    self:trigger_rites_listeners()

    self:add_bp_button()

    core:add_listener(
        "bp_button_pressed",
        "ComponentLClickUp",
        function(context)
            return context.string == "icon_black_pyramid" and bdsm:is_bp_rite_available()
        end,
        function(context)
            -- start the ritual
            bdsm:begin_bp_raise()

            --- refresh the button!
            bdsm:add_bp_button()
        end,
        true
    )

    core:add_listener(
        "bp_button_state_change",
        "BlackPyramidRaised",
        true,
        function(context)

            --- refresh the button!
            bdsm:add_bp_button()
        end,
        true
    )

    core:add_listener(
        "bp_button_state_change",
        "RegionFactionChangeEvent",
        function(context)
            local r = context:region()
            return r:name() == bdsm._bp_key and r:faction():name() == bdsm:get_faction_key()
        end,
        function(context)
            bdsm:add_bp_button()
        end,
        true
    )
end

cm:add_saving_game_callback(
    function(context)
        cm:set_saved_value("rite_status_nag_winds", rite_status.nag_winds)
        cm:set_saved_value("rite_status_nag_death", rite_status.nag_death)
        cm:set_saved_value("rite_status_nag_divinity", rite_status.nag_divinity)
        cm:set_saved_value("rite_status_nag_man", rite_status.nag_man)
        cm:set_saved_value("rite_status_nag_nagash", rite_status.nag_nagash)

        cm:set_saved_value("quests_unlocked_nag_rise_blyramid", quests_unlocked.nag_rise_blyramid)

        cm:set_saved_value("revealed_objectives_wh2_main_great_mortis_delta_black_pyramid_of_nagash", revealed_objectives.wh2_main_great_mortis_delta_black_pyramid_of_nagash)
        cm:set_saved_value("revealed_objectives_wh2_main_the_broken_teeth_nagashizar", revealed_objectives.wh2_main_the_broken_teeth_nagashizar)
        cm:set_saved_value("revealed_objectives_wh2_main_marshes_of_madness_morgheim", revealed_objectives.wh2_main_marshes_of_madness_morgheim)
        cm:set_saved_value("revealed_objectives_wh2_main_devils_backbone_lahmia", revealed_objectives.wh2_main_devils_backbone_lahmia)
        cm:set_saved_value("revealed_objectives_wh2_main_land_of_the_dead_khemri", revealed_objectives.wh2_main_land_of_the_dead_khemri)
        cm:set_saved_value("revealed_objectives_wh2_main_vampire_coast_the_awakening", revealed_objectives.wh2_main_vampire_coast_the_awakening)
        cm:set_saved_value("revealed_objectives_wh_main_eastern_sylvania_castle_drakenhof", revealed_objectives.wh_main_eastern_sylvania_castle_drakenhof)
        cm:set_saved_value("revealed_objectives_wh2_main_titan_peaks_ancient_city_of_quintex", revealed_objectives.wh2_main_titan_peaks_ancient_city_of_quintex)
        
        -- bdsm:logf("++++++ grand_spell_status_nag_grand_spell_01 save = %s", tostring(grand_spell_status.nag_grand_spell_01))

        cm:set_saved_value("grand_spell_status_nag_grand_spell_01", grand_spell_status.nag_grand_spell_01)
        cm:set_saved_value("grand_spell_status_nag_grand_spell_02", grand_spell_status.nag_grand_spell_02)
        cm:set_saved_value("grand_spell_status_nag_grand_spell_03", grand_spell_status.nag_grand_spell_03)
        -- bdsm:logf("++++++ grand_spell_status_nag_grand_spell_01 save = %s", tostring(cm:get_saved_value("grand_spell_status_nag_grand_spell_01")))

        cm:save_named_value("nag_rites", rite_status, context)
        cm:save_named_value("grand_spell_status", grand_spell_status, context)
        cm:save_named_value("revealed_objectives", revealed_objectives, context)     
        cm:save_named_value("quests_unlocked", quests_unlocked, context)    
    end
)

cm:add_loading_game_callback(
    function(context)
        cm:set_saved_value("nagash_stuff_loaded", true)
        -- local rite_status = {
        --     nag_winds = false, -- TODO
        --     nag_death = false,
        --     nag_divinity = false,
        --     nag_man = false,
        --     nag_nagash = false,
        -- }
        
        -- local quests_unlocked = {
        --     nag_rise_blyramid = false, 
        -- }
        
        -- local revealed_objectives = {
        --     wh2_main_great_mortis_delta_black_pyramid_of_nagash = false,
        --     wh2_main_the_broken_teeth_nagashizar = false,
        --     wh2_main_marshes_of_madness_morgheim = false,
        --     wh2_main_devils_backbone_lahmia = false,
        --     wh2_main_land_of_the_dead_khemri = false,
        --     wh2_main_vampire_coast_the_awakening = false,
        --     wh_main_eastern_sylvania_castle_drakenhof = false,
        --     wh2_main_titan_peaks_ancient_city_of_quintex = false,
        -- }
        
        -- local grand_spell_status = {
        --     nag_grand_spell_01 = false,
        --     nag_grand_spell_02 = false,
        --     nag_grand_spell_03 = false,
        -- }
        rite_status = cm:load_named_value("nag_rites", rite_status, context)
        revealed_objectives = cm:load_named_value("revealed_objectives", revealed_objectives, context)
        grand_spell_status = cm:load_named_value("grand_spell_status", grand_spell_status, context)
        quests_unlocked = cm:load_named_value("quests_unlocked", quests_unlocked, context)
    end
)