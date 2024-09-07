$mozillaCfgUrl = "https://codeberg.org/celenity/Phoenix/raw/branch/main/mozilla.cfg"
$localSettingsJsUrl = "https://codeberg.org/celenity/Phoenix/raw/branch/main/defaults/pref/local-settings.js"
$mozillaCfgPath = "C:\Program Files\Mozilla Firefox\mozilla.cfg"
$localSettingsJsPath = "C:\Program Files\Mozilla Firefox\defaults\pref\local-settings.js"


Invoke-WebRequest -Uri $mozillaCfgUrl -OutFile $mozillaCfgPath

$defaultsPrefDir = "C:\Program Files\Mozilla Firefox\defaults\pref"
if (-not (Test-Path -Path $defaultsPrefDir)) {
    New-Item -ItemType Directory -Path $defaultsPrefDir -Force
}

Invoke-WebRequest -Uri $localSettingsJsUrl -OutFile $localSettingsJsPath

choco upgrade all -y

choco install phoenix-policies -y

printf "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can grab them from here https://codeberg.org/Magnesium1062/Phoenix/src/branch/main/configs. Just drag the user.js under the config of your choice to your profile directory, and enjoy.\n"