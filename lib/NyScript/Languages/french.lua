local translations = {
    language =  "French",
    missing_translations =  "[LANCESCRIPT] Certaines traductions manquent. Certaines fonctionnalités seront remplacées par leurs clés de traduction jusqu'à ce que ce problème soit résolu.",
    off =  "off",
    on =  "on",
    success =  "Succès",
    none =  "Aucun",
    script_name =  "LANCESCRIPT",
    script_name_pretty =  "LanceScript",
    script_name_for_log =  "[LANCESCRIPT] ", 
    resource_dir_missing =  "ALERTE: Ressources DIR est manquante! Veuillez vous assurer que vous avez correctement installé Lancescript.",
    outdated_script_1 =  "Ce script est dépassé pour la version actuelle GTA:O (",
    outdated_script_2 =  ", codé pour",
    outdated_script_3 =  "). Certaines options peuvent ne pas fonctionner.",
}

setmetatable(translations, {
    __index = function (self, key)
        util.log("!!! Clé introuvable dans le fichier de traduction (".. key .. "). Le script fonctionnera toujours, mais cela devrait être corrigé bientôt.")
        return key
    end
})

return translations