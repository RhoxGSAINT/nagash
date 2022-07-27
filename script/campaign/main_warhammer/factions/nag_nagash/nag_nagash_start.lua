local cam_start_x = 391.7;
local cam_start_y = 316.4;
local cam_start_d = 10;
local cam_start_b = 0;
local cam_start_h = 20;
---------------------------------------------------------------
--	First-Tick callbacks
---------------------------------------------------------------

cm:add_first_tick_callback_sp_new(
	function() 
		-- put faction-specific calls that should only gets triggered in a new singleplayer game here
	end
)


cm:add_first_tick_callback_mp_new(
	function() 
		-- put faction-specific calls that should only gets triggered in a new multiplayer game here
		core:progress_on_loading_screen_dismissed(
			function() 
				local faction = cm:get_local_faction(true)			
				local faction_capital = faction:home_region():settlement()
				
				cam_start_x = faction_capital:display_position_x()
				cam_start_y = faction_capital:display_position_y()
				
				-- This will set the camera at faction capital, you'll want to change this for horde factions.	
				cm:set_camera_position(cam_start_x, cam_start_y, cam_start_d, cam_start_b, cam_start_h)
			end
		)
	end
)

-------------------------------------------------------
--	USELESS CRAP
-- 	we'll keep it there anyway, because otherwise it'll say that there's a script break
-------------------------------------------------------
function start_game_for_faction(should_show_cutscene)
	out("start_game_for_faction() called");
end;

-------------------------------------------------------
--	This gets called only once - at the start of a 
--	new game. Initialise new game stuff for this 
--	faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
	out("faction_new_sp_game_startup() called");
    		-- instantly trigger the intro QB
end


function faction_new_mp_game_startup()
	out("faction_new_mp_game_startup() called");
end;

-------------------------------------------------------
--	This gets called any time the game loads in,
--	singleplayer including from a save game and 
--	from a campaign battle. Put stuff that needs
--	re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
	out("faction_each_sp_game_startup() called");
end;

function faction_each_mp_game_startup()
	out("faction_each_mp_game_startup() called");
end;