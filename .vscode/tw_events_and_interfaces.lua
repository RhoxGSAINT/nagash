--- TODO auto gen
---@diagnostic disable -- Ignore all diagnostics on this page!

---============================---
    --- [[ Interfaces ]] ---
---============================---

---@class BUILDING_SCRIPT_INTERFACE Building script interface.


---@class SETTLEMENT_SCRIPT_INTERFACE

---@class REGION_SCRIPT_INTERFACE
---@field owning_faction fun(self:REGION_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE

---@class FACTION_SCRIPT_INTERFACE
---@field name fun(self:FACTION_SCRIPT_INTERFACE):string Key for this faction, from factions_tables

---@class CHARACTER_SCRIPT_INTERFACE
---@field faction fun(self:CHARACTER_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field character_subtype_key fun(self:CHARACTER_SCRIPT_INTERFACE):string Subtype for this character, from agent_subtypes_tables.

---============================---
    --- [[ Events ]] ---
---============================---

---@class IncidentFailedEvent
---@field faction fun(self:IncidentFailedEvent):FACTION_SCRIPT_INTERFACE The faction involved in the incident.
---@field record_key fun(self:IncidentFailedEvent):string The key for the incident.

---@class CharacterCreated
---@field character fun(self:CharacterCreated):CHARACTER_SCRIPT_INTERFACE

---@class RegionFactionChangeEvent
---@field region fun(self:RegionFactionChangeEvent):REGION_SCRIPT_INTERFACE

---@class ResearchCompleted
---@field technology fun(self:ResearchCompleted):string
---@field faction fun(self:ResearchCompleted):FACTION_SCRIPT_INTERFACE

---============================---
    --- [[ Listener ]] ---
---============================---

---@alias listenerCondition fun(context:Context):boolean

---@class Core
---@field add_listener fun(self:Core, key:string, event: "'IncidentFailedEvent'", conditional: fun(context:IncidentFailedEvent), callback:fun(context:IncidentFailedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCreated'", conditional: fun(context:CharacterCreated), callback:fun(context:CharacterCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionFactionChangeEvent'", conditional: fun(context:RegionFactionChangeEvent), callback:fun(context:RegionFactionChangeEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ResearchCompleted'", conditional: fun(context:ResearchCompleted), callback:fun(context:ResearchCompleted), persistent:boolean)


---@type Core
core = {}