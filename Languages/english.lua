local translations = {
    language =  "English",
    missing_translations =  "[LANCESCRIPT] Some translations are missing. Some features will be replaced with their translation keys until this is resolved.",
    script_name =  "LANCESCRIPT",
    script_name_pretty =  "LanceScript",
    script_name_for_log =  "[LANCESCRIPT] ", 
    resource_dir_missing =  "ALERT: resources dir is missing! Please make sure you installed Lancescript properly.",
    outdated_script_1 =  "This script is outdated for the current GTA:O version (",
    outdated_script_2 =  ", coded for ",
    outdated_script_3 =  "). Some options may not work.",
    off =  "off",
    on =  "on",
    success =  "Success",
    none =  "None",

    --JOIN
    nation_us = 'English',
    nation_fr = 'French',
    nation_de = 'German',
    nation_it = 'Italian',
    nation_es = 'Spanish',
    nation_br = 'Brazilian',
    nation_pl = 'Polish',
    nation_ru = 'Russian',
    nation_kr = 'Korean',
    nation_tw = 'Chinese (T)',
    nation_jp = 'Japanese',
    nation_mx = 'Mexican',
    nation_cn = 'Chinese (S)',

    nation_notify_arg = " is ",

    --SELF
    self_root = "Self",
    self_root_desc = "",

        self_godmode = "Godmode",
        self_godmode_desc = "Immortality, Auto Heal, Gracefulness, Glued To Seats, Lock Wanted Level, Infinite Stamina",

        self_unlimair = "Infinite breathing",
        self_unlimair_desc = "",

        self_cold_blood = "Cold blood",
        self_cold_blood_desc = "Removes your thermal signature.\nOther players still see it tho.",

        self_ninja = "Ninja",
        self_ninja_desc = "Move in silence.",

        self_ghost = "Ghost",
        self_ghost_desc = "Invisibility: locally visible\nOff The Radar: On",

    --WEAPON
    weapon_root = "Weapons",
    weapon_root_desc = "",

        -- aimbot
        weapon_aimbot_root =  "Silent aimbot",
        weapon_aimbot_root_desc =  "A custom, discreet aimbot that is nowhere as near as noticeable as a traditional one. (credit: LanceScript)",

            weapon_aimbot =  "Silent aimbot",
            weapon_aimbot_desc =  "A custom, discreet aimbot that is nowhere as near as noticeable as a traditional one. (credit: LanceScript)",

            weapon_aimbot_options_root = "OPTIONS",
            weapon_aimbot_options_root_desc = "",

                weapon_aimbot_options_damage = "Weapon damage (%)",
                weapon_aimbot_options_damage_desc = "",

                weapon_aimbot_options_use_fov = "Use FOV",
                weapon_aimbot_options_use_fov_desc = "",

                weapon_aimbot_options_fov = "FOV",
                weapon_aimbot_options_fov_desc = "Most accurate in first-person for really small FOV values. Usually it won't really matter though.",

                weapon_aimbot_options_mode = "Mode",
                weapon_aimbot_options_mode_desc = "Cheat: Bullet launch is close to the target.\nLegit: Bullet launch is your weapon.",

                weapon_aimbot_options_cible = "Impact",
                weapon_aimbot_options_cible_desc = "Pull on different parts of the body",

            weapon_aimbot_players = "Target Players",
            weapon_aimbot_players_desc = "",

            weapon_aimbot_friends = "Target Friends",
            weapon_aimbot_friends_desc = "",

            weapon_aimbot_godmode = "Ignore godmoded targets",
            weapon_aimbot_godmode_desc = "Because what's the point?",

            weapon_aimbot_npcs = "Target NPC's",
            weapon_aimbot_npcs_desc = "",

            weapon_aimbot_vehicles = "Ignore targets inside vehicles",
            weapon_aimbot_vehicles_desc = "If you want to be more realistic or are having issues hitting targets in cars",

            weapon_aimbot_display = "Display target",
            weapon_aimbot_display_desc = "Whether or not to draw an AR beacon on who your aimbot will hit.",

            weapon_aimbot_custom_root = "Custom",
            weapon_aimbot_custom_root_desc = "Custom the color and shape of the marker.",

                weapon_aimbot_custom_type = "Marker Type:",
                weapon_aimbot_custom_type_desc = "1: Arrow above the target\n2: A line to the target",

                weapon_aimbot_custom_colour_root = "Color marker",
                weapon_aimbot_custom_colour_root_desc = "Change the color of the target marker.",
        --fin aimbot

    --ONLINE
    online_root = "Online",
    online_root_desc = "",

        -- session
        online_session_root = "Session",
        online_session_root_desc = "",

            online_session_nation_notify = "Notify players of your language",
            online_session_nation_notify_desc = "Display a notification when a player of the configured language joins the session.",

            online_session_nation_save = "Saving players of your language",
            online_session_nation_save_desc = "Saves players of the set language when they join the session. (Does not delete the note, if already exists for the player.)",

            online_session_nation_select = "Select your language",
            online_session_nation_select_desc = "Language used for notifications and backup.",

    --DETECTION
    detection_root = "Detections",
    detection_root_desc = "",

        -- ped
        detection_divider_ped = "PED",

        detection_godmode = "Godmode",
        detection_godmode_desc = "Detects if someone is using Godmode.",
        detection_godmode_draw = "%s | Godmode",

        detection_glitched_godmode = "Glitched Godmode",
        detection_glitched_godmode_desc = "Detects if someone is using a glitch to obtain godmode.",
        detection_glitched_godmode_draw = "%s | Glitched Godmode.",

        detection_super_run = "Super Run",
        detection_super_run_desc = "",
        detection_super_run_toast = "%s is using super run.",

        detection_tp = "Teleport",
        detection_tp_desc = "",
        detection_tp_toast = "%s is teleported %s Meters",

        detection_tp_v2 = "Teleport (v2)",
        detection_tp_v2_desc = "",
        detection_tp_v2_toast = "%s teleported of %s meters",

        detection_no_clip = "No Clip",
        detection_no_clip_desc = "Detects if the player is using noclip aka levitation",
        detection_no_clip_toast = "%s is using NoClip.",

        -- weapon
        detection_divider_weapon = "WEAPON",

        detection_mod_weapon = "Modded Weapon",
        detection_mod_weapon_desc = "Detects if someone is using a weapon that can not be obtained in online.",
        detection_mod_weapon_toast1 = "%s use the %s",
        detection_mod_weapon_toast2 = "%s is using a modded weapon.(%s)",

        -- vehicle
        detection_divider_veh = "VEHICLE",

        detection_veh_godmode = "Vehicle Godmode",
        detection_veh_godmode_desc = "Detects if someone is using a vehicle that is in godmode.",
        detection_veh_godmode_draw = "%s | Vehicle Godmode",

        detection_unreleased_vehicle = "Unreleased Vehicle",
        detection_unreleased_vehicle_desc = "Detects if someone is using a vehicle that has not been released yet.",
        detection_unreleased_vehicle_toats = "%s driving an unreleased vehicle.\n%s",
        detection_unreleased_vehicle_draw = "%s | (%s) Unreleased vehicle",

        detection_mod_veh = "Modded Vehicle",
        detection_mod_veh_desc = "Detects if someone is using a vehicle that can not be obtained in online.",
        detection_mod_veh_toast = "%s is driving %s a modded vehicle.",
        detection_mod_veh_draw = "%s | (%s) Mod Vehicle",

        detection_super_drive = "Super Drive",
        detection_super_drive_desc = "",
        detection_super_drive_toast = "%s is using super drive.",

        -- player
        detection_divider_player = "PLAYER",

        detection_spectate = "Spectate",
        detection_spectate_desc = "Detects if someone is spectating you.",
        detection_spectate_toast = "%s is spectating you.",

        detection_watch_you = "Spectate V2",
        detection_watch_you_desc = "Detects if someone is watching you.",
        detection_watch_you_toast = "%s is watching you.(V2)",

        detection_thunder_join = "Thunder Join",
        detection_thunder_join_desc = "Detects if someone is using thunder join.",
        detection_thunder_join_toast = "%s triggered a detection (Thunder Join) and is now classified as a Modder.",

        -- orbital cannon
        detection_divider_orbital_cannon = "ORBITAL CANNON",

        detection_mod_orbital_cannon = "Modded Orbital Cannon",
        detection_mod_orbital_cannon_desc = "Detects if someone is using a modded orbital cannon.",
        detection_mod_orbital_cannon_toast = "%s is using a modded orbital cannon.",

        detection_orbital_canon = "Orbital Cannon",
        detection_orbital_canon_desc = "Detects if someone is using an orbital cannon.",
        detection_orbital_canon_draw = "%s | Orbital cannon.",

    --PROTECTION
    protection_root = "Protections",
    protection_root_desc = "",

        protection_mission = "Mission",
        protection_mission_desc = "",

        -- anti-muggers
        protection_anti_mugger_root = "Anti-Muggers",
        protection_anti_mugger_root_desc = "",

            protection_anti_mugger_myself_root = "Myself",
            protection_anti_mugger_myself_root_desc = "Prevents you from being mugged.",

                protection_anti_mugger_myself_active = "Active",
                protection_anti_mugger_myself_active_desc = "",
                protection_anti_mugger_myself_active_toast = "Blocked mugger from %s",
                protection_anti_mugger_myself_active_toast2 = "Mugger send by %s",

            protection_anti_mugger_someone_else_root = "Someone Else",
            protection_anti_mugger_someone_else_root_desc = "Prevents others from being mugged.",

                protection_anti_mugger_someone_else_active = "Active",
                protection_anti_mugger_someone_else_active_desc = "",
                protection_anti_mugger_someone_else_active_toast1 = "Blocked mugger sent by %s to %s",
                protection_anti_mugger_someone_else_active_toast2 = "Mugger sent by %s to %s",

            --global
            protection_anti_mugger_divider_options = "Options",
            protection_anti_mugger_options_block = "Bloquer",
            protection_anti_mugger_options_notif = "Notification",

        -- anti-vehicule
        protection_anti_veh_root = "Anti-Vehicles",
        protection_anti_veh_root_desc = "",

            protection_anti_vehicles_active = "Active",
            protection_anti_vehicles_active_desc = "Kill engine of all stuck vehicles.",
            protection_anti_vehicles_active_toast1 = "%s removed!",
            protection_anti_vehicles_active_toast2 = "%s kill engine!",

            -- manage
            protection_anti_vehicles_divider_manage = "Manage Anti-vehicles",

            protection_anti_vehicles_model = "Vehicle model",
            protection_anti_vehicles_model_desc = "Enter a custom vehicle name to generate (the NAME, not the hash)",
            protection_anti_vehicles_model_toast1 = "Vehicle already blocked!",
            protection_anti_vehicles_model_toast2 = "Vehicle blocked!",
            protection_anti_vehicles_model_toast3 = "Unknown vehicle!",
            protection_anti_vehicles_model_toast4 = "Empty value!",

            protection_anti_vehicles_save = "Save blocked vehicles",
            protection_anti_vehicles_save_desc = "",

            protection_anti_vehicles_list = "List blocked vehicles",
            protection_anti_vehicles_list_desc = "",

            protection_anti_vehicles_list_delete = "remove",
            protection_anti_vehicles_list_delete_desc = "",

            -- options
            protection_anti_vehicles_divider_options = "Options Anti-Vehicles",

            protection_anti_vehicles_delete = "Remove vehicles",
            protection_anti_vehicles_delete_desc = "Blocked vehicles will be removed!",

            protection_anti_vehicles_notif = "Notification",
            protection_anti_vehicles_notif_desc = "Warns you of the kill engines or remove vehicles",
            
}

setmetatable(translations, {
    __index = function (self, key)
        util.log("!!! Key not found in translation file (".. key .. "). The script will still work, but this should be fixed soon.")
        return key
    end
})

return translations