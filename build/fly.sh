#!/bin/bash

set -euo pipefail

# Functions
function echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

function echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

function error_fn() {
	echo
	echo_red_text "Something went wrong! The script failed."
	echo_red_text "Please report this (with the output message) to https://phoenix.celenity.dev/issues"
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

if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_CFG_FILE}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_CFG is set, but \$PHOENIX_EXTRA_CFG_FILE is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_CFG_OUTPUT_DIR}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_CFG is set, but \$PHOENIX_EXTRA_CFG_OUTPUT_DIR is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_CFG_OUTPUT_DIR}"
fi

if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_PREFS_JS_FILE}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_PREFS_JS is set, but \$PHOENIX_EXTRA_PREFS_JS_FILE is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_PREFS_JS is set, but \$PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}"
fi

if [ "${PHOENIX_EXTRA_POLICIES}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES is set, but \$PHOENIX_EXTRA_POLICIES_FILE is not set! Aborting..."
        exit 1
    fi
fi

if [ "${PHOENIX_EXTRA_POLICIES_ANDROID}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_ANDROID}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_ANDROID is set, but \$PHOENIX_EXTRA_POLICIES_FILE_ANDROID is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_ANDROID is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID}"
fi

if [ "${PHOENIX_EXTRA_POLICIES_OSX}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_OSX}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_OSX is set, but \$PHOENIX_EXTRA_POLICIES_FILE_OSX is not set! Aborting..."
        exit 1
    fi
fi

if [ "${PHOENIX_EXTRA_POLICIES_OSX_SILICON}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_OSX_SILICON}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_OSX_SILICON is set, but \$PHOENIX_EXTRA_POLICIES_FILE_OSX_SILICON is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICO}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_OSX_SILICON is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}"
fi

if [ "${PHOENIX_EXTRA_POLICIES_OSX_INTEL}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_OSX_INTEL}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_OSX_INTEL is set, but \$PHOENIX_EXTRA_POLICIES_FILE_OSX_INTEL is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_OSX_INTEL is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}"
fi

if [ "${PHOENIX_EXTRA_POLICIES_WINDOWS}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_WINDOWS}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_WINDOWS is set, but \$PHOENIX_EXTRA_POLICIES_FILE_WINDOWS is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_WINDOWS is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS}"
fi

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

PHOENIX_ANDROID_USER_PREF_CFG="${PHOENIX_UNUSED}/android/phoenix-user-pref.cfg"
PHOENIX_LINUX_FLATPAK_USER_PREF_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/phoenix.cfg"
PHOENIX_LINUX_USER_PREF_CFG="${PHOENIX_LINUX_DIR}/phoenix.cfg"
PHOENIX_OSX_USER_PREF_CFG="${PHOENIX_UNUSED}/macos/phoenix-user-pref.cfg"
PHOENIX_OSX_INTEL_USER_PREF_CFG="${PHOENIX_UNUSED}/macos-intel/phoenix-user-pref.cfg"
PHOENIX_WINDOWS_USER_PREF_CFG="${PHOENIX_UNUSED}/windows/phoenix-user-pref.cfg"

PHOENIX_ANDROID_CFG="${PHOENIX_ANDROID_DIR}/phoenix.cfg"
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

PHOENIX_PLUS_EXTENDED_ANDROID_PREFS="${PHOENIX_ANDROID_DIR}/phoenix-plus-extended.js"
PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_PREFS="${PHOENIX_UNUSED}/linux-flatpak/phoenix-plus-extended.js"
PHOENIX_PLUS_EXTENDED_LINUX_PREFS="${PHOENIX_UNUSED}/linux/phoenix-plus-extended.js"
PHOENIX_PLUS_EXTENDED_OSX_INTEL_PREFS="${PHOENIX_UNUSED}/macos-intel/phoenix-plus-extended.js"
PHOENIX_PLUS_EXTENDED_OSX_PREFS="${PHOENIX_UNUSED}/macos/phoenix-plus-extended.js"
PHOENIX_PLUS_EXTENDED_WINDOWS_PREFS="${PHOENIX_UNUSED}/windows/phoenix-plus-extended.js"

PHOENIX_EXTENDED_ANDROID_CFG="${PHOENIX_ANDROID_DIR}/phoenix-extended.cfg"
PHOENIX_EXTENDED_LINUX_CFG="${PHOENIX_LINUX_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_OSX_CFG="${PHOENIX_OSX_DIR}/configs/hardened.cfg"
PHOENIX_EXTENDED_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_DIR}/configs/extended.cfg"
PHOENIX_EXTENDED_WINDOWS_CFG="${PHOENIX_WINDOWS_DIR}/configs/hardened.cfg"

PHOENIX_PLUS_EXTENDED_ANDROID_CFG="${PHOENIX_ANDROID_DIR}/phoenix-plus-extended.cfg"
PHOENIX_PLUS_EXTENDED_LINUX_CFG="${PHOENIX_UNUSED}/linux/phoenix-plus-extended.cfg"
PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_CFG="${PHOENIX_UNUSED}/linux-flatpak/phoenix-plus-extended.cfg"
PHOENIX_PLUS_EXTENDED_OSX_CFG="${PHOENIX_UNUSED}/macos/phoenix-plus-extended.cfg"
PHOENIX_PLUS_EXTENDED_OSX_INTEL_CFG="${PHOENIX_UNUSED}/macos-intel/extended.cfg"
PHOENIX_PLUS_EXTENDED_WINDOWS_CFG="${PHOENIX_UNUSED}/windows/phoenix-plus-extended.cfg"

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
PHOENIX_CORE_POLICIES="${PHOENIX_BUILD}/policies/phoenix-core.json"
PHOENIX_DESKTOP_POLICIES="${PHOENIX_BUILD}/policies/phoenix-desktop.json"
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

PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-android.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-android.js"

PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-linux.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-linux.js"

PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-linux-flatpak.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-linux-flatpak.js"

PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-osx.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-osx.js"

PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-osx-intel.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-osx-intel.js"

PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-windows.cfg"
PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-windows.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_ANDROID="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.js"

PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.js"
PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_WINDOWS="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.js"

PHOENIX_EXTRA_CFG_OUTPUT_ANDROID="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_ANDROID="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.cfg"

PHOENIX_EXTRA_CFG_OUTPUT_LINUX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.cfg"

PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg"

PHOENIX_EXTRA_CFG_OUTPUT_OSX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.cfg"

PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.cfg"

PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg"
PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_WINDOWS="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.cfg"

PHOENIX_EXTRA_POLICIES_OUTPUT_ANDROID="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID}/policies.json"
PHOENIX_EXTRA_POLICIES_OUTPUT_LINUX="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK}/policies.json"
PHOENIX_EXTRA_POLICIES_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK}/policies.json"
PHOENIX_EXTRA_POLICIES_OUTPUT_OSX="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}/policies.json"
PHOENIX_EXTRA_POLICIES_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}/policies.json"
PHOENIX_EXTRA_POLICIES_OUTPUT_WINDOWS="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS}/policies.json"

# ANDROID
if [ "${PHOENIX_ANDROID}" == 1 ]; then
    echo_green_text 'Building Phoenix for Android...'
    mkdir -vp "${PHOENIX_ANDROID_DIR}" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_LICENSE}" "${PHOENIX_ANDROID_DIR}/" || error_fn
    echo

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_ANDROID_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_ANDROID_USER_PREF_CFG}"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_ANDROID_PREFS}"

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_ANDROID_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_ANDROID_PREFS}" "${PHOENIX_TEMP}/android.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/android.cfg" "${PHOENIX_ANDROID_USER_PREF_CFG}" > "${PHOENIX_ANDROID_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_ANDROID_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_ANDROID_PREFS}"

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_ANDROID_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_ANDROID_PREFS}" "${PHOENIX_EXTENDED_ANDROID_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_ANDROID_PREFS}" "${PHOENIX_EXTENDED_ANDROID_PREFS}" > "${PHOENIX_PLUS_EXTENDED_ANDROID_PREFS}" || error_fn
        echo
        cat "${PHOENIX_ANDROID_CFG}" "${PHOENIX_EXTENDED_ANDROID_CFG}" > "${PHOENIX_PLUS_EXTENDED_ANDROID_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID}" || error_fn
        echo

        cat "${PHOENIX_ANDROID_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID}" || error_fn
        echo
 
        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID}" "${PHOENIX_EXTENDED_ANDROID_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_ANDROID}" || error_fn
            echo

            # Create .cfg file
            python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID}" || error_fn
        echo

        cat "${PHOENIX_ANDROID_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_CFG_OUTPUT_ANDROID}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_ANDROID}" "${PHOENIX_EXTENDED_ANDROID_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_ANDROID}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_ANDROID}"
        fi
    fi
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

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        mkdir -vp "${PHOENIX_LINUX_DIR}/userjs/extended" || error_fn
        echo
        cp -vrf "${PHOENIX_BUILD}/linux/userjs/extended" "${PHOENIX_LINUX_DIR}/userjs/" || error_fn
        echo
    fi

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD}/assets/spec-welcome.txt" "${PHOENIX_LINUX_DIR}/assets/" || error_fn
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
    fi

    # Copy environment variables
    cp "${PHOENIX_BUILD}/linux/etc/profile.d/phoenix-env-overrides.sh" "${PHOENIX_LINUX_DIR}/etc/profile.d/phoenix-env-overrides.sh" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_USER_PREF_CFG}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_LINUX_USER_PREF_CFG}" > "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_LINUX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_PREFS}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_LINUX_PREFS}" > "${PHOENIX_LINUX_PREFS}" || error_fn
        echo
    fi

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_LINUX_PREFS}" "${PHOENIX_TEMP}/linux.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/linux.cfg" "${PHOENIX_LINUX_USER_PREF_CFG}" > "${PHOENIX_LINUX_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_LINUX_PREFS}"

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_EXTENDED_LINUX_PREFS}" > "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
            echo
        fi

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_LINUX_PREFS}" "${PHOENIX_EXTENDED_LINUX_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_LINUX_PREFS}" "${PHOENIX_EXTENDED_LINUX_PREFS}" > "${PHOENIX_PLUS_EXTENDED_LINUX_PREFS}" || error_fn
        echo
        cat "${PHOENIX_LINUX_CFG}" "${PHOENIX_EXTENDED_LINUX_CFG}" > "${PHOENIX_PLUS_EXTENDED_LINUX_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX}" || error_fn
        echo

        cat "${PHOENIX_LINUX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX}" || error_fn
        echo

        # Create .cfg files
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-linux-only.cfg" 
        cat "${PHOENIX_LINUX_CFG}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-linux-only.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX}" "${PHOENIX_EXTENDED_LINUX_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX}" || error_fn
            echo

            # Create .cfg file
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_CFG}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX}" || error_fn
        echo

        cat "${PHOENIX_LINUX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX}" "${PHOENIX_EXTENDED_LINUX_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX}"
        fi
    fi
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

    if [ "${PHOENIX_SPECS}" == 1 ]; then
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
    fi

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_FLATPAK_PREFS}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_LINUX_FLATPAK_PREFS}" > "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
        echo
    fi

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_TEMP}/linux-flatpak.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/linux-flatpak.cfg" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}"

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" > "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
            echo
        fi

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" > "${PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
        echo
        cat "${PHOENIX_LINUX_FLATPAK_CFG}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" > "${PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK}" || error_fn
        echo

        cat "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-linux-flatpak-only.cfg" 
        cat "${PHOENIX_LINUX_FLATPAK_CFG}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-linux-flatpak-only.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo

            # Create .cfg file
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_CFG}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK}" || error_fn
        echo

        cat "${PHOENIX_LINUX_FLATPAK_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK}"
        fi
    fi
fi

# OS X
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

    if [ "${PHOENIX_SPECS}" == 1 ]; then
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
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_BOOTSTRAP}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_OSX_BOOTSTRAP}" > "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_OSX_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_PREFS}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_OSX_PREFS}" > "${PHOENIX_OSX_PREFS}" || error_fn
        echo
    fi

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_OSX_PREFS}" "${PHOENIX_TEMP}/osx.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/osx.cfg" "${PHOENIX_OSX_USER_PREF_CFG}" > "${PHOENIX_OSX_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_OSX_PREFS}"

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_EXTENDED_OSX_PREFS}" > "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
            echo
        fi

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_OSX_PREFS}" "${PHOENIX_EXTENDED_OSX_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_OSX_PREFS}" "${PHOENIX_EXTENDED_OSX_PREFS}" > "${PHOENIX_PLUS_EXTENDED_OSX_PREFS}" || error_fn
        echo
        cat "${PHOENIX_OSX_CFG}" "${PHOENIX_EXTENDED_OSX_CFG}" > "${PHOENIX_PLUS_EXTENDED_OSX_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX}" || error_fn
        echo

        cat "${PHOENIX_OSX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX}" || error_fn
        echo

        # Create .cfg files
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-osx-only.cfg" 
        cat "${PHOENIX_OSX_CFG}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-osx-only.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX}" "${PHOENIX_EXTENDED_OSX_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX}" || error_fn
            echo

            # Create .cfg file
            cat "${PHOENIX_PLUS_EXTENDED_OSX_CFG}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX}" || error_fn
        echo

        cat "${PHOENIX_OSX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_CFG_OUTPUT_OSX}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_OSX}" "${PHOENIX_EXTENDED_OSX_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_OSX}"
        fi
    fi
fi

# OS X (INTEL)
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

    if [ "${PHOENIX_SPECS}" == 1 ]; then
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
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_BOOTSTRAP}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_OSX_INTEL_BOOTSTRAP}" > "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_PREFS}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_OSX_INTEL_PREFS}" > "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
        echo
    fi

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_TEMP}/osx-intel.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/osx-intel.cfg" "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" > "${PHOENIX_OSX_INTEL_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_OSX_INTEL_PREFS}"

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" > "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
            echo
        fi

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" > "${PHOENIX_PLUS_EXTENDED_OSX_INTEL_PREFS}" || error_fn
        echo
        cat "${PHOENIX_OSX_INTEL_CFG}" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" > "${PHOENIX_PLUS_EXTENDED_OSX_INTEL_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL}" || error_fn
        echo

        cat "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL}" || error_fn
        echo

        # Create .cfg files
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-osx-intel-only.cfg" 
        cat "${PHOENIX_OSX_INTEL_CFG}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-osx-intel-only.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL}" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX_INTEL}" || error_fn
            echo

            # Create .cfg file
            cat "${PHOENIX_PLUS_EXTENDED_OSX_INTEL_CFG}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL}" || error_fn
        echo

        cat "${PHOENIX_OSX_INTEL_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL}" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX_INTEL}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL}"
        fi
    fi
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

    if [ "${PHOENIX_SPECS}" == 1 ]; then
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
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_WINDOWS_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_BOOTSTRAP}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_WINDOWS_BOOTSTRAP}" > "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_UNIFIED_PREFS}" > "${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_PREFS}"

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_WINDOWS_PREFS}" > "${PHOENIX_WINDOWS_PREFS}" || error_fn
        echo
    fi

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_TEMP}/windows.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/windows.cfg" "${PHOENIX_WINDOWS_USER_PREF_CFG}" > "${PHOENIX_WINDOWS_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
        echo
        echo "Created ${PHOENIX_EXTENDED_WINDOWS_PREFS}"

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_EXTENDED_WINDOWS_PREFS}" > "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
            echo
        fi

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
        echo

        # Create .cfg file
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" "${PHOENIX_EXTENDED_WINDOWS_CFG}" || error_fn
        echo

        # Create files that contain contents of both Phoenix + Phoenix extended
        cat "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" > "${PHOENIX_PLUS_EXTENDED_WINDOWS_PREFS}" || error_fn
        echo
        cat "${PHOENIX_WINDOWS_CFG}" "${PHOENIX_EXTENDED_WINDOWS_CFG}" > "${PHOENIX_PLUS_EXTENDED_WINDOWS_CFG}" || error_fn
        echo
    fi

    # Process and append contents of an additional specified .js prefs file if necessary
    if [ "${PHOENIX_EXTRA_PREFS_JS}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTRA_PREFS_JS_FILE}" > "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS}" || error_fn
        echo

        cat "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS}" || error_fn
        echo

        # Create .cfg files
        python3 "${PHOENIX_BUILD}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-windows-only.cfg" 
        cat "${PHOENIX_WINDOWS_CFG}" "${PHOENIX_TEMP}/${PHOENIX_EXTRA_OUTPUT_FILENAME}-windows-only.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS}" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_WINDOWS}" || error_fn
            echo

            # Create .cfg file
            cat "${PHOENIX_PLUS_EXTENDED_WINDOWS_CFG}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS}" || error_fn
        echo

        cat "${PHOENIX_WINDOWS_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS}" || error_fn
        echo

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS}" "${PHOENIX_EXTENDED_WINDOWS_CFG}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_WINDOWS}" || error_fn
            echo
        fi

        if [ "${PHOENIX_STANDARD}" != 1 ]; then
            rm -f "${PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS}"
        fi
    fi
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

    # OS X
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

    # OS X (INTEL)
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

if [ "${PHOENIX_MAIL}" != 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp2.json" "${PHOENIX_CORE_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0.json" || error_fn
    echo
else
    cp -f "${PHOENIX_TEMP}/policies/temp2.json" "${PHOENIX_TEMP}/policies/temp0.json" || error_fn
    echo
fi

if [ "${PHOENIX_EXTRA_POLICIES}" == 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp0.json" "${PHOENIX_EXTRA_POLICIES_FILE}" > "${PHOENIX_TEMP}/policies/temp01.json" || error_fn
    echo
else
    cp -f "${PHOENIX_TEMP}/policies/temp0.json" "${PHOENIX_TEMP}/policies/temp01.json"
fi

if [ "${PHOENIX_ANDROID}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Android...'

    if [ "${PHOENIX_EXTRA_POLICIES_ANDROID}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp01.json" "${PHOENIX_EXTRA_POLICIES_FILE_ANDROID}" > "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID}/policies.json" || error_fn
        echo
    fi
fi

jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp01.json" "${PHOENIX_DESKTOP_POLICIES}" > "${PHOENIX_TEMP}/policies/temp98.json" || error_fn
echo

if [ "${PHOENIX_MAIL}" != 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp98.json" "${PHOENIX_ONLY_POLICIES}" > "${PHOENIX_POLICIES}" || error_fn
    echo
else
    cp -f "${PHOENIX_TEMP}/policies/temp98.json" "${PHOENIX_POLICIES}" || error_fn
    echo
fi

# (This is used by both Linux and Flatpak)
if [ "${PHOENIX_LINUX}" == 1 ] || [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp00.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_LINUX}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp00.json" "${PHOENIX_EXTRA_POLICIES_FILE_LINUX}" > "${PHOENIX_TEMP}/policies/temp3.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp00.json" "${PHOENIX_TEMP}/policies/temp3.json"
    fi
fi

if [ "${PHOENIX_LINUX}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Linux...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp4.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp4.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp5.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp5.json" "${PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp000.json" "${PHOENIX_EXTRA_POLICIES_FILE_LINUX_NONFLATPAK}" > "${PHOENIX_LINUX_POLICIES}" || error_fn
        echo
        cp -f "${PHOENIX_LINUX_POLICIES}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp000.json" "${PHOENIX_LINUX_POLICIES}" || error_fn
        echo
    fi
fi

if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Linux (Flatpak)...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp3.json" "${PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp6.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp6.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp7.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp7.json" "${PHOENIX_ONLY_LINUX_FLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp0000.json" "${PHOENIX_EXTRA_POLICIES_FILE_LINUX_FLATPAK}" > "${PHOENIX_LINUX_FLATPAK_POLICIES}" || error_fn
        echo
        cp -f "${PHOENIX_LINUX_FLATPAK_POLICIES}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp0000.json" "${PHOENIX_LINUX_FLATPAK_POLICIES}" || error_fn
        echo
    fi
fi

# (This is used by both OS X and OS X Intel)
if [ "${PHOENIX_OSX}" == 1 ] || [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp00000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_OSX}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp00000.json" "${PHOENIX_EXTRA_POLICIES_FILE_OSX}" > "${PHOENIX_TEMP}/policies/temp8.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp00000.json" "${PHOENIX_TEMP}/policies/temp8.json" || error_fn
        echo
    fi
fi

if [ "${PHOENIX_OSX}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for OS X...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp8.json" "${PHOENIX_UNIFIED_OSX_SILICON_POLICIES}" > "${PHOENIX_TEMP}/policies/temp9.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp9.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp10.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp10.json" "${PHOENIX_ONLY_OSX_SILICON_POLICIES}" > "${PHOENIX_TEMP}/policies/temp000000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_SILICON}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp000000.json" "${PHOENIX_EXTRA_POLICIES_FILE_OSX_SILICON}" > "${PHOENIX_OSX_POLICIES_JSON}" || error_fn
        echo
        cp -f "${PHOENIX_OSX_POLICIES_JSON}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp000000.json" "${PHOENIX_OSX_POLICIES_JSON}" || error_fn
        echo
    fi

    python3 "${PHOENIX_BUILD}/convert_json_to_plist.py" "${PHOENIX_OSX_POLICIES_JSON}" "${PHOENIX_OSX_POLICIES_PLIST}" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_SILICON}" == 1 ]; then
        cp -f "${PHOENIX_OSX_POLICIES_PLIST}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}/org.mozilla.firefox.plist" || error_fn
        echo
    fi
fi

if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for OS X (Intel)...'

    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp8.json" "${PHOENIX_UNIFIED_OSX_INTEL_POLICIES}" > "${PHOENIX_TEMP}/policies/temp11.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp11.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp12.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp12.json" "${PHOENIX_ONLY_OSX_INTEL_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0000000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_INTEL}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp0000000.json" "${PHOENIX_EXTRA_POLICIES_FILE_OSX_INTEL}" > "${PHOENIX_OSX_INTEL_POLICIES_JSON}" || error_fn
        echo
        cp -f "${PHOENIX_OSX_INTEL_POLICIES_JSON}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp0000000.json" "${PHOENIX_OSX_INTEL_POLICIES_JSON}" || error_fn
        echo
    fi

    python3 "${PHOENIX_BUILD}/convert_json_to_plist.py" "${PHOENIX_OSX_INTEL_POLICIES_JSON}" "${PHOENIX_OSX_INTEL_POLICIES_PLIST}" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_INTEL}" == 1 ]; then
        cp -f "${PHOENIX_OSX_INTEL_POLICIES_PLIST}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}/org.mozilla.firefox.plist" || error_fn
        echo
    fi
fi

if [ "${PHOENIX_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Phoenix policies for Windows...'

    jq -s '.[0] * .[1]' "${PHOENIX_POLICIES}" "${PHOENIX_UNIFIED_WINDOWS_POLICIES}" > "${PHOENIX_TEMP}/policies/temp13.json" || error_fn
    echo
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp13.json" "${PHOENIX_ONLY_WINDOWS_POLICIES}" > "${PHOENIX_TEMP}/policies/temp00000000.json" || error_fn
    echo

    if [ "${PHOENIX_EXTRA_POLICIES_WINDOWS}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp00000000.json" "${PHOENIX_EXTRA_POLICIES_FILE_WINDOWS}" > "${PHOENIX_WINDOWS_POLICIES}" || error_fn
        echo
        cp -f "${PHOENIX_WINDOWS_POLICIES}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp00000000.json" "${PHOENIX_WINDOWS_POLICIES}" || error_fn
        echo
    fi
fi

rm -rf "${PHOENIX_TEMP}/" || error_fn
echo
