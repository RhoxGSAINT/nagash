local function rhox_nagash_victory_conditions()
	if cm:is_new_game() and cm:get_campaign_name() == "main_warhammer" then

		if cm:get_faction("mixer_nag_nagash"):is_human() then

			local mission = {[[
				 mission
				{
					victory_type wh_main_victory_type_short;
					key wh_main_short_victory;
					issuer CLAN_ELDERS;
					primary_objectives_and_payload
					{
						objective
                        {
                            override_text rhox_nagash_short_victory_text;
                            type SCRIPTED;
                            script_key nagash_bp_complete;	
                        }
						payload
						{
							text_display dummy_rhox_nagash_boss_appear;
							game_victory;
						}
					}
				}
			]],
			[[
				mission
			   {
				   victory_type wh_main_victory_type_long;
				   key wh_main_long_victory;
				   issuer CLAN_ELDERS;
				   primary_objectives_and_payload
				   {
                        objective
                        {
                            override_text rhox_nagash_long_victory_text;
                            type SCRIPTED;
                            script_key nagash_final_ritual_complete;	
                        }
					   payload
					   {
                           text_display dummy_rhox_nagash_end_of_world;
						   game_victory;
					   }
				   }
			   }
		   ]]
		}

			cm:trigger_custom_mission_from_string("mixer_nag_nagash", mission[1]);
			cm:trigger_custom_mission_from_string("mixer_nag_nagash", mission[2]);

		end
	end
end

cm:add_first_tick_callback(function() rhox_nagash_victory_conditions() end)
