util.keep_running()
local scriptStartTime = util.current_time_millis()
local version = "0.1"
local Tree_V = 43
--[[
    -- https://github.com/hexarobi/stand-lua-auto-updater
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

    local languages = {
        'french',
        'english',
    }

    local auto_update_config = {
        source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/NyScript.lua",
        script_relpath=SCRIPT_RELPATH,
        --silent_updates=true,
        dependencies={
            {
                name="functions",
                source_url="https://raw.githubusercontent.com/NyCreamZ/NyScript/main/lib/NyScript/functions.lua",
                script_relpath="lib/NyScript/functions.lua",
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

]]--

    local required <const> = {
    	"lib/natives-1663599433.lua",
    	"lib/NyScript/functions.lua",
    }
    local scriptdir <const> = filesystem.scripts_dir()
    local libDir <const> = scriptdir .. "\\lib\\NyScript\\"
    local languagesDir <const> = libDir .. "\\Languages\\"
    local relative_languagesDir <const> = "./lib/NyScript/Languages/"

    for _, file in ipairs(required) do
    	assert(filesystem.exists(scriptdir .. file), "required file not found: " .. file)
    end
    require "NyScript.functions"
    local Json = require("json")
    util.ensure_package_is_installed('lua/natives-1663599433')
    util.require_natives(1663599433)

    if not filesystem.exists(libDir) then
    	filesystem.mkdir(libDir)
    end

    if not filesystem.exists(languagesDir) then
    	filesystem.mkdir(languagesDir)
    end

    if filesystem.exists(filesystem.resources_dir() .. "NyTextures.ytd") then
        util.register_file(filesystem.resources_dir() .. "NyTextures.ytd")
        notification.txdDict = "NyTextures"
        notification.txdName = "logo"

        util.spoof_script("main_persistent", function()
            GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("NyTextures", false)
        end)
    else
        error("required file not found: NyTextures.ytd" )
    end

    -- credit http://lua-users.org/wiki/StringRecipes
    local function ends_with(str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end

    Translations = {}
    setmetatable(Translations, {
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


    local need_default_language

    if not table.contains(languageDir_files, 'english.lua') then
        need_default_language = true
        async_http.init('raw.githubusercontent.com', 'NyCreamZ/NyScript/main/lib/NyScript/Languages/english.lua', function(data)
            local file = io.open(translations_dir .. "/english.lua",'w')
            file:write(data)
            file:close()
            need_default_language = false
        end, function()
            util.toast('!!! Failed to retrieve default translation table. All options that would be translated will look weird. Please check your connection to GitHub.')
        end)
        async_http.dispatch()
    else
        need_default_language = false
    end

    while need_default_language do
        util.toast("Looks like there was an update! Installing default/english translation now.")
        util.yield()
    end

    local selected_lang_path = languagesDir .. 'selected_language.txt'
    if not table.contains(languageDir_files, 'selected_language.txt') then
        local file = io.open(selected_lang_path, 'w')
        file:write('english.lua')
        file:close()
    end


    local selected_lang_file = io.open(selected_lang_path, 'r')
    local selected_language = selected_lang_file:read()
    if not table.contains(languageDir_files, selected_language) then
        notification.stand(selected_language .. ' was not found. Defaulting to English.')
        Translations = require(relative_languagesDir .. "english")
    else
        Translations = require(relative_languagesDir .. '\\' .. selected_language:gsub('.lua', ''))
    end


async_http.init('pastebin.com', '89Js2RDM', function() end)
async_http.dispatch()

    local commands = menu.trigger_commands


            local nation_lang2 = {"EN", "FR", "DE", "IT", "ES", "BR", "PL", "RU", "KR", "TW", "JP", "MX", "CN"}
            local nation_lang = {Translations.nation_us, Translations.nation_fr, Translations.nation_de, Translations.nation_it, Translations.nation_es, Translations.nation_br, Translations.nation_pl, Translations.nation_ru, Translations.nation_kr, Translations.nation_tw, Translations.nation_jp, Translations.nation_mx, Translations.nation_cn}
            local nation_notify = false
            local nation_save = false
            local nation_select = 1

            local self_list = {
                god = {
                    "Self>Immortality",
                    "Self>Auto Heal",
                    "Self>Gracefulness",
                    "Self>Glued To Seats",
                    "Self>Lock Wanted Level",
                    "Self>Infinite Stamina",
                    "Soi>Appearance>No Blood",
                },
            }

            local self_value = {god = {}, ghost = {}}

    local handle_ptr = memory.alloc(13*8)
    local function pid_to_handle(pid)
        NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
        return handle_ptr
    end

    local aimbot_mode = "closest"
    local aimbot_options_damage, aimbot_options_use_fov, aimbot_options_fov, aimbot_options_mode, aimbot_options_cible = 100, true, 60, 1, 1
    local aimbot_target_players, aimbot_target_friends, aimbot_target_godmode, aimbot_target_npcs, aimbot_target_vehicles = true, false, true, false, false
    local aimbot_show_target = true
    local aimbot_custom_type = 1
    local aimbot_custom_colour = {r = 1, g = 0.0, b = 0.0, a = 1.0}

    local function get_aimbot_target()
        local dist = 1000000000
        local cur_tar = 0
        for k,v in pairs(entities.get_all_peds_as_handles()) do
            local target_this = true
            local player_pos = players.get_position(players.user())
            local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
            local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
            if players.user_ped() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
                if not aimbot_target_players then
                    if PED.IS_PED_A_PLAYER(v) then
                        target_this = false
                    end
                end
                if not aimbot_target_npcs then
                    if not PED.IS_PED_A_PLAYER(v) then
                        target_this = false
                    end
                end
                if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), v, 17) then
                    target_this = false
                end
                if aimbot_options_use_fov then
                    if not PED.IS_PED_FACING_PED(players.user_ped(), v, aimbot_options_fov) then
                        target_this = false
                    end
                end
                if aimbot_target_vehicles then
                    if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                        target_this = false
                    end
                end
                if aimbot_target_godmode then
                    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(v) then
                        target_this = false
                    end
                end
                if not aimbot_target_friends then
                    if PED.IS_PED_A_PLAYER(v) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                        local hdl = pid_to_handle(pid)
                        if NETWORK.NETWORK_IS_FRIEND(hdl) then
                            target_this = false
                        end
                    end
                end
                if aimbot_mode == "closest" then
                    if this_dist <= dist then
                        if target_this then
                            dist = this_dist
                            cur_tar = v
                        end
                    end
                end
            end
        end
        return cur_tar
    end

players.on_join(function (pid)
    if pid == players.user() then return end
    while not util.is_session_started() or util.is_session_transition_active() do
        util.yield()
    end
    if nation_notify or nation_save then
        local player_language = players.get_language(pid) + 1
        if nation_select == player_language then
            local player_name = players.get_name(pid):lower()
            if nation_notify then
                notification.stand(player_name .. Translations.nation_notify_arg .. nation_lang[player_language] .. ".")
            end
            if nation_save and menu.ref_by_command_name("historynote"..player_name:lower()).value == "" then
                commands("historynote" .. player_name .. " " .. nation_lang2[player_language])
            end
        end
    end
end)


local main_root = menu.my_root()

local self_root = main_root:list(Translations.self_root, {}, Translations.self_root_desc)

        self_root:toggle(Translations.self_godmode,{},Translations.self_godmode_desc, function(on)
            for _,path in pairs(self_list.god) do
                if on then
                    self_value.god[path] = menu.ref_by_path(path, Tree_V).value
                    menu.set_value(menu.ref_by_path(path, Tree_V), true)
                elseif not self_value.god[path] then
                    menu.set_value(menu.ref_by_path(path, Tree_V), false)
                end
            end
        end)

        self_root:toggle(Translations.self_unlimair, {}, Translations.self_unlimair_desc, function(on)
        	PED.SET_PED_DIES_IN_SINKING_VEHICLE(PLAYER.PLAYER_PED_ID(), not on)
            PED.SET_PED_DIES_IN_WATER(PLAYER.PLAYER_PED_ID(), not on)
        end, false)

        self_root:toggle(Translations.self_cold_blood, {}, Translations.self_cold_blood_desc, function(on)
            PED.SET_PED_HEATSCALE_OVERRIDE(players.user_ped(), (on and 0 or 1.0))
        end, false)

        self_root:toggle(Translations.self_ninja, {}, Translations.self_ninja_desc, function(on)
            AUDIO.SET_PED_FOOTSTEPS_EVENTS_ENABLED(players.user_ped(), not on)
            AUDIO.SET_PED_CLOTH_EVENTS_ENABLED(players.user_ped(), not on)
        end, false)

        self_root:toggle(Translations.self_ghost, {}, Translations.self_ghost_desc, function(on)
            local path1 = "Self>Appearance>Invisibility"
            local path2 = "Online>Off The Radar"
            if on then
                self_value.ghost[path1] = menu.ref_by_path(path1, Tree_V).value
                self_value.ghost[path2] = menu.ref_by_path(path2, Tree_V).value
                menu.set_value(menu.ref_by_path(path1, Tree_V), 1)
                menu.set_value(menu.ref_by_path(path2, Tree_V), true)
            else
                if self_value.ghost[path1] ~= 1 or self_value.ghost[path1] ~= menu.ref_by_path(path1, Tree_V).value then
                    menu.set_value(menu.ref_by_path(path1, Tree_V), self_value.ghost[path1])
                end
                if not self_value.ghost[path2] then
                    menu.set_value(menu.ref_by_path(path2, Tree_V), on)
                end
            end
        end, false)

    local weapon_root = main_root:list(Translations.weapon_root, {}, Translations.weapon_root_desc)

        local aimbot_root = weapon_root:list(Translations.weapon_aimbot_root, {}, Translations.weapon_aimbot_root_desc)

            aimbot_root:toggle_loop(Translations.weapon_aimbot, {"nyaimbot"}, Translations.weapon_aimbot_desc, function(toggle)
                local target = get_aimbot_target()
                if target ~= 0 then
                    local weaponped = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), true)
                    local min, max = v3.new(), v3.new()
                    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(weaponped), min, max)
                    local startLine = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(weaponped,  max.x, 0, 0.04)

                    local t_pos
                    local t_pos2
                    local t_pos_target = ENTITY.GET_ENTITY_COORDS(target, true)
                    local t_pos_search = {
                        PED.GET_PED_BONE_COORDS(target, 27474, 0.25, 0.04, 0),
                        PED.GET_PED_BONE_COORDS(target, 24818, 0, 0.25, 0),
                    }
                    local t_pos2_search = {
                        PED.GET_PED_BONE_COORDS(target, 27474, 0, 0.04, 0),
                        PED.GET_PED_BONE_COORDS(target, 24818, 0, 0, 0),
                    }
                    local aimbot_options_cible_random = math.random(2)

                    if aimbot_options_mode == 1 then
                        if aimbot_options_cible ~= 3 then
                            t_pos = t_pos_search[aimbot_options_cible]
                        else
                            t_pos = t_pos_search[aimbot_options_cible_random]
                        end
                    else
                        t_pos = startLine
                    end

                    if aimbot_options_cible ~= 3 then
                        t_pos2 = t_pos2_search[aimbot_options_cible]
                    else
                        t_pos2 = t_pos2_search[aimbot_options_cible_random]
                    end

                    if aimbot_show_target then
                        if aimbot_custom_type == 1 then
                            GRAPHICS.DRAW_MARKER(0, t_pos_target.x, t_pos_target.y, t_pos_target.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 1, math.floor(aimbot_custom_colour.r*255), math.floor(aimbot_custom_colour.g*255), math.floor(aimbot_custom_colour.b*255), math.floor(aimbot_custom_colour.a*255), false, true, 2, false, 0, 0, false)
                        elseif aimbot_custom_type == 2 then
                            GRAPHICS.DRAW_MARKER(2, t_pos_target.x, t_pos_target.y, t_pos_target.z+2, 0, 0, 0, 0.0, 180, 0.0, 1, 1, 1, math.floor(aimbot_custom_colour.r*255), math.floor(aimbot_custom_colour.g*255), math.floor(aimbot_custom_colour.b*255), math.floor(aimbot_custom_colour.a*255), false, true, 2, false, 0, 0, false)
                        else
                            GRAPHICS.DRAW_LINE(startLine.x, startLine.y, startLine.z, t_pos2.x, t_pos2.y, t_pos2.z, math.floor(aimbot_custom_colour.r*255), math.floor(aimbot_custom_colour.g*255), math.floor(aimbot_custom_colour.b*255), math.floor(aimbot_custom_colour.a*255))
                        end
                    end
                    if PED.IS_PED_SHOOTING(players.user_ped()) then
                        local wep = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
                        local dmg = WEAPON.GET_WEAPON_DAMAGE(wep, 0) * aimbot_options_damage / 100
                        local veh = PED.GET_VEHICLE_PED_IS_IN(target, false)
                        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(t_pos['x'], t_pos['y'], t_pos['z'], t_pos2['x'], t_pos2['y'], t_pos2['z'], dmg, true, wep, players.user_ped(), true, false, 10000, veh)
                    end
                end
            end)

            local aimbot_options_root = aimbot_root:list(Translations.weapon_aimbot_options_root, {}, Translations.weapon_aimbot_options_root_desc)

                aimbot_options_root:slider(Translations.weapon_aimbot_options_damage, {}, Translations.weapon_aimbot_options_damage_desc, 1, 1000, aimbot_options_damage, 10, function(s)
                    aimbot_options_damage = s
                end)

                aimbot_options_root:toggle(Translations.weapon_aimbot_options_use_fov, {}, Translations.weapon_aimbot_options_use_fov_desc, function(on)
                    aimbot_options_use_fov = on
                end, aimbot_options_use_fov)

                aimbot_options_root:slider(Translations.weapon_aimbot_options_fov, {}, Translations.weapon_aimbot_options_fov_desc, 1, 270, aimbot_options_fov, 1, function(s)
                    aimbot_options_fov = s
                end)

                aimbot_options_root:list_select(Translations.weapon_aimbot_options_mode, {}, Translations.weapon_aimbot_options_mode_desc, {"Cheat", "Legit"}, aimbot_options_mode, function (index)
                    aimbot_options_mode = index
                end)

                aimbot_options_root:list_select(Translations.weapon_aimbot_options_cible, {}, Translations.weapon_aimbot_options_cible_desc, {"Head", "Torso", "Random"}, aimbot_options_cible, function (index)
                    aimbot_options_cible = index
                end)

            aimbot_root:toggle(Translations.weapon_aimbot_players, {}, Translations.weapon_aimbot_players_desc, function(on)
                aimbot_target_players = on
            end, aimbot_target_players)

            aimbot_root:toggle(Translations.weapon_aimbot_friends, {}, Translations.weapon_aimbot_friends_desc, function(on)
                aimbot_target_friends = on
            end, aimbot_target_friends)

            aimbot_root:toggle(Translations.weapon_aimbot_godmode, {}, Translations.weapon_aimbot_godmode_desc, function(on)
                aimbot_target_godmode = on
            end, aimbot_target_godmode)

            aimbot_root:toggle(Translations.weapon_aimbot_npcs, {}, Translations.weapon_aimbot_npcs_desc, function(on)
                aimbot_target_npcs = on
            end, aimbot_target_npcs)

            aimbot_root:toggle(Translations.weapon_aimbot_vehicles, {}, Translations.weapon_aimbot_vehicles_desc, function(on)
                aimbot_target_vehicles = on
            end, aimbot_target_vehicles)

            aimbot_root:toggle(Translations.weapon_aimbot_display, {}, Translations.weapon_aimbot_display_desc, function(on)
                aimbot_show_target = on
            end, aimbot_show_target)

            local aimbot_custom_root = aimbot_root:list(Translations.weapon_aimbot_custom_root, {}, Translations.weapon_aimbot_custom_root_desc)

                aimbot_custom_root:slider(Translations.weapon_aimbot_custom_type, {}, Translations.weapon_aimbot_custom_type_desc, 1, 3, aimbot_custom_type, 1, function (s)
                    aimbot_custom_type = s
                end)

                local aimbot_custom_colour_root = aimbot_custom_root:colour(Translations.weapon_aimbot_custom_colour_root, {"nyaimbotmarkcolor"}, Translations.weapon_aimbot_custom_colour_root_desc, aimbot_custom_colour, true, function (newColour)
                    aimbot_custom_colour = newColour
                end)
                aimbot_custom_colour_root:rainbow()

    local online_root = main_root:list(Translations.online_root, {}, Translations.online_root_desc)

        local session_root = online_root:list(Translations.online_session_root, {}, Translations.online_session_root_desc)

            session_root:toggle(Translations.online_session_nation_notify, {}, Translations.online_session_nation_notify_desc, function(on)
                nation_notify = on
            end, nation_notify)

            session_root:toggle(Translations.online_session_nation_save, {}, Translations.online_session_nation_save_desc, function(on)
                nation_save = on
            end, nation_save)

            session_root:list_select(Translations.online_session_nation_select, {}, Translations.online_session_nation_select_desc, nation_lang, nation_select, function (index)
                nation_select = index
            end)

    local protex_root = main_root:list(Translations.protection_root, {}, Translations.protection_root_desc)

        local protections_list = {
            mission = {
                "Online>Protections>Events>Crash Event",
                "Online>Protections>Events>Kick Event",
                "Online>Protections>Events>Modded Event",
                "Online>Protections>Events>Trigger Business Raid",
                "Online>Protections>Events>Start Freemode Mission",
                "Online>Protections>Events>Start Freemode Mission (Not My Boss)",
                "Online>Protections>Events>Teleport To Interior",
                "Online>Protections>Events>Teleport To Interior (Not My Boss)",
                "Online>Protections>Events>Give Collectible",
                "Online>Protections>Events>Give Collectible (Not My Boss)",
                "Online>Protections>Events>CEO/MC Kick",
                "Online>Protections>Events>Infinite Loading Screen",
                "Online>Protections>Events>Infinite Phone Ringing",
                "Online>Protections>Events>Teleport To Cayo Perico",
                "Online>Protections>Events>Cayo Perico Invite",
                "Online>Protections>Events>Apartment Invite",
                "Online>Protections>Events>Send To Cutscene",
                "Online>Protections>Events>Send To Job",
                "Online>Protections>Events>Transaction Error Event",
                "Online>Protections>Events>Vehicle Takeover",
                "Online>Protections>Events>Disable Driving Vehicles",
                "Online>Protections>Events>Kick From Vehicle",
                "Online>Protections>Events>Kick From Interior",
                "Online>Protections>Events>Freeze",
                "Online>Protections>Events>Force Camera Forward",
                "Online>Protections>Events>Love Letter Kick Blocking Event",
                "Online>Protections>Events>Camera Shaking Event",
                "Online>Protections>Events>Explosion Spam",
                "Online>Protections>Events>Ragdoll Event",

                    "Online>Protections>Events>Raw Network Events>Any Event",
                    "Online>Protections>Events>Raw Network Events>Script Event",
                    "Online>Protections>Events>Raw Network Events>OBJECT_ID_FREED_EVENT",
                    "Online>Protections>Events>Raw Network Events>OBJECT_ID_REQUEST_EVENT",
                    "Online>Protections>Events>Raw Network Events>ARRAY_DATA_VERIFY_EVENT",
                    "Online>Protections>Events>Raw Network Events>SCRIPT_ARRAY_DATA_VERIFY_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_CONTROL_EVENT",
                    "Online>Protections>Events>Raw Network Events>GIVE_CONTROL_EVENT",
                    "Online>Protections>Events>Raw Network Events>WEAPON_DAMAGE_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_PICKUP_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_MAP_PICKUP_EVENT",
                    "Online>Protections>Events>Raw Network Events>RESPAWN_PLAYER_PED_EVENT",
                    "Online>Protections>Events>Raw Network Events>Give Weapon Event",
                    "Online>Protections>Events>Raw Network Events>Remove Weapon Event",
                    "Online>Protections>Events>Raw Network Events>Remove All Weapons Event",
                    "Online>Protections>Events>Raw Network Events>VEHICLE_COMPONENT_CONTROL_EVENT",
                    "Online>Protections>Events>Raw Network Events>Fire",
                    "Online>Protections>Events>Raw Network Events>Explosion",
                    "Online>Protections>Events>Raw Network Events>START_PROJECTILE_EVENT",
                    "Online>Protections>Events>Raw Network Events>UPDATE_PROJECTILE_TARGET_EVENT",
                    "Online>Protections>Events>Raw Network Events>BREAK_PROJECTILE_TARGET_LOCK_EVENT",
                    "Online>Protections>Events>Raw Network Events>REMOVE_PROJECTILE_ENTITY_EVENT",
                    "Online>Protections>Events>Raw Network Events>ALTER_WANTED_LEVEL_EVENT",
                    "Online>Protections>Events>Raw Network Events>CHANGE_RADIO_STATION_EVENT",
                    "Online>Protections>Events>Raw Network Events>RAGDOLL_REQUEST_EVENT",
                    "Online>Protections>Events>Raw Network Events>PLAYER_TAUNT_EVENT",
                    "Online>Protections>Events>Raw Network Events>PLAYER_CARD_STAT_EVENT",
                    "Online>Protections>Events>Raw Network Events>DOOR_BREAK_EVENT",
                    "Online>Protections>Events>Raw Network Events>REMOTE_SCRIPT_INFO_EVENT",
                    "Online>Protections>Events>Raw Network Events>REMOTE_SCRIPT_LEAVE_EVENT",
                    "Online>Protections>Events>Raw Network Events>MARK_AS_NO_LONGER_NEEDED_EVENT",
                    "Online>Protections>Events>Raw Network Events>CONVERT_TO_SCRIPT_ENTITY_EVENT",
                    "Online>Protections>Events>Raw Network Events>SCRIPT_WORLD_STATE_EVENT",
                    "Online>Protections>Events>Raw Network Events>INCIDENT_ENTITY_EVENT",
                    "Online>Protections>Events>Raw Network Events>CLEAR_AREA_EVENT",
                    "Online>Protections>Events>Raw Network Events>CLEAR_RECTANGLE_AREA_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_REQUEST_SYNCED_SCENE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_START_SYNCED_SCENE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_UPDATE_SYNCED_SCENE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_STOP_SYNCED_SCENE_EVENT",
                    "Online>Protections>Events>Raw Network Events>GIVE_PED_SCRIPTED_TASK_EVENT",
                    "Online>Protections>Events>Raw Network Events>GIVE_PED_SEQUENCE_TASK_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_CLEAR_PED_TASKS_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_START_PED_ARREST_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_START_PED_UNCUFF_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_SOUND_CAR_HORN_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_ENTITY_AREA_STATUS_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_GARAGE_OCCUPIED_STATUS_EVENT",
                    "Online>Protections>Events>Raw Network Events>PED_CONVERSATION_LINE_EVENT",
                    "Online>Protections>Events>Raw Network Events>SCRIPT_ENTITY_STATE_CHANGE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_PLAY_SOUND_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_STOP_SOUND_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_PLAY_AIRDEFENSE_FIRE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_BANK_REQUEST_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_AUDIO_BARK_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_DOOR_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_TRAIN_REQUEST_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_TRAIN_REPORT_EVENT",
                    "Online>Protections>Events>Raw Network Events>MODIFY_VEHICLE_LOCK_WORD_STATE_DATA",
                    "Online>Protections>Events>Raw Network Events>MODIFY_PTFX_WORD_STATE_DATA_SCRIPTED_EVOLVE_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_PHONE_EXPLOSION_EVENT",
                    "Online>Protections>Events>Raw Network Events>REQUEST_DETACHMENT_EVENT",
                    "Online>Protections>Events>Raw Network Events>KICK_VOTES_EVENT",
                    "Online>Protections>Events>Raw Network Events>GIVE_PICKUP_REWARDS_EVENT",
                    
                    "Online>Protections>Events>Raw Network Events>BLOW_UP_VEHICLE_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_SPECIAL_FIRE_EQUIPPED_WEAPON",
                    "Online>Protections>Events>Raw Network Events>NETWORK_RESPONDED_TO_THREAT_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_SHOUT_TARGET_POSITION",
                    "Online>Protections>Events>Raw Network Events>VOICE_DRIVEN_MOUTH_MOVEMENT_FINISHED_EVENT",
                    "Online>Protections>Events>Raw Network Events>PICKUP_DESTROYED_EVENT",
                    "Online>Protections>Events>Raw Network Events>UPDATE_PLAYER_SCARS_EVENT",
                    "Online>Protections>Events>Raw Network Events>NETWORK_CHECK_EXE_SIZE_EVENT",
                    "Online>Protections>Events>Raw Network Events>PTFX",
                    "Online>Protections>Events>Raw Network Events>NETWORK_PED_SEEN_DEAD_PED_EVENT",
                    "Online>Protections>Events>Raw Network Events>REMOVE_STICKY_BOMB_EVENT",
                    
                    "Online>Protections>Events>Raw Network Events>INFORM_SILENCED_GUNSHOT_EVENT",
                    "Online>Protections>Events>Raw Network Events>PED_PLAY_PAIN_EVENT",
                    "Online>Protections>Events>Raw Network Events>CACHE_PLAYER_HEAD_BLEND_DATA_EVENT",
                    "Online>Protections>Events>Raw Network Events>REMOVE_PED_FROM_PEDGROUP_EVENT",
                    
                    "Online>Protections>Events>Raw Network Events>REPORT_CASH_SPAWN_EVENT",
                    "Online>Protections>Events>Raw Network Events>ACTIVATE_VEHICLE_SPECIAL_ABILITY_EVENT",
                    "Online>Protections>Events>Raw Network Events>BLOCK_WEAPON_SELECTION",
                    "Online>Protections>Events>Raw Network Events>NETWORK_CHECK_CATALOG_CRC",

                "Online>Protections>Detections>Spoofed Host Token (Aggressive)",
                "Online>Protections>Detections>Spoofed Host Token (Sweet Spot)",
                "Online>Protections>Detections>Spoofed Host Token (Handicap)",
                "Online>Protections>Detections>Spoofed Host Token (Other)",

                "Online>Protections>Syncs>World Object Sync",
                "Online>Protections>Syncs>Invalid Model Sync",
                    "Online>Protections>Syncs>Incoming>Any Incoming Sync",
                    "Online>Protections>Syncs>Incoming>Clone Create",
                    "Online>Protections>Syncs>Incoming>Clone Update",
                    "Online>Protections>Syncs>Incoming>Clone Delete",
                    "Online>Protections>Syncs>Incoming>Acknowledge Clone Create",
                    "Online>Protections>Syncs>Incoming>Acknowledge Clone Update",
                    "Online>Protections>Syncs>Incoming>Acknowledge Clone Delete",

                    "Online>Protections>Syncs>Outgoing>Clone Create",
                    "Online>Protections>Syncs>Outgoing>Clone Update",
                    "Online>Protections>Syncs>Outgoing>Clone Delete",

                "Online>Protections>Text Messages>Any Message",
                "Online>Protections>Text Messages>Advertisement",
                "Online>Protections>Text Messages>Bypassed Message Filter",

                "Online>Protections>Session Script Start>Any Script",
                "Online>Protections>Session Script Start>Uncategorised",
                "Online>Protections>Session Script Start>Freemode Activity",
                "Online>Protections>Session Script Start>Arcade Game",
                "Online>Protections>Session Script Start>Removed Freemode Activity",
                "Online>Protections>Session Script Start>Session Breaking",
                "Online>Protections>Session Script Start>Service",
                "Online>Protections>Session Script Start>Open Interaction Menu",
                "Online>Protections>Session Script Start>Flight School",
                "Online>Protections>Session Script Start>Lightning Strike For Random Player",
                "Online>Protections>Session Script Start>Disable Passive Mode",
                "Online>Protections>Session Script Start>Darts",
                "Online>Protections>Session Script Start>Impromptu Deathmatch",
                "Online>Protections>Session Script Start>Slasher",
                "Online>Protections>Session Script Start>Cutscene",

                "Online>Protections>Pickups>Any Pickup Collected",
                "Online>Protections>Pickups>Cash Pickup Collected",
                "Online>Protections>Pickups>RP Pickup Collected",
                "Online>Protections>Pickups>Invalid Pickup Collected",
            }
        }

        local protections_value = {mission = {}}

        protex_root:toggle(Translations.protection_mission, {}, Translations.protection_mission_desc, function(on)
            for _, path in pairs(protections_list.mission) do
                if on then
                    protections_value.mission[path..">Block"] = menu.ref_by_path(path..">Block", Tree_V).value
                    menu.ref_by_path(path..">Block", Tree_V):applyDefaultState()
                elseif menu.ref_by_path(path..">Block", Tree_V).value == menu.ref_by_path(path..">Block", Tree_V):getDefaultState() then
                    SetPathVal(path..">Block", protections_value.mission[path..">Block"])
                end
            end
        end)

    local settings_root = main_root:list("Paramètres")

        settings_root:list_action("Langue", {}, "", just_language_files, function(index, value, click_type)
            local file = io.open(selected_lang_path, 'w')
            if file then
                file:write(value)
                file:close()
            end
            util.restart_script()
        end, selected_language)

        local settings_credits_root = settings_root:list("Credits", {}, "")

            settings_credits_root:readonly("LanceScript", "Aimbot")
            settings_credits_root:readonly("LanceScript", "Translation")
            settings_credits_root:readonly("WiriScript", "Notification")
            settings_credits_root:readonly("Hexarobi", "Auto-Update")

--===============--
-- FIN Main
--===============--

util.log("NyScript loaded in %d millis", util.current_time_millis() - scriptStartTime)