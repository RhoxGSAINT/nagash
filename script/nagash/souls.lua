-- the scripted mechanics revolving around the raising of the BP and what not

-- TODO "unlock ritual" when the BP is occupied by Nagash (or upgraded to a certain level? some other criterion?)
-- TODO spawn intervention armies (use the welf system) when the ritual begins
-- TODO set the ritual in some cute UI, something floating on the BP region?

--- TODO the end game ritual

--- TODO all of the rituals

---@class bdsm
local bdsm = get_bdsm()

local rite_status = {
    nag_winds = true, -- TODO
    nag_death = false,
    nag_divinity = false,
    nag_man = false,
    nag_nagash = false,
}

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
            dummy:DestoryChildren()
        end,
        true
    )
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

local vlib = get_vandy_lib()

---@type vlib_camp_counselor
local cc = vlib:get_module("camp_counselor")
--- TODO scripted effects
function bdsm:setup_rites()
    cc:add_pr_uic("nag_warpstone", "ui/skins/default/icon_warpstone.png", bdsm:get_faction_key())

    add_scroll_bar()

    if not rite_status.nag_winds then
        -- build the BP Obelisk
        core:add_listener(
            "NagWinds",
            "MilitaryForceBuildingCompleteEvent",
            function(context)
                self:logf("MilitaryForceBuildingCompleteEvent!")
                return context:building():name() == "nag_bpyramid_main_obelisk_4"
            end,
            function(context)
                unlock_rite("nag_winds")
            end,
            false
        )
    else -- TODO doesn't work!
        --- TODO don't let the ritual be used if Nagash is wounded or offscreen
        -- TODO on ritual completed, trigger a dilemma
        -- on dilemma select, listen to the option to trigger the spell ability
        core:add_listener(
            "NagWindsRitual",
            "RitualCompletedEvent",
            function(context)
                return context:ritual():ritual_key() == "nag_winds"
            end,
            function(context)
                -- trigger ritual
                local faction = context:performing_faction()

                cm:trigger_dilemma(
                    faction:name(), 
                    context:ritual():ritual_key(),
                    function()
                        core:add_listener(
                            "NagWindsDilemma",
                            "DilemmaChoiceMadeEvent",
                            function(context)
                                return context:dilemma() == "nag_winds"
                            end,
                            function(context)
                                local choice = context:choice()
                                local faction_leader = bdsm:get_faction_leader()

                                local eb = "nag_ability_enable_blyramid_bombardment"

                                --- TODO assign army ability effect bundle to Nagash army based on choice
                                if choice == 0 then 
                                    -- batz
                                    eb = "nag_ability_enable_batocalypse"
                                elseif choice == 1 then
                                    -- endless tomb
                                    eb = "nag_ability_enable_endless_to☻mb"
                                end

                                cm:apply_effect_bundle_to_character(eb, faction_leader, 5)
                            end,
                            false
                        )
                    end
                )
            end,
            true
        )
    end

    if not rite_status.nag_death then
        --- TODO guarantee this works with either boner version
        --- Win 5 battles with Nagash
        core:add_listener(
            "NagDeath",
            "CharacterCompletedBattle",
            function(context)
                local character = context:character()
                return character:character_subtype_key() == "nag_nagash_husk" or character:character_subtype_key() == "nag_nagash_boss" and character:battles_won() >= 5
            end,
            function(context)
                unlock_rite("nag_death")
            end,
            false
        )
    else
        -- TODO on ritual completed, trigger an army spawn or whatever the fuck we decide
    end

    if not rite_status.nag_divinity then
        --- Nag level
        core:add_listener(
            "NagDivinity",
            "CharacterRankUp",
            function(context)
                local character = context:character()
                return character:faction():name() == bdsm:get_faction_key() and character:character_subtype_key() == "nag_nagash_husk" or character:character_subtype_key() == "nag_nagash_boss" and character:rank() >= 12
            end,
            function(context)
                unlock_rite("nag_divinity")
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
                unlock_rite("nag_man")
            end,
            false
        )
    else
        --- TODO on rite completed, select a Nemesis faction to target. can do this programmatically with a dilemma, yay
    end

    if not rite_status.nag_nagash then
        --- TODO gain it when you build the BP
        -- core:add_listener(
        --     "NagNagash",
        --     ""
        -- )
    end
end

cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("nag_rites", rite_status, context)
    end
)

cm:add_loading_game_callback(
    function(context)
        rite_status = cm:load_named_value("nag_rites", rite_status, context)
    end
)