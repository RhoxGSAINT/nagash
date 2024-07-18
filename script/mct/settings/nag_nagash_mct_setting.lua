if not get_mct then return end
local mct = get_mct()
local mct_mod = mct:register_mod("nag_nagash")
mct_mod:set_title("mct_nag_nagsh_title", true)
mct_mod:set_author("Team Nagash")
mct_mod:set_description("mct_nag_nagsh_description", true)

local enable_ai_nagash = mct_mod:add_new_option("enable_ai_nagash", "checkbox")
enable_ai_nagash:set_default_value(true)
enable_ai_nagash:set_text("mct_nag_nagsh_enable_ai_nagash_text", true)
enable_ai_nagash:set_tooltip_text("mct_nag_nagsh_enable_ai_nagash_tooltip", true)



local nag_ai_bonus = mct_mod:add_new_option("nag_ai_bonus", "slider")
nag_ai_bonus:slider_set_min_max(0, 100)
nag_ai_bonus:slider_set_step_size(1)
nag_ai_bonus:set_default_value(1)
nag_ai_bonus:set_text("mct_nag_nagsh_nag_ai_bonus_text", true)
nag_ai_bonus:set_tooltip_text("mct_nag_nagsh_nag_ai_bonus_tooltip", true)

local nag_ai_level_bonus = mct_mod:add_new_option("nag_ai_level_bonus", "slider")
nag_ai_level_bonus:slider_set_min_max(1, 50)
nag_ai_level_bonus:slider_set_step_size(1)
nag_ai_level_bonus:set_default_value(30)
nag_ai_level_bonus:set_text("mct_nag_nagsh_nag_ai_level_bonus_text", true)
nag_ai_level_bonus:set_tooltip_text("mct_nag_nagsh_nag_ai_level_bonus_tooltip", true)

local nag_ai_building_tier = mct_mod:add_new_option("nag_ai_building_tier", "slider")
nag_ai_building_tier:slider_set_min_max(1, 5)
nag_ai_building_tier:slider_set_step_size(1)
nag_ai_building_tier:set_default_value(5)
nag_ai_building_tier:set_text("mct_nag_nagsh_nag_ai_building_tier_text", true)
nag_ai_building_tier:set_tooltip_text("mct_nag_nagsh_nag_ai_building_tier_tooltip", true)


local nag_block_ai_research = mct_mod:add_new_option("nag_block_ai_research", "slider")
nag_block_ai_research:slider_set_min_max(1, 100)
nag_block_ai_research:slider_set_step_size(1)
nag_block_ai_research:set_default_value(15)
nag_block_ai_research:set_text("mct_nag_nagash_block_ai_research_text", true)
nag_block_ai_research:set_tooltip_text("mct_nag_nagash_block_ai_research_tooltip", true)




local nag_mortarch_arkhan = mct_mod:add_new_option("nag_mortarch_arkhan", "slider")
nag_mortarch_arkhan:slider_set_min_max(0, 200)
nag_mortarch_arkhan:slider_set_step_size(1)
nag_mortarch_arkhan:set_default_value(100)
nag_mortarch_arkhan:set_text("mct_nag_nagsh_nag_mortarch_arkhan_text", true)
nag_mortarch_arkhan:set_tooltip_text("mct_nag_nagsh_nag_mortarch_arkhan_tooltip", true)



local nag_mortarch_vlad = mct_mod:add_new_option("nag_mortarch_vlad", "slider")
nag_mortarch_vlad:slider_set_min_max(0, 100)
nag_mortarch_vlad:slider_set_step_size(1)
nag_mortarch_vlad:set_default_value(35)
nag_mortarch_vlad:set_text("mct_nag_nagsh_nag_mortarch_vlad_text", true)
nag_mortarch_vlad:set_tooltip_text("mct_nag_nagsh_nag_mortarch_vlad_tooltip", true)

local nag_mortarch_mannfred = mct_mod:add_new_option("nag_mortarch_mannfred", "slider")
nag_mortarch_mannfred:slider_set_min_max(0, 100)
nag_mortarch_mannfred:slider_set_step_size(1)
nag_mortarch_mannfred:set_default_value(35)
nag_mortarch_mannfred:set_text("mct_nag_nagsh_nag_mortarch_mannfred_text", true)
nag_mortarch_mannfred:set_tooltip_text("mct_nag_nagsh_nag_mortarch_mannfred_tooltip", true)

local nag_mortarch_luthor = mct_mod:add_new_option("nag_mortarch_luthor", "slider")
nag_mortarch_luthor:slider_set_min_max(0, 100)
nag_mortarch_luthor:slider_set_step_size(1)
nag_mortarch_luthor:set_default_value(35)
nag_mortarch_luthor:set_text("mct_nag_nagsh_nag_mortarch_luthor_text", true)
nag_mortarch_luthor:set_tooltip_text("mct_nag_nagsh_nag_mortarch_luthor_tooltip", true)

local nag_mortarch_dieter = mct_mod:add_new_option("nag_mortarch_neferata", "slider")
nag_mortarch_dieter:slider_set_min_max(0, 100)
nag_mortarch_dieter:slider_set_step_size(1)
nag_mortarch_dieter:set_default_value(35)
nag_mortarch_dieter:set_text("mct_nag_nagsh_nag_mortarch_neferata_text", true)
nag_mortarch_dieter:set_tooltip_text("mct_nag_nagsh_nag_mortarch_neferata_tooltip", true)


local nag_mortarch_dieter = mct_mod:add_new_option("nag_mortarch_dieter", "slider")
nag_mortarch_dieter:slider_set_min_max(0, 100)
nag_mortarch_dieter:slider_set_step_size(1)
nag_mortarch_dieter:set_default_value(35)
nag_mortarch_dieter:set_text("mct_nag_nagsh_nag_mortarch_dieter_text", true)
nag_mortarch_dieter:set_tooltip_text("mct_nag_nagsh_nag_mortarch_dieter_tooltip", true)


local nag_mortarch_dk = mct_mod:add_new_option("nag_mortarch_dk", "slider")
nag_mortarch_dk:slider_set_min_max(0, 100)
nag_mortarch_dk:slider_set_step_size(1)
nag_mortarch_dk:set_default_value(35)
nag_mortarch_dk:set_text("mct_nag_nagsh_nag_mortarch_dk_text", true)
nag_mortarch_dk:set_tooltip_text("mct_nag_nagsh_nag_mortarch_dk_tooltip", true)

local nag_mortarch_kalledria = mct_mod:add_new_option("nag_mortarch_kalledria", "slider")
nag_mortarch_kalledria:slider_set_min_max(0, 100)
nag_mortarch_kalledria:slider_set_step_size(1)
nag_mortarch_kalledria:set_default_value(35)
nag_mortarch_kalledria:set_text("mct_nag_nagsh_nag_mortarch_kalledria_text", true)
nag_mortarch_kalledria:set_tooltip_text("mct_nag_nagsh_nag_mortarch_kalledria_text", true)



