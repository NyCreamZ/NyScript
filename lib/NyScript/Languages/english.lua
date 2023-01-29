local translations = {
    language =  "English",
    missing_translations =  "[LANCESCRIPT] Some translations are missing. Some features will be replaced with their translation keys until this is resolved.",
    off =  "off",
    on =  "on",
    success =  "Success",
    none =  "None",
    script_name =  "LANCESCRIPT",
    script_name_pretty =  "LanceScript",
    script_name_for_log =  "[LANCESCRIPT] ", 
    resource_dir_missing =  "ALERT: resources dir is missing! Please make sure you installed Lancescript properly.",
    outdated_script_1 =  "This script is outdated for the current GTA:O version (",
    outdated_script_2 =  ", coded for ",
    outdated_script_3 =  "). Some options may not work.",
}

setmetatable(translations, {
    __index = function (self, key)
        util.log("!!! Key not found in translation file (".. key .. "). The script will still work, but this should be fixed soon.")
        return key
    end
})

return translations