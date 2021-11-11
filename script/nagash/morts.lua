--- TODO hook in the various Mortarch unlocks and spawns
--- TODO lock the various Mortarch events behind whatever conditions
--- TODO trigger whatever scripted effects for each event.

----- Handle the Mortarch systems

local bdsm = get_bdsm()

bdsm._mortarchs = {}
local mortarchs = {
    {
        subtype = "nag_mortarch_luthor",
        forename = "1937224331",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_mortarch_vlad",
        forename = "1937224329",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_mortarch_mannfred",
        forename = "1937224330",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_mortarch_arkhan",
        forename = "1937224332",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_mortarch_neferata",
        forename = "1937224334",
        surname = "",
        acquired = false,
    },
    {
        subtype = "nag_mortarch_krell",
        forename = "1937224333",
        surname = "",
        acquired = false,
    },
}

--- Each need:
--[[ 
    agent subtype
    mf horde type (?)
    acquisition state
    tech key?
    spawn details (ie. spawn with Nagash, or spawn in predefined locations, or what)
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

function mortarch:spawn()

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

function bdsm:get_mortarch_with_key(mortarch_key)
    if not is_string(mortarch_key) then return end

    local mortarchs = self._mortarchs
    for i = 1, #mortarchs do
        if mortarchs[i].subtype == mortarch_key then
            return mortarchs[i]
        end
    end
end

function bdsm:unlock_mortarch(mortarch_key)
    local mort = self:get_mortarch_with_key(mortarch_key)
    if not mort then return end


end

--- Dev function to automatically unlock and spawn every Mortarch.
function bdsm:all_morts()
    local fact = self:get_faction()
    local fact_key = self:get_faction_key()
    local nagash = self:get_faction_leader()
    local nag_mf = nagash:military_force()
    local region = nagash:region()
    local region_key = region:name()

    cm:spawn_agent_at_military_force(fact, nag_mf, "dignitary", "nag_mortarch_isabella")

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