--- TODO a file with all the CA methods and objects and shit

---@alias optstring string|'""'

---@class CampaignManager
---@alias cm CampaignManager
---@field unlock_technology fun(self:cm, faction_key:string, technology_key:string) Removes a lock previously placed with cm:lock_technology.
---@field lock_technology fun(self:cm, faction_key:string, technology_key:string) Lock a specified technology and all technologies that are children of it, for a specified faction. This setting is saved into the campaign save file when the game is saved, and automatically re-established when the campaign is reloaded.
---@field update_technology_unlock_progress_values fun(self:cm, faction_key:string, tech_key:string, values:table) Update the progress values for locked-techs, so their UI will show the proper values.
---@field instantly_set_settlement_primary_slot_level fun(self:cm, settlment:SETTLEMENT_SCRIPT_INTERFACE, level:number):BUILDING_SCRIPT_INTERFACE
---@field transfer_region_to_faction fun(self:cm, region_key:string, faction_key:string) Immediately transfers ownership of the specified region to the specified faction.
---@field force_add_ancillary fun(self:cm, character:CHARACTER_SCRIPT_INTERFACE, ancillary_key:string, force_equip:boolean, suppress_event_feed:boolean)
---@field spawn_character_to_pool fun(self:cm, faction:string, forename:optstring, surname:optstring, clan_name:optstring, other_name:optstring, age:number, is_male:boolean, agent_key: string, agent_subtype_key: string, is_immortal: boolean, art_set: optstring)
---@field find_valid_spawn_location_for_character_from_settlement fun(self:cm, faction_key:string, region_key:string, on_sea:boolean, in_same_region:boolean, preferred_spawn_distance?:number)
---@field find_valid_spawn_location_for_character_from_position fun(self:cm, faction_key:string, x:number, y:boolean, in_same_region:boolean, preferred_spawn_distance?:number)
---@field find_valid_spawn_location_for_character_from_character fun(self:cm, faction_key:string, char_str:string, in_same_region:boolean, preferred_spawn_distance?:number)
  
---@type CampaignManager
cm = {}
