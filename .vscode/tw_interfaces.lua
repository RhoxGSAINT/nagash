--- TODO autogen


---@class BUILDING_SCRIPT_INTERFACE Building script interface.
local BUILDING_SCRIPT_INTERFACE = {}

---@class SETTLEMENT_SCRIPT_INTERFACE
local SETTLEMENT_SCRIPT_INTERFACE = {}

---@class FACTION_SCRIPT_INTERFACE
---@field name fun(self:FACTION_SCRIPT_INTERFACE):string Key for this faction, from factions_tables

---@class CHARACTER_SCRIPT_INTERFACE
---@field faction fun(self:CHARACTER_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field character_subtype_key fun(self:CHARACTER_SCRIPT_INTERFACE):string Subtype for this character, from agent_subtypes_tables.