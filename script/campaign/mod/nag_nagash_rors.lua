--[[
    Script by Aexrael Dex, Shaky and Vandy
]]

local function nag_nagash_ror_setup()

    local ror_factions = {
        ["nag_nagash"] = true
    };

    local ror_units = {
        "nag_bone_colossus",
        "nag_virion_plaguecart",
        "nag_revenants",
        "nag_shade_haunts",
    };

    local unit_count = 1
    local rcp = 20
    local max_units = 1
    local murpt = 0.1
    local xp_level = 0
    local frr = ""
    local srr = ""
    local trr = ""

    core:add_listener(
        "nag_nagash_ror_setup_monitor",
        "FactionTurnStart",
        function(context)
            return ror_factions[context:faction():name()]
        end,
        function(context)
            for faction_key, _ in pairs(ror_factions) do
                local faction_obj = cm:get_faction(faction_key)
                if not faction_obj or faction_obj:is_null_interface() or faction_obj:is_dead() then
                    -- skip
                else
                  for i = 1, #ror_units do
                      local ror_unit = ror_units[i]
                      cm:add_unit_to_faction_mercenary_pool(faction_obj, ror_unit, unit_count, rcp, max_units, murpt, xp_level, frr, srr, trr, true)
                  end
                end
            end

            cm:set_saved_value("nag_nagash_rors_enabled", true)
        end,
        false
    )
end;

cm:add_first_tick_callback(
    function()
     if cm:get_saved_value("nag_nagash_rors_enabled") == nil then
        nag_nagash_ror_setup()
        end
    end
)