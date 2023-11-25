core:add_ui_created_callback(
    function(context)
        if vfs.exists("script/frontend/mod/mixer_frontend.lua")then
        
            mixer_change_lord_name("2001848346", "nag_lahmia_neferata")
    
            mixer_add_starting_unit_list_for_faction("wh3_main_vmp_lahmian_sisterhood", {"wh_main_vmp_veh_black_coach","wh_main_vmp_cav_black_knights_3","wh_main_vmp_inf_zombie", "wh_main_vmp_inf_skeleton_warriors_0","wh_main_vmp_mon_dire_wolves"})
            mixer_add_faction_to_major_faction_list("wh3_main_vmp_lahmian_sisterhood")    

            if vfs.exists("script/frontend/mod/cr_oldworld_campaign_frontend.lua") then 
                mixer_change_lord_name("914461306", "nag_lahmia_neferata")
            end
        end        
    end
)

