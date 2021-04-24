local bdsm = get_bdsm()

---@class ui_obj
local ui_obj = {}

function ui_obj:open_rites()

end

function ui_obj:open_mortarchs()
    local new_panel = core:get_or_create_component("mortarch_panel", "ui/vandy_lib/panel_frame")

    new_panel:SetVisible(true)

    -- local close_button = UIComponent(new_panel:CreateComponent("close_button", "ui/templates/"))
end

function ui_obj:init_listeners()
    core:add_listener(
        "NagashButtons",
        "ComponentLClickUp",
        function(context)
            return context.string == "nagash_rites"
        end,
        function(context)
            self:open_rites()
        end,
        true
    )
    
    core:add_listener(
        "NagashButtons",
        "ComponentLClickUp",
        function(context)
            return context.string == "nagash_mortarchs"
        end,
        function(context)
            self:open_mortarchs()
        end,
        true
    )
end

function ui_obj:init()
    if cm:get_local_faction_name(true) ~= bdsm:get_faction_key() then
        return
    end

    local parent = find_uicomponent("layout", "faction_buttons_docker", "button_group_management")

    local button_path = "ui/templates/round_medium_button"

    local rites = UIComponent(parent:CreateComponent("nagash_rites", button_path))
    local morts = UIComponent(parent:CreateComponent("nagash_mortarchs", button_path))

    -- TODO set the shit
    rites:SetTooltipText("Nagash's Rites!", true)
    morts:SetTooltipText("Mortarchs", true)

    parent:Layout()

    self:init_listeners()
end

cm:add_first_tick_callback(function() ui_obj:init() end)