--- TODO a file with all the CA methods and objects and shit

---@class CampaignManager
---@alias cm CampaignManager
---@field unlock_technology fun(self:cm, faction_key:string, technology_key:string) Removes a lock previously placed with cm:lock_technology.
---@field lock_technology fun(self:cm, faction_key:string, technology_key:string) Lock a specified technology and all technologies that are children of it, for a specified faction. This setting is saved into the campaign save file when the game is saved, and automatically re-established when the campaign is reloaded.
---@field update_technology_unlock_progress_values fun(self:cm, faction_key:string, tech_key:string, values:table) Update the progress values for locked-techs, so their UI will show the proper values.

---@type CampaignManager
cm = {}
