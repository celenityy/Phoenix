#!/bin/bash

set -euo pipefail

# Welcome to the Phoenix Unified build script!
# This script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_BUILD+x}" ]]; then
    echo_red_text 'ERROR: Do not call fly.sh directly. Instead, use build.sh.' >&1
    exit 1
fi

# Set-up Python venv
if [ "${PHOENIX_NIX}" != 1 ]; then
    source "${PHOENIX_PYENV}" || error_fn
    echo
fi

# Include version info
source "${PHOENIX_VERSIONS}" || error_fn
echo

# Ensure our directories exist
mkdir -vp "${PHOENIX_BUILD}/configs" || error_fn
echo
mkdir -vp "${PHOENIX_BUILD}/policies" || error_fn
echo
mkdir -vp "${PHOENIX_OUTPUTS}" || error_fn
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

if [ "${PHOENIX_EXTRA_POLICIES_LINUX}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_LINUX}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_LINUX is set, but \$PHOENIX_EXTRA_POLICIES_FILE_LINUX is not set! Aborting..."
        exit 1
    fi
fi

if [ "${PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_LINUX_NONFLATPAK}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK is set, but \$PHOENIX_EXTRA_POLICIES_FILE_LINUX_NONFLATPAK is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK}"
fi

if [ "${PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK}" == 1 ]; then
    if [ "${PHOENIX_EXTRA_POLICIES_FILE_LINUX_FLATPAK}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK is set, but \$PHOENIX_EXTRA_POLICIES_FILE_LINUX_FLATPAK is not set! Aborting..."
        exit 1
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK}" == 'undefined' ]; then
        echo_red_text "\$PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK is set, but \$PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK is not set! Aborting..."
        exit 1
    fi
    mkdir -vp "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK}"
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
    elif [ "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}" == 'undefined' ]; then
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

readonly PHOENIX_ANDROID_PREFS="${PHOENIX_ANDROID_OUTPUTS}/phoenix.js"
readonly PHOENIX_LINUX_FLATPAK_PREFS="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused/phoenix.js"
readonly PHOENIX_LINUX_PREFS="${PHOENIX_LINUX_OUTPUTS}/unused/phoenix.js"
readonly PHOENIX_OSX_INTEL_PREFS="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/phoenix.js"
readonly PHOENIX_OSX_PREFS="${PHOENIX_OSX_OUTPUTS}/unused/phoenix.js"
readonly PHOENIX_WINDOWS_PREFS="${PHOENIX_WINDOWS_OUTPUTS}/unused/phoenix.js"

readonly PHOENIX_BOOTSTRAP="${PHOENIX_BUILD_RESOURCES}/phoenix-bootstrap.js"

readonly PHOENIX_LINUX_BOOTSTRAP="${PHOENIX_LINUX_OUTPUTS}/defaults/pref/phoenix.js"
readonly PHOENIX_LINUX_FLATPAK_BOOTSTRAP="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/defaults/pref/phoenix.js"
readonly PHOENIX_OSX_BOOTSTRAP="${PHOENIX_OSX_OUTPUTS}/defaults/pref/phoenix.js"
readonly PHOENIX_OSX_INTEL_BOOTSTRAP="${PHOENIX_OSX_INTEL_OUTPUTS}/defaults/pref/phoenix.js"
readonly PHOENIX_WINDOWS_BOOTSTRAP="${PHOENIX_WINDOWS_OUTPUTS}/defaults/pref/phoenix.js"

readonly PHOENIX_USER_PREF_CFG="${PHOENIX_BUILD_RESOURCES}/phoenix-user-pref.cfg"

readonly PHOENIX_ANDROID_USER_PREF_CFG="${PHOENIX_ANDROID_OUTPUTS}/unused/phoenix-user-pref.cfg"
readonly PHOENIX_LINUX_FLATPAK_USER_PREF_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused/phoenix-user-pref.cfg"
readonly PHOENIX_LINUX_USER_PREF_CFG="${PHOENIX_LINUX_OUTPUTS}/unused/phoenix-user-pref.cfg"
readonly PHOENIX_OSX_USER_PREF_CFG="${PHOENIX_OSX_OUTPUTS}/unused/phoenix-user-pref.cfg"
readonly PHOENIX_OSX_INTEL_USER_PREF_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/phoenix-user-pref.cfg"
readonly PHOENIX_WINDOWS_USER_PREF_CFG="${PHOENIX_WINDOWS_OUTPUTS}/unused/phoenix-user-pref.cfg"

readonly PHOENIX_ANDROID_CFG="${PHOENIX_ANDROID_OUTPUTS}/phoenix.cfg"
readonly PHOENIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/phoenix.cfg"
readonly PHOENIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/phoenix.cfg"
readonly PHOENIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/macos/phoenix.cfg"
readonly PHOENIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/phoenix.cfg"
readonly PHOENIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/phoenix.cfg"

readonly PHOENIX_EXTENDED_UNIFIED_PREFS="${PHOENIX_BUILD_RESOURCES}/extended/phoenix-extended-unified.js"

readonly PHOENIX_EXTENDED_ANDROID_PREFS="${PHOENIX_ANDROID_OUTPUTS}/phoenix-extended.js"
readonly PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused/phoenix-extended.js"
readonly PHOENIX_EXTENDED_LINUX_PREFS="${PHOENIX_LINUX_OUTPUTS}/unused/phoenix-extended.js"
readonly PHOENIX_EXTENDED_OSX_INTEL_PREFS="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/phoenix-extended.js"
readonly PHOENIX_EXTENDED_OSX_PREFS="${PHOENIX_OSX_OUTPUTS}/unused/phoenix-extended.js"
readonly PHOENIX_EXTENDED_WINDOWS_PREFS="${PHOENIX_WINDOWS_OUTPUTS}/unused/phoenix-extended.js"

readonly PHOENIX_PLUS_EXTENDED_ANDROID_PREFS="${PHOENIX_ANDROID_OUTPUTS}/phoenix-plus-extended.js"
readonly PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_PREFS="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused/phoenix-plus-extended.js"
readonly PHOENIX_PLUS_EXTENDED_LINUX_PREFS="${PHOENIX_LINUX_OUTPUTS}/unused/phoenix-plus-extended.js"
readonly PHOENIX_PLUS_EXTENDED_OSX_INTEL_PREFS="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/phoenix-plus-extended.js"
readonly PHOENIX_PLUS_EXTENDED_OSX_PREFS="${PHOENIX_OSX_OUTPUTS}/unused/phoenix-plus-extended.js"
readonly PHOENIX_PLUS_EXTENDED_WINDOWS_PREFS="${PHOENIX_WINDOWS_OUTPUTS}/unused/phoenix-plus-extended.js"

readonly PHOENIX_EXTENDED_ANDROID_CFG="${PHOENIX_ANDROID_OUTPUTS}/phoenix-extended.cfg"
readonly PHOENIX_EXTENDED_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/hardened.cfg"
readonly PHOENIX_EXTENDED_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/hardened.cfg"
readonly PHOENIX_EXTENDED_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/hardened.cfg"
readonly PHOENIX_EXTENDED_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/extended.cfg"
readonly PHOENIX_EXTENDED_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/hardened.cfg"

readonly PHOENIX_PLUS_EXTENDED_ANDROID_CFG="${PHOENIX_ANDROID_OUTPUTS}/phoenix-plus-extended.cfg"
readonly PHOENIX_PLUS_EXTENDED_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/unused/phoenix-plus-extended.cfg"
readonly PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused/phoenix-plus-extended.cfg"
readonly PHOENIX_PLUS_EXTENDED_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/unused/phoenix-plus-extended.cfg"
readonly PHOENIX_PLUS_EXTENDED_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/phoenix-plus-extended.cfg"
readonly PHOENIX_PLUS_EXTENDED_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/unused/phoenix-plus-extended.cfg"

readonly PHOENIX_SPECIALIZED_UNIFIED_CFG="${PHOENIX_BUILD_RESOURCES}/specs/specialized-unified.cfg"

readonly PHOENIX_EXTENDED_UNIFIED_CFG="${PHOENIX_BUILD}/configs/extended-unified.cfg"

readonly PHOENIX_SPECIALIZED_CFG="${PHOENIX_BUILD}/configs/specialized.cfg"

readonly PHOENIX_SPECIALIZED_UNIFIED_APPLE_MAPS_CFG="${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/apple-maps-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_DISCORD_CFG="${PHOENIX_BUILD_RESOURCES}/specs/discord/discord-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_ELEMENT_CFG="${PHOENIX_BUILD_RESOURCES}/specs/element/element-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_GOOGLE_MAPS_CFG="${PHOENIX_BUILD_RESOURCES}/specs/google-maps/google-maps-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_PHOTOPEA_CFG="${PHOENIX_BUILD_RESOURCES}/specs/photopea/photopea-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_TWITTER_CFG="${PHOENIX_BUILD_RESOURCES}/specs/twitter/twitter-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_CFG="${PHOENIX_BUILD_RESOURCES}/specs/youtube/youtube-unified.cfg"
readonly PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_MUSIC_CFG="${PHOENIX_BUILD_RESOURCES}/specs/youtube-music/youtube-music-unified.cfg"

readonly PHOENIX_SPECIALIZED_APPLE_MAPS_CFG="${PHOENIX_BUILD}/configs/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_CFG="${PHOENIX_BUILD}/configs/discord.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_CFG="${PHOENIX_BUILD}/configs/element.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG="${PHOENIX_BUILD}/configs/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_CFG="${PHOENIX_BUILD}/configs/photopea.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_CFG="${PHOENIX_BUILD}/configs/twitter.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_CFG="${PHOENIX_BUILD}/configs/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG="${PHOENIX_BUILD}/configs/youtube-music.cfg"

readonly PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/apple-maps.cfg"

readonly PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/discord.cfg"

readonly PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/element.cfg"

readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/google-maps.cfg"

readonly PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/photopea.cfg"

readonly PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/twitter.cfg"

readonly PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/youtube.cfg"

readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/youtube-music.cfg"

readonly PHOENIX_UI_FIX_UNIFIED_CFG="${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/ui-fix-unified.cfg"

readonly PHOENIX_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix.cfg"
readonly PHOENIX_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix.cfg"
readonly PHOENIX_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix.cfg"
readonly PHOENIX_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix.cfg"
readonly PHOENIX_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix.cfg"

readonly PHOENIX_EXTENDED_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/hardened.cfg"
readonly PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/hardened.cfg"
readonly PHOENIX_EXTENDED_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/hardened.cfg"
readonly PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/hardened.cfg"
readonly PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/hardened.cfg"

readonly PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/apple-maps.cfg"
readonly PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/apple-maps.cfg"

readonly PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/discord.cfg"
readonly PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/discord.cfg"

readonly PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/element.cfg"
readonly PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/element.cfg"

readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/google-maps.cfg"
readonly PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/google-maps.cfg"

readonly PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/photopea.cfg"
readonly PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/photopea.cfg"

readonly PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/twitter.cfg"
readonly PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/twitter.cfg"

readonly PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/youtube.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/youtube.cfg"

readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG="${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG="${PHOENIX_OSX_OUTPUTS}/configs/ui-fix/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG="${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix/youtube-music.cfg"
readonly PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG="${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix/youtube-music.cfg"

readonly PHOENIX_UNIFIED_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-unified.json"
readonly PHOENIX_CORE_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-core.json"
readonly PHOENIX_DESKTOP_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-desktop.json"
readonly PHOENIX_ONLY_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only.json"

readonly PHOENIX_BLOCKLIST_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/blocklist.json"
readonly PHOENIX_COOKIES_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/cookies.json"

readonly PHOENIX_ONLY_LINUX_FLATPAK_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-linux-flatpak.json"
readonly PHOENIX_ONLY_LINUX_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-linux.json"
readonly PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-linux-non-flatpak.json"
readonly PHOENIX_ONLY_OSX_INTEL_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-osx-intel.json"
readonly PHOENIX_ONLY_OSX_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-osx.json"
readonly PHOENIX_ONLY_OSX_SILICON_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-osx-silicon.json"
readonly PHOENIX_ONLY_WINDOWS_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-only-windows.json"

readonly PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-linux-flatpak-unified.json"
readonly PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-linux-non-flatpak-unified.json"
readonly PHOENIX_UNIFIED_LINUX_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-linux-unified.json"
readonly PHOENIX_UNIFIED_OSX_INTEL_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-osx-intel-unified.json"
readonly PHOENIX_UNIFIED_OSX_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-osx-unified.json"
readonly PHOENIX_UNIFIED_OSX_SILICON_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-osx-silicon-unified.json"
readonly PHOENIX_UNIFIED_WINDOWS_POLICIES="${PHOENIX_BUILD_RESOURCES}/policies/phoenix-windows-unified.json"

readonly PHOENIX_POLICIES="${PHOENIX_BUILD}/policies/phoenix.json"

readonly PHOENIX_LINUX_POLICIES="${PHOENIX_LINUX_OUTPUTS}/policies/policies.json"
readonly PHOENIX_LINUX_FLATPAK_POLICIES="${PHOENIX_LINUX_FLATPAK_OUTPUTS}/policies/policies.json"
readonly PHOENIX_WINDOWS_POLICIES="${PHOENIX_WINDOWS_OUTPUTS}/distribution/policies.json"

readonly PHOENIX_OSX_INTEL_POLICIES_JSON="${PHOENIX_OSX_INTEL_OUTPUTS}/unused/policies.json"
readonly PHOENIX_OSX_INTEL_POLICIES_PLIST="${PHOENIX_OSX_INTEL_OUTPUTS}/org.mozilla.firefox.plist"
readonly PHOENIX_OSX_POLICIES_JSON="${PHOENIX_OSX_OUTPUTS}/unused/policies.json"
readonly PHOENIX_OSX_POLICIES_PLIST="${PHOENIX_OSX_OUTPUTS}/macos/org.mozilla.firefox.plist"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-android.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-android.js"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-linux.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-linux.js"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-linux-flatpak.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-linux-flatpak.js"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-osx.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-osx.js"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-osx-intel.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-osx-intel.js"

readonly PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS="${PHOENIX_TEMP}/phoenix-extra-cfg-processed-windows.cfg"
readonly PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS="${PHOENIX_TEMP}/phoenix-extra-prefs-js-processed-windows.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_ANDROID="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.js"

readonly PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.js"
readonly PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_WINDOWS="${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.js"

readonly PHOENIX_EXTRA_CFG_OUTPUT_ANDROID="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_ANDROID="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.cfg"

readonly PHOENIX_EXTRA_CFG_OUTPUT_LINUX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.cfg"

readonly PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg"

readonly PHOENIX_EXTRA_CFG_OUTPUT_OSX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.cfg"

readonly PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.cfg"

readonly PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg"
readonly PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_WINDOWS="${PHOENIX_EXTRA_CFG_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.cfg"

readonly PHOENIX_EXTRA_POLICIES_OUTPUT_ANDROID="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_ANDROID}/policies.json"
readonly PHOENIX_EXTRA_POLICIES_OUTPUT_LINUX="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_NONFLATPAK}/policies.json"
readonly PHOENIX_EXTRA_POLICIES_OUTPUT_LINUX_FLATPAK="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_LINUX_FLATPAK}/policies.json"
readonly PHOENIX_EXTRA_POLICIES_OUTPUT_OSX="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}/policies.json"
readonly PHOENIX_EXTRA_POLICIES_OUTPUT_OSX_INTEL="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}/policies.json"
readonly PHOENIX_EXTRA_POLICIES_OUTPUT_WINDOWS="${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_WINDOWS}/policies.json"

# ANDROID
if [ "${PHOENIX_ANDROID}" == 1 ]; then
    echo_green_text 'Building Phoenix for Android...'
    mkdir -vp "${PHOENIX_ANDROID_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_ANDROID_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_BUILD_RESOURCES}/android/README.md" "${PHOENIX_ANDROID_OUTPUTS}/" || error_fn
    echo

    # Copy Android-specific files
    cp -f "${PHOENIX_BUILD_RESOURCES}/android/phoenix-unextend.js" "${PHOENIX_ANDROID_OUTPUTS}/"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_ANDROID_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_ANDROID_USER_PREF_CFG}"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    echo "Created ${PHOENIX_ANDROID_PREFS}"

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_ANDROID_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_ANDROID_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_ANDROID_PREFS}" "${PHOENIX_TEMP}/android.cfg" || error_fn
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
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_ANDROID_PREFS}" "${PHOENIX_EXTENDED_ANDROID_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_ANDROID_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_ANDROID}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_ANDROID}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_ANDROID_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_ANDROID}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_ANDROID}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_ANDROID}.cfg" || error_fn
            echo
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_ANDROID_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_CFG_OUTPUT_ANDROID}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_ANDROID_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_ANDROID}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_ANDROID}" || error_fn
            echo
        fi
    fi
fi

# GNU/LINUX
if [ "${PHOENIX_LINUX}" == 1 ]; then
    echo_green_text 'Building Phoenix for Linux...'
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/etc/profile.d" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/policies" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_LINUX_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_ROOT}/README.md" "${PHOENIX_LINUX_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.css" "${PHOENIX_LINUX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.html" "${PHOENIX_LINUX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.css" "${PHOENIX_LINUX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.html" "${PHOENIX_LINUX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/phoenix.png" "${PHOENIX_LINUX_OUTPUTS}/assets/" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ] || [ "${PHOENIX_SPECS}" == 1 ]; then
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs" || error_fn
        echo
        cp "${PHOENIX_BUILD_RESOURCES}/specs/README.md" "${PHOENIX_LINUX_OUTPUTS}/userjs/" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/extended" || error_fn
        echo
        cp -vrf "${PHOENIX_BUILD_RESOURCES}/extended/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/extended/" || error_fn
        echo
    fi

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD_RESOURCES}/specs/spec-welcome.txt" "${PHOENIX_LINUX_OUTPUTS}/assets/" || error_fn
        echo

        # Copy specialized config default permission files
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/resources/specs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/resources/specs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/resources/specs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/resources/specs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/resources/specs/twitter" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/permissions" "${PHOENIX_LINUX_OUTPUTS}/resources/specs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/permissions" "${PHOENIX_LINUX_OUTPUTS}/resources/specs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/permissions" "${PHOENIX_LINUX_OUTPUTS}/resources/specs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/permissions" "${PHOENIX_LINUX_OUTPUTS}/resources/specs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/permissions" "${PHOENIX_LINUX_OUTPUTS}/resources/specs/twitter/" || error_fn
        echo

        # Copy specialized config user.js files
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/extended" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/youtube-music" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix-base" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_OUTPUTS}/userjs/youtube-music" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/photopea/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube-music/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/youtube-music/" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/apple-maps/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/base/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix-base/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/discord/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/element/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/extended/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/extended/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/google-maps/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/photopea/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/twitter/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube-music/linux/user.js" "${PHOENIX_LINUX_OUTPUTS}/userjs/ui-fix/youtube-music/" || error_fn
        echo
    fi

    # Copy environment variables
    cp -vf "${PHOENIX_BUILD_RESOURCES}/linux/etc/profile.d/phoenix-env-overrides.sh" "${PHOENIX_LINUX_OUTPUTS}/etc/profile.d/" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_TEMP}/phoenix-bootstrap-linux-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-bootstrap-linux-temp.js" > "${PHOENIX_LINUX_BOOTSTRAP}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-bootstrap-linux-temp.js" "${PHOENIX_LINUX_BOOTSTRAP}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_LINUX_BOOTSTRAP}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_TEMP}/phoenix-linux-prefs-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-linux-prefs-temp.js" > "${PHOENIX_LINUX_PREFS}" || error_fn
        echo
    else 
        cp -f "${PHOENIX_TEMP}/phoenix-linux-prefs-temp.js" "${PHOENIX_LINUX_PREFS}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_LINUX_PREFS}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_LINUX_PREFS}" "${PHOENIX_TEMP}/linux.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/linux.cfg" "${PHOENIX_LINUX_USER_PREF_CFG}" > "${PHOENIX_LINUX_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_TEMP}/phoenix-extended-linux-prefs-temp.js" || error_fn
        echo

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-extended-linux-prefs-temp.js" > "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
            echo
        else
            cp -f "${PHOENIX_TEMP}/phoenix-extended-linux-prefs-temp.js" "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
            echo
        fi
        echo "Created ${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
        echo

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_PREFS}" || error_fn
        echo

        # Create .cfg file
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_LINUX_PREFS}" "${PHOENIX_EXTENDED_LINUX_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_LINUX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX}.cfg" || error_fn
            echo
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_LINUX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX}" || error_fn
            echo
        fi
    fi
fi

# GNU/LINUX (FLATPAK)
if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
    echo_green_text 'Building Phoenix for Linux (Flatpak)...'
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/policies" || error_fn
    echo
    mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_ROOT}/README.md" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.css" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.html" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.css" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.html" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/phoenix.png" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ] || [ "${PHOENIX_SPECS}" == 1 ]; then
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs" || error_fn
        echo
        cp "${PHOENIX_BUILD_RESOURCES}/specs/README.md" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/extended" || error_fn
        echo
        cp -vrf "${PHOENIX_BUILD_RESOURCES}/extended/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/extended/" || error_fn
        echo
    fi

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD_RESOURCES}/specs/spec-welcome.txt" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/assets/" || error_fn
        echo

        # Copy specialized config default permission files
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/twitter" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/permissions" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/permissions" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/permissions" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/permissions" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/permissions" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/resources/specs/twitter/" || error_fn
        echo

        # Copy specialized config user.js files
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/extended" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/youtube-music" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix-base" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/youtube-music" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/photopea/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube-music/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/youtube-music/" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/apple-maps/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/base/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix-base/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/discord/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/element/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/extended/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/extended/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/google-maps/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/photopea/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/twitter/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube-music/linux-flatpak/user.js" "${PHOENIX_LINUX_FLATPAK_OUTPUTS}/userjs/ui-fix/youtube-music/" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_TEMP}/phoenix-bootstrap-linux-flatpak-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-bootstrap-linux-flatpak-temp.js" > "${PHOENIX_LINUX_FLATPAK_BOOTSTRAP}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-bootstrap-linux-flatpak-temp.js" "${PHOENIX_LINUX_FLATPAK_BOOTSTRAP}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_LINUX_FLATPAK_BOOTSTRAP}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_TEMP}/phoenix-linux-flatpak-prefs-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-linux-flatpak-prefs-temp.js" > "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-linux-flatpak-prefs-temp.js" "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_TEMP}/linux-flatpak.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/linux-flatpak.cfg" "${PHOENIX_LINUX_FLATPAK_USER_PREF_CFG}" > "${PHOENIX_LINUX_FLATPAK_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_TEMP}/phoenix-extended-linux-flatpak-prefs-temp.js" || error_fn
        echo

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-extended-linux-flatpak-prefs-temp.js" > "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
            echo
        else
            cp -f "${PHOENIX_TEMP}/phoenix-extended-linux-flatpak-prefs-temp.js" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
            echo
        fi
        echo "Created ${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
        echo

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" || error_fn
        echo

        # Create .cfg file
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTENDED_LINUX_FLATPAK_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_LINUX_FLATPAK}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_LINUX_FLATPAK}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_LINUX_FLATPAK}.cfg" || error_fn
            echo
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_LINUX_FLATPAK_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_CFG_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_LINUX_FLATPAK_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_LINUX_FLATPAK}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_LINUX_FLATPAK}" || error_fn
            echo
        fi
    fi
fi

# OS X
if [ "${PHOENIX_OSX}" == 1 ]; then
    echo_green_text 'Building Phoenix for OS X...'
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/Library/celenity" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/macos" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_OSX_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_ROOT}/README.md" "${PHOENIX_OSX_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.css" "${PHOENIX_OSX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.html" "${PHOENIX_OSX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.css" "${PHOENIX_OSX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.html" "${PHOENIX_OSX_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/phoenix.png" "${PHOENIX_OSX_OUTPUTS}/assets/" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ] || [ "${PHOENIX_SPECS}" == 1 ]; then
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs" || error_fn
        echo
        cp "${PHOENIX_BUILD_RESOURCES}/specs/README.md" "${PHOENIX_OSX_OUTPUTS}/userjs/" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/extended" || error_fn
        echo
        cp -vrf "${PHOENIX_BUILD_RESOURCES}/extended/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/extended/" || error_fn
        echo
    fi

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD_RESOURCES}/specs/spec-welcome.txt" "${PHOENIX_OSX_OUTPUTS}/assets/" || error_fn
        echo

        # Copy specialized config default permission files
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/resources/specs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/resources/specs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/resources/specs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/resources/specs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/resources/specs/twitter" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/permissions" "${PHOENIX_OSX_OUTPUTS}/resources/specs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/permissions" "${PHOENIX_OSX_OUTPUTS}/resources/specs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/permissions" "${PHOENIX_OSX_OUTPUTS}/resources/specs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/permissions" "${PHOENIX_OSX_OUTPUTS}/resources/specs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/permissions" "${PHOENIX_OSX_OUTPUTS}/resources/specs/twitter/" || error_fn
        echo

        # Copy specialized config user.js files
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/extended" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/youtube-music" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix-base" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_OUTPUTS}/userjs/youtube-music" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/photopea/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube-music/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/youtube-music/" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/apple-maps/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/base/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix-base/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/discord/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/element/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/extended/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/extended/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/google-maps/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/photopea/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/twitter/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube-music/osx/user.js" "${PHOENIX_OSX_OUTPUTS}/userjs/ui-fix/youtube-music/" || error_fn
        echo
    fi

    # Copy OS X-specific files
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx-shared/Library/LaunchAgents" "${PHOENIX_OSX_OUTPUTS}/Library/"

    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx/Library/celenity/Phoenix" "${PHOENIX_OSX_OUTPUTS}/Library/celenity/"
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx/Library/LaunchAgents/" "${PHOENIX_OSX_OUTPUTS}/Library/LaunchAgents/"
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx/Library/LaunchDaemons" "${PHOENIX_OSX_OUTPUTS}/Library/"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_TEMP}/phoenix-bootstrap-osx-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-bootstrap-osx-temp.js" > "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-bootstrap-osx-temp.js" "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_TEMP}/phoenix-osx-prefs-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-osx-prefs-temp.js" > "${PHOENIX_OSX_PREFS}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-osx-prefs-temp.js" "${PHOENIX_OSX_PREFS}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_OSX_PREFS}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_OSX_PREFS}" "${PHOENIX_TEMP}/osx.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/osx.cfg" "${PHOENIX_OSX_USER_PREF_CFG}" > "${PHOENIX_OSX_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_TEMP}/phoenix-extended-osx-prefs-temp.js" || error_fn
        echo

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-extended-osx-prefs-temp.js" > "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
            echo
        else
            cp -f "${PHOENIX_TEMP}/phoenix-extended-osx-prefs-temp.js" "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
            echo
        fi
        echo "Created ${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
        echo

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_PREFS}" || error_fn
        echo

        # Create .cfg file
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_OSX_PREFS}" "${PHOENIX_EXTENDED_OSX_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_OSX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_OSX_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX}.cfg" || error_fn
            echo
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [LINUX-NON-FLATPAK-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|LINUX-NON-FLATPAK-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_OSX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_CFG_OUTPUT_OSX}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_OSX_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX}" || error_fn
            echo
        fi
    fi
fi

# OS X (INTEL)
if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
    echo_green_text 'Building Phoenix for OS X (Intel)...'
    mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/Library/celenity" || error_fn
    echo
    mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_OSX_INTEL_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_ROOT}/README.md" "${PHOENIX_OSX_INTEL_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.css" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.html" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.css" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.html" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/phoenix.png" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ] || [ "${PHOENIX_SPECS}" == 1 ]; then
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs" || error_fn
        echo
        cp "${PHOENIX_BUILD_RESOURCES}/specs/README.md" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/extended" || error_fn
        echo
        cp -vrf "${PHOENIX_BUILD_RESOURCES}/extended/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/extended/" || error_fn
        echo
    fi

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD_RESOURCES}/specs/spec-welcome.txt" "${PHOENIX_OSX_INTEL_OUTPUTS}/assets/" || error_fn
        echo

        # Copy specialized config default permission files
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/twitter" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/permissions" "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/permissions" "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/permissions" "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/permissions" "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/permissions" "${PHOENIX_OSX_INTEL_OUTPUTS}/resources/specs/twitter/" || error_fn
        echo

        # Copy specialized config user.js files
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/extended" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/photopea" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/twitter" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/youtube-music" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix-base" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/youtube" || error_fn
        echo
        mkdir -vp "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/youtube-music" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/photopea/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/youtube-music/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/youtube-music/" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/apple-maps/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/base/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix-base/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/discord/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/element/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/extended/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/extended/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/google-maps/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/photopea/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/photopea/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/twitter/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/twitter/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/youtube/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/ui-fix/youtube-music/osx-intel/user.js" "${PHOENIX_OSX_INTEL_OUTPUTS}/userjs/ui-fix/youtube-music/" || error_fn
        echo
    fi

    # Copy OS X-specific files
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx-shared/Library/LaunchAgents" "${PHOENIX_OSX_INTEL_OUTPUTS}/Library/"

    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx-intel/Library/celenity/Phoenix" "${PHOENIX_OSX_INTEL_OUTPUTS}/Library/celenity/"
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx-intel/Library/LaunchAgents/" "${PHOENIX_OSX_INTEL_OUTPUTS}/Library/LaunchAgents/"
    cp -rf "${PHOENIX_BUILD_RESOURCES}/osx-intel/Library/LaunchDaemons" "${PHOENIX_OSX_INTEL_OUTPUTS}/Library/"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_OSX_INTEL_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_TEMP}/phoenix-bootstrap-osx-intel-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-bootstrap-osx-intel-temp.js" > "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-bootstrap-osx-intel-temp.js" "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_TEMP}/phoenix-osx-intel-prefs-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-osx-intel-prefs-temp.js" > "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-osx-intel-prefs-temp.js" "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_TEMP}/osx-intel.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/osx-intel.cfg" "${PHOENIX_OSX_INTEL_USER_PREF_CFG}" > "${PHOENIX_OSX_INTEL_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_TEMP}/phoenix-extended-osx-intel-prefs-temp.js" || error_fn
        echo

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-extended-osx-intel-prefs-temp.js" > "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
            echo
        else
            cp -f "${PHOENIX_TEMP}/phoenix-extended-osx-intel-prefs-temp.js" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
            echo
        fi
        echo "Created ${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
        echo

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" || error_fn
        echo

        # Create .cfg file
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_OSX_INTEL_PREFS}" "${PHOENIX_EXTENDED_OSX_INTEL_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_OSX_INTEL_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_OSX_INTEL}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_OSX_INTEL}.cfg" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_OSX_INTEL_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX_INTEL}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_OSX_INTEL}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_OSX_INTEL}.cfg" || error_fn
            echo
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [LINUX-NON-FLATPAK-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|LINUX-NON-FLATPAK-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_OSX_INTEL_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_CFG_OUTPUT_OSX_INTEL}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_OSX_INTEL_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_OSX_INTEL}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_OSX_INTEL}" || error_fn
            echo
        fi
    fi
fi

# WINDOWS
if [ "${PHOENIX_WINDOWS}" == 1 ]; then
    echo_green_text 'Building Phoenix for Windows...'
    mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/assets/about" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/configs/ui-fix" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/defaults/pref" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/distribution" || error_fn
    echo
    mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/unused" || error_fn
    echo

    # Copy license
    cp "${PHOENIX_ROOT}/COPYING.txt" "${PHOENIX_WINDOWS_OUTPUTS}/" || error_fn
    echo

    # Copy README
    cp "${PHOENIX_ROOT}/README.md" "${PHOENIX_WINDOWS_OUTPUTS}/" || error_fn
    echo

    # Copy assets
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.css" "${PHOENIX_WINDOWS_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/attribution.html" "${PHOENIX_WINDOWS_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.css" "${PHOENIX_WINDOWS_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/about/phoenix.html" "${PHOENIX_WINDOWS_OUTPUTS}/assets/about/" || error_fn
    echo
    cp "${PHOENIX_BUILD_RESOURCES}/assets/phoenix.png" "${PHOENIX_WINDOWS_OUTPUTS}/assets/" || error_fn
    echo

    if [ "${PHOENIX_SPECS}" == 1 ]; then
        cp "${PHOENIX_BUILD_RESOURCES}/specs/spec-welcome.txt" "${PHOENIX_WINDOWS_OUTPUTS}/assets/" || error_fn
        echo

        # Copy specialized config default permission files
        mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/apple-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/discord" || error_fn
        echo
        mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/element" || error_fn
        echo
        mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/google-maps" || error_fn
        echo
        mkdir -vp "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/twitter" || error_fn
        echo

        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/apple-maps/permissions" "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/apple-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/discord/permissions" "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/discord/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/element/permissions" "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/element/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/google-maps/permissions" "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/google-maps/" || error_fn
        echo
        cp -vf "${PHOENIX_BUILD_RESOURCES}/specs/twitter/permissions" "${PHOENIX_WINDOWS_OUTPUTS}/resources/specs/twitter/" || error_fn
        echo
    fi

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_USER_PREF_CFG}" > "${PHOENIX_WINDOWS_USER_PREF_CFG}" || error_fn
    echo
    echo "Created ${PHOENIX_WINDOWS_USER_PREF_CFG}"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_BOOTSTRAP}" > "${PHOENIX_TEMP}/phoenix-bootstrap-windows-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-bootstrap-windows-temp.js" > "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-bootstrap-windows-temp.js" "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_BUILD_RESOURCES}/phoenix-unified.js" > "${PHOENIX_TEMP}/phoenix-windows-prefs-temp.js" || error_fn
    echo

    if [ "${PHOENIX_MAIL}" == 1 ]; then
        # Remove lines containing [NO-MAIL]
        grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-windows-prefs-temp.js" > "${PHOENIX_WINDOWS_PREFS}" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/phoenix-windows-prefs-temp.js" "${PHOENIX_WINDOWS_PREFS}" || error_fn
        echo
    fi
    echo "Created ${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo

    # Update the version
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_BOOTSTRAP}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_PREFS}" || error_fn
    echo
    "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_WINDOWS_USER_PREF_CFG}" || error_fn
    echo

    # Create .cfg files
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_TEMP}/windows.cfg" || error_fn
    echo
    cat "${PHOENIX_TEMP}/windows.cfg" "${PHOENIX_WINDOWS_USER_PREF_CFG}" > "${PHOENIX_WINDOWS_CFG}" || error_fn
    echo

    if [ "${PHOENIX_EXTENDED}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTENDED_UNIFIED_PREFS}" > "${PHOENIX_TEMP}/phoenix-extended-windows-prefs-temp.js" || error_fn
        echo

        if [ "${PHOENIX_MAIL}" == 1 ]; then
            # Remove lines containing [NO-MAIL]
            grep -vE 'NO-MAIL' "${PHOENIX_TEMP}/phoenix-extended-windows-prefs-temp.js" > "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
            echo
        else
            cp -f "${PHOENIX_TEMP}/phoenix-extended-windows-prefs-temp.js" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
            echo
        fi
        echo "Created ${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
        echo

        # Update the version
        "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" || error_fn
        echo

        # Create .cfg file
        "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_WINDOWS_PREFS}" "${PHOENIX_EXTENDED_WINDOWS_CFG}" || error_fn
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

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_WINDOWS_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_WINDOWS}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_OUTPUT_FILENAME_WINDOWS}.cfg"
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_WINDOWS_PREFS}" "${PHOENIX_EXTRA_PREFS_JS_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_WINDOWS}" || error_fn
            echo

            "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTRA_EXTENDED_PREFS_JS_OUTPUT_WINDOWS}" "${PHOENIX_EXTRA_PREFS_JS_OUTPUT_DIR}/${PHOENIX_EXTRA_EXTENDED_OUTPUT_FILENAME_WINDOWS}.cfg"
        fi
    fi

    # Process and append contents of an additional specified .cfg file if necessary
    if [ "${PHOENIX_EXTRA_CFG}" == 1 ]; then
        # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [LINUX-NON-FLATPAK-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
        grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|LINUX-NON-FLATPAK-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "${PHOENIX_EXTRA_CFG_FILE}" > "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS}" || error_fn
        echo

        if [ "${PHOENIX_STANDARD}" == 1 ]; then
            cat "${PHOENIX_WINDOWS_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_CFG_OUTPUT_WINDOWS}" || error_fn
            echo
        fi

        if [ "${PHOENIX_EXTENDED}" == 1 ]; then
            cat "${PHOENIX_PLUS_EXTENDED_WINDOWS_CFG}" "${PHOENIX_EXTRA_CFG_FILE_PROCESSED_WINDOWS}" > "${PHOENIX_EXTRA_EXTENDED_CFG_OUTPUT_WINDOWS}" || error_fn
            echo
        fi
    fi
fi

# SPECIALIZED CONFIGS
if [ "${PHOENIX_SPECS}" == 1 ]; then

    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert.py" "${PHOENIX_EXTENDED_UNIFIED_PREFS}" "${PHOENIX_EXTENDED_UNIFIED_CFG}" || error_fn
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

if [ "${PHOENIX_MAIL}" == 1 ]; then
    cp -f "${PHOENIX_TEMP}/policies/temp2.json" "${PHOENIX_TEMP}/policies/temp0.json" || error_fn
    echo
else
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp2.json" "${PHOENIX_CORE_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0.json" || error_fn
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

if [ "${PHOENIX_MAIL}" == 1 ]; then
    cp -f "${PHOENIX_TEMP}/policies/temp98.json" "${PHOENIX_POLICIES}" || error_fn
    echo
else
    jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp98.json" "${PHOENIX_ONLY_POLICIES}" > "${PHOENIX_POLICIES}" || error_fn
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

    if [ "${PHOENIX_MAIL}" == 1 ]; then 
        cp -f "${PHOENIX_TEMP}/policies/temp4.json" "${PHOENIX_TEMP}/policies/temp000.json" || error_fn
        echo
    else
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp4.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp5.json" || error_fn
        echo
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp5.json" "${PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp000.json" || error_fn
        echo
    fi

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

    if [ "${PHOENIX_MAIL}" == 1 ]; then 
        cp -f "${PHOENIX_TEMP}/policies/temp6.json" "${PHOENIX_TEMP}/policies/temp0000.json" || error_fn
        echo
    else
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp6.json" "${PHOENIX_ONLY_LINUX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp7.json" || error_fn
        echo
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp7.json" "${PHOENIX_ONLY_LINUX_FLATPAK_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0000.json" || error_fn
        echo
    fi

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

    if [ "${PHOENIX_MAIL}" == 1 ]; then 
        cp -f "${PHOENIX_TEMP}/policies/temp9.json" "${PHOENIX_TEMP}/policies/temp000000.json" || error_fn
        echo
    else
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp9.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp10.json" || error_fn
        echo
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp10.json" "${PHOENIX_ONLY_OSX_SILICON_POLICIES}" > "${PHOENIX_TEMP}/policies/temp000000.json" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_SILICON}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp000000.json" "${PHOENIX_EXTRA_POLICIES_FILE_OSX_SILICON}" > "${PHOENIX_OSX_POLICIES_JSON}" || error_fn
        echo
        cp -f "${PHOENIX_OSX_POLICIES_JSON}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_SILICON}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp000000.json" "${PHOENIX_OSX_POLICIES_JSON}" || error_fn
        echo
    fi

    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert_json_to_plist.py" "${PHOENIX_OSX_POLICIES_JSON}" "${PHOENIX_OSX_POLICIES_PLIST}" || error_fn
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

    if [ "${PHOENIX_MAIL}" == 1 ]; then 
        cp -f "${PHOENIX_TEMP}/policies/temp11.json" "${PHOENIX_TEMP}/policies/temp0000000.json" || error_fn
        echo
    else
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp11.json" "${PHOENIX_ONLY_OSX_POLICIES}" > "${PHOENIX_TEMP}/policies/temp12.json" || error_fn
        echo
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp12.json" "${PHOENIX_ONLY_OSX_INTEL_POLICIES}" > "${PHOENIX_TEMP}/policies/temp0000000.json" || error_fn
        echo
    fi

    if [ "${PHOENIX_EXTRA_POLICIES_OSX_INTEL}" == 1 ]; then
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp0000000.json" "${PHOENIX_EXTRA_POLICIES_FILE_OSX_INTEL}" > "${PHOENIX_OSX_INTEL_POLICIES_JSON}" || error_fn
        echo
        cp -f "${PHOENIX_OSX_INTEL_POLICIES_JSON}" "${PHOENIX_EXTRA_POLICIES_OUTPUT_DIR_OSX_INTEL}/policies.json" || error_fn
        echo
    else
        cp -f "${PHOENIX_TEMP}/policies/temp0000000.json" "${PHOENIX_OSX_INTEL_POLICIES_JSON}" || error_fn
        echo
    fi

    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert_json_to_plist.py" "${PHOENIX_OSX_INTEL_POLICIES_JSON}" "${PHOENIX_OSX_INTEL_POLICIES_PLIST}" || error_fn
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

    if [ "${PHOENIX_MAIL}" == 1 ]; then 
        cp -f "${PHOENIX_TEMP}/policies/temp13.json" "${PHOENIX_TEMP}/policies/temp00000000.json" || error_fn
        echo
    else
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/policies/temp13.json" "${PHOENIX_ONLY_WINDOWS_POLICIES}" > "${PHOENIX_TEMP}/policies/temp00000000.json" || error_fn
        echo
    fi

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
