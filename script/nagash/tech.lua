--- TODO get rid of this file and handle it all in morts.lua


--- TODO pull in all of the shit necessary for tech stuff from VLib, for scripted unlocks and stuff? Or use the new BMen stuff?
    --- yes, use new BMen stuff. 
        --- cm:update_technology_unlock_progress_values(faction_key, technology_key, {table_of_values})
        --- cm:[un]lock_technology

--- TODO handle Mort acquisition and events and stuff through here as well
--- TODO fix up the PR UI within tech, right now it gets confused and says Canopic Jars on the tech node display.

--- TODO a table of all tech keys and their inner values.
    --- unlock conditions, texts, etc.

-- local bdsm = get_bdsm()
local tech_progress = {

}

--- All of the event techs begin locked, as do all Mort unlock techs except for Arkhan
local locked_techs = {
    "nag_arkhan_event_1",
    "nag_arkhan_event_2",
    "nag_arkhan_event_3",
    "nag_luthor_event_1",
    "nag_luthor_event_2",
    "nag_luthor_event_3",
    "nag_mannfred_event_1",
    "nag_mannfred_event_2",
    "nag_mannfred_event_3",
    "nag_krell_event_1",
    "nag_krell_event_2",
    "nag_krell_event_3",
    "nag_neferata_event_1",
    "nag_neferata_event_2",
    "nag_neferata_event_3",
    "nag_vlad_event_1",
    "nag_vlad_event_2",
    "nag_vlad_event_3",

    -- "nag_arkhan_unlock",
    "nag_luthor_unlock",
    "nag_mannfred_unlock",
    "nag_krell_unlock",
    "nag_neferata_unlock",
    "nag_vlad_unlock",
}

--- First node for each Mortarch
local unlock_techs = {
    nag_arkhan_unlock = true,
    nag_luthor_unlock = true,
    nag_mannfred_unlock = true,
    nag_krell_unlock = true,
    nag_neferata_unlock = true,
    nag_vlad_unlock = true,
}
    
--- TODO start up the listeners for each tech event.
--- TODO track values and shit.
local function init()
    if cm:is_new_game() then
        --- Start off every primary tech as locked!
        for i,tech in ipairs(locked_techs) do
            cm:lock_technology(bdsm:get_faction_key(), tech)
        end
    end

    --- When an "unlock" tech is researched, spawn the related Morty.
    core:add_listener(
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            return unlock_techs[context:technology()]
        end,
        function(context)
            local tech_key = context:technology()
            
            --- format "nag_arkhan_unlock" to "nag_mortarch_arkhan"

            -- mort_key is "arkhan" or "vlad" or whatever
            local mort_key = string.gsub(tech_key, "nag_", "")
            mort_key = string.gsub(mort_key, "_unlock", "")

            -- append the prefix
            mort_key = "nag_mortarch_"..mort_key

            -- get and spawn the mortarch
            bdsm:log()
        end,
        true
    )
end


cm:add_first_tick_callback(init)