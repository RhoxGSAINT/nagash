----- Handle the Mortarch systems

local bdsm = get_bdsm()

bdsm._mortarchs = {}
local mortarchs = {
    {
        subtype = "wh2_dlc11_cst_harkon",
        forename = "1937224331",
        surname = "",
        acquired = false,
    },
    {
        subtype = "dlc04_vmp_vlad_con_carstein",
        forename = "1937224332",
        surname = "",
        acquired = false,
    },
    {
        subtype = "vmp_mannfred_von_carstein",
        forename = "1937224333",
        surname = "",
        acquired = false,
    },
    {
        subtype = "wh2_dlc09_tmb_arkhan",
        forename = "1937224334",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_neferata",
        forename = "1937224329",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_krell",
        forename = "1937224330",
        surname = "",
        acquired = false,
    },
}

--- Each need:
--[[ 
    agent subtype
    mf horde type (?)
    PR tracker listeners
    Acquisition listeners
    Acquisition state
    porthole UIC details and shtuff
--]]

---@class mortarch
local mortarch = {}

function mortarch.new(o)
    o = o or {}
    setmetatable(o, {__index = mortarch})

    return o
end

function mortarch:init()
    -- if not acquired, start the tracking for the acquisition!

    -- if acquired, start the tracking for PR and stuff if needed!
end

--- objective key (also links to loc key) ; event ; callback/conditional ; tracker var ; limit
function mortarch:add_acquisition_condition(callback)
    local str = "hello " ..
    "hello" .. " my friends" ..
    ""
end

--- Sets the number of conditions required to unlock this Mortarch
---@param num number The number of conditions required
function mortarch:set_acquisition_condition_requirement(num)
    if not is_number(num) then return end

    self._acquisition_num = num
end

--- TODO initialize the mortarch objects in the first place!
function bdsm:create_mortarchs()
    local arkhan = mortarchs[4]

    local mort = mortarch.new(arkhan)
    -- mort:

    self._mortarchs[#self._mortarchs+1] = mort

    mort:init()
end

function bdsm:instantiate_mortarch(o, i)
    if not is_table(o) then return end

    setmetatable(o, {__index = mortarch})

    self._mortarchs[i] = o
end

function bdsm:instantiate_mortarchs()
    for i = 1, #self._mortarchs do
        self:instantiate_mortarch(self._mortarchs[i], i)
    end
end

function bdsm:unlock_mortarch()

end

--- Dev function to automatically unlock and spawn every Mortarch.
function bdsm:all_morts()
    local fact_key = self:get_faction_key()
    local nagash = self:get_faction_leader()
    local region = nagash:region()
    local region_key = region:name()

    for i = 1, #mortarchs do
        local mort = mortarchs[i]

        local x,y = cm:find_valid_spawn_location_for_character_from_character(fact_key, "character_cqi:"..nagash:command_queue_index(), true, 6)

        if x ~= -1 then

            cm:create_force_with_general(
                fact_key,
                "",
                region_key,
                x,
                y,
                "general",
                mort.subtype,
                "names_name_"..mort.forename,
                "",
                "names_name_"..mort.surname,
                "",
                false,
                function(cqi)

                end
            )
        else
            bdsm:error("Couldn't find a position for morty "..mort.subtype)
        end
    end
end



cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("nag_mortarchs", bdsm._mortarchs, context)
    end
)

cm:add_loading_game_callback(
    function(context)
        bdsm._mortarchs = cm:load_named_value("nag_mortarchs", {}, context)

        bdsm:instantiate_mortarchs()
    end
)