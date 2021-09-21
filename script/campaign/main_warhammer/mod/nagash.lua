local bdsm = get_bdsm()
local mct

if is_function(get_mct) then
    mct = get_mct()
end

local faction_key = bdsm._faction_key

local function init_listeners()
    --- Whenever a settlement is occupied by Nagash, auto-set the level to 1.
    core:add_listener(
        "NagashWimp",
        "RegionFactionChangeEvent",
        function(context)
            local reg = context:region()
            local daddy = reg:owning_faction()
            return not reg:is_abandoned() and not daddy:is_null_interface() and daddy:name() == faction_key --and reg:settlement():primary_slot():building():building_level() > 1
        end,
        function (context)
            local reg = context:region()
            cm:instantly_set_settlement_primary_slot_level(reg:settlement(), 1)
        end,
        true
    )
end

local function init()
    local option = "bp"
    local all_morts = true
    if mct then
        option = mct:get_mod_by_key("nagash_dev"):get_option_by_key("start_choice"):get_finalized_setting()
        all_morts = mct:get_mod_by_key("nagash_dev"):get_option_by_key("morts"):get_finalized_setting()
    end

    local f = nil

    if option == "intro" then
        f = bdsm.first_turn_begin
    elseif option == "bp" then
        f = bdsm.mid_game_start
    elseif option == "domination" then
        f = bdsm.world_domination_start
    end

    if cm:is_new_game() then
        -- spawn units, set buildings, etc.
        -- intro battle triggered after the rest
        f(bdsm)

        if all_morts then
            bdsm:all_morts()
        end
    else
        -- if option == "intro" then
            if not cm:get_saved_value("bdsm_first_turn_completed") and cm:get_saved_value("bdsm_intro_battle_completed") then
                -- trigger post-battle stuff
                bdsm:post_intro_battle()
            end
        -- end
    end

    init_listeners()
end

cm:add_first_tick_callback(init)