core:add_ui_created_callback(
    function(context)
        if vfs.exists("script/frontend/mod/mixer_frontend.lua")then
    
            if common.get_context_value("CcoOwnershipProductRecord", "TW_WH1_BASE_GAME", "IsOwned") == false then
                mixer_add_dlc_requirement_to_faction("mixer_vmp_wailing_conclave", "TW_WH1_BASE_GAME")
            elseif common.get_context_value("CcoOwnershipProductRecord", "TW_WH3_SHADOWS_OF_CHANGE", "IsOwned") == false and common.get_context_value("CcoOwnershipProductRecord", "TW_WH3_SHADOWS_OF_CHANGE_KSL", "IsOwned") == false then
                mixer_add_dlc_requirement_to_faction("mixer_vmp_wailing_conclave", "TW_WH3_SHADOWS_OF_CHANGE")
            end   
            mixer_enable_custom_faction("1568726704")
            mixer_add_starting_unit_list_for_faction("mixer_vmp_wailing_conclave", {"wh2_dlc11_cst_inf_syreens","wh_main_vmp_inf_crypt_ghouls","wh_main_vmp_cav_hexwraiths", "wh_main_vmp_inf_cairn_wraiths"})
            
            mixer_change_lord_name("1568726704", "nag_vmp_kalledria")
            
            mixer_add_faction_to_major_faction_list("mixer_vmp_wailing_conclave")
            
        end        
    end
)