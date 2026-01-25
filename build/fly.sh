#!/bin/bash

set -euo pipefail

echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo_red_text -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo_red_text -e "\033[31mPlease report this (with the output message) to https://phoenix.celenity.dev/issues\033[0m"
	echo
	exit 1
}

# Welcome to the Phoenix Unified build script!
# This script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

# Include version info
source "${PHOENIX_VERSIONS}" || error_fn
echo

mkdir -vp "${PHOENIX_TEMP}/policies" || error_fn
echo

PHOENIX_LICENSE="${PHOENIX_ROOT}/COPYING.txt"
PHOENIX_README="${PHOENIX_ROOT}/README.md"

PHOENIX_UNIFIED_PREFS="${PHOENIX_BUILD}/phoenix-unified.js"

PHOENIX_ANDROID_PREFS="${PHOENIX_ANDROID_DIR}/phoenix.js"
PHOENIX_LINUX_FLATPAK_PREFS="${PHOENIX_LINUX_FLATPAK_DIR}/defaults/pref/phoenix-desktop.js"
PHOENIX_LINUX_PREFS="${PHOENIX_LINUX_DIR}/defaults/pref/phoenix-desktop.js"
PHOENIX_OSX_INTEL_PREFS="${PHOENIX_UNUSED}/macos-intel/phoenix.js"
PHOENIX_OSX_PREFS="${PHOENIX_UNUSED}/macos/phoenix.js"
PHOENIX_WINDOWS_PREFS="${PHOENIX_UNUSED}/windows/phoenix.js"

PHOENIX_BOOTSTRAP="${PHOENIX_BUILD}/phoenix-bootstrap.js"

PHOENIX_OSX_BOOTSTRAP="${PHOENIX_OSX_DIR}/defaults/pref/phoenix.js"
PHOENIX_OSX_INTEL_BOOTSTRAP="${PHOENIX_OSX_INTEL_DIR}/defaults/pref/phoenix.js"
PHOENIX_WINDOWS_BOOTSTRAP="${PHOENIX_WINDOWS_DIR}/defaults/pref/phoenix.js"

PHOENIX_USER_PREF_CFG="${PHOENIX_BUILD}/phoenix-user-pref.cfg"

PHOENIX_LINUX_FLATPAK_USER_PREF_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/phoenix.cfg"
PHOENIX_LINUX_USER_PREF_CFG="${PHOENIX_LINUX_DIR}/phoenix.cfg"

PHOENIX_LINUX_CFG="${PHOENIX_UNUSED}/linux/phoenix.cfg"
PHOENIX_LINUX_FLATPAK_CFG="${PHOENIX_UNUSED}/linux-flatpak/phoenix.cfg"
PHOENIX_OSX_CFG="${PHOENIX_OSX_DIR}/macos/phoenix.cfg"
PHOENIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/phoenix.cfg"
PHOENIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/phoenix.cfg"

PHOENIX_EXTENDED_UNIFIED_PREFS="${PHOENIX_BUILD}/phoenix-extended-unified.js"

PHOENIX_EXTENDED_ANDROID_PREFS="${PHOENIX_ANDROID_DIR}/phoenix-extended.js"
PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS="${PHOENIX_UNUSED}/linux-flatpak/phoenix-extended.js"
PHOENIX_EXTENDED_LINUX_PREFS="${PHOENIX_UNUSED}/linux/phoenix-extended.js"
PHOENIX_EXTENDED_OSX_INTEL_PREFS="${PHOENIX_UNUSED}/macos-intel/phoenix-extended.js"
PHOENIX_EXTENDED_OSX_PREFS="${PHOENIX_UNUSED}/macos/phoenix-extended.js"
PHOENIX_EXTENDED_WINDOWS_PREFS="${PHOENIX_UNUSED}/windows/phoenix-extended.js"

PHOENIX_EXTENDED_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_OSX_CFG="${PHOENIX_OSX_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/extended.cfg"
PHOENIX_EXTENDED_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/hardened.cfg"

PHOENIX_SPECIALIZED_UNIFIED_CFG="${PHOENIX_BUILD}/specialized-configs/specialized-unified.cfg"

PHOENIX_EXTENDED_UNIFIED_CFG="${PHOENIX_BUILD}/specialized-configs/extended-unified.cfg"

PHOENIX_SPECIALIZED_CFG="${PHOENIX_UNUSED}/configs/specialized.cfg"

PHOENIX_SPECIALIZED_UNIFIED_APPLE_MAPS_CFG="${PHOENIX_BUILD}/specialized-configs/apple-maps-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_DISCORD_CFG="${PHOENIX_BUILD}/specialized-configs/discord-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_ELEMENT_CFG="${PHOENIX_BUILD}/specialized-configs/element-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_GOOGLE_MAPS_CFG="${PHOENIX_BUILD}/specialized-configs/google-maps-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_PHOTOPEA_CFG="${PHOENIX_BUILD}/specialized-configs/photopea-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_TWITTER_CFG="${PHOENIX_BUILD}/specialized-configs/twitter-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_CFG="${PHOENIX_BUILD}/specialized-configs/youtube-unified.cfg"
PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_MUSIC_CFG="${PHOENIX_BUILD}/specialized-configs/youtube-music-unified.cfg"

PHOENIX_SPECIALIZED_APPLE_MAPS_CFG="${PHOENIX_UNUSED}/configs/apple-maps.cfg"
PHOENIX_SPECIALIZED_DISCORD_CFG="${PHOENIX_UNUSED}/configs/discord.cfg"
PHOENIX_SPECIALIZED_ELEMENT_CFG="${PHOENIX_UNUSED}/configs/element.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG="${PHOENIX_UNUSED}/configs/google-maps.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_CFG="${PHOENIX_UNUSED}/configs/photopea.cfg"
PHOENIX_SPECIALIZED_TWITTER_CFG="${PHOENIX_UNUSED}/configs/twitter.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_CFG="${PHOENIX_UNUSED}/configs/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG="${PHOENIX_UNUSED}/configs/youtube-music.cfg"

PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG="${PHOENIX_OSX_DIR}/configs/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/apple-maps.cfg"

PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_OSX_CFG="${PHOENIX_OSX_DIR}/configs/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/discord.cfg"

PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG="${PHOENIX_OSX_DIR}/configs/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/element.cfg"

PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG="${PHOENIX_OSX_DIR}/configs/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/google-maps.cfg"

PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG="${PHOENIX_OSX_DIR}/configs/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/photopea.cfg"

PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_OSX_CFG="${PHOENIX_OSX_DIR}/configs/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/twitter.cfg"

PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG="${PHOENIX_OSX_DIR}/configs/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/youtube.cfg"

PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG="${PHOENIX_OSX_DIR}/configs/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/youtube-music.cfg"

PHOENIX_UI_FIX_UNIFIED_CFG="${PHOENIX_BUILD}/specialized-configs/ui-fix-unified.cfg"

PHOENIX_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix.cfg"
PHOENIX_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix.cfg"
PHOENIX_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix.cfg"
PHOENIX_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix.cfg"
PHOENIX_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix.cfg"

PHOENIX_EXTENDED_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/hardened.cfg"
PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/hardened.cfg"
PHOENIX_EXTENDED_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/hardened.cfg"
PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/hardened.cfg"
PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/hardened.cfg"

PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/apple-maps.cfg"
PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/apple-maps.cfg"

PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/discord.cfg"
PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/discord.cfg"

PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/element.cfg"
PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/element.cfg"

PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/google-maps.cfg"
PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/google-maps.cfg"

PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/photopea.cfg"
PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/photopea.cfg"

PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/twitter.cfg"
PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/twitter.cfg"

PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/youtube.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/youtube.cfg"

PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/ui-fix/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG="${PHOENIX_OSX_DIR}/configs/ui-fix/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix/youtube-music.cfg"
PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/ui-fix/youtube-music.cfg"

PHOENIX_UNIFIED_POLICIES="${PHOENIX_BUILD}/policies/phoenix-unified.json"
PHOENIX_ONLY_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only.json"

PHOENIX_BLOCKLIST_POLICIES="${PHOENIX_BUILD}/policies/blocklist.json"
PHOENIX_COOKIES_POLICIES="${PHOENIX_BUILD}/policies/cookies.json"

PHOENIX_ONLY_LINUX_FLATPAK_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-linux-flatpak.json"
PHOENIX_ONLY_LINUX_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-linux.json"
PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-linux-non-flatpak.json"
PHOENIX_ONLY_OSX_INTEL_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-osx-intel.json"
PHOENIX_ONLY_OSX_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-osx.json"
PHOENIX_ONLY_OSX_SILICON_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-osx-silicon.json"
PHOENIX_ONLY_WINDOWS_POLICIES="${PHOENIX_BUILD}/policies/phoenix-only-windows.json"

PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES="${PHOENIX_BUILD}/policies/phoenix-linux-flatpak-unified.json"
PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES="${PHOENIX_BUILD}/policies/phoenix-linux-non-flatpak-unified.json"
PHOENIX_UNIFIED_LINUX_POLICIES="${PHOENIX_BUILD}/policies/phoenix-linux-unified.json"
PHOENIX_UNIFIED_OSX_INTEL_POLICIES="${PHOENIX_BUILD}/policies/phoenix-osx-intel-unified.json"
PHOENIX_UNIFIED_OSX_POLICIES="${PHOENIX_BUILD}/policies/phoenix-osx-unified.json"
PHOENIX_UNIFIED_OSX_SILICON_POLICIES="${PHOENIX_BUILD}/policies/phoenix-osx-silicon-unified.json"
PHOENIX_UNIFIED_WINDOWS_POLICIES="${PHOENIX_BUILD}/policies/phoenix-windows-unified.json"

PHOENIX_POLICIES="${PHOENIX_UNUSED}/policies/phoenix.json"

PHOENIX_LINUX_POLICIES="${PHOENIX_LINUX_DIR}/policies/policies.json"
PHOENIX_LINUX_FLATPAK_POLICIES="${PHOENIX_LINUX_FLATPAK_DIR}/policies/policies.json"
PHOENIX_WINDOWS_POLICIES="${PHOENIX_WINDOWS_DIR}/distribution/policies.json"

PHOENIX_OSX_INTEL_POLICIES_JSON="${PHOENIX_UNUSED}/macos-intel/policies.json"
PHOENIX_OSX_INTEL_POLICIES_PLIST="${PHOENIX_OSX_INTEL_DIR}/org.mozilla.firefox.plist"
PHOENIX_OSX_POLICIES_JSON="${PHOENIX_UNUSED}/macos/policies.json"
PHOENIX_OSX_POLICIES_PLIST="${PHOENIX_OSX_DIR}/macos/org.mozilla.firefox.plist"

# ANDROID
if [ "${PHOENIX_ANDROID}" == 1 ]; then
    echo_green_text 'Building Phoenix for Android...'
    mkdir -vp "${PHOENIX_ANDROID_DIR}" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_ANDROID_DIR}/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_ANDROID_PREFS}"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_ANDROID_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_ANDROID_PREFS}"

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_ANDROID_PREFS}" || error_fn
    echo
fi

# GNU/LINUX
if [ "${PHOENIX_LINUX}" == 1 ]; then
    echo_green_text 'Building Phoenix for Linux...'
    mkdir -vp "${PHOENIX_LINUX_DIR}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/etc/profile.d" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/policies" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_BUILD}/linux/COPYING.txt" "${PHOENIX_LINUX_DIR}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_BUILD}/linux/README.md" "${PHOENIX_LINUX_DIR}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD}/assets/about/attribution.css" "${PHOENIX_LINUX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/attribution.html" "${PHOENIX_LINUX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.css" "${PHOENIX_LINUX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.html" "${PHOENIX_LINUX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/phoenix.png" "${PHOENIX_LINUX_DIR}/assets/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_LINUX_DIR}/assets/" || error_fn
    echo

    # Copy environment variables
    cp "${PHOENIX_BUILD}/linux/etc/profile.d/phoenix-env-overrides.sh" "${PHOENIX_LINUX_DIR}/etc/profile.d/phoenix-env-overrides.sh" || error_fn
    echo

    # Copy specialized config default permission files
    mkdir -vp "${PHOENIX_LINUX_DIR}/resources/specs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/resources/specs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/resources/specs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/resources/specs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/resources/specs/twitter" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/resources/specs" "${PHOENIX_LINUX_DIR}/resources/" || error_fn
    echo

    # Copy specialized config user.js files
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/extended" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/photopea" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/twitter" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/extended" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/photopea" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/twitter" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/youtube" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix/youtube-music" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/ui-fix-base" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/youtube" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/youtube-music" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/linux/userjs" "${PHOENIX_LINUX_DIR}/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_LINUX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_LINUX_PREFS}" "${PHOENIX_LINUX_CFG}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_LINUX_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_LINUX_PREFS}" "${PHOENIX_EXTENDED_LINUX_CFG}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo
fi

# GNU/LINUX (FLATPAK)
if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Phoenix for Linux (Flatpak)...'
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/policies" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_README}" "${PHOENIX_LINUX_FLATPAK_DIR}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD}/assets/about/attribution.css" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/attribution.html" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.css" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.html" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/phoenix.png" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_LINUX_FLATPAK_DIR}/assets/" || error_fn
    echo

    # Copy specialized config default permission files
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/resources/specs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/resources/specs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/resources/specs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/resources/specs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_DIR}/resources/specs/twitter" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/resources/specs" "${PHOENIX_LINUX_FLATPAK_DIR}/resources/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_FLATPAK_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_LINUX_FLATPAK_CFG}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
fi

# MACOS
if [ "${PHOENIX_OSX}" == 1 ]; then
    echo_green_text 'Building Phoenix for OS X...'
    mkdir -vp "${PHOENIX_OSX_DIR}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/policies" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_OSX_DIR}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_README}" "${PHOENIX_OSX_DIR}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD}/assets/about/attribution.css" "${PHOENIX_OSX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/attribution.html" "${PHOENIX_OSX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.css" "${PHOENIX_OSX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.html" "${PHOENIX_OSX_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/phoenix.png" "${PHOENIX_OSX_DIR}/assets/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_OSX_DIR}/assets/" || error_fn
    echo

    # Copy specialized config default permission files
    mkdir -vp "${PHOENIX_OSX_DIR}/resources/specs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/resources/specs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/resources/specs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/resources/specs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_DIR}/resources/specs/twitter" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/resources/specs" "${PHOENIX_OSX_DIR}/resources/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_OSX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_OSX_PREFS}" "${PHOENIX_TEMP}/phoenix-osx-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${PHOENIX_TEMP}/phoenix-osx-tmp.cfg" "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_CFG}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_OSX_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_OSX_PREFS}" "${PHOENIX_EXTENDED_OSX_CFG}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_PREFS}" || error_fn
    echo
fi

# MACOS (INTEL)
if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Phoenix for OS X (Intel)...'
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/policies" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_README}" "${PHOENIX_OSX_INTEL_DIR}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD}/assets/about/attribution.css" "${PHOENIX_OSX_INTEL_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/attribution.html" "${PHOENIX_OSX_INTEL_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.css" "${PHOENIX_OSX_INTEL_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.html" "${PHOENIX_OSX_INTEL_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/phoenix.png" "${PHOENIX_OSX_INTEL_DIR}/assets/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_OSX_INTEL_DIR}/assets/" || error_fn
    echo

    # Copy specialized config default permission files
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/resources/specs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/resources/specs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/resources/specs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/resources/specs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_DIR}/resources/specs/twitter" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/resources/specs" "${PHOENIX_OSX_INTEL_DIR}/resources/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_TEMP}/phoenix-osx-intel-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${PHOENIX_TEMP}/phoenix-osx-intel-tmp.cfg" "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_INTEL_CFG}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_OSX_INTEL_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo
fi

# WINDOWS
if [ "${PHOENIX_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Phoenix for Windows...'
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/policies" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_WINDOWS_DIR}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_README}" "${PHOENIX_WINDOWS_DIR}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD}/assets/about/attribution.css" "${PHOENIX_WINDOWS_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/attribution.html" "${PHOENIX_WINDOWS_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.css" "${PHOENIX_WINDOWS_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/about/phoenix.html" "${PHOENIX_WINDOWS_DIR}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/phoenix.png" "${PHOENIX_WINDOWS_DIR}/assets/" || error_fn
    echo
    cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_WINDOWS_DIR}/assets/" || error_fn
    echo

    # Copy specialized config default permission files
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/resources/specs/apple-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/resources/specs/discord" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/resources/specs/element" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/resources/specs/google-maps" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_DIR}/resources/specs/twitter" || error_fn
    echo

    cp -vrf "${PHOENIX_BUILD}/resources/specs" "${PHOENIX_WINDOWS_DIR}/resources/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_BOOTSTRAP}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_TEMP}/phoenix-windows-tmp.cfg" || error_fn
    echo

    # Add "user" prefs
    cat "${PHOENIX_TEMP}/phoenix-windows-tmp.cfg" "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_WINDOWS_CFG}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_EXTENDED_WINDOWS_PREFS}"

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" "${PHOENIX_EXTENDED_WINDOWS_CFG}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_WINDOWS_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo
fi

# SPECIALIZED CONFIGS
if [ "${PHOENIX_SPECS}" == 1 ]; then

    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_UNIFIED_PREFS}" "${PHOENIX_EXTENDED_UNIFIED_CFG}" || error_fn
    echo

    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" || error_fn
    echo
    cat "${PHOENIX_EXTENDED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_CFG}" "${PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" || error_fn
    echo

    # GNU/LINUX
    if [ "${PHOENIX_LINUX}" == 1 ]; then
        echo_green_text 'Building Phoenix specialized configs for Linux...'

        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG}"

        # UI FIX

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "${PHOENIX_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_UI_FIX_LINUX_CFG}"

        cat "$PHOENIX_EXTENDED_LINUX_CFG" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_EXTENDED_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG}" "${PHOENIX_UI_FIX_LINUX_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG}" || error_fn
        echo

        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_UI_FIX_LINUX_CFG}" || error_fn
        echo
    fi

    # GNU/LINUX (FLATPAK)
    if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
        echo_green_text 'Building Phoenix specialized configs for Linux (Flatpak)...'

        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG}"

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG}"

        # UI FIX

        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG}" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG}" || error_fn
        echo

        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_UI_FIX_LINUX_FLATPAK_CFG}" || error_fn
        echo
    fi

    # MACOS
    if [ "${PHOENIX_OSX}" == 1 ]; then
        echo_green_text 'Building Phoenix specialized configs for OS X...'

        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY] and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG}"

        # UI FIX

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "${PHOENIX_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_EXTENDED_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_EXTENDED_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_DISCORD_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_TWITTER_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG}" "${PHOENIX_UI_FIX_OSX_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG}" || error_fn
        echo

        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_UI_FIX_OSX_CFG}" || error_fn
        echo
    fi

    # MACOS (INTEL)
    if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
        echo_green_text 'Building Phoenix specialized configs for OS X (Intel)...'

        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG}"

        # UI FIX

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG}" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG}" || error_fn
        echo

        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_UI_FIX_OSX_INTEL_CFG}" || error_fn
        echo
    fi

    # WINDOWS
    if [ "${PHOENIX_WINDOWS}" == 1 ]; then
        echo_green_text 'Building Phoenix specialized configs for Windows...'

        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY],
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_APPLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_DISCORD_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_ELEMENT_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_PHOTOPEA_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_TWITTER_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG}"

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG}"

        # UI FIX

        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "${PHOENIX_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_EXTENDED_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_TWITTER_OSX_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG}"

        cat "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG}" "${PHOENIX_UI_FIX_WINDOWS_CFG}" > "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        echo "Created ${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG}" || error_fn
        echo

        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_UI_FIX_WINDOWS_CFG}" || error_fn
        echo
    fi

fi

# POLICIES
jq -s '.[0] * .[1]' "${PHOENIX_UNIFIED_POLICIES}" "${PHOENIX_BLOCKLIST_POLICIES}" > "${PHOENIX_TEMP}/policies/temp1.json" || error_fn
echo
jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp1.json" "${PHOENIX_COOKIES_POLICIES}" > "${PHOENIX_TEMP}/policies/temp2.json" || error_fn
echo
jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp2.json" "${PHOENIX_ONLY_POLICIES}" > "${PHOENIX_POLICIES}" || error_fn
echo

# (This is used by both Linux and Flatpak)
if [ "${PHOENIX_LINUX}" == 1 ] || [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp3.json" || error_fn
    echo
fi

if [ "${PHOENIX_LINUX}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Linux...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies//temp6.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp6.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp7.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp7.json" "${PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES}" > "${PHOENIX_LINUX_POLICIES}" || error_fn
    echo
fi

if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Linux (Flatpak)...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp4.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp4.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp5.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp5.json" "${PHOENIX_ONLY_LINUX_FLATPAK_POLICIES}" > "${PHOENIX_LINUX_FLATPAK_POLICIES}" || error_fn
    echo
fi

# (This is used by both OS X and OS X Intel)
if [ "${PHOENIX_OSX}" == 1 ] || [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp8.json" || error_fn
    echo
fi

if [ "${PHOENIX_OSX}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for OS X...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp8.json" "${PHOENIX_UNIFIED_OSX_SILICON_POLICIES}" > "${PHOENIX_TEMP}/policies/temp9.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp9.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp10.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp10.json" "${PHOENIX_ONLY_OSX_SILICON_POLICIES}" > "${PHOENIX_OSX_POLICIES_JSON}" || error_fn
    echo
    python3 "${PHOENIX_BUILD}/convert_json_to_plist.py" "${PHOENIX_OSX_POLICIES_JSON}" "${PHOENIX_OSX_POLICIES_PLIST}" || error_fn
    echo
fi

if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for OS X (Intel)...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp8.json" "${PHOENIX_UNIFIED_OSX_INTEL_POLICIES}" > "${PHOENIX_TEMP}/policies/temp11.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp11.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp12.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp12.json" "${PHOENIX_ONLY_OSX_INTEL_POLICIES}" > "${PHOENIX_OSX_INTEL_POLICIES_JSON}" || error_fn
    echo
    python3 "${PHOENIX_BUILD}/convert_json_to_plist.py" "${PHOENIX_OSX_INTEL_POLICIES_JSON}" "${PHOENIX_OSX_INTEL_POLICIES_PLIST}" || error_fn
    echo
fi

if [ "${PHOENIX_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Windows...'

    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_WINDOWS_POLICIES}" > "${PHOENIX_TEMP}/policies/temp13.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp13.json" "${PHOENIX_ONLY_WINDOWS_POLICIES}" > "${PHOENIX_WINDOWS_POLICIES}" || error_fn
    echo
fi

rm -rf "${PHOENIX_TEMP}/" || error_fn
echo
