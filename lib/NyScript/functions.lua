GetOn = function(on) if on then return "on" else return "off" end end
InSession = function() return util.is_session_started() and not util.is_session_transition_active() end
GetPathVal = function(path) return menu.get_value(menu.ref_by_path(path)) end
SetPathVal = function(path,state) local path_ref = menu.ref_by_path(path) if menu.is_ref_valid(path_ref) then menu.set_value(path_ref,state) end end
ClickPath = function(path) local path_ref = menu.ref_by_path(path) if menu.is_ref_valid(path_ref) then menu.trigger_command(path_ref) end end
Notify = function(str) if notifications_enabled or update_available then if notifications_mode == 2 then util.show_corner_help("~p~test2~s~~n~"..str ) else util.toast("[= test2 =]"..str) end end end


--weapon function (from lance)
local all_weapons = {}
local temp_weapons = util.get_weapons()
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function weapon_from_hash(hash)
    for k, v in pairs(all_weapons) do
        if v.hash == hash then
            return util.get_label_text(v.label_key)
        end
    end
    return 'Unarmed'
end

function SaveCommands(list)
    local l = {}
    for _,path in pairs(list) do
        l[path.."_command"] = menu.ref_by_path(path)
    end
    return l
end

function SaveProtex(list)
    local l = {}
    for name,_ in pairs(list) do
        l[name] = {}
        for i,path in pairs(_) do
            l[name][path..">Block_command"] = menu.ref_by_path(path..">Block")
        end
    end
    return l
end

function BitTest(bits, place)
    return (bits & (1 << place)) ~= 0
end
function IsPlayerUsingOrbitalCannon(player)
    return BitTest(memory.read_int(memory.script_global((2657589 + (player * 466 + 1) + 427))), 0) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_427), 0
end
function get_spawn_state(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
end

function get_interior_player_is_in(pid)
    return memory.read_int(memory.script_global(((2657589 + 1) + (pid * 466)) + 245)) -- Global_2657589[bVar0 /*466*/].f_245
end

function build_vehicles_list ()
	for _, anti_vehicle_menu in pairs(anti_vehicle_menus) do
		if anti_vehicle_menu:isValid() then
			menu.delete(anti_vehicle_menu)
		end
	end
	
	menus.anti_menu = {}
	for hash, model in anti_vehicles_list do
		menus.anti_menu = menus.vehlist:list(model)
		menus.anti_delete = menus.anti_menu:action('supprimer', {}, "", function()
			anti_vehicles_list[hash] = nil
			build_vehicles_list()
		end)
		table.insert(anti_vehicle_menus, menus.anti_menu)
	end
end

function get_entity_owner(entity)
	local pEntity = entities.handle_to_pointer(entity)
	local addr = memory.read_long(pEntity + 0xD0)
	return (addr ~= 0) and memory.read_byte(addr + 0x49) or -1
end

--------------------------
-- TIMER
--------------------------

---@class Timer
---@field elapsed fun(): integer
---@field reset fun()
---@field isEnabled fun(): boolean
---@field disable fun()

---@return Timer
function newTimer()
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
function request_control_once(entity)
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
function request_control(entity, timeOut)
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