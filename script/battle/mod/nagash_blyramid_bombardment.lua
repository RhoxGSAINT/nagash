--Script by prop joe, modified by Belisarian
local data = {}

local last_kill = nil
local current_behemoth = nil
local spawn_blyramid = 0;
local blyramid_anchor_coords = nil;

bm = battle_manager:new(empire_battle:new());
-- local gc = generated_cutscene:new(true);

gb = generated_battle:new(
	false,                                      		-- screen starts black
	false,                                     		-- prevent deployment for player
	false,                                      	-- prevent deployment for ai
	nil, -- intro cutscene function
	false                                      		-- debug mode
);




local function update()
	local ui_root = core:get_ui_root()
	--
	local event_icon = find_uicomponent(ui_root, "layout", "radar_holder", "radar_group", "adc_frame", "event_icon")
	if event_icon then
		local label = find_uicomponent(event_icon, "label")
		if label then
			if string.find(label:GetStateText(), "wiped out") then
				UIComponent(label:Parent()):SetVisible(false)
			end
		end
	end

	if last_kill and os.clock() - last_kill < 5 then
		local adc_ping = find_uicomponent(ui_root, "layout", "ping_parent", "adc_ping")
		if adc_ping then
			local adc_icon = find_uicomponent(adc_ping, "adc_icon")
			local arrow = find_uicomponent(adc_ping, "arrow")
			if adc_icon and arrow then
				if string.find(adc_icon:GetTooltipText(), "wiped out") then
					UIComponent(adc_icon:Parent()):SetVisible(false)
					adc_icon:SetVisible(false)
					adc_ping:SetVisible(false)
					arrow:SetVisible(false)
				end
			end
		end
	end

	local summoned = nil

	local pos
	local b
	local w

	local current_battle_time = bm:time_elapsed_ms()

	local alliance_armies = bm:alliances():item(bm:get_player_alliance_num()):armies()

	for j=1, alliance_armies:count() do
		local army = alliance_armies:item(j)
		local player_units = army:units();

		for i = 1, player_units:count() do
			local current_unit = player_units:item(i);
			if current_unit then
				local type_key = current_unit:type();
				local su = script_unit:new(army, i)

				if (type_key == "nag_nagash_husk" or type_key == "nag_nagash_revenant" or type_key == "nag_nagash_boss") and spawn_blyramid < 1 and gb:has_battle_started() then
					-- current_unit:position();
					blyramid_anchor_coords = current_unit:position();
					army:use_special_ability("nag_blyramid_itself", blyramid_anchor_coords, d_to_r(0))
					spawn_blyramid = 1
				end

				if type_key == "nag_bombardment_targeting" then
					summoned = su
					summoned:cache_location()
					pos = summoned:get_cached_position()
					b = summoned:get_cached_bearing()
					w = summoned:get_cached_width()
					-- blyramid_anchor_coords
					-- pos
					-- math.atan2(targetY-gunY, targetX-gunX)
					y = pos:get_z()-(blyramid_anchor_coords:get_z() + 1400)
					x = pos:get_x()-(blyramid_anchor_coords:get_x() + 1400)
					original_x = pos:get_x()
					original_z = pos:get_z()
					angle_radians = math.atan2(y, x)
					angle_degrees = math.deg(angle_radians)
					-- math.atan2 (y, x)
					-- army:use_special_ability("nag_army_abilities_blyramid_bombardment", summoned:get_cached_position(), b)
					-- army:use_special_ability("nag_army_abilities_blyramid_bombardment", summoned:get_cached_position(), d_to_r(45))
					army:use_special_ability("nag_army_abilities_blyramid_bombardment_00", summoned:get_cached_position(), angle_radians)
					
					y_generated = battle:get_terrain_height(original_x + 10, original_z - 10)
					army:use_special_ability("nag_army_abilities_blyramid_bombardment_01", v(original_x + 10, y_generated, original_z - 10), angle_radians)
					
					y_generated = battle:get_terrain_height(original_x - 10, original_z + 10)
					army:use_special_ability("nag_army_abilities_blyramid_bombardment_02", v(original_x - 10, y_generated, original_z + 10), angle_radians)
					
					y_generated = battle:get_terrain_height(original_x + 10, original_z + 10)
					army:use_special_ability("nag_army_abilities_blyramid_bombardment_03", v(original_x + 10, y_generated, original_z + 10), angle_radians)
					
					y_generated = battle:get_terrain_height(original_x - 10, original_z - 10)
					army:use_special_ability("nag_army_abilities_blyramid_bombardment_04", v(original_x - 10, y_generated, original_z - 10), angle_radians)
					
					
					-- gb:add_ping_icon_on_message("test", summoned:get_cached_position(), 16, 1000, 8000)
					-- gb.sm:trigger_message("test")
					summoned:set_enabled(false)
					summoned:kill(true)

					last_kill = os.clock()
					

				end
			end
		end
	end
end


core:remove_listener("belisarian_nagash_blyramid_scan_listener_cb")
core:add_listener(
	"belisarian_nagash_blyramid_scan_listener_cb",
	"RealTimeTrigger",
	function(context)
		return context.string == "belisarian_nagash_blyramid_scan_listener"
	end,
	function(context)
		update()
		real_timer.register_singleshot("belisarian_nagash_blyramid_scan_listener", 50)
	end,
	true
)

bm:remove_process("belisarian_nagash_blyramid_scan_cycle")
bm:callback(function()
	update()
	real_timer.register_singleshot("belisarian_nagash_blyramid_scan_listener", 50)
end, 1000, "belisarian_nagash_blyramid_scan_cycle")

