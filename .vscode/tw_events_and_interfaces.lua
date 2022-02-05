---@diagnostic disable

---============================---
	--- [[ Events ]] ---
---============================---

---@class CampaignCoastalAssaultOnGarrison
---@see Core#add_listener
---@field garrison_residence fun(self:CampaignCoastalAssaultOnGarrison):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CampaignCoastalAssaultOnGarrison):CHARACTER_SCRIPT_INTERFACE

---@class UnitTrained
---@field unit fun(self:UnitTrained):UNIT_SCRIPT_INTERFACE

---@class CharacterRankUpNeedsAncillary
---@field character fun(self:CharacterRankUpNeedsAncillary):CHARACTER_SCRIPT_INTERFACE

---@class MissionEvent
---@field faction fun(self:MissionEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionEvent):MODEL_SCRIPT_INTERFACE

---@class UnitCreated
---@field unit fun(self:UnitCreated):UNIT_SCRIPT_INTERFACE

---@class CharacterCharacterTargetAction
---@field mission_result_critial_success fun(self:CharacterCharacterTargetAction):NONE
---@field mission_result_success fun(self:CharacterCharacterTargetAction):NONE
---@field mission_result_opportune_failure fun(self:CharacterCharacterTargetAction):NONE
---@field mission_result_failure fun(self:CharacterCharacterTargetAction):NONE
---@field mission_result_critial_failure fun(self:CharacterCharacterTargetAction):NONE
---@field ability fun(self:CharacterCharacterTargetAction):NONE
---@field attribute fun(self:CharacterCharacterTargetAction):NONE
---@field agent_action_key fun(self:CharacterCharacterTargetAction):NONE
---@field target_character fun(self:CharacterCharacterTargetAction):CHARACTER_SCRIPT_INTERFACE
---@field character fun(self:CharacterCharacterTargetAction):CHARACTER_SCRIPT_INTERFACE

---@class CharacterSelected
---@field character fun(self:CharacterSelected):CHARACTER_SCRIPT_INTERFACE

---@class UnitTurnEnd
---@field unit fun(self:UnitTurnEnd):UNIT_SCRIPT_INTERFACE

---@class FactionLeaderSignsPeaceTreaty
---@field character fun(self:FactionLeaderSignsPeaceTreaty):CHARACTER_SCRIPT_INTERFACE

---@class ScriptedCharacterUnhiddenFailed
---@field character fun(self:ScriptedCharacterUnhiddenFailed):CHARACTER_SCRIPT_INTERFACE

---@class FactionTurnStart
---@field faction fun(self:FactionTurnStart):FACTION_SCRIPT_INTERFACE

---@class UnitCompletedBattle
---@field unit fun(self:UnitCompletedBattle):UNIT_SCRIPT_INTERFACE

---@class FactionLeaderDeclaresWar
---@field character fun(self:FactionLeaderDeclaresWar):CHARACTER_SCRIPT_INTERFACE

---@class ForceAdoptsStance
---@field stance_adopted fun(self:ForceAdoptsStance):NONE
---@field military_force fun(self:ForceAdoptsStance):MILITARY_FORCE_SCRIPT_INTERFACE

---@class CampaignBuildingDamaged
---@field garrison_residence fun(self:CampaignBuildingDamaged):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class CharacterComesOfAge
---@field character fun(self:CharacterComesOfAge):CHARACTER_SCRIPT_INTERFACE

---@class RegionFactionChangeEvent
---@field previous_faction fun(self:RegionFactionChangeEvent):FACTION_SCRIPT_INTERFACE
---@field reason fun(self:RegionFactionChangeEvent):NONE
---@field region fun(self:RegionFactionChangeEvent):REGION_SCRIPT_INTERFACE

---@class MissionStatusEvent
---@field mission fun(self:MissionStatusEvent):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionStatusEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionStatusEvent):MODEL_SCRIPT_INTERFACE

---@class RegionAbandonedWithBuildingEvent
---@field abandoning_faction fun(self:RegionAbandonedWithBuildingEvent):FACTION_SCRIPT_INTERFACE
---@field building fun(self:RegionAbandonedWithBuildingEvent):BUILDING_SCRIPT_INTERFACE

---@class FactionAboutToEndTurn
---@field faction fun(self:FactionAboutToEndTurn):FACTION_SCRIPT_INTERFACE

---@class MilitaryForceDevelopmentPointChange
---@field military_force fun(self:MilitaryForceDevelopmentPointChange):MILITARY_FORCE_SCRIPT_INTERFACE
---@field point_change fun(self:MilitaryForceDevelopmentPointChange):NONE

---@class CharacterBecomesFactionLeader
---@field character fun(self:CharacterBecomesFactionLeader):CHARACTER_SCRIPT_INTERFACE

---@class CharacterFamilyRelationDied
---@field relationship fun(self:CharacterFamilyRelationDied):NONE

---@class CampaignArmiesMerge
---@field target_character fun(self:CampaignArmiesMerge):CHARACTER_SCRIPT_INTERFACE
---@field character fun(self:CampaignArmiesMerge):CHARACTER_SCRIPT_INTERFACE

---@class MissionNearingExpiry
---@field mission fun(self:MissionNearingExpiry):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionNearingExpiry):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionNearingExpiry):MODEL_SCRIPT_INTERFACE

---@class CharacterCandidateBecomesMinister
---@field character fun(self:CharacterCandidateBecomesMinister):CHARACTER_SCRIPT_INTERFACE

---@class CampaignEffectsBundleAwarded
---@field faction fun(self:CampaignEffectsBundleAwarded):FACTION_SCRIPT_INTERFACE

---@class FirstTickAfterWorldCreated
---@field world fun(self:FirstTickAfterWorldCreated):WORLD_SCRIPT_INTERFACE

---@class CharacterGarrisonTargetAction
---@field mission_result_critial_success fun(self:CharacterGarrisonTargetAction):NONE
---@field mission_result_success fun(self:CharacterGarrisonTargetAction):NONE
---@field mission_result_opportune_failure fun(self:CharacterGarrisonTargetAction):NONE
---@field mission_result_failure fun(self:CharacterGarrisonTargetAction):NONE
---@field mission_result_critial_failure fun(self:CharacterGarrisonTargetAction):NONE
---@field ability fun(self:CharacterGarrisonTargetAction):NONE
---@field attribute fun(self:CharacterGarrisonTargetAction):NONE
---@field agent_action_key fun(self:CharacterGarrisonTargetAction):NONE
---@field garrison_residence fun(self:CharacterGarrisonTargetAction):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterGarrisonTargetAction):CHARACTER_SCRIPT_INTERFACE

---@class FactionBeginTurnPhaseNormal
---@field faction fun(self:FactionBeginTurnPhaseNormal):FACTION_SCRIPT_INTERFACE

---@class CharacterParticipatedAsSecondaryGeneralInBattle
---@field character fun(self:CharacterParticipatedAsSecondaryGeneralInBattle):CHARACTER_SCRIPT_INTERFACE

---@class SlotOpens
---@field region_slot fun(self:SlotOpens):SLOT_SCRIPT_INTERFACE

---@class RegionRebels
---@field region fun(self:RegionRebels):REGION_SCRIPT_INTERFACE

---@class MovementPointsExhausted
---@field character fun(self:MovementPointsExhausted):CHARACTER_SCRIPT_INTERFACE

---@class FactionTurnEnd
---@field faction fun(self:FactionTurnEnd):FACTION_SCRIPT_INTERFACE

---@class CharacterBrokePortBlockade
---@field character fun(self:CharacterBrokePortBlockade):CHARACTER_SCRIPT_INTERFACE

---@class AreaEntered
---@field area_key fun(self:AreaEntered):CHARACTER_SCRIPT_INTERFACE

---@class ForeignSlotManagerDiscoveredEvent
---@field owner fun(self:ForeignSlotManagerDiscoveredEvent):FACTION_SCRIPT_INTERFACE
---@field discoveree fun(self:ForeignSlotManagerDiscoveredEvent):FACTION_SCRIPT_INTERFACE
---@field slot_manager fun(self:ForeignSlotManagerDiscoveredEvent):FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE

---@class CharacterSkillPointAllocated
---@field skill_point_spent_on fun(self:CharacterSkillPointAllocated):NONE

---@class CharacterPerformsActionAgainstFriendlyTarget
---@field character fun(self:CharacterPerformsActionAgainstFriendlyTarget):CHARACTER_SCRIPT_INTERFACE

---@class CharacterBlockadedPort
---@field garrison_residence fun(self:CharacterBlockadedPort):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterBlockadedPort):CHARACTER_SCRIPT_INTERFACE

---@class PendingBankruptcy
---@field faction fun(self:PendingBankruptcy):FACTION_SCRIPT_INTERFACE

---@class SharedStateChangedScriptEvent
---@field get_key fun(self:SharedStateChangedScriptEvent):NONE
---@field get_state_as_bool fun(self:SharedStateChangedScriptEvent):NONE
---@field get_state_as_float fun(self:SharedStateChangedScriptEvent):NONE
---@field is_bool fun(self:SharedStateChangedScriptEvent):NONE
---@field is_float fun(self:SharedStateChangedScriptEvent):NONE

---@class CharacterCapturedSettlementUnopposed
---@field garrison_residence fun(self:CharacterCapturedSettlementUnopposed):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterCapturedSettlementUnopposed):CHARACTER_SCRIPT_INTERFACE

---@class CharacterSackedSettlement
---@field garrison_residence fun(self:CharacterSackedSettlement):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterSackedSettlement):CHARACTER_SCRIPT_INTERFACE

---@class UniqueAgentEvent
---@field unique_agent_details fun(self:UniqueAgentEvent):UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE

---@class IncidentFailedEvent
---@field faction fun(self:IncidentFailedEvent):FACTION_SCRIPT_INTERFACE
---@field record_key fun(self:IncidentFailedEvent):String

---@class RegionIssuesDemands
---@field region fun(self:RegionIssuesDemands):REGION_SCRIPT_INTERFACE

---@class CharacterRelativeKilled
---@field character fun(self:CharacterRelativeKilled):CHARACTER_SCRIPT_INTERFACE

---@class CampaignCoastalAssaultOnCharacter
---@field target_character fun(self:CampaignCoastalAssaultOnCharacter):CHARACTER_SCRIPT_INTERFACE
---@field character fun(self:CampaignCoastalAssaultOnCharacter):CHARACTER_SCRIPT_INTERFACE

---@class CharacterLootedSettlement
---@field garrison_residence fun(self:CharacterLootedSettlement):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterLootedSettlement):CHARACTER_SCRIPT_INTERFACE

---@class PrisonActionTakenEvent
---@field prisoner_family_member fun(self:PrisonActionTakenEvent):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field action_key fun(self:PrisonActionTakenEvent):String
---@field faction fun(self:PrisonActionTakenEvent):FACTION_SCRIPT_INTERFACE

---@class MultiTurnMove
---@field character fun(self:MultiTurnMove):CHARACTER_SCRIPT_INTERFACE

---@class PooledResourceEffectChangedEvent
---@field old_effect fun(self:PooledResourceEffectChangedEvent):NONE
---@field new_effect fun(self:PooledResourceEffectChangedEvent):NONE
---@field type fun(self:PooledResourceEffectChangedEvent):NONE
---@field faction fun(self:PooledResourceEffectChangedEvent):FACTION_SCRIPT_INTERFACE
---@field resource fun(self:PooledResourceEffectChangedEvent):POOLED_RESOURCE_SCRIPT_INTERFACE

---@class IncidentOccuredEvent
---@field faction fun(self:IncidentOccuredEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:IncidentOccuredEvent):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:IncidentOccuredEvent):NONE

---@class CharacterEvent
---@field character fun(self:CharacterEvent):CHARACTER_SCRIPT_INTERFACE

---@class DilemmaIssued
---@field faction fun(self:DilemmaIssued):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:DilemmaIssued):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:DilemmaIssued):NONE

---@class DebugCharacterEvent
---@field id fun(self:DebugCharacterEvent):NONE

---@class PooledResourceEvent
---@field faction fun(self:PooledResourceEvent):FACTION_SCRIPT_INTERFACE
---@field resource fun(self:PooledResourceEvent):POOLED_RESOURCE_SCRIPT_INTERFACE

---@class FactionRoundStart
---@field faction fun(self:FactionRoundStart):FACTION_SCRIPT_INTERFACE

---@class FactionGovernmentTypeChanged
---@field faction fun(self:FactionGovernmentTypeChanged):FACTION_SCRIPT_INTERFACE

---@class CharacterAttacksAlly
---@field target_faction fun(self:CharacterAttacksAlly):FACTION_SCRIPT_INTERFACE
---@field character fun(self:CharacterAttacksAlly):CHARACTER_SCRIPT_INTERFACE

---@class RecruitmentItemIssuedByPlayer
---@field main_unit_record fun(self:RecruitmentItemIssuedByPlayer):NONE
---@field time_to_build fun(self:RecruitmentItemIssuedByPlayer):NONE
---@field faction fun(self:RecruitmentItemIssuedByPlayer):FACTION_SCRIPT_INTERFACE

---@class ScriptedCharacterUnhidden
---@field character fun(self:ScriptedCharacterUnhidden):CHARACTER_SCRIPT_INTERFACE

---@class CharacterCompletedBattle
---@field pending_battle fun(self:CharacterCompletedBattle):PENDING_BATTLE_SCRIPT_INTERFACE
---@field character fun(self:CharacterCompletedBattle):CHARACTER_SCRIPT_INTERFACE

---@class SlotSelected
---@field garrison_residence fun(self:SlotSelected):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class AreaExited
---@field area_key fun(self:AreaExited):CHARACTER_SCRIPT_INTERFACE

---@class DilemmaChoiceMadeEvent
---@field choice fun(self:DilemmaChoiceMadeEvent):NONE
---@field faction fun(self:DilemmaChoiceMadeEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:DilemmaChoiceMadeEvent):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:DilemmaChoiceMadeEvent):NONE

---@class CharacterConvalescedOrKilled
---@field character fun(self:CharacterConvalescedOrKilled):CHARACTER_SCRIPT_INTERFACE

---@class RegionRiots
---@field region fun(self:RegionRiots):REGION_SCRIPT_INTERFACE

---@class RitualsCompletedAndDelayedEvent
---@field rituals fun(self:RitualsCompletedAndDelayedEvent):ACTIVE_RITUAL_LIST_SCRIPT_INTERFACE

---@class CharacterDisembarksNavy
---@field character fun(self:CharacterDisembarksNavy):CHARACTER_SCRIPT_INTERFACE

---@class RegionTurnStart
---@field region fun(self:RegionTurnStart):REGION_SCRIPT_INTERFACE

---@class MissionGenerationFailed
---@field mission fun(self:MissionGenerationFailed):NONE

---@class CharacterCreated
---@field character fun(self:CharacterCreated):CHARACTER_SCRIPT_INTERFACE

---@class CharacterTargetEvent
---@field target_character fun(self:CharacterTargetEvent):CHARACTER_SCRIPT_INTERFACE
---@field character fun(self:CharacterTargetEvent):CHARACTER_SCRIPT_INTERFACE

---@class FactionCivilWarOccured
---@field opponent fun(self:FactionCivilWarOccured):FACTION_SCRIPT_INTERFACE
---@field faction fun(self:FactionCivilWarOccured):FACTION_SCRIPT_INTERFACE

---@class RitualCompletedEvent
---@field succeeded fun(self:RitualCompletedEvent):NONE
---@field performing_faction fun(self:RitualCompletedEvent):FACTION_SCRIPT_INTERFACE
---@field ritual_target_faction fun(self:RitualCompletedEvent):FACTION_SCRIPT_INTERFACE
---@field ritual fun(self:RitualCompletedEvent):ACTIVE_RITUAL_SCRIPT_INTERFACE

---@class UnitConverted
---@field converted_unit fun(self:UnitConverted):UNIT_SCRIPT_INTERFACE
---@field unit fun(self:UnitConverted):UNIT_SCRIPT_INTERFACE

---@class UnitEvent
---@field unit fun(self:UnitEvent):UNIT_SCRIPT_INTERFACE

---@class UnitSelectedCampaign
---@field unit fun(self:UnitSelectedCampaign):UNIT_SCRIPT_INTERFACE

---@class GarrisonOccupiedEvent
---@field garrison_residence fun(self:GarrisonOccupiedEvent):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:GarrisonOccupiedEvent):CHARACTER_SCRIPT_INTERFACE

---@class ClimatePhaseChange
---@field world fun(self:ClimatePhaseChange):WORLD_SCRIPT_INTERFACE

---@class RitualEvent
---@field performing_faction fun(self:RitualEvent):FACTION_SCRIPT_INTERFACE
---@field ritual_target_faction fun(self:RitualEvent):FACTION_SCRIPT_INTERFACE
---@field ritual fun(self:RitualEvent):ACTIVE_RITUAL_SCRIPT_INTERFACE

---@class UniqueAgentDespawned
---@field unique_agent_details fun(self:UniqueAgentDespawned):UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE

---@class MissionSucceeded
---@field mission fun(self:MissionSucceeded):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionSucceeded):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionSucceeded):MODEL_SCRIPT_INTERFACE

---@class GovernorAssignedCharacterEvent
---@field province fun(self:GovernorAssignedCharacterEvent):GOVERNOR_ASSIGNED_CHARACTER_EVENT
---@field region fun(self:GovernorAssignedCharacterEvent):GOVERNOR_ASSIGNED_CHARACTER_EVENT

---@class UnitDisbanded
---@field unit fun(self:UnitDisbanded):UNIT_SCRIPT_INTERFACE

---@class GovernorshipTaxRateChanged
---@field faction fun(self:GovernorshipTaxRateChanged):FACTION_SCRIPT_INTERFACE

---@class NominalDifficultyLevelChangedEvent
---@field model fun(self:NominalDifficultyLevelChangedEvent):MODEL_SCRIPT_INTERFACE

---@class CharacterFinishedMovingEvent
---@field was_flee fun(self:CharacterFinishedMovingEvent):NONE

---@class UnitEffectPurchased
---@field effect fun(self:UnitEffectPurchased):UNIT_PURCHASABLE_EFFECT_SCRIPT_INTERFACE
---@field unit fun(self:UnitEffectPurchased):UNIT_SCRIPT_INTERFACE

---@class CharacterTurnEnd
---@field character fun(self:CharacterTurnEnd):CHARACTER_SCRIPT_INTERFACE

---@class WorldCreated
---@field world fun(self:WorldCreated):WORLD_SCRIPT_INTERFACE

---@class CharacterMilitaryForceTraditionPointAvailable
---@field military_force fun(self:CharacterMilitaryForceTraditionPointAvailable):MILITARY_FORCE_SCRIPT_INTERFACE

---@class TradeNodeConnected
---@field character fun(self:TradeNodeConnected):CHARACTER_SCRIPT_INTERFACE

---@class FactionEvent
---@field faction fun(self:FactionEvent):FACTION_SCRIPT_INTERFACE

---@class NegativeDiplomaticEvent
---@field proposer fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field recipient fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_alliance fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_military_alliance fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_defensive_alliance fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_war fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_military_access fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_trade_agreement fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_non_aggression_pact fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field was_vassalage fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field proposer_was_vassal fun(self:NegativeDiplomaticEvent):FACTION_SCRIPT_INTERFACE

---@class FactionJoinsConfederation
---@field confederation fun(self:FactionJoinsConfederation):FACTION_SCRIPT_INTERFACE
---@field faction fun(self:FactionJoinsConfederation):FACTION_SCRIPT_INTERFACE

---@class PendingBattle
---@field model fun(self:PendingBattle):MODEL_SCRIPT_INTERFACE
---@field pending_battle fun(self:PendingBattle):PENDING_BATTLE_SCRIPT_INTERFACE

---@class NewCharacterEnteredRecruitmentPool
---@field character_details fun(self:NewCharacterEnteredRecruitmentPool):CHARACTER_DETAILS_SCRIPT_INTERFACE

---@class SeaTradeRouteRaided
---@field character fun(self:SeaTradeRouteRaided):CHARACTER_SCRIPT_INTERFACE

---@class DilemmaEvent
---@field faction fun(self:DilemmaEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:DilemmaEvent):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:DilemmaEvent):NONE

---@class IncidentEvent
---@field faction fun(self:IncidentEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:IncidentEvent):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:IncidentEvent):NONE

---@class CharacterMilitaryForceTraditionPointAllocated
---@field military_force fun(self:CharacterMilitaryForceTraditionPointAllocated):MILITARY_FORCE_SCRIPT_INTERFACE
---@field tradition_point_spent_on fun(self:CharacterMilitaryForceTraditionPointAllocated):NONE

---@class CharacterLeavesGarrison
---@field garrison_residence fun(self:CharacterLeavesGarrison):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterLeavesGarrison):CHARACTER_SCRIPT_INTERFACE

---@class CharacterEntersGarrison
---@field garrison_residence fun(self:CharacterEntersGarrison):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterEntersGarrison):CHARACTER_SCRIPT_INTERFACE

---@class ImprisonmentEvent
---@field prisoner_family_member fun(self:ImprisonmentEvent):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field faction fun(self:ImprisonmentEvent):FACTION_SCRIPT_INTERFACE

---@class ResearchStarted
---@field faction fun(self:ResearchStarted):FACTION_SCRIPT_INTERFACE

---@class BuildingCompleted
---@field building fun(self:BuildingCompleted):BUILDING_SCRIPT_INTERFACE
---@field garrison_residence fun(self:BuildingCompleted):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class CharacterGarrisonTargetEvent
---@field garrison_residence fun(self:CharacterGarrisonTargetEvent):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterGarrisonTargetEvent):CHARACTER_SCRIPT_INTERFACE

---@class TriggerPostBattleAncillaries
---@field pending_battle fun(self:TriggerPostBattleAncillaries):PENDING_BATTLE_SCRIPT_INTERFACE
---@field has_stolen_ancillary fun(self:TriggerPostBattleAncillaries):NONE

---@class MissionCancelled
---@field mission fun(self:MissionCancelled):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionCancelled):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionCancelled):MODEL_SCRIPT_INTERFACE

---@class RitualStartedEvent
---@field performing_faction fun(self:RitualStartedEvent):FACTION_SCRIPT_INTERFACE
---@field ritual_target_faction fun(self:RitualStartedEvent):FACTION_SCRIPT_INTERFACE
---@field ritual fun(self:RitualStartedEvent):ACTIVE_RITUAL_SCRIPT_INTERFACE

---@class FactionLeaderIssuesEdict
---@field province fun(self:FactionLeaderIssuesEdict):NONE
---@field initiative_key fun(self:FactionLeaderIssuesEdict):NONE

---@class FactionSubjugatesOtherFaction
---@field other_faction fun(self:FactionSubjugatesOtherFaction):FACTION_SCRIPT_INTERFACE

---@class MilitaryForceBuildingCompleteEvent
---@field building fun(self:MilitaryForceBuildingCompleteEvent):NONE

---@class CharacterPromoted
---@field character fun(self:CharacterPromoted):CHARACTER_SCRIPT_INTERFACE

---@class DebugFactionEvent
---@field id fun(self:DebugFactionEvent):NONE

---@class CharacterEmbarksNavy
---@field character fun(self:CharacterEmbarksNavy):CHARACTER_SCRIPT_INTERFACE

---@class ResearchCompleted
---@field technology fun(self:ResearchCompleted):NONE
---@field faction fun(self:ResearchCompleted):FACTION_SCRIPT_INTERFACE

---@class MissionIssued
---@field mission fun(self:MissionIssued):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionIssued):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionIssued):MODEL_SCRIPT_INTERFACE

---@class UITrigger
---@field faction_cqi fun(self:UITrigger):NONE
---@field trigger fun(self:UITrigger):NONE

---@class SettlementSelected
---@field garrison_residence fun(self:SettlementSelected):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class RegionPlagueStateChanged
---@field is_infected fun(self:RegionPlagueStateChanged):REGION_SCRIPT_INTERFACE
---@field region fun(self:RegionPlagueStateChanged):REGION_SCRIPT_INTERFACE

---@class CharacterRazedSettlement
---@field garrison_residence fun(self:CharacterRazedSettlement):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterRazedSettlement):CHARACTER_SCRIPT_INTERFACE

---@class NewCampaignStarted
---@field model fun(self:NewCampaignStarted):MODEL_SCRIPT_INTERFACE

---@class ForeignSlotBuildingDamagedEvent
---@field building fun(self:ForeignSlotBuildingDamagedEvent):NONE

---@class CharacterPerformsSettlementOccupationDecision
---@field occupation_decision fun(self:CharacterPerformsSettlementOccupationDecision):NONE
---@field garrison_residence fun(self:CharacterPerformsSettlementOccupationDecision):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:CharacterPerformsSettlementOccupationDecision):CHARACTER_SCRIPT_INTERFACE

---@class SlotTurnStart
---@field region_slot fun(self:SlotTurnStart):SLOT_SCRIPT_INTERFACE

---@class ForcePlagueStateChanged
---@field military_force fun(self:ForcePlagueStateChanged):MILITARY_FORCE_SCRIPT_INTERFACE
---@field is_infected fun(self:ForcePlagueStateChanged):NONE

---@class RegionEvent
---@field region fun(self:RegionEvent):REGION_SCRIPT_INTERFACE

---@class CharacterEntersAttritionalArea
---@field character fun(self:CharacterEntersAttritionalArea):CHARACTER_SCRIPT_INTERFACE

---@class CharacterTurnStart
---@field character fun(self:CharacterTurnStart):CHARACTER_SCRIPT_INTERFACE

---@class FactionEncountersOtherFaction
---@field other_faction fun(self:FactionEncountersOtherFaction):FACTION_SCRIPT_INTERFACE

---@class RegionStrikes
---@field region fun(self:RegionStrikes):REGION_SCRIPT_INTERFACE

---@class AreaEnteredEvent
---@field character fun(self:AreaEnteredEvent):CHARACTER_SCRIPT_INTERFACE

---@class DebugRegionEvent
---@field id fun(self:DebugRegionEvent):NONE

---@class ForeignSlotManagerRemovedEvent
---@field owner fun(self:ForeignSlotManagerRemovedEvent):FACTION_SCRIPT_INTERFACE
---@field remover fun(self:ForeignSlotManagerRemovedEvent):FACTION_SCRIPT_INTERFACE
---@field cause_was_razing fun(self:ForeignSlotManagerRemovedEvent):FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE

---@class LandTradeRouteRaided
---@field character fun(self:LandTradeRouteRaided):CHARACTER_SCRIPT_INTERFACE

---@class CharacterRankUp
---@field character fun(self:CharacterRankUp):CHARACTER_SCRIPT_INTERFACE

---@class FactionLiberated
---@field liberating_character fun(self:FactionLiberated):CHARACTER_SCRIPT_INTERFACE

---@class GarrisonResidenceExposedToFaction
---@field encountering_faction fun(self:GarrisonResidenceExposedToFaction):FACTION_SCRIPT_INTERFACE
---@field garrison_residence fun(self:GarrisonResidenceExposedToFaction):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class RegionSlotEvent
---@field region_slot fun(self:RegionSlotEvent):SLOT_SCRIPT_INTERFACE

---@class DiplomaticOfferRejected
---@field proposer fun(self:DiplomaticOfferRejected):FACTION_SCRIPT_INTERFACE
---@field recipient fun(self:DiplomaticOfferRejected):FACTION_SCRIPT_INTERFACE

---@class SharedStateCreatedScriptEvent
---@field get_key fun(self:SharedStateCreatedScriptEvent):NONE
---@field get_state_as_bool fun(self:SharedStateCreatedScriptEvent):NONE
---@field get_state_as_float fun(self:SharedStateCreatedScriptEvent):NONE
---@field is_bool fun(self:SharedStateCreatedScriptEvent):NONE
---@field is_float fun(self:SharedStateCreatedScriptEvent):NONE

---@class AreaExitedEvent
---@field character fun(self:AreaExitedEvent):CHARACTER_SCRIPT_INTERFACE

---@class MilitaryForceCreated
---@field military_force_created fun(self:MilitaryForceCreated):MILITARY_FORCE_SCRIPT_INTERFACE

---@class CharacterMarriage
---@field character fun(self:CharacterMarriage):CHARACTER_SCRIPT_INTERFACE

---@class TradeRouteEstablished
---@field faction fun(self:TradeRouteEstablished):FACTION_SCRIPT_INTERFACE

---@class UnitMergedAndDestroyed
---@field new_unit fun(self:UnitMergedAndDestroyed):UNIT_SCRIPT_INTERFACE
---@field unit fun(self:UnitMergedAndDestroyed):UNIT_SCRIPT_INTERFACE

---@class DilemmaGenerationFailedEvent
---@field faction fun(self:DilemmaGenerationFailedEvent):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:DilemmaGenerationFailedEvent):MODEL_SCRIPT_INTERFACE
---@field dilemma fun(self:DilemmaGenerationFailedEvent):NONE

---@class RitualCancelledEvent
---@field performing_faction fun(self:RitualCancelledEvent):FACTION_SCRIPT_INTERFACE
---@field ritual_target_faction fun(self:RitualCancelledEvent):FACTION_SCRIPT_INTERFACE
---@field ritual fun(self:RitualCancelledEvent):ACTIVE_RITUAL_SCRIPT_INTERFACE

---@class SlotRoundStart
---@field region_slot fun(self:SlotRoundStart):SLOT_SCRIPT_INTERFACE

---@class CharacterBesiegesSettlement
---@field region fun(self:CharacterBesiegesSettlement):REGION_SCRIPT_INTERFACE

---@class HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent
---@field mission_key fun(self:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent):NONE
---@field mission_cqi fun(self:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent):NONE
---@field was_successful fun(self:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent):NONE
---@field character fun(self:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent):CHARACTER_SCRIPT_INTERFACE

---@class GarrisonResidenceEvent
---@field garrison_residence fun(self:GarrisonResidenceEvent):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class CharacterBuildingCompleted
---@field building fun(self:CharacterBuildingCompleted):BUILDING_SCRIPT_INTERFACE
---@field character fun(self:CharacterBuildingCompleted):CHARACTER_SCRIPT_INTERFACE

---@class FactionCookedDish
---@field dish fun(self:FactionCookedDish):COOKING_DISH_SCRIPT_INTERFACE
---@field faction fun(self:FactionCookedDish):FACTION_SCRIPT_INTERFACE

---@class FactionBecomesLiberationVassal
---@field liberating_character fun(self:FactionBecomesLiberationVassal):CHARACTER_SCRIPT_INTERFACE
---@field faction fun(self:FactionBecomesLiberationVassal):FACTION_SCRIPT_INTERFACE

---@class RegionSelected
---@field region fun(self:RegionSelected):REGION_SCRIPT_INTERFACE

---@class UnitEffectUnpurchased
---@field effect fun(self:UnitEffectUnpurchased):UNIT_PURCHASABLE_EFFECT_SCRIPT_INTERFACE

---@class CharacterAncillaryGained
---@field ancillary fun(self:CharacterAncillaryGained):NONE

---@class CharacterCanLiberate
---@field character fun(self:CharacterCanLiberate):CHARACTER_SCRIPT_INTERFACE

---@class CharacterInfoPanelOpened
---@field character fun(self:CharacterInfoPanelOpened):CHARACTER_SCRIPT_INTERFACE

---@class GarrisonAttackedEvent
---@field garrison_residence fun(self:GarrisonAttackedEvent):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field character fun(self:GarrisonAttackedEvent):CHARACTER_SCRIPT_INTERFACE

---@class PositiveDiplomaticEvent
---@field proposer fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field recipient fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_alliance fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_military_alliance fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_defensive_alliance fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_peace_treaty fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_military_access fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_trade_agreement fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_non_aggression_pact fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field is_vassalage fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE
---@field proposer_is_vassal fun(self:PositiveDiplomaticEvent):FACTION_SCRIPT_INTERFACE

---@class ForeignSlotBuildingCompleteEvent
---@field building fun(self:ForeignSlotBuildingCompleteEvent):NONE
---@field slot_manager fun(self:ForeignSlotBuildingCompleteEvent):FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE

---@class FirstTickAfterNewCampaignStarted
---@field model fun(self:FirstTickAfterNewCampaignStarted):MODEL_SCRIPT_INTERFACE

---@class BuildingConstructionIssuedByPlayer
---@field building fun(self:BuildingConstructionIssuedByPlayer):NONE
---@field garrison_residence fun(self:BuildingConstructionIssuedByPlayer):GARRISON_RESIDENCE_SCRIPT_INTERFACE

---@class ImprisonmenRejectiontEvent
---@field prisoner_family_member fun(self:ImprisonmenRejectiontEvent):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field rejection_reasons fun(self:ImprisonmenRejectiontEvent):CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE
---@field faction fun(self:ImprisonmenRejectiontEvent):FACTION_SCRIPT_INTERFACE

---@class RegionTurnEnd
---@field region fun(self:RegionTurnEnd):REGION_SCRIPT_INTERFACE

---@class MissionFailed
---@field mission fun(self:MissionFailed):CAMPAIGN_MISSION_SCRIPT_INTERFACE
---@field faction fun(self:MissionFailed):FACTION_SCRIPT_INTERFACE
---@field campaign_model fun(self:MissionFailed):MODEL_SCRIPT_INTERFACE

---@class UniqueAgentSpawned
---@field unique_agent_details fun(self:UniqueAgentSpawned):UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE

---@class ClanBecomesVassal
---@field faction fun(self:ClanBecomesVassal):FACTION_SCRIPT_INTERFACE

---============================---
	--- [[ Interfaces ]] ---
---============================---

---@class CHARACTER_LIST_SCRIPT_INTERFACE Description: A list of character interfaces
---@field num_items fun(self:CHARACTER_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:CHARACTER_LIST_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field is_empty fun(self:CHARACTER_LIST_SCRIPT_INTERFACE):bool

---@class REGION_MANAGER_SCRIPT_INTERFACE Description: The interface that stores and manages all regions in the game. Useful for looking up region and slot//settlement keys.
---@field is_null_interface fun(self:REGION_MANAGER_SCRIPT_INTERFACE):bool
---@field model fun(self:REGION_MANAGER_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field region_list fun(self:REGION_MANAGER_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field faction_region_list fun(self:REGION_MANAGER_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field region_by_key fun(self:REGION_MANAGER_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field settlement_by_key fun(self:REGION_MANAGER_SCRIPT_INTERFACE):SETTLEMENT_SCRIPT_INTERFACE
---@field slot_by_key fun(self:REGION_MANAGER_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE
---@field resource_exists_anywhere fun(self:REGION_MANAGER_SCRIPT_INTERFACE):bool. It will also return false if the resource key is invalid.

---@class CHARACTER_SCRIPT_INTERFACE Description: Character interface
---@field is_null_interface fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field has_garrison_residence fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field has_region fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field has_military_force fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field model fun(self:CHARACTER_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field garrison_residence fun(self:CHARACTER_SCRIPT_INTERFACE):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field faction fun(self:CHARACTER_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field region fun(self:CHARACTER_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field military_force fun(self:CHARACTER_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field forename fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field surname fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field get_forename fun(self:CHARACTER_SCRIPT_INTERFACE):string
---@field get_surname fun(self:CHARACTER_SCRIPT_INTERFACE):string
---@field flag_path fun(self:CHARACTER_SCRIPT_INTERFACE):string
---@field in_settlement fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field in_port fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_besieging fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_blockading fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_carrying_troops fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field character_type fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field character_type_key fun(self:CHARACTER_SCRIPT_INTERFACE):String
---@field character_subtype fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field character_subtype_key fun(self:CHARACTER_SCRIPT_INTERFACE):String
---@field has_trait fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field trait_points fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field has_ancillary fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field action_points_remaining_percent fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field action_points_per_turn fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field is_male fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field age fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field performed_action_this_turn fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_ambushing fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field turns_at_sea fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field turns_in_own_regions fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field turns_in_enemy_regions fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field is_faction_leader fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field rank fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field defensive_sieges_fought fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field defensive_sieges_won fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field offensive_sieges_fought fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field offensive_sieges_won fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field fought_in_battle fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field won_battle fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field percentage_of_own_alliance_killed fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field ministerial_position fun(self:CHARACTER_SCRIPT_INTERFACE):string
---@field logical_position_x fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field logical_position_y fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field display_position_x fun(self:CHARACTER_SCRIPT_INTERFACE):float
---@field display_position_y fun(self:CHARACTER_SCRIPT_INTERFACE):float
---@field battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_naval_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_naval_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_naval_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_naval_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_ambush_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field offensive_ambush_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_ambush_battles_won fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field defensive_ambush_battles_fought fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field cqi fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field is_embedded_in_military_force fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field embedded_in_military_force fun(self:CHARACTER_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field has_skill fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_hidden fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field routed_in_battle fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field body_guard_casulties fun(self:CHARACTER_SCRIPT_INTERFACE):float
---@field is_deployed fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_at_sea fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field has_recruited_mercenaries fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field number_of_traits fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field trait_level fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field loyalty fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field personal_loyalty_factor fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field interfaction_loyalty fun(self:CHARACTER_SCRIPT_INTERFACE):int
---@field gravitas fun(self:CHARACTER_SCRIPT_INTERFACE):card
---@field has_father fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field has_mother fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field mother fun(self:CHARACTER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field father fun(self:CHARACTER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field family_member fun(self:CHARACTER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field is_politician fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field post_battle_ancilary_chance fun(self:CHARACTER_SCRIPT_INTERFACE):float
---@field is_caster fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_visible_to_faction fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field can_equip_ancillary fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field is_wounded fun(self:CHARACTER_SCRIPT_INTERFACE):bool
---@field character_details fun(self:CHARACTER_SCRIPT_INTERFACE):CHARACTER_DETAILS_SCRIPT_INTERFACE
---@field effect_bundles fun(self:CHARACTER_SCRIPT_INTERFACE):EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE
---@field has_effect_bundle fun(self:CHARACTER_SCRIPT_INTERFACE):bool

---@class MILITARY_FORCE_SCRIPT_INTERFACE Description: Military force interface. Armies and navies are military forces.
---@field is_null_interface fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):int
---@field has_general fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field is_army fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field is_navy fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field model fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field unit_list fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):UNIT_LIST_SCRIPT_INTERFACE
---@field character_list fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):CHARACTER_LIST_SCRIPT_INTERFACE
---@field general_character fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field faction fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field has_garrison_residence fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field garrison_residence fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field contains_mercenaries fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field upkeep fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):int >= 
---@field active_stance fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):String
---@field can_activate_stance fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field morale fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):card
---@field is_armed_citizenry fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field can_recruit_agent_at_force fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field can_recruit_unit fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field can_recruit_unit_class fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field can_recruit_unit_category fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field strength fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):float
---@field has_effect_bundle fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):bool
---@field effect_bundles fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE
---@field force_type fun(self:MILITARY_FORCE_SCRIPT_INTERFACE):MILITARY_FORCE_TYPE_SCRIPT_INTERFACE

---@class SETTLEMENT_SCRIPT_INTERFACE Description: Settlement script interface
---@field is_null_interface fun(self:SETTLEMENT_SCRIPT_INTERFACE):bool
---@field cqi fun(self:SETTLEMENT_SCRIPT_INTERFACE):card
---@field has_commander fun(self:SETTLEMENT_SCRIPT_INTERFACE):bool
---@field logical_position_x fun(self:SETTLEMENT_SCRIPT_INTERFACE):int
---@field logical_position_y fun(self:SETTLEMENT_SCRIPT_INTERFACE):int
---@field display_position_x fun(self:SETTLEMENT_SCRIPT_INTERFACE):float
---@field display_position_y fun(self:SETTLEMENT_SCRIPT_INTERFACE):float
---@field display_primary_building_chain fun(self:SETTLEMENT_SCRIPT_INTERFACE):String
---@field primary_building_chain fun(self:SETTLEMENT_SCRIPT_INTERFACE):String
---@field model fun(self:SETTLEMENT_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field commander fun(self:SETTLEMENT_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field faction fun(self:SETTLEMENT_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field region fun(self:SETTLEMENT_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field slot_list fun(self:SETTLEMENT_SCRIPT_INTERFACE):SLOT_LIST_SCRIPT_INTERFACE
---@field is_port fun(self:SETTLEMENT_SCRIPT_INTERFACE):bool
---@field get_climate fun(self:SETTLEMENT_SCRIPT_INTERFACE):String
---@field primary_slot fun(self:SETTLEMENT_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE
---@field port_slot fun(self:SETTLEMENT_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE
---@field active_secondary_slots fun(self:SETTLEMENT_SCRIPT_INTERFACE):SLOT_LIST_SCRIPT_INTERFACE
---@field first_empty_active_secondary_slot fun(self:SETTLEMENT_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE

---@class SEA_REGION_LIST_SCRIPT_INTERFACE Description: Sea Region List script interface, a list of sea regions
---@field is_null_interface fun(self:SEA_REGION_LIST_SCRIPT_INTERFACE):bool

---@class RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE Description: Ritual Target Region Status Script Interface
---@field is_null_interface fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field valid fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field wrong_type fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field no_target fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field not_own fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field is_own fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_subculture fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field foreign_slot_subculture_not_present fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field foreign_slot_set_not_present fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field foreign_slot_set_present fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field is_ruin fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool
---@field is_not_ruin fun(self:RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE):bool

---@class FAMILY_MEMBER_LIST_SCRIPT_INTERFACE Description: A list of family member interfaces
---@field num_items fun(self:FAMILY_MEMBER_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:FAMILY_MEMBER_LIST_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field is_empty fun(self:FAMILY_MEMBER_LIST_SCRIPT_INTERFACE):bool

---@class RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE Description: Ritual Performing Character Script Interface
---@field is_null_interface fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):bool
---@field performer_record fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field performer fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field status fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE
---@field status_with_performer fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE
---@field required_agent_type fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field required_agent_subtype fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field required_level fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):card
---@field recovery_time fun(self:RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):card

---@class FACTION_SCRIPT_INTERFACE Description: Faction interface
---@field is_null_interface fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:FACTION_SCRIPT_INTERFACE):int
---@field region_list fun(self:FACTION_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field character_list fun(self:FACTION_SCRIPT_INTERFACE):CHARACTER_LIST_SCRIPT_INTERFACE
---@field military_force_list fun(self:FACTION_SCRIPT_INTERFACE):MILITARY_FORCE_LIST_SCRIPT_INTERFACE
---@field model fun(self:FACTION_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field is_human fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field name fun(self:FACTION_SCRIPT_INTERFACE):string
---@field home_region fun(self:FACTION_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field faction_leader fun(self:FACTION_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field has_faction_leader fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field has_home_region fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field flag_path fun(self:FACTION_SCRIPT_INTERFACE):String
---@field started_war_this_turn fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field ended_war_this_turn fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field ancillary_exists fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field num_allies fun(self:FACTION_SCRIPT_INTERFACE):int
---@field at_war fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field allied_with fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field military_allies_with fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field defensive_allies_with fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field is_vassal_of fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field is_ally_vassal_or_client_state_of fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field at_war_with fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field trade_resource_exists fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field trade_value fun(self:FACTION_SCRIPT_INTERFACE):int
---@field trade_value_percent fun(self:FACTION_SCRIPT_INTERFACE):int
---@field unused_international_trade_route fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field trade_route_limit_reached fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field sea_trade_route_raided fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field trade_ship_not_in_trade_node fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field treasury fun(self:FACTION_SCRIPT_INTERFACE):int
---@field treasury_percent fun(self:FACTION_SCRIPT_INTERFACE):int
---@field losing_money fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field tax_level fun(self:FACTION_SCRIPT_INTERFACE):int
---@field upkeep_expenditure_percent fun(self:FACTION_SCRIPT_INTERFACE):int
---@field research_queue_idle fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field has_technology fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field state_religion fun(self:FACTION_SCRIPT_INTERFACE):string
---@field num_generals fun(self:FACTION_SCRIPT_INTERFACE):int
---@field culture fun(self:FACTION_SCRIPT_INTERFACE):string
---@field subculture fun(self:FACTION_SCRIPT_INTERFACE):string
---@field has_food_shortages fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field imperium_level fun(self:FACTION_SCRIPT_INTERFACE):card
---@field diplomatic_standing_with fun(self:FACTION_SCRIPT_INTERFACE):int
---@field diplomatic_attitude_towards fun(self:FACTION_SCRIPT_INTERFACE):float
---@field factions_non_aggression_pact_with fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field factions_trading_with fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field factions_at_war_with fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field factions_met fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field factions_of_same_culture fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field factions_of_same_subculture fun(self:FACTION_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field is_quest_battle_faction fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field holds_entire_province fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field is_vassal fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field is_dead fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field total_food fun(self:FACTION_SCRIPT_INTERFACE):int
---@field food_production fun(self:FACTION_SCRIPT_INTERFACE):int
---@field food_consumption fun(self:FACTION_SCRIPT_INTERFACE):int
---@field get_food_factor_value fun(self:FACTION_SCRIPT_INTERFACE):int
---@field get_food_factor_base_value fun(self:FACTION_SCRIPT_INTERFACE):int
---@field get_food_factor_multiplier fun(self:FACTION_SCRIPT_INTERFACE):int
---@field unique_agents fun(self:FACTION_SCRIPT_INTERFACE):UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE
---@field has_effect_bundle fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field has_rituals fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field rituals fun(self:FACTION_SCRIPT_INTERFACE):FACTION_RITUALS
---@field has_faction_slaves fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field num_faction_slaves fun(self:FACTION_SCRIPT_INTERFACE):int
---@field max_faction_slaves fun(self:FACTION_SCRIPT_INTERFACE):int
---@field percentage_faction_slaves fun(self:FACTION_SCRIPT_INTERFACE):float
---@field pooled_resources fun(self:FACTION_SCRIPT_INTERFACE):POOLED_RESOURCE_LIST_SCRIPT_INTERFACE
---@field pooled_resource fun(self:FACTION_SCRIPT_INTERFACE):POOLED_RESOURCE_LIST_SCRIPT_INTERFACE
---@field has_pooled_resource fun(self:FACTION_SCRIPT_INTERFACE):POOLED_RESOURCE_LIST_SCRIPT_INTERFACE
---@field has_ritual_chain fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field has_access_to_ritual_category fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field get_climate_suitability fun(self:FACTION_SCRIPT_INTERFACE):String
---@field foreign_slot_managers fun(self:FACTION_SCRIPT_INTERFACE):FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE
---@field is_allowed_to_capture_territory fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field effect_bundles fun(self:FACTION_SCRIPT_INTERFACE):EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE
---@field is_rebel fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field is_faction fun(self:FACTION_SCRIPT_INTERFACE):bool
---@field unit_cap fun(self:FACTION_SCRIPT_INTERFACE):int
---@field unit_cap_remaining fun(self:FACTION_SCRIPT_INTERFACE):int

---@class SLOT_SCRIPT_INTERFACE Description: Slot script interface
---@field is_null_interface fun(self:SLOT_SCRIPT_INTERFACE):bool
---@field has_building fun(self:SLOT_SCRIPT_INTERFACE):bool
---@field model fun(self:SLOT_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field region fun(self:SLOT_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field building fun(self:SLOT_SCRIPT_INTERFACE):BUILDING_SCRIPT_INTERFACE
---@field faction fun(self:SLOT_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field type fun(self:SLOT_SCRIPT_INTERFACE):string
---@field name fun(self:SLOT_SCRIPT_INTERFACE):string
---@field template_key fun(self:SLOT_SCRIPT_INTERFACE):string
---@field resource_key fun(self:SLOT_SCRIPT_INTERFACE):string
---@field active fun(self:SLOT_SCRIPT_INTERFACE):bool

---@class EFFECT_LIST_SCRIPT_INTERFACE Description: A list of effects
---@field num_items fun(self:EFFECT_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:EFFECT_LIST_SCRIPT_INTERFACE):EFFECT_SCRIPT_INTERFACE
---@field is_empty fun(self:EFFECT_LIST_SCRIPT_INTERFACE):bool

---@class UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE Description: A list of unique agent details
---@field num_items fun(self:UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE):UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE):bool
---@field has_unique_agent_details fun(self:UNIQUE_AGENT_DETAILS_LIST_SCRIPT_INTERFACE):bool

---@class SEA_REGION_MANAGER_SCRIPT_INTERFACE Description: Sea Region Manager script interface, world sea region list, faction sea regions and lookup by key
---@field is_null_interface fun(self:SEA_REGION_MANAGER_SCRIPT_INTERFACE):bool
---@field model fun(self:SEA_REGION_MANAGER_SCRIPT_INTERFACE):CAMPAIGN_MODEL
---@field sea_region_list fun(self:SEA_REGION_MANAGER_SCRIPT_INTERFACE):SEA_REGION_LIST
---@field faction_sea_region_list fun(self:SEA_REGION_MANAGER_SCRIPT_INTERFACE):SEA_REGION_LIST
---@field sea_region_by_key fun(self:SEA_REGION_MANAGER_SCRIPT_INTERFACE):SEA_REGION

---@class CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE Description: Character Imprisonment Rejection Reason Mask Scripting Interface
---@field is_null_interface fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field is_member_of_garrison fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field is_placeholder_character fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field is_from_rebel_faction fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field is_from_companion_faction fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field is_from_dead_faction fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool
---@field any fun(self:CHARACTER_IMPRISONMENT_REJECTION_REASON_MASK_SCRIPTING_INTERFACE):bool

---@class UNIT_LIST_SCRIPT_INTERFACE Description: A list of units
---@field num_items fun(self:UNIT_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:UNIT_LIST_SCRIPT_INTERFACE):UNIT_SCRIPT_INTERFACE
---@field is_empty fun(self:UNIT_LIST_SCRIPT_INTERFACE):bool
---@field has_unit fun(self:UNIT_LIST_SCRIPT_INTERFACE):bool

---@class REGION_DATA_SCRIPT_INTERFACE Description: Region Data Script Interface, a region of the campaign map. May or may not be represented by a region or sea region
---@field is_null_interface fun(self:REGION_DATA_SCRIPT_INTERFACE):bool
---@field key fun(self:REGION_DATA_SCRIPT_INTERFACE):String
---@field is_sea fun(self:REGION_DATA_SCRIPT_INTERFACE):bool
---@field get_bounds fun(self:REGION_DATA_SCRIPT_INTERFACE):bool

---@class CAMPAIGN_MISSION_SCRIPT_INTERFACE Description: Mission script interface.
---@field is_null_interface fun(self:CAMPAIGN_MISSION_SCRIPT_INTERFACE):bool
---@field model fun(self:CAMPAIGN_MISSION_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field faction fun(self:CAMPAIGN_MISSION_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field mission_record_key fun(self:CAMPAIGN_MISSION_SCRIPT_INTERFACE):String
---@field mission_issuer_record_key fun(self:CAMPAIGN_MISSION_SCRIPT_INTERFACE):String

---@class EFFECT_SCRIPT_INTERFACE Description: An effect that provides bonus values via a scope
---@field is_null_interface fun(self:EFFECT_SCRIPT_INTERFACE):bool
---@field key fun(self:EFFECT_SCRIPT_INTERFACE):String
---@field scope fun(self:EFFECT_SCRIPT_INTERFACE):String
---@field value fun(self:EFFECT_SCRIPT_INTERFACE):float

---@class BUILDING_SCRIPT_INTERFACE Description: Building script interface
---@field is_null_interface fun(self:BUILDING_SCRIPT_INTERFACE):bool
---@field model fun(self:BUILDING_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field faction fun(self:BUILDING_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field region fun(self:BUILDING_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field slot fun(self:BUILDING_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE
---@field name fun(self:BUILDING_SCRIPT_INTERFACE):String
---@field chain fun(self:BUILDING_SCRIPT_INTERFACE):String
---@field superchain fun(self:BUILDING_SCRIPT_INTERFACE):String
---@field percent_health fun(self:BUILDING_SCRIPT_INTERFACE)
---@field building_level fun(self:BUILDING_SCRIPT_INTERFACE):card

---@class RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE Description: Ritual Target Military Force Status Script Interface
---@field is_null_interface fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field valid fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field wrong_type fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field no_target fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field not_own fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field is_own fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_subculture fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_for_any_ritual fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field not_on_sea fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool
---@field not_on_land fun(self:RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE):bool

---@class UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE Description: A list of unit purchasable effects
---@field num_items fun(self:UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE):UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE):bool

---@class RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE Description: Ritual Target Faction Status Script Interface
---@field is_null_interface fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field valid fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field wrong_type fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field no_target fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field not_own fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field is_own fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_for_any_ritual fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field human fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field not_human fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool
---@field faction_not_permitted fun(self:RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE):bool

---@class PENDING_BATTLE_SCRIPT_INTERFACE Description: Pending battle script interface.
---@field is_null_interface fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field has_attacker fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field has_defender fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field has_contested_garrison fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field model fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field attacker fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field secondary_attackers fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):CHARACTER_LIST_SCRIPT_INTERFACE
---@field defender fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field secondary_defenders fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):CHARACTER_LIST_SCRIPT_INTERFACE
---@field contested_garrison fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field is_active fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field attacker_is_stronger fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field percentage_of_attacker_killed fun(self:PENDING_BATTLE_SCRIPT_INTERFACE)
---@field percentage_of_defender_killed fun(self:PENDING_BATTLE_SCRIPT_INTERFACE)
---@field percentage_of_attacker_routed fun(self:PENDING_BATTLE_SCRIPT_INTERFACE)
---@field percentage_of_defender_routed fun(self:PENDING_BATTLE_SCRIPT_INTERFACE)
---@field attacker_commander_fought_in_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field defender_commander_fought_in_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field attacker_commander_fought_in_melee fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field defender_commander_fought_in_melee fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field attacker_battle_result fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):String (close_victory, decisive_victory, heroic_victory, pyrrhic_victory, close_defeat, decisive_defeat, crushing_defeat, valiant_defeat
---@field defender_battle_result fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):String (close_victory, decisive_victory, heroic_victory, pyrrhic_victory, close_defeat, decisive_defeat, crushing_defeat, valiant_defeat
---@field naval_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field seige_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field ambush_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field failed_ambush_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field night_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field battle_type fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):string
---@field attacker_strength fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):float
---@field defender_strength fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):float
---@field has_been_fought fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field set_piece_battle_key fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):String
---@field has_scripted_tile_upgrade fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool
---@field get_how_many_times_ability_has_been_used_in_battle fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):int
---@field is_auto_resolved fun(self:PENDING_BATTLE_SCRIPT_INTERFACE):bool

---@class RITUAL_SETUP_SCRIPT_INTERFACE Description: Ritual Setup Script Interface
---@field is_null_interface fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):bool
---@field performing_faction fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field ritual_record fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):String
---@field performing_characters_valid fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):bool
---@field performing_characters fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE
---@field target fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):RITUAL_TARGET_SCRIPT_INTERFACE
---@field clone_as_modify_interface fun(self:RITUAL_SETUP_SCRIPT_INTERFACE):MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE

---@class POOLED_RESOURCE_SCRIPT_INTERFACE Description: Pooled Resource Script Interface
---@field is_null_interface fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):bool
---@field key fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):string
---@field value fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):int
---@field percentage_of_capacity fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):int
---@field minimum_value fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):int
---@field maximum_value fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):int
---@field active_effect fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):String
---@field number_of_effect_types fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):card
---@field factors fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):POOLED_RESOURCE_FACTOR_LIST_SCRIPT_INTERFACE
---@field factor_by_key fun(self:POOLED_RESOURCE_SCRIPT_INTERFACE):POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE

---@class FACTION_LIST_SCRIPT_INTERFACE Description: A list of faction interfaces
---@field num_items fun(self:FACTION_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:FACTION_LIST_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field is_empty fun(self:FACTION_LIST_SCRIPT_INTERFACE):bool

---@class COOKING_DISH_SCRIPT_INTERFACE Description: Cook Dish Script Interface
---@field is_null_interface fun(self:COOKING_DISH_SCRIPT_INTERFACE):bool
---@field recipe fun(self:COOKING_DISH_SCRIPT_INTERFACE):String
---@field ingredients fun(self:COOKING_DISH_SCRIPT_INTERFACE):Lua String Table
---@field faction_effects fun(self:COOKING_DISH_SCRIPT_INTERFACE):EFFECT_LIST_SCRIPT_INTERFACE
---@field faction_leader_effects fun(self:COOKING_DISH_SCRIPT_INTERFACE):EFFECT_LIST_SCRIPT_INTERFACE
---@field remaining_duration fun(self:COOKING_DISH_SCRIPT_INTERFACE):card

---@class REGION_SCRIPT_INTERFACE Description: Region script interface, includes region finance and slot/settlement info
---@field is_null_interface fun(self:REGION_SCRIPT_INTERFACE):bool
---@field cqi fun(self:REGION_SCRIPT_INTERFACE):card
---@field model fun(self:REGION_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field owning_faction fun(self:REGION_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field slot_list fun(self:REGION_SCRIPT_INTERFACE):SLOT_LIST_SCRIPT_INTERFACE
---@field settlement fun(self:REGION_SCRIPT_INTERFACE):SETTLEMENT_SCRIPT_INTERFACE
---@field garrison_residence fun(self:REGION_SCRIPT_INTERFACE):GARRISON_RESIDENCE_SCRIPT_INTERFACE
---@field name fun(self:REGION_SCRIPT_INTERFACE): string
---@field province_name fun(self:REGION_SCRIPT_INTERFACE):String
---@field public_order fun(self:REGION_SCRIPT_INTERFACE):int
---@field num_buildings fun(self:REGION_SCRIPT_INTERFACE):int
---@field slot_type_exists fun(self:REGION_SCRIPT_INTERFACE):bool
---@field building_exists fun(self:REGION_SCRIPT_INTERFACE):bool
---@field last_building_constructed_key fun(self:REGION_SCRIPT_INTERFACE):String
---@field resource_exists fun(self:REGION_SCRIPT_INTERFACE):bool
---@field any_resource_available fun(self:REGION_SCRIPT_INTERFACE):bool
---@field town_wealth_growth fun(self:REGION_SCRIPT_INTERFACE):int
---@field adjacent_region_list fun(self:REGION_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field majority_religion fun(self:REGION_SCRIPT_INTERFACE):String
---@field region_wealth_change_percent fun(self:REGION_SCRIPT_INTERFACE):float
---@field squalor fun(self:REGION_SCRIPT_INTERFACE):card
---@field sanitation fun(self:REGION_SCRIPT_INTERFACE):card
---@field is_abandoned fun(self:REGION_SCRIPT_INTERFACE):bool
---@field religion_proportion fun(self:REGION_SCRIPT_INTERFACE):float
---@field can_recruit_agent_at_settlement fun(self:REGION_SCRIPT_INTERFACE):bool
---@field faction_province_growth fun(self:REGION_SCRIPT_INTERFACE):card
---@field faction_province_growth_per_turn fun(self:REGION_SCRIPT_INTERFACE):card
---@field is_province_capital fun(self:REGION_SCRIPT_INTERFACE):bool
---@field has_development_points_to_upgrade fun(self:REGION_SCRIPT_INTERFACE):bool
---@field has_faction_province_slaves fun(self:REGION_SCRIPT_INTERFACE):bool
---@field num_faction_province_slaves fun(self:REGION_SCRIPT_INTERFACE):int
---@field max_faction_province_slaves fun(self:REGION_SCRIPT_INTERFACE):int
---@field percentage_faction_province_slaves fun(self:REGION_SCRIPT_INTERFACE):float
---@field has_active_storm fun(self:REGION_SCRIPT_INTERFACE):bool
---@field region_data_interface fun(self:REGION_SCRIPT_INTERFACE):REGION_DATA_SCRIPT_INTERFACE
---@field get_selected_edict_key fun(self:REGION_SCRIPT_INTERFACE):REGION_DATA_SCRIPT_INTERFACE
---@field get_active_edict_key fun(self:REGION_SCRIPT_INTERFACE):REGION_DATA_SCRIPT_INTERFACE
---@field foreign_slot_managers fun(self:REGION_SCRIPT_INTERFACE):FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE
---@field foreign_slot_manager_for_faction fun(self:REGION_SCRIPT_INTERFACE):FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE
---@field effect_bundles fun(self:REGION_SCRIPT_INTERFACE):EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE
---@field faction_province_effect_bundles fun(self:REGION_SCRIPT_INTERFACE):EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE
---@field has_effect_bundle fun(self:REGION_SCRIPT_INTERFACE):bool
---@field faction_province_has_effect_bundle fun(self:REGION_SCRIPT_INTERFACE):bool

---@class ACTIVE_RITUAL_SCRIPT_INTERFACE Description: Active Ritual Script Interface
---@field is_null_interface fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):bool
---@field ritual_key fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):String
---@field ritual_chain_key fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):String
---@field is_part_of_chain fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):bool
---@field target_faction fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):Faction
---@field cast_time fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):card
---@field cooldown_time fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):card
---@field expended_resources fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):card
---@field slave_cost fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):card
---@field ritual_sites fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field ritual_category fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):String
---@field ritual_target fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):RITUAL_TARGET_SCRIPT_INTERFACE
---@field characters_who_performed fun(self:ACTIVE_RITUAL_SCRIPT_INTERFACE):FAMILY_MEMBER_LIST_SCRIPT_INTERFACE

---@class FACTION_RITUALS_SCRIPT_INTERFACE Description: Faction Rituals Script Interface
---@field is_null_interface fun(self:FACTION_RITUALS_SCRIPT_INTERFACE):bool
---@field active_rituals fun(self:FACTION_RITUALS_SCRIPT_INTERFACE):ACTIVE_RITUAL_LIST
---@field ritual_status fun(self:FACTION_RITUALS_SCRIPT_INTERFACE):RITUAL_STATUS_SCRIPT_INTERFACE

---@class POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE Description: Pooled Resource Factor Script Interface
---@field is_null_interface fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):bool
---@field key fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):String
---@field value fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):int
---@field percentage_of_capacity fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):int
---@field minimum_value fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):int
---@field maximum_value fun(self:POOLED_RESOURCE_FACTOR_SCRIPT_INTERFACE):int

---@class MODEL_SCRIPT_INTERFACE Description: Model is the central access point of the campaign. Everything should be reachable from this interface
---@field is_null_interface fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field world fun(self:MODEL_SCRIPT_INTERFACE):WORLD_SCRIPT_INTERFACE
---@field pending_battle fun(self:MODEL_SCRIPT_INTERFACE):PENDING_BATTLE_SCRIPT_INTERFACE
---@field date_in_range fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field date_and_week_in_range fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field turn_number fun(self:MODEL_SCRIPT_INTERFACE):int
---@field campaign_name fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field random_percent fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field random_int fun(self:MODEL_SCRIPT_INTERFACE):int
---@field is_multiplayer fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field is_player_turn fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field character_can_reach_character fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field character_can_reach_settlement fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field difficulty_level fun(self:MODEL_SCRIPT_INTERFACE):int
---@field combined_difficulty_level fun(self:MODEL_SCRIPT_INTERFACE):int
---@field faction_is_local fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field player_steam_id_is_even fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field campaign_ai fun(self:MODEL_SCRIPT_INTERFACE):CAMPAIGN_AI_SCRIPT_INTERFACE
---@field campaign_type fun(self:MODEL_SCRIPT_INTERFACE):card
---@field prison_system fun(self:MODEL_SCRIPT_INTERFACE):PRISON_SYSTEM_SCRIPT_INTERFACE
---@field character_for_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field military_force_for_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field faction_for_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field has_character_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field has_military_force_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field has_faction_command_queue_index fun(self:MODEL_SCRIPT_INTERFACE):bool
---@field shared_states_manager fun(self:MODEL_SCRIPT_INTERFACE):SHARED_STATES_MANAGER_SCRIPT_INTERFACE

---@class RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE Description: A list of ritual performing character script interfaces
---@field num_items fun(self:RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE
---@field is_empty fun(self:RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):bool

---@class WORLD_SCRIPT_INTERFACE Description: Contains entities that exist in the game world. Examples include the region manager and faction list
---@field is_null_interface fun(self:WORLD_SCRIPT_INTERFACE):bool
---@field faction_list fun(self:WORLD_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field region_manager fun(self:WORLD_SCRIPT_INTERFACE):REGION_MANAGER_SCRIPT_INTERFACE
---@field sea_region_manager fun(self:WORLD_SCRIPT_INTERFACE):SEA_REGION_MANAGER_SCRIPT_INTERFACE
---@field model fun(self:WORLD_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field faction_by_key fun(self:WORLD_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field faction_exists fun(self:WORLD_SCRIPT_INTERFACE):bool
---@field ancillary_exists fun(self:WORLD_SCRIPT_INTERFACE):bool
---@field climate_phase_index fun(self:WORLD_SCRIPT_INTERFACE):int
---@field whose_turn_is_it fun(self:WORLD_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field region_data fun(self:WORLD_SCRIPT_INTERFACE):REGION_DATA_LIST_SCRIPT_INTERFACE
---@field land_region_data fun(self:WORLD_SCRIPT_INTERFACE):REGION_DATA_LIST_SCRIPT_INTERFACE
---@field sea_region_data fun(self:WORLD_SCRIPT_INTERFACE):REGION_DATA_LIST_SCRIPT_INTERFACE
---@field cooking_system fun(self:WORLD_SCRIPT_INTERFACE):COOKING_SYSTEM_SCRIPT_INTERFACE
---@field characters_owning_ancillary fun(self:WORLD_SCRIPT_INTERFACE):CHARACTER_LIST_SCRIPT_INTERFACE

---@class FACTION_COOKING_INFO_SCRIPT_INTERFACE Description: Faction Cooking Info Script Interface
---@field is_null_interface fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):bool
---@field is_recipe_available fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):bool
---@field is_ingredient_available fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):bool
---@field is_recipe_unlocked fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):bool
---@field is_ingredient_unlocked fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):bool
---@field active_dish fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):String
---@field max_primary_ingredients fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):card
---@field max_secondary_ingredients fun(self:FACTION_COOKING_INFO_SCRIPT_INTERFACE):card

---@class REGION_DATA_LIST_SCRIPT_INTERFACE Description: A list of region datas
---@field num_items fun(self:REGION_DATA_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:REGION_DATA_LIST_SCRIPT_INTERFACE):REGION_DATA_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:REGION_DATA_LIST_SCRIPT_INTERFACE):bool

---@class EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE Description: A list of effects
---@field num_items fun(self:EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE):EFFECT_SCRIPT_INTERFACE
---@field is_empty fun(self:EFFECT_BUNDLE_LIST_SCRIPT_INTERFACE):bool

---@class MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE Description: Modify Ritual Target Script Interface
---@field is_null_interface fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field valid fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field target_faction_status fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE
---@field target_region_status fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE
---@field target_force_status fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE
---@field target_type fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):String
---@field target_record_key fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):String
---@field get_target_faction fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field get_target_region fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field get_target_force fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field is_faction_valid_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field is_region_valid_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field is_force_valid_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field can_target_self fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field status_for_faction_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE
---@field status_for_region_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE
---@field status_for_force_target fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE
---@field get_all_valid_target_forces_in_faction fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):MILITARY_FORCE_LIST_SCRIPT_INTERFACE
---@field get_all_valid_target_regions_in_faction fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field get_all_valid_target_factions fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE
---@field clear fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):void
---@field set_target_faction fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field set_target_region fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field set_target_force fun(self:MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE):bool

---@class RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE Description: Ritual Performing Character Status Script Interface
---@field is_null_interface fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field valid fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field no_performer_provided fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field dead fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field wounded fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field wrong_agent_type fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field wrong_agent_subtype fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field level_too_low fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool
---@field duplicate_performer fun(self:RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE):bool

---@class MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE Description: A list of mutable ritual performing character script interfaces
---@field num_items fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE):bool

---@class FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE Description: Foreign Slot Manager Script Interface
---@field is_null_interface fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):bool
---@field faction fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field region fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field slots fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):SLOT_LIST_SCRIPT_INTERFACE
---@field num_slots fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):card
---@field has_upgrade_available fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):bool
---@field gdp fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):card
---@field has_been_discovered fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):bool
---@field current_discoverability fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):int
---@field discoverability_threshold fun(self:FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE):int

---@class ACTIVE_RITUAL_LIST_SCRIPT_INTERFACE Description: A list of active ritual script interfaces
---@field num_items fun(self:ACTIVE_RITUAL_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:ACTIVE_RITUAL_LIST_SCRIPT_INTERFACE):ACTIVE_RITUAL_SCRIPT_INTERFACE
---@field is_empty fun(self:ACTIVE_RITUAL_LIST_SCRIPT_INTERFACE):bool

---@class SLOT_LIST_SCRIPT_INTERFACE Description: A list of slot interfaces
---@field num_items fun(self:SLOT_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:SLOT_LIST_SCRIPT_INTERFACE):SLOT_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:SLOT_LIST_SCRIPT_INTERFACE):bool
---@field slot_type_exists fun(self:SLOT_LIST_SCRIPT_INTERFACE):bool
---@field buliding_type_exists fun(self:SLOT_LIST_SCRIPT_INTERFACE):bool

---@class COOKING_SYSTEM_SCRIPT_INTERFACE Description: Cook System Script Interface
---@field is_null_interface fun(self:COOKING_SYSTEM_SCRIPT_INTERFACE):bool
---@field faction_cooking_info fun(self:COOKING_SYSTEM_SCRIPT_INTERFACE):FACTION_COOKING_INFO_SCRIPT_INTERFACE

---@class MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE Description: Modify Ritual Performing Character Script Interface
---@field is_null_interface fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):bool
---@field performer_record fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field performer fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field status fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE
---@field status_with_performer fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):RITUAL_PERFORMING_CHARACTER_STATUS_SCRIPT_INTERFACE
---@field required_agent_type fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field required_agent_subtype fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):String
---@field required_level fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):card
---@field recovery_time fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):card
---@field set_performer fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):bool
---@field clear fun(self:MODIFY_RITUAL_PERFORMING_CHARACTER_SCRIPT_INTERFACE):void

---@class RITUAL_TARGET_SCRIPT_INTERFACE Description: Ritual Target Script Interface
---@field is_null_interface fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field valid fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field target_faction_status fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE
---@field target_region_status fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE
---@field target_force_status fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE
---@field target_type fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):String
---@field target_record_key fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):String
---@field get_target_faction fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field get_target_region fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field get_target_force fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field is_faction_valid_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field is_region_valid_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field is_force_valid_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field can_target_self fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):bool
---@field status_for_faction_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_FACTION_STATUS_SCRIPT_INTERFACE
---@field status_for_region_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_REGION_STATUS_SCRIPT_INTERFACE
---@field status_for_force_target fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):RITUAL_TARGET_MILITARY_FORCE_STATUS_SCRIPT_INTERFACE
---@field get_all_valid_target_forces_in_faction fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):MILITARY_FORCE_LIST_SCRIPT_INTERFACE
---@field get_all_valid_target_regions_in_faction fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):REGION_LIST_SCRIPT_INTERFACE
---@field get_all_valid_target_factions fun(self:RITUAL_TARGET_SCRIPT_INTERFACE):FACTION_LIST_SCRIPT_INTERFACE

---@class FOREIGN_SLOT_LIST_SCRIPT_INTERFACE Description: A list of foreign slot script interfaces
---@field num_items fun(self:FOREIGN_SLOT_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:FOREIGN_SLOT_LIST_SCRIPT_INTERFACE):FOREIGN_SLOT
---@field is_empty fun(self:FOREIGN_SLOT_LIST_SCRIPT_INTERFACE):bool

---@class GARRISON_RESIDENCE_SCRIPT_INTERFACE Description: Garrison residence interface, a residence that can act as a garrison for military forces. A Settlement is a garrison residence for example.
---@field is_null_interface fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):int
---@field has_army fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field has_navy fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field model fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field faction fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field army fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field navy fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field region fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field unit_count fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):int >= 
---@field buildings fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):BUILDING_LIST_SCRIPT_INTERFACE
---@field is_under_siege fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field can_assault fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field can_be_occupied_by_faction fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field is_settlement fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field is_slot fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):bool
---@field settlement_interface fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):SETTLEMENT_SCRIPT_INTERFACE
---@field slot_interface fun(self:GARRISON_RESIDENCE_SCRIPT_INTERFACE):SLOT_SCRIPT_INTERFACE

---@class UNIT_PURCHASABLE_EFFECT_SCRIPT_INTERFACE Description: Unit purchasable effect script interface.
---@field is_null_interface fun(self:UNIT_PURCHASABLE_EFFECT_SCRIPT_INTERFACE):bool
---@field record_key fun(self:UNIT_PURCHASABLE_EFFECT_SCRIPT_INTERFACE):String

---@class MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE Description: Modify Ritual Setup Script Interface
---@field is_null_interface fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):bool
---@field performing_faction fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field ritual_record fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):String
---@field performing_characters_valid fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):bool
---@field performing_characters fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):MODIFY_RITUAL_PERFORMING_CHARACTER_LIST_SCRIPT_INTERFACE
---@field target fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):MODIFY_RITUAL_TARGET_SCRIPT_INTERFACE
---@field change_ritual fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):void
---@field change_performing_faction fun(self:MODIFY_RITUAL_SETUP_SCRIPT_INTERFACE):void

---@class REGION_LIST_SCRIPT_INTERFACE Description: A list of region interfaces
---@field num_items fun(self:REGION_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:REGION_LIST_SCRIPT_INTERFACE):REGION_SCRIPT_INTERFACE
---@field is_empty fun(self:REGION_LIST_SCRIPT_INTERFACE):bool

---@class SHARED_STATES_MANAGER_SCRIPT_INTERFACE Description: Shared States Manager Script Interfaces
---@field is_null_interface fun(self:SHARED_STATES_MANAGER_SCRIPT_INTERFACE):bool
---@field get_state_as_bool_value fun(self:SHARED_STATES_MANAGER_SCRIPT_INTERFACE):bool
---@field get_state_as_float_value fun(self:SHARED_STATES_MANAGER_SCRIPT_INTERFACE):float

---@class PRISON_SYSTEM_SCRIPT_INTERFACE Description: Prison System Script Interface
---@field is_null_interface fun(self:PRISON_SYSTEM_SCRIPT_INTERFACE):bool
---@field get_faction_prisoners fun(self:PRISON_SYSTEM_SCRIPT_INTERFACE):FAMILY_MEMBER_LIST_SCRIPT_INTERFACE

---@class FOREIGN_SLOT_SCRIPT_INTERFACE Description: Foreign Slot Script Interface
---@field is_null_interface fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):bool
---@field cqi fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):card
---@field slot_manager fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):FOREIGN_SLOT_MANAGER_SCRIPT_INTERFACE
---@field has_building fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):bool
---@field building fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):String
---@field type_key fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):String
---@field template_key fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):String
---@field active fun(self:FOREIGN_SLOT_SCRIPT_INTERFACE):bool

---@class CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE Description: A customisable effect bundle, based off of an existing effect bundle defined in the database
---@field is_null_interface fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):bool
---@field key fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):String
---@field effects fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):EFFECT_LIST_SCRIPT_INTERFACE
---@field duration fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):card
---@field set_duration fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):void
---@field add_effect fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):bool
---@field set_effect_value fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):bool
---@field remove_effect fun(self:CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE):bool

---@class CHARACTER_DETAILS_SCRIPT_INTERFACE Description: Character details interface
---@field is_null_interface fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field model fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field faction fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field forename fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field surname fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field get_forename fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):string
---@field get_surname fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):string
---@field character_type fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field has_trait fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field trait_points fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field has_ancillary fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field is_male fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field age fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field has_skill fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field number_of_traits fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):card
---@field trait_level fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field loyalty fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field personal_loyalty_factor fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):int
---@field gravitas fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):card
---@field has_father fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field has_mother fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):bool
---@field mother fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field father fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field family_member fun(self:CHARACTER_DETAILS_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE

---@class RESOURCE_TRANSACTION_SCRIPT_INTERFACE Description: Resource Transaction Script Interface
---@field is_null_interface fun(self:RESOURCE_TRANSACTION_SCRIPT_INTERFACE):bool
---@field total_treasury_change fun(self:RESOURCE_TRANSACTION_SCRIPT_INTERFACE):RESOURCE_TRANSACTION_SCRIPT_INTERFACE
---@field total_resource_change fun(self:RESOURCE_TRANSACTION_SCRIPT_INTERFACE):RESOURCE_TRANSACTION_SCRIPT_INTERFACE

---@class POOLED_RESOURCE_LIST_SCRIPT_INTERFACE Description: A list of pooled resource script interfaces
---@field num_items fun(self:POOLED_RESOURCE_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:POOLED_RESOURCE_LIST_SCRIPT_INTERFACE):POOLED_RESOURCE
---@field is_empty fun(self:POOLED_RESOURCE_LIST_SCRIPT_INTERFACE):bool

---@class SEA_REGION_SCRIPT_INTERFACE Description: Sea Region script interface, only basic information as sea regions do not contain settlements
---@field is_null_interface fun(self:SEA_REGION_SCRIPT_INTERFACE):bool
---@field model fun(self:SEA_REGION_SCRIPT_INTERFACE):CAMPAIGN_MODEL
---@field name fun(self:SEA_REGION_SCRIPT_INTERFACE):String
---@field region_data_interface fun(self:SEA_REGION_SCRIPT_INTERFACE):REGION_DATA_SCRIPT_INTERFACE

---@class CHARACTER_DETAILS_LIST_SCRIPT_INTERFACE Description: A list of character details interfaces
---@field num_items fun(self:CHARACTER_DETAILS_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:CHARACTER_DETAILS_LIST_SCRIPT_INTERFACE):CHARACTER_DETAILS_SCRIPT_INTERFACE
---@field is_empty fun(self:CHARACTER_DETAILS_LIST_SCRIPT_INTERFACE):bool

---@class EFFECT_BUNDLE_SCRIPT_INTERFACE Description: An effect bundle, which provides multiple effects to a target game object
---@field is_null_interface fun(self:EFFECT_BUNDLE_SCRIPT_INTERFACE):bool
---@field key fun(self:EFFECT_BUNDLE_SCRIPT_INTERFACE):String
---@field effects fun(self:EFFECT_BUNDLE_SCRIPT_INTERFACE):EFFECT_LIST_SCRIPT_INTERFACE
---@field duration fun(self:EFFECT_BUNDLE_SCRIPT_INTERFACE):card
---@field clone_and_create_custom_effect_bundle fun(self:EFFECT_BUNDLE_SCRIPT_INTERFACE):CUSTOM_EFFECT_BUNDLE_SCRIPT_INTERFACE

---@class POOLED_RESOURCE_FACTOR_LIST_SCRIPT_INTERFACE Description: A list of pooled resource factor script interfaces
---@field num_items fun(self:POOLED_RESOURCE_FACTOR_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:POOLED_RESOURCE_FACTOR_LIST_SCRIPT_INTERFACE):POOLED_RESOURCE_FACTOR
---@field is_empty fun(self:POOLED_RESOURCE_FACTOR_LIST_SCRIPT_INTERFACE):bool

---@class RITUAL_STATUS_SCRIPT_INTERFACE Description: Ritual Status Script Interface
---@field is_null_interface fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field available fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field disabled fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field cannot_afford_resource_cost fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field unlock_mission_not_completed fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field chain_locked fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field prior_chain_stages_incomplete fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field already_completed_in_chain fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field on_cooldown fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field chain_locked_by_another_faction fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field reaction_constraints_not_met fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field not_enough_slaves fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field no_available_ritual_sites fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field script_locked fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field war_declaration_required fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_performing_characters fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool
---@field invalid_target fun(self:RITUAL_STATUS_SCRIPT_INTERFACE):bool

---@class UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE Description: Unique Agent Details Script Interface.
---@field is_null_interface fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):bool
---@field faction fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field character fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field agent_key fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):String
---@field charges fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):card
---@field charges_expended fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):card
---@field valid fun(self:UNIQUE_AGENT_DETAILS_SCRIPT_INTERFACE):bool

---@class CAMPAIGN_AI_SCRIPT_INTERFACE Description: Campaign AI script interface.
---@field is_null_interface fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE):bool
---@field strategic_stance_between_factions fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_available fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_or_blocking_is_set fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_is_active fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_current_level fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_start_round fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_start_level fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_end_round fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_promotion_end_level fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_is_being_blocked fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)
---@field strategic_stance_between_factions_is_being_blocked_until fun(self:CAMPAIGN_AI_SCRIPT_INTERFACE)

---@class UNIT_SCRIPT_INTERFACE Description: Unit script interface. Land units and Naval units are derived from Unit.
---@field is_null_interface fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:UNIT_SCRIPT_INTERFACE):int
---@field has_force_commander fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field has_unit_commander fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field is_land_unit fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field is_naval_unit fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field model fun(self:UNIT_SCRIPT_INTERFACE):MODEL_SCRIPT_INTERFACE
---@field force_commander fun(self:UNIT_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field unit_commander fun(self:UNIT_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE
---@field military_force fun(self:UNIT_SCRIPT_INTERFACE):MILITARY_FORCE_SCRIPT_INTERFACE
---@field faction fun(self:UNIT_SCRIPT_INTERFACE):FACTION_SCRIPT_INTERFACE
---@field unit_key fun(self:UNIT_SCRIPT_INTERFACE):String
---@field unit_category fun(self:UNIT_SCRIPT_INTERFACE):String
---@field unit_class fun(self:UNIT_SCRIPT_INTERFACE):String
---@field percentage_proportion_of_full_strength fun(self:UNIT_SCRIPT_INTERFACE):float
---@field has_banner_ancillary fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field banner_ancillary fun(self:UNIT_SCRIPT_INTERFACE):String
---@field can_upgrade_unit_equipment fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field can_upgrade_unit fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field get_unit_custom_battle_cost fun(self:UNIT_SCRIPT_INTERFACE):card
---@field can_purchase_effect fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field can_unpurchase_effect fun(self:UNIT_SCRIPT_INTERFACE):bool
---@field get_unit_purchasable_effects fun(self:UNIT_SCRIPT_INTERFACE):UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE
---@field get_unit_purchased_effects fun(self:UNIT_SCRIPT_INTERFACE):UNIT_PURCHASABLE_EFFECT_LIST_SCRIPT_INTERFACE

---@class MILITARY_FORCE_TYPE_SCRIPT_INTERFACE Description: A military force type record
---@field is_null_interface fun(self:MILITARY_FORCE_TYPE_SCRIPT_INTERFACE):bool
---@field key fun(self:MILITARY_FORCE_TYPE_SCRIPT_INTERFACE):String
---@field has_feature fun(self:MILITARY_FORCE_TYPE_SCRIPT_INTERFACE):bool
---@field can_convert_to fun(self:MILITARY_FORCE_TYPE_SCRIPT_INTERFACE):bool
---@field can_automatically_convert_to fun(self:MILITARY_FORCE_TYPE_SCRIPT_INTERFACE):bool

---@class BUILDING_LIST_SCRIPT_INTERFACE Description: A list of building interfaces
---@field num_items fun(self:BUILDING_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:BUILDING_LIST_SCRIPT_INTERFACE):BUILDING_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:BUILDING_LIST_SCRIPT_INTERFACE):bool

---@class MILITARY_FORCE_LIST_SCRIPT_INTERFACE Description: A list of military forces
---@field num_items fun(self:MILITARY_FORCE_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:MILITARY_FORCE_LIST_SCRIPT_INTERFACE):MILITARY_FORCE_LIST_SCRIPT_INTERFACE
---@field is_empty fun(self:MILITARY_FORCE_LIST_SCRIPT_INTERFACE):bool

---@class FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE Description: A list of foreign slot manager script interfaces
---@field num_items fun(self:FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE):positive int
---@field item_at fun(self:FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE):FOREIGN_SLOT_MANAGER
---@field is_empty fun(self:FOREIGN_SLOT_MANAGER_LIST_SCRIPT_INTERFACE):bool

---@class FAMILY_MEMBER_SCRIPT_INTERFACE Description: Family interface
---@field is_null_interface fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):bool
---@field has_father fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):bool
---@field has_mother fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):bool
---@field father fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field mother fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):FAMILY_MEMBER_SCRIPT_INTERFACE
---@field has_trait fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):bool
---@field come_of_age fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):bool
---@field command_queue_index fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):card
---@field character_details fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):CHARACTER_DETAILS_SCRIPT_INTERFACE
---@field character fun(self:FAMILY_MEMBER_SCRIPT_INTERFACE):CHARACTER_SCRIPT_INTERFACE

---@class NULL_SCRIPT_INTERFACE Description: An empty interface, returned if a requested interface doesn't exist. If function calls are made with this interface, the LUA script will fail
---@field is_null_interface fun(self:NULL_SCRIPT_INTERFACE):bool

---============================---
	--- [[ Listeners ]] ---
---============================---

---@class Core
---@alias core Core
---@field add_listener fun(self:Core, key:string, event: "'CampaignCoastalAssaultOnGarrison'", conditional: fun(context:CampaignCoastalAssaultOnGarrison), callback:fun(context:CampaignCoastalAssaultOnGarrison), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitTrained'", conditional: fun(context:UnitTrained), callback:fun(context:UnitTrained), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterRankUpNeedsAncillary'", conditional: fun(context:CharacterRankUpNeedsAncillary), callback:fun(context:CharacterRankUpNeedsAncillary), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionEvent'", conditional: fun(context:MissionEvent), callback:fun(context:MissionEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitCreated'", conditional: fun(context:UnitCreated), callback:fun(context:UnitCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCharacterTargetAction'", conditional: fun(context:CharacterCharacterTargetAction), callback:fun(context:CharacterCharacterTargetAction), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterSelected'", conditional: fun(context:CharacterSelected), callback:fun(context:CharacterSelected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitTurnEnd'", conditional: fun(context:UnitTurnEnd), callback:fun(context:UnitTurnEnd), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionLeaderSignsPeaceTreaty'", conditional: fun(context:FactionLeaderSignsPeaceTreaty), callback:fun(context:FactionLeaderSignsPeaceTreaty), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ScriptedCharacterUnhiddenFailed'", conditional: fun(context:ScriptedCharacterUnhiddenFailed), callback:fun(context:ScriptedCharacterUnhiddenFailed), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionTurnStart'", conditional: fun(context:FactionTurnStart), callback:fun(context:FactionTurnStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitCompletedBattle'", conditional: fun(context:UnitCompletedBattle), callback:fun(context:UnitCompletedBattle), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionLeaderDeclaresWar'", conditional: fun(context:FactionLeaderDeclaresWar), callback:fun(context:FactionLeaderDeclaresWar), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForceAdoptsStance'", conditional: fun(context:ForceAdoptsStance), callback:fun(context:ForceAdoptsStance), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CampaignBuildingDamaged'", conditional: fun(context:CampaignBuildingDamaged), callback:fun(context:CampaignBuildingDamaged), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterComesOfAge'", conditional: fun(context:CharacterComesOfAge), callback:fun(context:CharacterComesOfAge), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionFactionChangeEvent'", conditional: fun(context:RegionFactionChangeEvent), callback:fun(context:RegionFactionChangeEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionStatusEvent'", conditional: fun(context:MissionStatusEvent), callback:fun(context:MissionStatusEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionAbandonedWithBuildingEvent'", conditional: fun(context:RegionAbandonedWithBuildingEvent), callback:fun(context:RegionAbandonedWithBuildingEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionAboutToEndTurn'", conditional: fun(context:FactionAboutToEndTurn), callback:fun(context:FactionAboutToEndTurn), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MilitaryForceDevelopmentPointChange'", conditional: fun(context:MilitaryForceDevelopmentPointChange), callback:fun(context:MilitaryForceDevelopmentPointChange), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterBecomesFactionLeader'", conditional: fun(context:CharacterBecomesFactionLeader), callback:fun(context:CharacterBecomesFactionLeader), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterFamilyRelationDied'", conditional: fun(context:CharacterFamilyRelationDied), callback:fun(context:CharacterFamilyRelationDied), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CampaignArmiesMerge'", conditional: fun(context:CampaignArmiesMerge), callback:fun(context:CampaignArmiesMerge), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionNearingExpiry'", conditional: fun(context:MissionNearingExpiry), callback:fun(context:MissionNearingExpiry), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCandidateBecomesMinister'", conditional: fun(context:CharacterCandidateBecomesMinister), callback:fun(context:CharacterCandidateBecomesMinister), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CampaignEffectsBundleAwarded'", conditional: fun(context:CampaignEffectsBundleAwarded), callback:fun(context:CampaignEffectsBundleAwarded), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FirstTickAfterWorldCreated'", conditional: fun(context:FirstTickAfterWorldCreated), callback:fun(context:FirstTickAfterWorldCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterGarrisonTargetAction'", conditional: fun(context:CharacterGarrisonTargetAction), callback:fun(context:CharacterGarrisonTargetAction), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionBeginTurnPhaseNormal'", conditional: fun(context:FactionBeginTurnPhaseNormal), callback:fun(context:FactionBeginTurnPhaseNormal), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterParticipatedAsSecondaryGeneralInBattle'", conditional: fun(context:CharacterParticipatedAsSecondaryGeneralInBattle), callback:fun(context:CharacterParticipatedAsSecondaryGeneralInBattle), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SlotOpens'", conditional: fun(context:SlotOpens), callback:fun(context:SlotOpens), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionRebels'", conditional: fun(context:RegionRebels), callback:fun(context:RegionRebels), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MovementPointsExhausted'", conditional: fun(context:MovementPointsExhausted), callback:fun(context:MovementPointsExhausted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionTurnEnd'", conditional: fun(context:FactionTurnEnd), callback:fun(context:FactionTurnEnd), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterBrokePortBlockade'", conditional: fun(context:CharacterBrokePortBlockade), callback:fun(context:CharacterBrokePortBlockade), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'AreaEntered'", conditional: fun(context:AreaEntered), callback:fun(context:AreaEntered), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForeignSlotManagerDiscoveredEvent'", conditional: fun(context:ForeignSlotManagerDiscoveredEvent), callback:fun(context:ForeignSlotManagerDiscoveredEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterSkillPointAllocated'", conditional: fun(context:CharacterSkillPointAllocated), callback:fun(context:CharacterSkillPointAllocated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterPerformsActionAgainstFriendlyTarget'", conditional: fun(context:CharacterPerformsActionAgainstFriendlyTarget), callback:fun(context:CharacterPerformsActionAgainstFriendlyTarget), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterBlockadedPort'", conditional: fun(context:CharacterBlockadedPort), callback:fun(context:CharacterBlockadedPort), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PendingBankruptcy'", conditional: fun(context:PendingBankruptcy), callback:fun(context:PendingBankruptcy), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SharedStateChangedScriptEvent'", conditional: fun(context:SharedStateChangedScriptEvent), callback:fun(context:SharedStateChangedScriptEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCapturedSettlementUnopposed'", conditional: fun(context:CharacterCapturedSettlementUnopposed), callback:fun(context:CharacterCapturedSettlementUnopposed), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterSackedSettlement'", conditional: fun(context:CharacterSackedSettlement), callback:fun(context:CharacterSackedSettlement), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UniqueAgentEvent'", conditional: fun(context:UniqueAgentEvent), callback:fun(context:UniqueAgentEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'IncidentFailedEvent'", conditional: fun(context:IncidentFailedEvent), callback:fun(context:IncidentFailedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionIssuesDemands'", conditional: fun(context:RegionIssuesDemands), callback:fun(context:RegionIssuesDemands), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterRelativeKilled'", conditional: fun(context:CharacterRelativeKilled), callback:fun(context:CharacterRelativeKilled), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CampaignCoastalAssaultOnCharacter'", conditional: fun(context:CampaignCoastalAssaultOnCharacter), callback:fun(context:CampaignCoastalAssaultOnCharacter), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterLootedSettlement'", conditional: fun(context:CharacterLootedSettlement), callback:fun(context:CharacterLootedSettlement), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PrisonActionTakenEvent'", conditional: fun(context:PrisonActionTakenEvent), callback:fun(context:PrisonActionTakenEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MultiTurnMove'", conditional: fun(context:MultiTurnMove), callback:fun(context:MultiTurnMove), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PooledResourceEffectChangedEvent'", conditional: fun(context:PooledResourceEffectChangedEvent), callback:fun(context:PooledResourceEffectChangedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'IncidentOccuredEvent'", conditional: fun(context:IncidentOccuredEvent), callback:fun(context:IncidentOccuredEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterEvent'", conditional: fun(context:CharacterEvent), callback:fun(context:CharacterEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DilemmaIssued'", conditional: fun(context:DilemmaIssued), callback:fun(context:DilemmaIssued), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DebugCharacterEvent'", conditional: fun(context:DebugCharacterEvent), callback:fun(context:DebugCharacterEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PooledResourceEvent'", conditional: fun(context:PooledResourceEvent), callback:fun(context:PooledResourceEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionRoundStart'", conditional: fun(context:FactionRoundStart), callback:fun(context:FactionRoundStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionGovernmentTypeChanged'", conditional: fun(context:FactionGovernmentTypeChanged), callback:fun(context:FactionGovernmentTypeChanged), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterAttacksAlly'", conditional: fun(context:CharacterAttacksAlly), callback:fun(context:CharacterAttacksAlly), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RecruitmentItemIssuedByPlayer'", conditional: fun(context:RecruitmentItemIssuedByPlayer), callback:fun(context:RecruitmentItemIssuedByPlayer), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ScriptedCharacterUnhidden'", conditional: fun(context:ScriptedCharacterUnhidden), callback:fun(context:ScriptedCharacterUnhidden), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCompletedBattle'", conditional: fun(context:CharacterCompletedBattle), callback:fun(context:CharacterCompletedBattle), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SlotSelected'", conditional: fun(context:SlotSelected), callback:fun(context:SlotSelected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'AreaExited'", conditional: fun(context:AreaExited), callback:fun(context:AreaExited), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DilemmaChoiceMadeEvent'", conditional: fun(context:DilemmaChoiceMadeEvent), callback:fun(context:DilemmaChoiceMadeEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterConvalescedOrKilled'", conditional: fun(context:CharacterConvalescedOrKilled), callback:fun(context:CharacterConvalescedOrKilled), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionRiots'", conditional: fun(context:RegionRiots), callback:fun(context:RegionRiots), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RitualsCompletedAndDelayedEvent'", conditional: fun(context:RitualsCompletedAndDelayedEvent), callback:fun(context:RitualsCompletedAndDelayedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterDisembarksNavy'", conditional: fun(context:CharacterDisembarksNavy), callback:fun(context:CharacterDisembarksNavy), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionTurnStart'", conditional: fun(context:RegionTurnStart), callback:fun(context:RegionTurnStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionGenerationFailed'", conditional: fun(context:MissionGenerationFailed), callback:fun(context:MissionGenerationFailed), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCreated'", conditional: fun(context:CharacterCreated), callback:fun(context:CharacterCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterTargetEvent'", conditional: fun(context:CharacterTargetEvent), callback:fun(context:CharacterTargetEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionCivilWarOccured'", conditional: fun(context:FactionCivilWarOccured), callback:fun(context:FactionCivilWarOccured), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RitualCompletedEvent'", conditional: fun(context:RitualCompletedEvent), callback:fun(context:RitualCompletedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitConverted'", conditional: fun(context:UnitConverted), callback:fun(context:UnitConverted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitEvent'", conditional: fun(context:UnitEvent), callback:fun(context:UnitEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitSelectedCampaign'", conditional: fun(context:UnitSelectedCampaign), callback:fun(context:UnitSelectedCampaign), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GarrisonOccupiedEvent'", conditional: fun(context:GarrisonOccupiedEvent), callback:fun(context:GarrisonOccupiedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ClimatePhaseChange'", conditional: fun(context:ClimatePhaseChange), callback:fun(context:ClimatePhaseChange), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RitualEvent'", conditional: fun(context:RitualEvent), callback:fun(context:RitualEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UniqueAgentDespawned'", conditional: fun(context:UniqueAgentDespawned), callback:fun(context:UniqueAgentDespawned), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionSucceeded'", conditional: fun(context:MissionSucceeded), callback:fun(context:MissionSucceeded), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GovernorAssignedCharacterEvent'", conditional: fun(context:GovernorAssignedCharacterEvent), callback:fun(context:GovernorAssignedCharacterEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitDisbanded'", conditional: fun(context:UnitDisbanded), callback:fun(context:UnitDisbanded), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GovernorshipTaxRateChanged'", conditional: fun(context:GovernorshipTaxRateChanged), callback:fun(context:GovernorshipTaxRateChanged), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'NominalDifficultyLevelChangedEvent'", conditional: fun(context:NominalDifficultyLevelChangedEvent), callback:fun(context:NominalDifficultyLevelChangedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterFinishedMovingEvent'", conditional: fun(context:CharacterFinishedMovingEvent), callback:fun(context:CharacterFinishedMovingEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitEffectPurchased'", conditional: fun(context:UnitEffectPurchased), callback:fun(context:UnitEffectPurchased), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterTurnEnd'", conditional: fun(context:CharacterTurnEnd), callback:fun(context:CharacterTurnEnd), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'WorldCreated'", conditional: fun(context:WorldCreated), callback:fun(context:WorldCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterMilitaryForceTraditionPointAvailable'", conditional: fun(context:CharacterMilitaryForceTraditionPointAvailable), callback:fun(context:CharacterMilitaryForceTraditionPointAvailable), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'TradeNodeConnected'", conditional: fun(context:TradeNodeConnected), callback:fun(context:TradeNodeConnected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionEvent'", conditional: fun(context:FactionEvent), callback:fun(context:FactionEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'NegativeDiplomaticEvent'", conditional: fun(context:NegativeDiplomaticEvent), callback:fun(context:NegativeDiplomaticEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionJoinsConfederation'", conditional: fun(context:FactionJoinsConfederation), callback:fun(context:FactionJoinsConfederation), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PendingBattle'", conditional: fun(context:PendingBattle), callback:fun(context:PendingBattle), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'NewCharacterEnteredRecruitmentPool'", conditional: fun(context:NewCharacterEnteredRecruitmentPool), callback:fun(context:NewCharacterEnteredRecruitmentPool), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SeaTradeRouteRaided'", conditional: fun(context:SeaTradeRouteRaided), callback:fun(context:SeaTradeRouteRaided), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DilemmaEvent'", conditional: fun(context:DilemmaEvent), callback:fun(context:DilemmaEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'IncidentEvent'", conditional: fun(context:IncidentEvent), callback:fun(context:IncidentEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterMilitaryForceTraditionPointAllocated'", conditional: fun(context:CharacterMilitaryForceTraditionPointAllocated), callback:fun(context:CharacterMilitaryForceTraditionPointAllocated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterLeavesGarrison'", conditional: fun(context:CharacterLeavesGarrison), callback:fun(context:CharacterLeavesGarrison), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterEntersGarrison'", conditional: fun(context:CharacterEntersGarrison), callback:fun(context:CharacterEntersGarrison), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ImprisonmentEvent'", conditional: fun(context:ImprisonmentEvent), callback:fun(context:ImprisonmentEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ResearchStarted'", conditional: fun(context:ResearchStarted), callback:fun(context:ResearchStarted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'BuildingCompleted'", conditional: fun(context:BuildingCompleted), callback:fun(context:BuildingCompleted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterGarrisonTargetEvent'", conditional: fun(context:CharacterGarrisonTargetEvent), callback:fun(context:CharacterGarrisonTargetEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'TriggerPostBattleAncillaries'", conditional: fun(context:TriggerPostBattleAncillaries), callback:fun(context:TriggerPostBattleAncillaries), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionCancelled'", conditional: fun(context:MissionCancelled), callback:fun(context:MissionCancelled), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RitualStartedEvent'", conditional: fun(context:RitualStartedEvent), callback:fun(context:RitualStartedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionLeaderIssuesEdict'", conditional: fun(context:FactionLeaderIssuesEdict), callback:fun(context:FactionLeaderIssuesEdict), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionSubjugatesOtherFaction'", conditional: fun(context:FactionSubjugatesOtherFaction), callback:fun(context:FactionSubjugatesOtherFaction), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MilitaryForceBuildingCompleteEvent'", conditional: fun(context:MilitaryForceBuildingCompleteEvent), callback:fun(context:MilitaryForceBuildingCompleteEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterPromoted'", conditional: fun(context:CharacterPromoted), callback:fun(context:CharacterPromoted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DebugFactionEvent'", conditional: fun(context:DebugFactionEvent), callback:fun(context:DebugFactionEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterEmbarksNavy'", conditional: fun(context:CharacterEmbarksNavy), callback:fun(context:CharacterEmbarksNavy), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ResearchCompleted'", conditional: fun(context:ResearchCompleted), callback:fun(context:ResearchCompleted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionIssued'", conditional: fun(context:MissionIssued), callback:fun(context:MissionIssued), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UITrigger'", conditional: fun(context:UITrigger), callback:fun(context:UITrigger), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SettlementSelected'", conditional: fun(context:SettlementSelected), callback:fun(context:SettlementSelected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionPlagueStateChanged'", conditional: fun(context:RegionPlagueStateChanged), callback:fun(context:RegionPlagueStateChanged), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterRazedSettlement'", conditional: fun(context:CharacterRazedSettlement), callback:fun(context:CharacterRazedSettlement), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'NewCampaignStarted'", conditional: fun(context:NewCampaignStarted), callback:fun(context:NewCampaignStarted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForeignSlotBuildingDamagedEvent'", conditional: fun(context:ForeignSlotBuildingDamagedEvent), callback:fun(context:ForeignSlotBuildingDamagedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterPerformsSettlementOccupationDecision'", conditional: fun(context:CharacterPerformsSettlementOccupationDecision), callback:fun(context:CharacterPerformsSettlementOccupationDecision), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SlotTurnStart'", conditional: fun(context:SlotTurnStart), callback:fun(context:SlotTurnStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForcePlagueStateChanged'", conditional: fun(context:ForcePlagueStateChanged), callback:fun(context:ForcePlagueStateChanged), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionEvent'", conditional: fun(context:RegionEvent), callback:fun(context:RegionEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterEntersAttritionalArea'", conditional: fun(context:CharacterEntersAttritionalArea), callback:fun(context:CharacterEntersAttritionalArea), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterTurnStart'", conditional: fun(context:CharacterTurnStart), callback:fun(context:CharacterTurnStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionEncountersOtherFaction'", conditional: fun(context:FactionEncountersOtherFaction), callback:fun(context:FactionEncountersOtherFaction), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionStrikes'", conditional: fun(context:RegionStrikes), callback:fun(context:RegionStrikes), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'AreaEnteredEvent'", conditional: fun(context:AreaEnteredEvent), callback:fun(context:AreaEnteredEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DebugRegionEvent'", conditional: fun(context:DebugRegionEvent), callback:fun(context:DebugRegionEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForeignSlotManagerRemovedEvent'", conditional: fun(context:ForeignSlotManagerRemovedEvent), callback:fun(context:ForeignSlotManagerRemovedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'LandTradeRouteRaided'", conditional: fun(context:LandTradeRouteRaided), callback:fun(context:LandTradeRouteRaided), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterRankUp'", conditional: fun(context:CharacterRankUp), callback:fun(context:CharacterRankUp), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionLiberated'", conditional: fun(context:FactionLiberated), callback:fun(context:FactionLiberated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GarrisonResidenceExposedToFaction'", conditional: fun(context:GarrisonResidenceExposedToFaction), callback:fun(context:GarrisonResidenceExposedToFaction), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionSlotEvent'", conditional: fun(context:RegionSlotEvent), callback:fun(context:RegionSlotEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DiplomaticOfferRejected'", conditional: fun(context:DiplomaticOfferRejected), callback:fun(context:DiplomaticOfferRejected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SharedStateCreatedScriptEvent'", conditional: fun(context:SharedStateCreatedScriptEvent), callback:fun(context:SharedStateCreatedScriptEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'AreaExitedEvent'", conditional: fun(context:AreaExitedEvent), callback:fun(context:AreaExitedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MilitaryForceCreated'", conditional: fun(context:MilitaryForceCreated), callback:fun(context:MilitaryForceCreated), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterMarriage'", conditional: fun(context:CharacterMarriage), callback:fun(context:CharacterMarriage), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'TradeRouteEstablished'", conditional: fun(context:TradeRouteEstablished), callback:fun(context:TradeRouteEstablished), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitMergedAndDestroyed'", conditional: fun(context:UnitMergedAndDestroyed), callback:fun(context:UnitMergedAndDestroyed), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'DilemmaGenerationFailedEvent'", conditional: fun(context:DilemmaGenerationFailedEvent), callback:fun(context:DilemmaGenerationFailedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RitualCancelledEvent'", conditional: fun(context:RitualCancelledEvent), callback:fun(context:RitualCancelledEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'SlotRoundStart'", conditional: fun(context:SlotRoundStart), callback:fun(context:SlotRoundStart), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterBesiegesSettlement'", conditional: fun(context:CharacterBesiegesSettlement), callback:fun(context:CharacterBesiegesSettlement), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent'", conditional: fun(context:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent), callback:fun(context:HaveCharacterWithinRangeOfPositionMissionEvaluationResultEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GarrisonResidenceEvent'", conditional: fun(context:GarrisonResidenceEvent), callback:fun(context:GarrisonResidenceEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterBuildingCompleted'", conditional: fun(context:CharacterBuildingCompleted), callback:fun(context:CharacterBuildingCompleted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionCookedDish'", conditional: fun(context:FactionCookedDish), callback:fun(context:FactionCookedDish), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FactionBecomesLiberationVassal'", conditional: fun(context:FactionBecomesLiberationVassal), callback:fun(context:FactionBecomesLiberationVassal), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionSelected'", conditional: fun(context:RegionSelected), callback:fun(context:RegionSelected), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UnitEffectUnpurchased'", conditional: fun(context:UnitEffectUnpurchased), callback:fun(context:UnitEffectUnpurchased), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterAncillaryGained'", conditional: fun(context:CharacterAncillaryGained), callback:fun(context:CharacterAncillaryGained), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterCanLiberate'", conditional: fun(context:CharacterCanLiberate), callback:fun(context:CharacterCanLiberate), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'CharacterInfoPanelOpened'", conditional: fun(context:CharacterInfoPanelOpened), callback:fun(context:CharacterInfoPanelOpened), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'GarrisonAttackedEvent'", conditional: fun(context:GarrisonAttackedEvent), callback:fun(context:GarrisonAttackedEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'PositiveDiplomaticEvent'", conditional: fun(context:PositiveDiplomaticEvent), callback:fun(context:PositiveDiplomaticEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ForeignSlotBuildingCompleteEvent'", conditional: fun(context:ForeignSlotBuildingCompleteEvent), callback:fun(context:ForeignSlotBuildingCompleteEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'FirstTickAfterNewCampaignStarted'", conditional: fun(context:FirstTickAfterNewCampaignStarted), callback:fun(context:FirstTickAfterNewCampaignStarted), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'BuildingConstructionIssuedByPlayer'", conditional: fun(context:BuildingConstructionIssuedByPlayer), callback:fun(context:BuildingConstructionIssuedByPlayer), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ImprisonmenRejectiontEvent'", conditional: fun(context:ImprisonmenRejectiontEvent), callback:fun(context:ImprisonmenRejectiontEvent), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'RegionTurnEnd'", conditional: fun(context:RegionTurnEnd), callback:fun(context:RegionTurnEnd), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'MissionFailed'", conditional: fun(context:MissionFailed), callback:fun(context:MissionFailed), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'UniqueAgentSpawned'", conditional: fun(context:UniqueAgentSpawned), callback:fun(context:UniqueAgentSpawned), persistent:boolean)
---@field add_listener fun(self:Core, key:string, event: "'ClanBecomesVassal'", conditional: fun(context:ClanBecomesVassal), callback:fun(context:ClanBecomesVassal), persistent:boolean)
core = {}
