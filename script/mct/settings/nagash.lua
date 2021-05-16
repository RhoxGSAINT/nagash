-- temporary dev settings to change the start positions and shit

local mct = get_mct()

local mct_mod = mct:register_mod("nagash_dev")
mct_mod:set_title("Nagash Dev")
mct_mod:set_description("Bloopity blep")
mct_mod:set_author("Made By Nagash")

local start = mct_mod:add_new_option("start_choice", "dropdown")
start:add_dropdown_value("intro", "Regular Intro", "Set Nagash to start in Nagashizar as regular")
start:add_dropdown_value("bp", "Black Pyramid", "Set Nagash to start in the Black Pyramid with Arkhan")
start:add_dropdown_value("domination", "World Domination!", "Give Nagash every single region except for the BP.")

start:set_default_value("bp")

local morts = mct_mod:add_new_option("morts", "checkbox")
morts:set_text("Mortarchs Start")
morts:set_tooltip_text("Enables all the Mortarchs to start spawned with Nagash, in whichever start chosen above.")
morts:set_default_value(true)