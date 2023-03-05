core:add_ui_created_callback(
	function(context)
		if vfs.exists("script/frontend/mod/mixer_frontend.lua")then
			
            mixer_enable_custom_faction("807711235")

            mixer_add_starting_unit_list_for_faction("mixer_nag_nagash", {"wh2_dlc09_tmb_inf_nehekhara_warriors_0","wh2_dlc09_tmb_inf_skeleton_spearmen_0","wh2_dlc09_tmb_inf_skeleton_spearmen_0","wh2_dlc09_tmb_inf_skeleton_archers_0",})
            
            mixer_change_lord_name("807711235", "nag_nagash_husk")
            
            mixer_add_faction_to_major_faction_list("mixer_nag_nagash")
		end		
	end
)


