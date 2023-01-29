util.keep_running()--ceci fait que le script ne s'arrête pas après avoir fait son travail
local scriptStartTime = util.current_time_millis()
local version = "0.1"

---
--- Auto-Updater Lib Install
---

-- Auto Updater from https://github.com/hexarobi/stand-lua-auto-updater
local status, auto_updater = pcall(require, "auto-updater")
if not status then
    local auto_update_complete = nil util.toast("Installing auto-updater...", TOAST_ALL)
    async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
            function(result, headers, status_code)
                local function parse_auto_update_result(result, headers, status_code)
                    local error_prefix = "Error downloading auto-updater: "
                    if status_code ~= 200 then util.toast(error_prefix..status_code, TOAST_ALL) return false end
                    if not result or result == "" then util.toast(error_prefix.."Found empty file.", TOAST_ALL) return false end
                    filesystem.mkdir(filesystem.scripts_dir() .. "lib")
                    local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
                    if file == nil then util.toast(error_prefix.."Could not open file for writing.", TOAST_ALL) return false end
                    file:write(result) file:close() util.toast("Successfully installed auto-updater lib", TOAST_ALL) return true
                end
                auto_update_complete = parse_auto_update_result(result, headers, status_code)
            end, function() util.toast("Error downloading auto-updater lib. Update failed to download.", TOAST_ALL) end)
    async_http.dispatch() local i = 1 while (auto_update_complete == nil and i < 40) do util.yield(250) i = i + 1 end
    if auto_update_complete == nil then error("Error downloading auto-updater lib. HTTP Request timeout") end
    auto_updater = require("auto-updater")
end
if auto_updater == true then error("Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again") end

---
--- Config
---

local languages = {
    'french',
    'english',
}

---
--- Auto-Update
---

local auto_update_config = {
    source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/NyScript.lua",
    script_relpath=SCRIPT_RELPATH,
    silent_updates=true,
    dependencies={
        {
            name="functions",
            source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/lib/NyScript/functions.lua",
            script_relpath="lib/NyScript/functions.lua",
        },
        {
            name="weapons",
            source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/lib/NyScript/weapons.lua",
            script_relpath="lib/NyScript/weapons.lua",
        },
        {
            name="vehicles",
            source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/lib/NyScript/vehicles.lua",
            script_relpath="lib/NyScript/vehicles.lua",
        },
    }
}

for _, language in pairs(languages) do
    local language_config = {
        name=language,
        source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/lib/NyScript/Languages/"..language..".lua",
        script_relpath="lib/NyScript/Languages/"..language..".lua",
    }
    table.insert(auto_update_config.dependencies, language_config)
end

auto_updater.run_auto_update(auto_update_config)



local Json = require("json")
util.ensure_package_is_installed('lua/natives-1663599433')
util.require_natives(1663599433)

-----------------------
---FICHIER
----------------------
local required <const> = {
	"lib/natives-1663599433.lua",
	"lib/NyScript/functions.lua",
	"lib/NyScript/vehicles.lua",
	"lib/NyScript/weapons.lua",
}
local scriptdir <const> = filesystem.scripts_dir()
local libDir <const> = scriptdir .. "lib\\NyScript"
local languagesDir <const> = libDir .. "Languages"
local relative_languagesDir <const> = "./lib/NyScript/Languages/"

for _, file in ipairs(required) do
	assert(filesystem.exists(scriptdir .. file), "required file not found: " .. file)
end
require "NyScript.functions"
require "NyScript.vehicles"
require "NyScript.weapons"

if not filesystem.exists(libDir) then
	filesystem.mkdir(libDir)
end

if not filesystem.exists(languagesDir) then
	filesystem.mkdir(languagesDir)
end
-------------------------
---FIN FICHIER
-------------------------
--===============--
-- Local
--===============--
local notifications_enabled = true
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}
local Commands = menu.trigger_commands
---ANTI VEHICLES
menus = {}
anti_vehicle_menus  = {}
anti_vehicles_list = {}
local anti_vehicles_model
local anti_vehicles_option = {}
anti_vehicles_option["remove"] = false
anti_vehicles_option["notif"] = true
local anti_vehicles_file = scriptdir.."lib/NyScript/anti_vehicles.json"
if not filesystem.exists(anti_vehicles_file) then
    local filehandle = io.open(anti_vehicles_file, "w")
    if filehandle then
        filehandle:write(Json.encode(anti_vehicles_list))
        filehandle:close()
    end
else
    local filehandle = io.open(anti_vehicles_file, "r")
    if filehandle then
        anti_vehicles_list = Json.decode(filehandle:read())
        filehandle:close()
    end
end
---FIN ANTI VEHICLES

--===============--
-- Translation
--===============--

-- credit http://lua-users.org/wiki/StringRecipes
local function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

local translations = {}
setmetatable(translations, {
    __index = function (self, key)
        return key
    end
})

local languageDir_files = {}
local just_language_files = {}
for i, path in ipairs(filesystem.list_files(languagesDir)) do
    local file_str = path:gsub(languagesDir, '')
    languageDir_files[#languageDir_files + 1] = file_str
    if ends_with(file_str, '.lua') then
        just_language_files[#just_language_files + 1] = file_str
    end
end
local selected_lang_path = languagesDir .. 'selected_language.txt'
if not table.contains(languageDir_files, 'selected_language.txt') then
    local file = io.open(selected_lang_path, 'w')
    file:write('english.lua')
    file:close()
end

-- read selected language 

    local selected_lang_file = io.open(selected_lang_path, 'r')
    local selected_language = selected_lang_file:read()
    if not table.contains(languageDir_files, selected_language) then
        util.toast(selected_language .. ' was not found. Defaulting to English.')
        translations = require(relative_languagesDir .. "english")
    else
        translations = require(relative_languagesDir .. '\\' .. selected_language:gsub('.lua', ''))
    end

--===============--
-- Roots
--===============--

local main = menu.my_root()
local self = main:list("Self")
local detex = main:list("Detections")
local protex = main:list("Protections")
local anti_mugger = protex:list("Block Muggers")
local misc = main:list("Misc")
--local vehicle = main:list("Vehicle")
--local online = main:list("Online")
--local game = main:list("Game")
--local stand = main:list("Stand")

--===============--
-- Main
--===============--
    
    --local add_block_join_reaction = true
    local stand_edition = menu.get_edition()
    local lua_path = "Stand>Lua Scripts>"..string.gsub(string.gsub(SCRIPT_RELPATH,".lua",""),"\\",">")

    --===============--
    -- Self
    --===============--
        --lua_path..">".."Self"..">".."Auto Armor after Death",
        
        local self_list = {
            dieu = {
                "Self>Immortality",
                "Self>Auto Heal",
                "Self>Gracefulness",
                "Self>Glued To Seats",
                "Self>Lock Wanted Level",
                "Self>Infinite Stamina",
                --"Stand>Lua Scripts>AndyScript>Self>Clean Loop",
            },
        }
        local self_list_cmds = SaveCommands(self_list["dieu"])
        --Stand>Lua Scripts>JinxScript

        self:toggle("GOD",{},"Immortality, Auto Heal, Gracefulness, Glued To Seats, Lock Wanted Level, Infinite Stamina",function(on)
            for _,path in pairs(self_list["dieu"]) do
                if on then
                    self_list_cmds[path] = menu.get_value(self_list_cmds[path.."_command"])
                    menu.trigger_command(self_list_cmds[path.."_command"], "On")
                elseif not self_list_cmds[path] then
                    menu.trigger_command(self_list_cmds[path.."_command"], "Off")
                end
            end
        end)

        local unlimair = false
        self:toggle("Respiration infini", {}, "", function(on)
            unlimair = on
        	while unlimair do
        		PED.SET_PED_DIES_IN_WATER(PLAYER.PLAYER_PED_ID(), false)
        		PED.SET_PED_DIES_IN_SINKING_VEHICLE(PLAYER.PLAYER_PED_ID(), false)
        		util.yield()
        	end
        	PED.SET_PED_DIES_IN_WATER(PLAYER.PLAYER_PED_ID(), true)
        	PED.SET_PED_DIES_IN_SINKING_VEHICLE(PLAYER.PLAYER_PED_ID(), true)
        end, false)

        --Ghost
        --[[menu.toggle(self_tab, "Ghost", {"andyghostmode"}, "Toggles several Stand features such as Invisibility and Off The Radar all at the same time to make you fully invisible.",
        function(state)
            menu.trigger_command(menu.ref_by_path("Self>Appearance>Invisibility>" .. (state and "Enabled" or "Disabled"), 38))
            menu.set_value(menu.ref_by_path("Online>Off The Radar", 38), state)
            announce("Ghostmode " .. (state and "On" or "Off"))
        end
        )]]--

    --===============--
    -- Détections
    --===============--
    detex:toggle_loop("Godmode", {}, "Detects if someone is using godmode.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            for _, id in ipairs(interior_stuff) do
                if players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(pid) == 99 and get_interior_player_is_in(pid) == id then
                    util.draw_debug_text(players.get_name(pid) .. " is in Godmode.")
                    break
                end
            end
        end
    end)

    detex:toggle_loop("Vehicle Godmode", {}, "Detects if someone is using a vehicle that is in godmode.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            --local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) ~= 0 then
                for _, id in ipairs(interior_stuff) do
                    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(pid) == 99 and get_interior_player_is_in(pid) == id then
                        util.draw_debug_text(players.get_name(pid) ..  " is in vehicle Godmode.")
                        break
                    end
                end
            end
        end
    end)

    --ok
    detex:toggle_loop("Unreleased Vehicle", {}, "Detects if someone is using a vehicle that has not been released yet.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            --PED.IS_PED_IN_ANY_VEHICLE(ped, false) return true si le ped est dans un vehicle
            if vehicle ~= 0 then
                local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
                if driver == pid then
                    local modelHash = players.get_vehicle_model(pid)
                    for i, name in ipairs(unreleased_vehicles) do
                        if modelHash == util.joaat(name) then
                            Notify(players.get_name(pid).." driving an unreleased vehicle.\n"..util.get_label_text(modelHash))
                            util.draw_debug_text(players.get_name(pid) .. " unreleased vehicle.(V2) " .. "(" .. name .. ")")
                        end
                    end
                end
            end
        end
    end)
    
    --ok
    detex:toggle_loop("Modded Vehicle", {}, "Detects if someone is using a vehicle that can not be obtained in online.", function()
        for _, pid in ipairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            if driver == pid then
                local modelHash = players.get_vehicle_model(pid)
                for i, name in ipairs(modded_vehicles) do
                    if modelHash == util.joaat(name) then
                        if util.get_label_text(modelHash) == "NULL" then
                            Notify(players.get_name(pid).." is driving a modded vehicle.\n".."("..util.reverse_joaat(modelHash)..")")
                        else
                            Notify(players.get_name(pid).." is driving a modded vehicle.\n"..util.get_label_text(modelHash).."("..util.reverse_joaat(modelHash)..")")
                        end
                        --util.draw_debug_text(players.get_name(pid) .. " is driving a modded vehicle(V2) " .. "(" .. name .. ")")
                        break
                    end
                end
            end
        end
    end)

    detex:toggle_loop("Modded Weapon", {}, "Detects if someone is using a weapon that can not be obtained in online.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            for i, hash in ipairs(modded_weapons) do
                local weapon_hash = util.joaat(hash)
                --si le joueur possède une arme moddé et (a une arme a la main ou vise avec une arme ou vise avec une arme )
                --WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
                --if WEAPON.HAS_PED_GOT_WEAPON(player, weapon_hash, false) and (WEAPON.IS_PED_ARMED(player, 7) or TASK.GET_IS_TASK_ACTIVE(player, 8) or TASK.GET_IS_TASK_ACTIVE(player, 9)) then
                if WEAPON.GET_SELECTED_PED_WEAPON(player) == weapon_hash then
                    Notify(players.get_name(pid) .. " use the " .. weapon_from_hash(WEAPON.GET_SELECTED_PED_WEAPON(player)))
                    --Notify(players.get_name(pid) .. " is using a modded weapon.(" .. util.reverse_joaat(WEAPON.GET_SELECTED_PED_WEAPON(player))..")")
                    break
                end
            end
        end
    end)

    --[[
    detex:toggle_loop("Weapon In Interior", {}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if players.is_in_interior(pid) and WEAPON.IS_PED_ARMED(player, 7) then
                Notify(players.get_name(pid).."\nHas A Weapon In An Interior")
                break
            end
        end
    end)
    ]]--

    --[[
    detex:toggle_loop("Modded Animation", {}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if PED.IS_PED_USING_ANY_SCENARIO(player) then
                Notify(players.get_name(pid).."\nIs In A Modded Scenario")
            end
        end 
    end)
    ]]--


    detex:toggle_loop("Super Run", {}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local ped_speed = (ENTITY.GET_ENTITY_SPEED(ped)* 2.236936)
            if not util.is_session_transition_active() and get_interior_player_is_in(pid) == 0 and get_spawn_state(pid) ~= 0 and not PED.IS_PED_DEAD_OR_DYING(ped) 
            and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
            and not TASK.IS_PED_STILL(ped) and not PED.IS_PED_JUMPING(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped)
            and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 300.0 and ped_speed > 30 then
                Notify(players.get_name(pid).." is using super run.")
                break
            end
        end
    end)
    
    --Ne fonctionne pas ?
    detex:toggle_loop("Spectate", {}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            for i, interior in ipairs(interior_stuff) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                if not util.is_session_transition_active() and get_spawn_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior
                and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                    if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                        Notify(players.get_name(pid).." is spectating you.")
                        break
                    end
                end
            end
        end
    end)
    
    detex:toggle_loop("Spectate V2", {}, "Detects if someone is spectating you.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if not PED.IS_PED_DEAD_OR_DYING(ped) then
                if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                    Notify(players.get_name(pid) .. " is watching you.(V2)")
                    break
                end
            end
        end
    end)
    
    detex:toggle_loop("Super Drive", {}, "", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
            if driver == pid then
                local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 3.6)
                local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
                --veh_speed >= 180
                if class ~= 15 and class ~= 16 and veh_speed >= 245 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then -- not checking opressor mk1 cus its stinky
                    Notify(players.get_name(pid).." is using super drive.")
                    break
                end
            end
        end
    end)

    
    --[[detex:toggle_loop("No Clip", {}, "Detects if the player is using noclip aka levitation", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local ped_ptr = entities.handle_to_pointer(ped)
            local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
            local oldpos = players.get_position(pid)
            util.yield()
            local currentpos = players.get_position(pid)
            local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
            if not util.is_session_transition_active() and players.exists(pid)
            and get_interior_player_is_in(pid) == 0 and get_spawn_state(pid) ~= 0
            and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
            and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
            and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
            and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
            and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 395.0 
            and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
            and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
            and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
                Notify(players.get_name(pid).." is using NoClip.")
                break
            end
        end
    end)
    ]]--
    --ok
    detex:toggle_loop("Teleport", {}, "", function()
        for _, pid in ipairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                local oldpos = players.get_position(pid)
                util.yield(50) --250
                local currentpos = players.get_position(pid)
                local distance_between_tp = v3.distance(oldpos, currentpos)
                if distance_between_tp > 500.0 then
                    for i, interior in ipairs(interior_stuff) do
                        if get_interior_player_is_in(pid) == interior  and get_spawn_state(pid) ~= 0 and players.exists(pid) then
                            util.yield(100)
                            Notify(players.get_name(pid).." is teleported" .. SYSTEM.ROUND(distance_between_tp) .. " Meters")
                        end
                    end
                end
            end
        end
    end)
    detex:toggle_loop("Teleport (v2)", {}, "", function()
        for _, pid in ipairs(players.list(true, true, true)) do
            local old_pos = players.get_position(pid)
            util.yield(50)
            local cur_pos = players.get_position(pid)
            local distance_between_tp = v3.distance(old_pos, cur_pos)
            for _, id in ipairs(interior_stuff) do
                if get_interior_player_is_in(pid) == id and get_spawn_state(pid) ~= 0 and players.exists(pid) then
                    util.yield(100)
                    if distance_between_tp > 300.0 then
                        util.toast(players.get_name(pid) .. " Teleported " .. SYSTEM.ROUND(distance_between_tp) .. " Meters")
                    end
                end
            end
        end
    end)

    detex:toggle_loop("Thunder Join", {}, "Detects if someone is using thunder join.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            if get_spawn_state(players.user()) == 0 then return end
            local old_sh = players.get_script_host()
            util.yield(100)
            local new_sh = players.get_script_host()
            if old_sh ~= new_sh then
                if get_spawn_state(pid) == 0 and players.get_script_host() == pid then
                    util.toast(players.get_name(pid) .. " triggered a detection (Thunder Join) and is now classified as a Modder.")
                end
            end
        end
    end)

    detex:toggle_loop("Modded Orbital Cannon", {}, "Detects if someone is using a modded orbital cannon.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if IsPlayerUsingOrbitalCannon(pid) and not TASK.GET_IS_TASK_ACTIVE(ped, 135) then
                util.toast(players.get_name(pid) .. " is using a modded orbital cannon.")
            end
        end
    end)
    
    detex:toggle_loop("Orbital Cannon", {}, "Detects if someone is using an orbital cannon.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135)then
                util.draw_debug_text(players.get_name(pid) .. " is at the orbital cannon.")
            end
        end
    end)
    
    detex:toggle_loop("Glitched Godmode", {}, "Detects if someone is using a glitch to obtain godmode.", function()
        for _, pid in ipairs(players.list(false, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            for _, id in ipairs(interior_stuff) do
                if players.is_in_interior(pid) and players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_spawn_state(pid) == 99 and get_interior_player_is_in(pid) == id then
                    util.draw_debug_text(players.get_name(pid) .. " is in glitched Godmode.")
                    break
                end
            end
        end 
    end)



    --===============--
    -- Protections
    --===============--
        
    local protections_list = {
        mission = { -- on = 4
            "Online>Protections>Events>Start Freemode Mission",
            "Online>Protections>Events>Teleport To Interior",
            "Online>Protections>Events>Give Collectible",
            "Online>Protections>Events>Cayo Perico Invite",
            "Online>Protections>Events>Apartment Invite",
            "Online>Protections>Events>Vehicle Takeover",
            "Online>Protections>Events>Kick From Vehicle",
            "Online>Protections>Events>Ragdoll Event",
            "Online>Protections>Events>Raw Network Events>Give Weapon Event",
            "Online>Protections>Events>Raw Network Events>Remove Weapon Event",
            "Online>Protections>Events>Raw Network Events>Remove All Weapons Event",
            "Online>Protections>Events>Raw Network Events>Fire",
            "Online>Protections>Events>Raw Network Events>Explosion",
            "Online>Protections>Events>Raw Network Events>GIVE_PICKUP_REWARDS_EVENT",
            "Online>Protections>Events>Raw Network Events>PTFX",
            "Online>Protections>Events>Raw Network Events>REMOVE_STICKY_BOMB_EVENT",
            "Online>Protections>Syncs>World Object Sync",
            "Online>Protections>Syncs>Incoming>Any Incoming Sync",
            "Online>Protections>Syncs>Incoming>Clone Create",
            "Online>Protections>Syncs>Incoming>Clone Update",
            "Online>Protections>Syncs>Incoming>Clone Delete",
            "Online>Protections>Syncs>Incoming>Acknowledge Clone Create",
            "Online>Protections>Syncs>Incoming>Acknowledge Clone Update",
            "Online>Protections>Syncs>Incoming>Acknowledge Clone Delete",
            "Online>Protections>Session Script Start>Any Script",
            "Online>Protections>Session Script Start>Uncategorised",
            "Online>Protections>Session Script Start>Freemode Activity",
            "Online>Protections>Session Script Start>Removed Freemode Activity",
            "Online>Protections>Pickups>Any Pickup Collected",
            "Online>Protections>Pickups>Cash Pickup Collected",
            "Online>Protections>Pickups>RP Pickup Collected",
            "Online>Protections>Pickups>Invalid Pickup Collected",
        },
        additional_mission = {
            "Online>Protections>Pickups>Any Pickup Collected",
            "Online>Protections>Pickups>Cash Pickup Collected",
            "Online>Protections>Pickups>RP Pickup Collected",
            "Online>Protections>Pickups>Invalid Pickup Collected",
            "Online>Protections>Syncs>Outgoing>Clone Create",
            "Online>Protections>Syncs>Outgoing>Clone Update",
            "Online>Protections>Syncs>Outgoing>Clone Delete",
        },
    }
    
    local protections_list_cmds = SaveProtex(protections_list)

    protex:toggle('Mission', {}, '', function(on)
        for _,path in pairs(protections_list["mission"]) do
            if on then
                protections_list_cmds["mission"][path..">Block"] = menu.get_value(protections_list_cmds["mission"][path..">Block_command"])
                SetPathVal(path..">Block", 0)
            elseif menu.get_value(protections_list_cmds["mission"][path..">Block_command"]) == 0 then
                SetPathVal(path..">Block", protections_list_cmds["mission"][path..">Block"])
            end
        end
        for _,path in pairs(protections_list["additional_mission"]) do
            if on then
                protections_list_cmds["additional_mission"][path..">Block"] = menu.get_value(protections_list_cmds["additional_mission"][path..">Block_command"])
                SetPathVal(path..">Block", false)
            elseif menu.get_value(protections_list_cmds["additional_mission"][path..">Block_command"]) == false then
                SetPathVal(path..">Block", protections_list_cmds["additional_mission"][path..">Block"])
            end
        end
    end)

    anti_mugger:toggle_loop("Myself", {}, "Prevents you from being mugged.", function() -- thx nowiry for improving my method :D
        if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
            local sender = memory.script_local("am_gang_call", 287)
            local target = memory.script_local("am_gang_call", 288)
            local player = players.user()
    
            util.spoof_script("am_gang_call", function()
                if (memory.read_int(sender) ~= player and memory.read_int(target) == player 
                and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
                and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId))) then
                    local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                    entities.delete_by_handle(mugger)
                    util.toast("Blocked mugger from " .. players.get_name(memory.read_int(sender)))
                end
            end)
        end
    end)
    
    anti_mugger:toggle_loop("Someone Else", {}, "Prevents others from being mugged.", function()
        if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
            local ped_netId = memory.script_local("am_gang_call", 63 + 10 + (0 * 7 + 1))
            local sender = memory.script_local("am_gang_call", 287)
            local target = memory.script_local("am_gang_call", 288)
            local player = players.user()
    
            util.spoof_script("am_gang_call", function()
                if memory.read_int(target) ~= player and memory.read_int(sender) ~= player
                and NETWORK.NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(ped_netId)) 
                and NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(ped_netId)) then
                    local mugger = NETWORK.NET_TO_PED(memory.read_int(ped_netId))
                    entities.delete_by_handle(mugger)
                    util.toast("Blocked mugger sent by " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
                end
            end)
        end
    end)
    
    --===============--
    -- Misc
    --===============--
        misc:toggle_loop("Anti-vehicles", {}, "Détruit le moteur de tous les véhicules bloqué.", function ()
            local vehall = entities.get_all_vehicles_as_handles()
            for k,pid in pairs(vehall) do
                local veh = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(pid)
                local hash = ENTITY.GET_ENTITY_MODEL(pid)
                if anti_vehicles_list[hash] then
                    if anti_vehicles_option["remove"] then
                        entities.delete_by_handle(veh)
                        if anti_vehicles_option["notif"] then
                            util.toast(util.reverse_joaat(hash).." supprimé !")
                        end
                    elseif VEHICLE.GET_VEHICLE_ENGINE_HEALTH(veh) > -4000 then
                        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, -4000)
                        VEHICLE.SET_VEHICLE_ENGINE_ON(veh, false, true, true)
	                    VEHICLE.BRING_VEHICLE_TO_HALT(veh, 100.0, 1)
	                    VEHICLE.SET_HELI_BLADES_SPEED(veh, 0.0)
                        if anti_vehicles_option["notif"] then
                            util.toast(util.reverse_joaat(hash).." moteur détruit !")
                        end
                    end
                end
            end
            util.yield()
        end)
        menu.divider(misc, "Options Anti-vehicles")
        misc:toggle("Suppression du véhicule", {}, "Les véhicles bloqué seront supprimé !", function (on)
            anti_vehicles_option["remove"] = on
        end)
        misc:toggle("Notification", {}, "Vous averti de la destruction des moteurs ou des vehicules supprimé.", function (on)
            anti_vehicles_option["notif"] = on
        end,true)

        misc:action("test", {}, "", function ()
            local vehall = entities.get_all_vehicles_as_handles()
            for k,pid in pairs(vehall) do
                local veh = ENTITY.GET_VEHICLE_INDEX_FROM_ENTITY_INDEX(pid)
                local hash = ENTITY.GET_ENTITY_MODEL(pid)
                if anti_vehicles_list[hash] then
                    util.toast("test: "..VEHICLE.GET_VEHICLE_ENGINE_HEALTH(veh))
                    --VEHICLE.SET_VEHICLE_ENGINE_ON(veh, false, true, true)
                end
            end
            
        end)
        menu.divider(misc, "Gestion Anti-vehicles")
        misc:text_input("Modèle de véhicule", {"vehmodeladd"}, "Entrez un nom de véhicule personnalisé à générer (le NOM, pas le hachage)", function(on_input)
            if anti_vehicles_model ~= on_input then
                if on_input ~= nil then
                    local i = util.joaat(on_input)
                    if anti_vehicles_list[i] then
                        -- util.get_label_text(modelHash)
                        util.toast("Véhicule déjà bloqué !")
                    elseif VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(i) ~= 0 then
                        anti_vehicles_list[i] = on_input
                        util.toast("Véhicule bloqué !")
                    else
                        util.toast("Véhicule inconnu !")
                    end
                else
                    util.toast("Valeur vide !")
                end
                anti_vehicles_model = on_input
            end
        end, '')

        misc:action("Sauvegarder les véhicles bloqué", {}, "", function()
            --sauvegarde de la liste
            local filehandle = io.open(anti_vehicles_file, "w")
            if filehandle then
                filehandle:write(Json.encode(anti_vehicles_list))
                filehandle:flush()
                filehandle:close()
            end
        end)

        menus.vehlist = misc:list("Voir les véhicules bloqué", {}, "", function()
            build_vehicles_list()
        end)



        menu.divider(misc, "Auto-Features")

        misc:slider("Change seat", {}, "DriverSeat = -1 Passenger = 0 Left Rear = 1 RightRear = 2", -1, 2, -1, 1, function(seatnumber)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
            local vehicle = entities.get_user_vehicle_as_handle()
            --PED.SET_PED_INTO_VEHICLE(ped, vehicle, seatnumber)
            PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
        end)

        misc:toggle_loop("Unlock Vehicle that you try to get into", {"unlockvehget"}, "Unlocks a vehicle that you try to get into. This will work on locked player cars.", function ()
            ::start::
            local localPed = players.user_ped()
            --obtenir le véhicule où le ped essaie d'entrer
            local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
            --Obtient une valeur indiquant si le ped spécifié se trouve dans un véhicule. Si le 2ème argument est faux, la fonction ne retournera pas vrai jusqu'à ce que le ped soit assis dans le véhicule et soit sur le point de fermer la porte.
            if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
                --Obtient le véhicule dans lequel se trouve le piéton spécifié. Renvoie 0 si le piéton est/n'était pas dans un véhicule. True recupère le dernier vehicle.
                local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
                --VERROUILLER LES PORTES DU VÉHICULE {VEHICLELOCK_NONE, VEHICLELOCK_UNLOCKED, VEHICLELOCK_LOCKED, VEHICLELOCK_LOCKOUT_PLAYER_ONLY, VEHICLELOCK_LOCKED_PLAYER_INSIDE, VEHICLELOCK_LOCKED_INITIALLY, VEHICLELOCK_FORCE_SHUT_DOORS, VEHICLELOCK_LOCKED_BUT_CAN_BE_DAMAGED, VEHICLELOCK_LOCKED_BUT_BOOT_UNLOCKED, VEHICLELOCK_LOCKED_NO_PASSENGERS, VEHICLELOCK_CANNOT_ENTER}
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 0)
                --DÉFINIR LES PORTES DU VÉHICULE VERROUILLÉES POUR TOUS LES JOUEURS
                --VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
                --DÉFINIR LES PORTES DU VÉHICULE VERROUILLÉES POUR LE JOUEUR
                --VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
                --VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
                util.yield()
            else
                if veh ~= 0 then
                    --RÉSEAU DEMANDE DE CONTRÔLE DE L'ENTITÉ
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    --LE RÉSEAU A PAS LE CONTRÔLE DE L'ENTITÉ
                    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                        for i = 1, 20 do
                            --RÉSEAU DEMANDE DE CONTRÔLE DE L'ENTITÉ
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                            util.yield(100)
                        end
                    end
                    --LE RÉSEAU A PAS LE CONTRÔLE DE L'ENTITÉ
                    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                        util.toast("Waited 2 secs, couldn't get control!")
                        goto start
                    else
                        --if SE_Notifications then
                            util.toast("Has control.")
                        --end
                    end
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 0)
                    --VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
                    --VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
                    --DÉFINIR LE VÉHICULE APPARTIENT AU JOUEUR
                    --VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
                end
            end
        end)

        misc:toggle_loop("Turn Car On Instantly", {"turnvehonget"}, "Turns the car engine on instantly when you get into it, so you don't have to wait.", function ()
            local localped = players.user_ped()
            if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
                local veh = PED.GET_VEHICLE_PED_IS_ENTERING(localped)
                if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) then
                    VEHICLE.SET_VEHICLE_FIXED(veh)
                    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000)
                    VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
                end
                if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 then --15 is heli
                    VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
                end
            end
        end)


        --[[ NE FONCTIONNE PAS
        misc:toggle_loop('Increase Kosatka Missile Range', {'krange'}, 'You can use it anywhere in the map now', function ()
            if util.is_session_started() then
                memory.write_float(memory.script_global(262145 + 30176), 200000.0)
            end
        end)
        ]]--


        --consistent freeze clock
        --[[local function read_time(file_path)
            local filehandle = io.open(file_path, "r")
            if filehandle then
                local time = filehandle:read()
                filehandle:close()
                return tostring(time)
            else
                return false
            end
        end

        local function save_current_time(file_path, time)
            filehandle = io.open(file_path, "w")
            filehandle:write(time)
            filehandle:flush()
            filehandle:close()
        end

        local function get_clock()
            return tostring(CLOCK.GET_CLOCK_HOURS() .. ":" .. CLOCK.GET_CLOCK_MINUTES() .. ":".. CLOCK.GET_CLOCK_SECONDS())
        end

        local time_path = filesystem.store_dir() .. "AndyScript\\time.txt"
        local is_freeze_clock_on = false
        misc:toggle("Consistent Freeze Clock", {}, "Freezes the clock using Stand's function, then saves the time for next execution. Change the current time using the \"time\" command, or in \"World > Atmosphere > Clock > Time\".",
        function(state)
            is_freeze_clock_on = state
            if state then
                if filesystem.exists(time_path) then
                    local time = read_time(time_path)
                    menu.trigger_command(menu.ref_by_path("World>Atmosphere>Clock>Time", 38), time)
                else
                    save_current_time(time_path, get_clock())
                end
            else
                menu.trigger_command(menu.ref_by_path("World>Atmosphere>Clock>Lock Time", 38), "false")
            end
            while is_freeze_clock_on do
                menu.trigger_command(menu.ref_by_path("World>Atmosphere>Clock>Lock Time", 38), "true")
                save_current_time(time_path, get_clock())
                util.yield(1000)
            end
        end)
        -- end of freeze clock
        ]]--