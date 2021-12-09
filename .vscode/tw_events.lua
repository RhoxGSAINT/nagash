---@diagnostic disable -- Ignore all diagnostics on this page!


---@class IncidentFailedEvent
---@field faction fun(self:IncidentFailedEvent):FACTION_SCRIPT_INTERFACE The faction involved in the incident.
---@field record_key fun(self:IncidentFailedEvent):string The key for the incident.

---@class CharacterCreated
---@field character fun(self:CharacterCreated):CHARACTER_SCRIPT_INTERFACE

---@class Core
---@field add_listener fun(self:Core, key:string, event: "'IncidentFailedEvent'", conditional: fun(context:IncidentFailedEvent), callback:fun(context:IncidentFailedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCreated'", conditional: fun(context:CharacterCreated), callback:fun(context:CharacterCreated), persistent:boolean)
core = {}