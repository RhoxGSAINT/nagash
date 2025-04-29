core:add_ui_created_callback(
	function(context)
	
        if common.get_context_value("CcoOwnershipProductRecord", "TW_WH2_DLC11_VAMPIRE_COAST", "IsOwned") and common.get_context_value("CcoOwnershipProductRecord", "TW_WH2_TOMB_KINGS", "IsOwned") and common.get_context_value("CcoOwnershipProductRecord", "TW_WH1_LORDS_AND_UNITS_1", "IsOwned") then
            if vfs.exists("script/frontend/mod/mixer_frontend.lua")then
                mixer_enable_custom_faction("807711235")
                mixer_change_lord_name("807711235", "nag_nagash_husk")
                ----------TOW
                mixer_enable_custom_faction("541325225")
                mixer_change_lord_name("541325225", "nag_nagash_husk")

                mixer_add_starting_unit_list_for_faction("mixer_nag_nagash", {"nag_bone_golems","nag_nagashi_guard","nag_skeleton_reaper", "nag_vanilla_vmp_mon_fell_bats","nag_vanilla_tmb_inf_skeleton_warriors_0","nag_vanilla_tmb_inf_skeleton_spearmen_0", "nag_bone_thrower"})
                
                
                mixer_add_faction_to_major_faction_list("mixer_nag_nagash")
            end		
        
        else
            core:add_listener(
                "rhox_nagash_hide_the_UI",
                "ComponentLClickUp",
                function (context)
                    return context.string == "button_select_race"
                end,
                function (context)
                    --out("Rhox Test: button clicked: ".. context.string)
                    local parent = find_uicomponent(core:get_ui_root(), "popup_menu", "culture_list");
                    if not parent then
                        out("Rhox Nagash: Parent wasn't there")
                        return
                    end
                    
                
                    local culture_to_kill = find_uicomponent(parent, "CcoCultureRecordmixer_nag_nagash");
                    
                    if not culture_to_kill then
                        out("Rhox Nagash: There wasn't subculture to kill")
                    end
                    if culture_to_kill then
                        out("Rhox Nagash: Killing UI")
                        culture_to_kill:SetVisible(false)
                    end
                end,
                true)
		end
	
		
	end
)
