local translations = {
    language =  "French",
    missing_translations =  "[LANCESCRIPT] Certaines traductions manquent. Certaines fonctionnalités seront remplacées par leurs clés de traduction jusqu'à ce que ce problème soit résolu.",
    script_name =  "LANCESCRIPT",
    script_name_pretty =  "LanceScript",
    script_name_for_log =  "[LANCESCRIPT] ", 
    resource_dir_missing =  "ALERTE: Ressources DIR est manquante! Veuillez vous assurer que vous avez correctement installé Lancescript.",
    outdated_script_1 =  "Ce script est dépassé pour la version actuelle GTA:O (",
    outdated_script_2 =  ", codé pour",
    outdated_script_3 =  "). Certaines options peuvent ne pas fonctionner.",
    off =  "off",
    on =  "on",
    success =  "Succès",
    none =  "Aucun",

    --JOIN
    nation_us = "Anglais",
    nation_fr = "Français",
    nation_de = "Allemand",
    nation_it = "Italien",
    nation_es = "Espagnol",
    nation_br = "Brésilien",
    nation_pl = "Polonais",
    nation_ru = "Russe",
    nation_kr = "Coréen",
    nation_tw = "Chinois (T)",
    nation_jp = "Japonais",
    nation_mx = "Mexicain" ,
    nation_cn = "Chinois (S)",

    nation_notify_arg = " est ",

    --SELF
    self_root = "Moi",
    self_root_desc = "",

        self_godmode = "Godmode",
        self_godmode_desc = "Immortalité, Guérison automatique, Rester debout, Collé aux sièges, Bloqué niveau de recherche, Endurance infinie",

        self_unlimair = "Respiration infinie",
        self_unlimair_desc = "",

        self_cold_blood = "Sang-Froid",
        self_cold_blood_desc = "Supprime votre signature thermique.\nLes autres joueurs le voient encore",

        self_ninja = "Ninja",
        self_ninja_desc = "Se déplacer en silence.",

        self_ghost = "Fantôme",
        self_ghost_desc = "Invisibilité: Visible localement\nInvisible radar: On",

    --WEAPON
    weapon_root = "Armes",
    weapon_root_desc = "",

        -- aimbot
        weapon_aimbot_root =  "Aimbot silencieux",
        weapon_aimbot_root_desc =  "Un aimbot personnalisé et discret qui est loin d'être aussi visible qu'un aimbot traditionnel. (credit: LanceScript)",

            weapon_aimbot =  "Aimbot silencieux",
            weapon_aimbot_desc =  "Un aimbot personnalisé et discret qui est loin d'être aussi visible qu'un aimbot traditionnel. (credit: LanceScript)",

            weapon_aimbot_options_root = "OPTIONS",
            weapon_aimbot_options_root_desc = "",

                weapon_aimbot_options_damage = "Dégats de l'arme (%)",
                weapon_aimbot_options_damage_desc = "",

                weapon_aimbot_options_use_fov = "Utiliser FOV",
                weapon_aimbot_options_use_fov_desc = "",

                weapon_aimbot_options_fov = "FOV",
                weapon_aimbot_options_fov_desc = "Plus précis à la première personne pour de très petites valeurs FOV. Habituellement, cela n'aura pas vraiment d'importance.",

                weapon_aimbot_options_mode = "Mode",
                weapon_aimbot_options_mode_desc = "Cheat: Le départ des balles est proche de la cible.\nLegit: Le départ des balles est votre arme.",

                weapon_aimbot_options_cible = "Impact",
                weapon_aimbot_options_cible_desc = "Tire sur les differentes partie du corps",

            weapon_aimbot_players = "Cibler les Joueurs",
            weapon_aimbot_players_desc = "",

            weapon_aimbot_friends = "Cibler les Amis",
            weapon_aimbot_friends_desc = "",

            weapon_aimbot_godmode = "Ignorer les cibles invulnérable",
            weapon_aimbot_godmode_desc = "Car à quoi ça sert ?",

            weapon_aimbot_npcs = "Cibler les PNJs",
            weapon_aimbot_npcs_desc = "",

            weapon_aimbot_vehicles = "Ignorer les cibles à l'intérieur des véhicules",
            weapon_aimbot_vehicles_desc = "Si vous voulez être plus réaliste ou si vous rencontrez des problèmes pour atteindre des cibles dans les voitures",

            weapon_aimbot_display = "Afficher la cible",
            weapon_aimbot_display_desc = "Que ce soit pour dessiner ou non une balise AR sur qui votre aimbot touchera.",

            weapon_aimbot_custom_root = "Custom",
            weapon_aimbot_custom_root_desc = "Personnalise la couleur et la forme du marqueur.",

                weapon_aimbot_custom_type = "Type de marqueur:",
                weapon_aimbot_custom_type_desc = "1: Cône \n2: Un chevron vers le bas\n3: Une ligne jusqu'à la cible",

                weapon_aimbot_custom_colour_root = "Couleur du marqueur",
                weapon_aimbot_custom_colour_root_desc = "Modifie la couleur du marqueur de la cible.",
        --fin aimbot

    --ONLINE
    online_root = "En-Ligne",
    online_root_desc = "",

        -- session
        online_session_root = "Session",
        online_session_root_desc = "",

            online_session_nation_notify = "Notifie des joueurs de votre langue",
            online_session_nation_notify_desc = "Affiche une notification quand un joueur de la langue parametré rejoins la session.",

            online_session_nation_save = "Sauvegarde des joueurs de votre langue",
            online_session_nation_save_desc = "Sauvegarde les joueurs de la langue parametré quand ils rejoignent la session.(N'efface pas la note, si déjà existante pour le joueur.)",

            online_session_nation_select = "Sélectionnez votre langue",
            online_session_nation_select_desc = "Langue utilisé pour les notifications et la sauvegarde.",

    --DETECTION
    detection_root = "Détections",
    detection_root_desc = "",

        -- ped
        detection_divider_ped = "PED",

        detection_godmode = "Godmode",
        detection_godmode_desc = "Détecte si quelqu'un est en Godmode.",
        detection_godmode_draw = "%s | Godmode",

        detection_glitched_godmode = "Glitched Godmode",
        detection_glitched_godmode_desc = "Détecte si quelqu'un utilise un bug pour être Godmode.",
        detection_glitched_godmode_draw = "%s | Glitched Godmode.",

        detection_super_run = "Super course",
        detection_super_run_desc = "",
        detection_super_run_toast = "%s utilise super course.",

        detection_tp = "Teleportation",
        detection_tp_desc = "",
        detection_tp_toast = "%s c'est téléporté à %s mètres",

        detection_tp_v2 = "Teleportation (v2)",
        detection_tp_v2_desc = "",
        detection_tp_v2_toast = "%s téléporté de %s mètres",

        detection_no_clip = "Lévitation",
        detection_no_clip_desc = "Détecte si le joueur utilise noclip alias lévitation",
        detection_no_clip_toast = "%s utilise lévitation.",

        -- arme
        detection_divider_weapon = "ARME",

        detection_mod_weapon = "Arme moddé",
        detection_mod_weapon_desc = "Détecte si quelqu'un utilise une arme qui ne peut pas être obtenue en ligne.",
        detection_mod_weapon_toast1 = "%s utilise %s",
        detection_mod_weapon_toast2 = "%s utilise une arme moddé.(%s)",

        -- vehicule
        detection_divider_veh = "VEHICULE",

        detection_veh_godmode = "Vehicule Godmode",
        detection_veh_godmode_desc = "Détecte si quelqu'un utilise un véhicule en Godmode.",
        detection_veh_godmode_draw = "%s | Vehicule Godmode",

        detection_unreleased_vehicle = "Véhicule inédit",
        detection_unreleased_vehicle_desc = "Détecte si quelqu'un utilise un véhicule qui n'a pas encore été débloqué.",
        detection_unreleased_vehicle_toats = "% conduit un véhicule inédit.\n%s",
        detection_unreleased_vehicle_draw = "%s | (%s) Véhicule Inédit",

        detection_mod_veh = "Vehicle moddé",
        detection_mod_veh_desc = "Détecte si quelqu'un utilise un véhicule qui ne peut pas être obtenu en ligne.",
        detection_mod_veh_toast = "%s conduit %s un vehicule moddé.",
        detection_mod_veh_draw = "%s | (%s) Véhicule Mod",

        detection_super_drive = "Super conduite",
        detection_super_drive_desc = "",
        detection_super_drive_toast = "%s utilise super conduite.",

        -- joueur
        detection_divider_player = "JOUEUR",

        detection_spectate = "Observe",
        detection_spectate_desc = "Détecte si quelqu'un vous observe.",
        detection_spectate_toast = "%s vous observe.",

        detection_watch_you = "Observe V2",
        detection_watch_you_desc = "Détecte si quelqu'un vous regarde.",
        detection_watch_you_toast = "%s vous regarde.(V2)",

        detection_thunder_join = "Thunder Join",
        detection_thunder_join_desc = "Détecte si quelqu'un utilise Thunder Join.",
        detection_thunder_join_toast = "%s a déclenché une détection (Thunder Join) et est désormais classé comme Modder.",

        -- canon orbital
        detection_divider_orbital_cannon = "CANON ORBITAL",

        detection_mod_orbital_cannon = "Canon orbital moddé",
        detection_mod_orbital_cannon_desc = "Détecte si quelqu'un utilise un canon orbital moddé.",
        detection_mod_orbital_cannon_toast = "%s utilise un canon orbital moddé.",

        detection_orbital_canon = "Canon orbital",
        detection_orbital_canon_desc = "Détecte si quelqu'un utilise un canon orbital.",
        detection_orbital_canon_draw = "%s | Canon orbital",

    --PROTECTION
    protection_root = "Protections",
    protection_root_desc = "",

        protection_mission = "Mission",
        protection_mission_desc = "",

        -- anti-agresseurs
        protection_anti_mugger_root = "Anti-Agresseurs",
        protection_anti_mugger_root_desc = "",

            protection_anti_mugger_myself_root = "Moi-même",
            protection_anti_mugger_myself_root_desc = "Vous empêche d'être agressé.",

                protection_anti_mugger_myself_active = "Activer",
                protection_anti_mugger_myself_active_desc = "",
                protection_anti_mugger_myself_active_toast1 = "Agresseur bloqué de %s",
                protection_anti_mugger_myself_active_toast2 = "Agresseur envoyé par %s",

            protection_anti_mugger_someone_else_root = "Quelqu'un d'autre",
            protection_anti_mugger_someone_else_root_desc = "Empêche les autres d'être agressés.",

                protection_anti_mugger_someone_else_active = "Activer",
                protection_anti_mugger_someone_else_active_desc = "",
                protection_anti_mugger_someone_else_active_toast1 = "Agresseur bloqué envoyé par %s pour %s",
                protection_anti_mugger_someone_else_active_toast2 = "Agresseur envoyé par %s pour %s",

            --global
            protection_anti_mugger_divider_options = "Options",
            protection_anti_mugger_options_block = "Bloquer",
            protection_anti_mugger_options_notif = "Notification",

        -- anti-vehicule
        protection_anti_veh_root = "Anti-Vehicles",
        protection_anti_veh_root_desc = "",

            protection_anti_vehicles_active = "Activé",
            protection_anti_vehicles_active_desc = "Détruit le moteur de tous les véhicules bloqué.",
            protection_anti_vehicles_active_toast1 = "%s supprimé!",
            protection_anti_vehicles_active_toast2 = "%s moteur détruit!",

            -- gestion
            protection_anti_vehicles_divider_manage = "Gestion Anti-vehicules",

            protection_anti_vehicles_model = "Modèle de véhicule",
            protection_anti_vehicles_model_desc = "Entrez un nom de véhicule personnalisé à générer (le NOM, pas le hachage)",
            protection_anti_vehicles_model_toast1 = "Véhicule déjà bloqué!",
            protection_anti_vehicles_model_toast2 = "Véhicule bloqué!",
            protection_anti_vehicles_model_toast3 = "Véhicule inconnu!",
            protection_anti_vehicles_model_toast4 = "Valeur vide!",

            protection_anti_vehicles_save = "Sauvegarder les véhicules bloqué",
            protection_anti_vehicles_save_desc = "",

            protection_anti_vehicles_list = "Voir les véhicules bloqué",
            protection_anti_vehicles_list_desc = "",

            protection_anti_vehicles_list_delete = "supprimer",
            protection_anti_vehicles_list_delete_desc = "",

            -- options
            protection_anti_vehicles_divider_options = "Options Anti-Vehicules",

            protection_anti_vehicles_delete = "Suppression du véhicule",
            protection_anti_vehicles_delete_desc = "Les véhicles bloqué seront supprimé!",

            protection_anti_vehicles_notif = "Notification",
            protection_anti_vehicles_notif_desc = "Vous avertit de la destruction des moteurs ou des véhicules supprimés",
            
}

setmetatable(translations, {
    __index = function (self, key)
        util.log("!!! Clé introuvable dans le fichier de traduction (".. key .. "). Le script fonctionnera toujours, mais cela devrait être corrigé bientôt.")
        return key
    end
})

return translations