--[[non utilisé]]--GetOn = function(on) if on then return "on" else return "off" end end
--[[non utilisé]]--InSession = function() return util.is_session_started() and not util.is_session_transition_active() end
--[[non utilisé]]--GetPathVal = function(path) return menu.get_value(menu.ref_by_path(path)) end
SetPathVal = function(path,state) local path_ref = menu.ref_by_path(path) if menu.is_ref_valid(path_ref) then menu.set_value(path_ref,state) end end
--[[non utilisé]]--ClickPath = function(path) local path_ref = menu.ref_by_path(path) if menu.is_ref_valid(path_ref) then menu.trigger_command(path_ref) end end
--[[non utilisé]]--Notify = function(str) if notifications_enabled or update_available then if notifications_mode == 2 then util.show_corner_help("~p~NyScript~s~~n~"..str ) else util.toast("[= NyScript =]"..str) end end end


local self = {}
---@alias HudColour integer
HudColour =
{
	pureWhite = 0,
	white = 1,
	black = 2,
	grey = 3,
	greyLight = 4,
	greyDrak = 5,
	red = 6,
	redLight = 7,
	redDark = 8,
	blue = 9,
	blueLight = 10,
	blueDark = 11,
	yellow = 12,
	yellowLight = 13,
	yellowDark = 14,
	orange = 15,
	orangeLight = 16,
	orangeDark = 17,
	green = 18,
	greenLight = 19,
	greenDark = 20,
	purple = 21,
	purpleLight = 22,
	purpleDark = 23,
	radarHealth = 25,
	radarArmour = 26,
	friendly = 118,
}
--[[
	~r~ rouge
	~b~ bleu
	--~x~ bleu clair
	~g~ vert
	--~t~ vert clair
	~y~ jaune
	~p~ purple
	~q~ pink
	~o~ orange
	~c~ gris
	~m~ gris foncé
	~u~ noir
	~w~ white
	~s~ default white
	~n~ new line
	~h~ gras
	~italic~ italic
	¦ Rockstar Verified Icon
	÷ Rockstar Icon
	∑ = Rockstar Icon 2
]]
--------------------------
-- NOTIFICATION
--------------------------
local sound_notif = {}
util.create_tick_handler(function()
	::start::
	for key, value in pairs(sound_notif) do
		if value + 120 < util.current_unix_time_seconds() then
			sound_notif.key = nil
		end
	end
	util.yield(120000)
	goto start
end)
---@class Notification
notification = {
	txdDict = "DIA_ZOMBIE1",
	txdName = "DIA_ZOMBIE1",
	title = "NyScript",
	subtitle = "~c~" .. util.get_label_text("PM_PANE_FEE") .. "~s~",
	defaultColour = HudColour.black
}

---@param msg string
function notification.stand(msg, ...)
	assert(type(msg) == "string", "msg must be a string, got " .. type(msg))
	msg = string.format(msg, ...)
	msg = msg:gsub('~[%w_]-~', ""):gsub('<C>(.-)</C>', '%1')
	util.toast("[NyScript] " .. msg)
	local time
	local current_time = util.current_unix_time_seconds()
	if sound_notif[msg] then
		time = sound_notif[msg] + 60
	else
		time = 0
	end
	if time < current_time then
		sound_notif[msg] = current_time
		AUDIO.PLAY_SOUND(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", false, 0, false)
	end
end

---@param msg string
function notification.draw_debug_text(msg, ...)
	assert(type(msg) == "string", "msg must be a string, got " .. type(msg))
	msg = string.format(msg, ...)
	msg = msg:gsub('~[%w_]-~', ""):gsub('<C>(.-)</C>', '%1')
	util.draw_debug_text(msg)
end

---@param format string
---@param colour? HudColour
function notification:help(format, colour, ...)
	assert(type(format) == "string", "msg must be a string, got " .. type(format))

	local msg = string.format(format, ...)
	--if Config.general.standnotifications then
	--	return self.stand(msg)
	--end

	HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(colour or self.defaultColour)
	util.BEGIN_TEXT_COMMAND_THEFEED_POST("~BLIP_INFO_ICON~ " .. msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER_WITH_TOKENS(true, true)
end


---@param format string
---@param colour? HudColour
function notification:normal(format, colour, ...)
	assert(type(format) == "string", "msg must be a string, got " .. type(format))

	local msg = string.format(format, ...)
	--if Config.general.standnotifications then
	--	return self.stand(msg)
	--end

	HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(colour or self.defaultColour)
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(self.txdDict, self.txdName, true, 4, self.title, self.subtitle)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
end
--------------------------
-- FIN NOTIFICATION
--------------------------
local orgLog = util.log

---@param format string
---@param ... any
util.log = function (format, ...)
	local strg = type(format) ~= "string" and tostring(format) or format:format(...)
	orgLog("[NyScript] " .. strg)
end

function draw_debug_text(...)
	local arg = {...}
	local strg = ""
	for _, w in ipairs(arg) do
		strg = strg .. tostring(w) .. '\n'
	end
	local colour = {r = 1.0, g = 0.0, b = 0.0, a = 1.0}
	directx.draw_text(0.05, 0.05, strg, ALIGN_TOP_LEFT, 1.0, colour, false)
end

---Credits to aaron
---@param textureDict string
function request_streamed_texture_dict(textureDict)
	util.spoof_script("main_persistent", function()
		GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(textureDict, false)
	end)
end

--------------------------
-- FIN AFFICHAGE
--------------------------

--weapon function (from lance)
local all_weapons = {}
local temp_weapons = util.get_weapons()
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function Weapon_from_hash(hash)
    for k, v in pairs(all_weapons) do
        if v.hash == hash then
            return util.get_label_text(v.label_key)
        end
    end
    return 'Unarmed'
end
local all_vehicles = {}
local temp_vehicles = util.get_vehicles()
for a,b in pairs(temp_weapons) do
    all_vehicles[#all_vehicles + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function Vehicle_from_hash(hash)
    for k, v in pairs(all_vehicles) do
        if v.hash == hash then
            return util.get_label_text(v.label_key)
        end
    end
    return 'none'
end

local function BitTest(bits, place)
    return (bits & (1 << place)) ~= 0
end
function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end

function Get_spawn_state(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
end

function Get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245
end

local anti_vehicle_menus  = {}
function Build_vehicles_list ()
	for _, anti_vehicle_menu in pairs(anti_vehicle_menus) do
		if anti_vehicle_menu:isValid() then
			menu.delete(anti_vehicle_menu)
		end
	end

	Menus.anti_menu = {}
	for hash, model in Anti_vehicles_list do
		Menus.anti_menu = Menus.vehlist:list(model)
		Menus.anti_delete = Menus.anti_menu:action(Translations.protection_anti_vehicles_list_delete, {}, Translations.protection_anti_vehicles_list_delete_desc, function()
			Anti_vehicles_list[hash] = nil
			Build_vehicles_list()
		end)
		table.insert(anti_vehicle_menus, Menus.anti_menu)
	end
end

--[[non utilisé
function Get_entity_owner(entity)
	local pEntity = entities.handle_to_pointer(entity)
	local addr = memory.read_long(pEntity + 0xD0)
	return (addr ~= 0) and memory.read_byte(addr + 0x49) or -1
end
]]

--------------------------
-- REQUEST CONTROL
--------------------------
--non utilisé
	--timer
	---@class Timer
	---@field elapsed fun(): integer
	---@field reset fun()
	---@field isEnabled fun(): boolean
	---@field disable fun()

	---@return Timer
	local function newTimer()
		local self = {
			start = util.current_time_millis(),
			m_enabled = false,
		}

		local function reset()
			self.start = util.current_time_millis()
			self.m_enabled = true
		end

		local function elapsed()
			return util.current_time_millis() - self.start
		end

		local function disable() self.m_enabled = false end
		local function isEnabled() return self.m_enabled end

		return
		{
			isEnabled = isEnabled,
			reset = reset,
			elapsed = elapsed,
			disable = disable,
		}
	end


	---@param entity Entity
	---@return boolean
	local function request_control_once(entity)
		if not NETWORK.NETWORK_IS_IN_SESSION() then
			return true
		end
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
		return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	end


	---@param entity Entity
	---@param timeOut? integer #time in `ms` trying to get control
	---@return boolean
	function Request_control(entity, timeOut)
		if not ENTITY.DOES_ENTITY_EXIST(entity) then
			return false
		end
		timeOut = timeOut or 500
		local start = newTimer()
		while not request_control_once(entity) and start.elapsed() < timeOut do
			util.yield_once()
		end
		return start.elapsed() < timeOut
	end
--------------------------
-- FIN REQUEST CONTROL
--------------------------