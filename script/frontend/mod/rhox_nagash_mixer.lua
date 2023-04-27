core:add_ui_created_callback(
	function(context)
		if vfs.exists("script/frontend/mod/mixer_frontend.lua")then
			
            mixer_enable_custom_faction("807711235")

            mixer_add_starting_unit_list_for_faction("mixer_nag_nagash", {"nag_bone_golems","nag_nagashi_guard","nag_skeleton_reaper", "nag_vanilla_vmp_mon_fell_bats","nag_vanilla_tmb_inf_skeleton_warriors_0","nag_vanilla_tmb_inf_skeleton_spearmen_0", "nag_bone_thrower"})
            
            mixer_change_lord_name("807711235", "nag_nagash_husk")
            
            mixer_add_faction_to_major_faction_list("mixer_nag_nagash")
		end		
	end
)


