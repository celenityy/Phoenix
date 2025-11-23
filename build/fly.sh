#!/usr/bin/env bash

# Welcome to the Phoenix Unified build script!
# This script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

source "$phoenix_dir/build/env.sh"

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    mkdir -vp "$phoenix_linux_dir/assets/about"
    mkdir -vp "$phoenix_linux_dir/configs/ui-fix"
    mkdir -vp "$phoenix_linux_dir/defaults/pref"
    mkdir -vp "$phoenix_linux_dir/policies"
else
    mkdir -vp "$phoenix_android_dir"
    mkdir -vp "$phoenix_linux_dir/assets/about"
    mkdir -vp "$phoenix_linux_dir/configs/ui-fix"
	mkdir -vp "$phoenix_linux_dir/defaults/pref"
    mkdir -vp "$phoenix_linux_dir/policies"
    mkdir -vp "$phoenix_linux_flatpak_dir/assets/about"
    mkdir -vp "$phoenix_linux_flatpak_dir/configs/ui-fix"
    mkdir -vp "$phoenix_linux_flatpak_dir/defaults/pref"
    mkdir -vp "$phoenix_linux_flatpak_dir/policies"
    mkdir -vp "$phoenix_osx_dir/assets/about"
    mkdir -vp "$phoenix_osx_dir/configs/ui-fix"
    mkdir -vp "$phoenix_osx_dir/macos"
    mkdir -vp "$phoenix_osx_intel_dir/assets/about"
    mkdir -vp "$phoenix_osx_intel_dir/configs/ui-fix"
    mkdir -vp "$phoenix_windows_dir/assets/about"
    mkdir -vp "$phoenix_windows_dir/configs/ui-fix"
    mkdir -vp "$phoenix_windows_dir/distribution"
fi

mkdir -vp "$phoenix_dir/archives"
mkdir -vp /tmp/phoenix

export PHOENIX_LICENSE="COPYING.txt"
export PHOENIX_README="README.md"

export PHOENIX_UNIFIED_PREFS="build/phoenix-unified.js"

export PHOENIX_ANDROID_PREFS="$phoenix_android_dir/phoenix.js"
export PHOENIX_LINUX_FLATPAK_PREFS="$phoenix_linux_flatpak_dir/defaults/pref/phoenix-desktop.js"
export PHOENIX_LINUX_PREFS="$phoenix_linux_dir/defaults/pref/phoenix-desktop.js"
export PHOENIX_OSX_INTEL_PREFS="unused/macos-intel/phoenix.js"
export PHOENIX_OSX_PREFS="unused/macos/phoenix.js"
export PHOENIX_WINDOWS_PREFS="unused/windows/phoenix.js"

export PHOENIX_BOOTSTRAP="build/phoenix-bootstrap.js"

export PHOENIX_OSX_BOOTSTRAP="$phoenix_osx_dir/defaults/pref/phoenix.js"
export PHOENIX_OSX_INTEL_BOOTSTRAP="$phoenix_osx_intel_dir/defaults/pref/phoenix.js"
export PHOENIX_WINDOWS_BOOTSTRAP="$phoenix_windows_dir/defaults/pref/phoenix.js"

export PHOENIX_USER_PREF_CFG="build/phoenix-user-pref.cfg"

export PHOENIX_LINUX_FLATPAK_USER_PREF_CFG="$phoenix_linux_flatpak_dir/phoenix.cfg"
export PHOENIX_LINUX_USER_PREF_CFG="$phoenix_linux_dir/phoenix.cfg"

export PHOENIX_LINUX_CFG="unused/linux/phoenix.cfg"
export PHOENIX_LINUX_FLATPAK_CFG="unused/linux-flatpak/phoenix.cfg"
export PHOENIX_OSX_CFG="$phoenix_osx_dir/macos/phoenix.cfg"
export PHOENIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/phoenix.cfg"
export PHOENIX_WINDOWS_CFG="$phoenix_windows_dir/phoenix.cfg"

export PHOENIX_EXTENDED_UNIFIED_PREFS="build/phoenix-extended-unified.js"

export PHOENIX_EXTENDED_ANDROID_PREFS="$phoenix_android_dir/phoenix-extended.js"
export PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS="unused/linux-flatpak/phoenix-extended.js"
export PHOENIX_EXTENDED_LINUX_PREFS="unused/linux/phoenix-extended.js"
export PHOENIX_EXTENDED_OSX_INTEL_PREFS="unused/macos-intel/phoenix-extended.js"
export PHOENIX_EXTENDED_OSX_PREFS="unused/macos/phoenix-extended.js"
export PHOENIX_EXTENDED_WINDOWS_PREFS="unused/windows/phoenix-extended.js"

export PHOENIX_EXTENDED_LINUX_CFG="$phoenix_linux_dir/configs/hardened.cfg"
export PHOENIX_EXTENDED_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/hardened.cfg"
export PHOENIX_EXTENDED_OSX_CFG="$phoenix_osx_dir/configs/hardened.cfg"
export PHOENIX_EXTENDED_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/extended.cfg"
export PHOENIX_EXTENDED_WINDOWS_CFG="$phoenix_windows_dir/configs/hardened.cfg"

export PHOENIX_SPECIALIZED_UNIFIED_CFG="build/specialized-configs/specialized-unified.cfg"

export PHOENIX_EXTENDED_UNIFIED_CFG="build/specialized-configs/extended-unified.cfg"

export PHOENIX_SPECIALIZED_CFG="unused/configs/specialized.cfg"

export PHOENIX_SPECIALIZED_UNIFIED_APPLE_MAPS_CFG="build/specialized-configs/apple-maps-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_DISCORD_CFG="build/specialized-configs/discord-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_ELEMENT_CFG="build/specialized-configs/element-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_GOOGLE_MAPS_CFG="build/specialized-configs/google-maps-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_PHOTOPEA_CFG="build/specialized-configs/photopea-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_TWITTER_CFG="build/specialized-configs/twitter-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_CFG="build/specialized-configs/youtube-unified.cfg"
export PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_MUSIC_CFG="build/specialized-configs/youtube-music-unified.cfg"

export PHOENIX_SPECIALIZED_APPLE_MAPS_CFG="unused/configs/apple-maps.cfg"
export PHOENIX_SPECIALIZED_DISCORD_CFG="unused/configs/discord.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_CFG="unused/configs/element.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG="unused/configs/google-maps.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_CFG="unused/configs/photopea.cfg"
export PHOENIX_SPECIALIZED_TWITTER_CFG="unused/configs/twitter.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_CFG="unused/configs/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG="unused/configs/youtube-music.cfg"

export PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG="$phoenix_linux_dir/configs/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG="$phoenix_osx_dir/configs/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG="$phoenix_windows_dir/configs/apple-maps.cfg"

export PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG="$phoenix_linux_dir/configs/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_OSX_CFG="$phoenix_osx_dir/configs/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG="$phoenix_windows_dir/configs/discord.cfg"

export PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG="$phoenix_linux_dir/configs/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG="$phoenix_osx_dir/configs/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG="$phoenix_windows_dir/configs/element.cfg"

export PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG="$phoenix_linux_dir/configs/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG="$phoenix_osx_dir/configs/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG="$phoenix_windows_dir/configs/google-maps.cfg"

export PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG="$phoenix_linux_dir/configs/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG="$phoenix_osx_dir/configs/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG="$phoenix_windows_dir/configs/photopea.cfg"

export PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG="$phoenix_linux_dir/configs/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_OSX_CFG="$phoenix_osx_dir/configs/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG="$phoenix_windows_dir/configs/twitter.cfg"

export PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG="$phoenix_linux_dir/configs/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG="$phoenix_osx_dir/configs/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG="$phoenix_windows_dir/configs/youtube.cfg"

export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG="$phoenix_linux_dir/configs/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG="$phoenix_osx_dir/configs/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG="$phoenix_windows_dir/configs/youtube-music.cfg"

export PHOENIX_UI_FIX_UNIFIED_CFG="build/specialized-configs/ui-fix-unified.cfg"

export PHOENIX_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix.cfg"
export PHOENIX_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix.cfg"
export PHOENIX_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix.cfg"
export PHOENIX_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix.cfg"
export PHOENIX_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix.cfg"

export PHOENIX_EXTENDED_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/hardened.cfg"
export PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/hardened.cfg"
export PHOENIX_EXTENDED_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/hardened.cfg"
export PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/hardened.cfg"
export PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/hardened.cfg"

export PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/apple-maps.cfg"
export PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/apple-maps.cfg"

export PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/discord.cfg"
export PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/discord.cfg"

export PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/element.cfg"
export PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/element.cfg"

export PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/google-maps.cfg"
export PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/google-maps.cfg"

export PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/photopea.cfg"
export PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/photopea.cfg"

export PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/twitter.cfg"
export PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/twitter.cfg"

export PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/youtube.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/youtube.cfg"

export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG="$phoenix_linux_dir/configs/ui-fix/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG="$phoenix_linux_flatpak_dir/configs/ui-fix/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG="$phoenix_osx_dir/configs/ui-fix/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG="$phoenix_osx_intel_dir/configs/ui-fix/youtube-music.cfg"
export PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG="$phoenix_windows_dir/configs/ui-fix/youtube-music.cfg"

export PHOENIX_UNIFIED_POLICIES="build/policies/phoenix-unified.json"
export PHOENIX_ONLY_POLICIES="build/policies/phoenix-only.json"

export PHOENIX_BLOCKLIST_POLICIES="build/policies/blocklist.json"
export PHOENIX_COOKIES_POLICIES="build/policies/cookies.json"

export PHOENIX_ONLY_LINUX_FLATPAK_POLICIES="build/policies/phoenix-only-linux-flatpak.json"
export PHOENIX_ONLY_LINUX_POLICIES="build/policies/phoenix-only-linux.json"
export PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES="build/policies/phoenix-only-linux-non-flatpak.json"
export PHOENIX_ONLY_OSX_INTEL_POLICIES="build/policies/phoenix-only-osx-intel.json"
export PHOENIX_ONLY_OSX_POLICIES="build/policies/phoenix-only-osx.json"
export PHOENIX_ONLY_OSX_SILICON_POLICIES="build/policies/phoenix-only-osx-silicon.json"
export PHOENIX_ONLY_WINDOWS_POLICIES="build/policies/phoenix-only-windows.json"

export PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES="build/policies/phoenix-linux-flatpak-unified.json"
export PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES="build/policies/phoenix-linux-non-flatpak-unified.json"
export PHOENIX_UNIFIED_LINUX_POLICIES="build/policies/phoenix-linux-unified.json"
export PHOENIX_UNIFIED_OSX_INTEL_POLICIES="build/policies/phoenix-osx-intel-unified.json"
export PHOENIX_UNIFIED_OSX_POLICIES="build/policies/phoenix-osx-unified.json"
export PHOENIX_UNIFIED_OSX_SILICON_POLICIES="build/policies/phoenix-osx-silicon-unified.json"
export PHOENIX_UNIFIED_WINDOWS_POLICIES="build/policies/phoenix-windows-unified.json"

export PHOENIX_POLICIES="unused/policies/phoenix.json"

export PHOENIX_LINUX_POLICIES="$phoenix_linux_dir/policies/policies.json"
export PHOENIX_LINUX_FLATPAK_POLICIES="$phoenix_linux_flatpak_dir/policies/policies.json"
export PHOENIX_WINDOWS_POLICIES="$phoenix_windows_dir/distribution/policies.json"

export PHOENIX_OSX_INTEL_POLICIES_JSON="unused/macos-intel/policies.json"
export PHOENIX_OSX_INTEL_POLICIES_PLIST="$phoenix_osx_intel_dir/org.mozilla.firefox.plist"
export PHOENIX_OSX_POLICIES_JSON="unused/macos/policies.json"
export PHOENIX_OSX_POLICIES_PLIST="$phoenix_osx_dir/macos/org.mozilla.firefox.plist"

# ANDROID

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Android..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Copy license
    cp "$PHOENIX_LICENSE" "$phoenix_android_dir"/

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_ANDROID_PREFS"
    echo "Created $PHOENIX_ANDROID_PREFS"

    # Remove lines containing [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-ANDROID], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-ANDROID|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_ANDROID_PREFS"
    echo "Created $PHOENIX_EXTENDED_ANDROID_PREFS"
fi

# GNU/LINUX

# Copy license
cp "$phoenix_dir/build/linux/COPYING.txt" "$phoenix_linux_dir"/

# Copy README
cp "$phoenix_dir/build/linux/README.md" "$phoenix_linux_dir"/

# Copy assets
cp "$phoenix_dir/build/assets/about/attribution.css" "$phoenix_linux_dir"/assets/about/
cp "$phoenix_dir/build/assets/about/attribution.html" "$phoenix_linux_dir"/assets/about/
cp "$phoenix_dir/build/assets/about/phoenix.css" "$phoenix_linux_dir"/assets/about/
cp "$phoenix_dir/build/assets/about/phoenix.html" "$phoenix_linux_dir"/assets/about/
cp "$phoenix_dir/build/assets/phoenix.png" "$phoenix_linux_dir"/assets/

# Copy environment variables
mkdir -vp "$phoenix_linux_dir/etc/profile.d"
cp "$phoenix_dir/build/linux/etc/profile.d/phoenix-env-overrides.sh" "$phoenix_linux_dir/etc/profile.d/phoenix-env-overrides.sh"

# Copy specialized config user.js files
mkdir -vp "$phoenix_linux_dir/userjs/apple-maps"
mkdir -vp "$phoenix_linux_dir/userjs/discord"
mkdir -vp "$phoenix_linux_dir/userjs/element"
mkdir -vp "$phoenix_linux_dir/userjs/extended"
mkdir -vp "$phoenix_linux_dir/userjs/google-maps"
mkdir -vp "$phoenix_linux_dir/userjs/photopea"
mkdir -vp "$phoenix_linux_dir/userjs/twitter"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/apple-maps"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/discord"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/element"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/extended"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/google-maps"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/photopea"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/twitter"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/youtube"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix/youtube-music"
mkdir -vp "$phoenix_linux_dir/userjs/ui-fix-base"
mkdir -vp "$phoenix_linux_dir/userjs/youtube"
mkdir -vp "$phoenix_linux_dir/userjs/youtube-music"

cp -vrf "$phoenix_dir/build/linux/userjs" "$phoenix_linux_dir/"

# Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_USER_PREF_CFG" > "$PHOENIX_LINUX_USER_PREF_CFG"
echo "Created $PHOENIX_LINUX_USER_PREF_CFG"

# Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_LINUX_PREFS"
echo "Created $PHOENIX_LINUX_PREFS"

python3 build/convert.py "$PHOENIX_LINUX_PREFS" "$PHOENIX_LINUX_CFG"

# Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_LINUX_PREFS"
echo "Created $PHOENIX_EXTENDED_LINUX_PREFS"

python3 build/convert.py "$PHOENIX_EXTENDED_LINUX_PREFS" "$PHOENIX_EXTENDED_LINUX_CFG"

# GNU/LINUX (FLATPAK)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Flatpak..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Copy license
    cp "$PHOENIX_LICENSE" "$phoenix_linux_flatpak_dir"/

    # Copy README
    cp "$PHOENIX_README" "$phoenix_linux_flatpak_dir"/

    # Copy assets
    cp "$phoenix_dir/build/assets/about/attribution.css" "$phoenix_linux_flatpak_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/attribution.html" "$phoenix_linux_flatpak_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.css" "$phoenix_linux_flatpak_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.html" "$phoenix_linux_flatpak_dir"/assets/about/
    cp "$phoenix_dir/build/assets/phoenix.png" "$phoenix_linux_flatpak_dir"/assets/

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_USER_PREF_CFG" > "$PHOENIX_LINUX_FLATPAK_USER_PREF_CFG"
    echo "Created $PHOENIX_LINUX_FLATPAK_USER_PREF_CFG"

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_LINUX_FLATPAK_PREFS"
    echo "Created $PHOENIX_LINUX_FLATPAK_PREFS"

    python3 build/convert.py "$PHOENIX_LINUX_FLATPAK_PREFS" "$PHOENIX_LINUX_FLATPAK_CFG"

    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS"
    echo "Created $PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS"

    python3 build/convert.py "$PHOENIX_EXTENDED_LINUX_FLATPAK_PREFS" "$PHOENIX_EXTENDED_LINUX_FLATPAK_CFG"
fi

# MACOS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Copy license
    cp "$PHOENIX_LICENSE" "$phoenix_osx_dir"/

    # Copy README
    cp "$PHOENIX_README" "$phoenix_osx_dir"/

    # Copy assets
    cp "$phoenix_dir/build/assets/about/attribution.css" "$phoenix_osx_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/attribution.html" "$phoenix_osx_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.css" "$phoenix_osx_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.html" "$phoenix_osx_dir"/assets/about/
    cp "$phoenix_dir/build/assets/phoenix.png" "$phoenix_osx_dir"/assets/

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [NON-FLATPAK-LINUX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_BOOTSTRAP" > "$PHOENIX_OSX_BOOTSTRAP"
    echo "Created $PHOENIX_OSX_BOOTSTRAP"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [NON-FLATPAK-LINUX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_OSX_PREFS"
    echo "Created $PHOENIX_OSX_PREFS"

    python3 build/convert.py "$PHOENIX_OSX_PREFS" /tmp/phoenix/phoenix-osx-tmp.cfg

    # Add "user" prefs
    cat /tmp/phoenix/phoenix-osx-tmp.cfg "$PHOENIX_USER_PREF_CFG" > "$PHOENIX_OSX_CFG"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [NON-FLATPAK-LINUX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_OSX_PREFS"
    echo "Created $PHOENIX_EXTENDED_OSX_PREFS"

    python3 build/convert.py "$PHOENIX_EXTENDED_OSX_PREFS" "$PHOENIX_EXTENDED_OSX_CFG"
fi

# MACOS (INTEL)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS Intel..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Copy license
    cp "$PHOENIX_LICENSE" "$phoenix_osx_intel_dir"/

    # Copy README
    cp "$PHOENIX_README" "$phoenix_osx_intel_dir"/

    # Copy assets
    cp "$phoenix_dir/build/assets/about/attribution.css" "$phoenix_osx_intel_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/attribution.html" "$phoenix_osx_intel_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.css" "$phoenix_osx_intel_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.html" "$phoenix_osx_intel_dir"/assets/about/
    cp "$phoenix_dir/build/assets/phoenix.png" "$phoenix_osx_intel_dir"/assets/

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [NON-FLATPAK-LINUX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_BOOTSTRAP" > "$PHOENIX_OSX_INTEL_BOOTSTRAP"
    echo "Created $PHOENIX_OSX_INTEL_BOOTSTRAP"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [NON-FLATPAK-LINUX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_OSX_INTEL_PREFS"
    echo "Created $PHOENIX_OSX_INTEL_PREFS"

    python3 build/convert.py "$PHOENIX_OSX_INTEL_PREFS" /tmp/phoenix/phoenix-osx-intel-tmp.cfg

    # Add "user" prefs
    cat /tmp/phoenix/phoenix-osx-intel-tmp.cfg "$PHOENIX_USER_PREF_CFG" > "$PHOENIX_OSX_INTEL_CFG"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [NON-FLATPAK-LINUX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_OSX_INTEL_PREFS"
    echo "Created $PHOENIX_EXTENDED_OSX_INTEL_PREFS"

    python3 build/convert.py "$PHOENIX_EXTENDED_OSX_INTEL_PREFS" "$PHOENIX_EXTENDED_OSX_INTEL_CFG"
fi

# WINDOWS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Windows..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Copy license
    cp "$PHOENIX_LICENSE" "$phoenix_windows_dir"/

    # Copy README
    cp "$PHOENIX_README" "$phoenix_windows_dir"/

    # Copy assets
    cp "$phoenix_dir/build/assets/about/attribution.css" "$phoenix_windows_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/attribution.html" "$phoenix_windows_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.css" "$phoenix_windows_dir"/assets/about/
    cp "$phoenix_dir/build/assets/about/phoenix.html" "$phoenix_windows_dir"/assets/about/
    cp "$phoenix_dir/build/assets/phoenix.png" "$phoenix_windows_dir"/assets/

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_BOOTSTRAP" > "$PHOENIX_WINDOWS_BOOTSTRAP"
    echo "Created $PHOENIX_WINDOWS_BOOTSTRAP"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_UNIFIED_PREFS" > "$PHOENIX_WINDOWS_PREFS"
    echo "Created $PHOENIX_WINDOWS_PREFS"

    python3 build/convert.py "$PHOENIX_WINDOWS_PREFS" /tmp/phoenix/phoenix-windows-tmp.cfg

    # Add "user" prefs
    cat /tmp/phoenix/phoenix-windows-tmp.cfg "$PHOENIX_USER_PREF_CFG" > "$PHOENIX_WINDOWS_CFG"

    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY] 
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_EXTENDED_UNIFIED_PREFS" > "$PHOENIX_EXTENDED_WINDOWS_PREFS"
    echo "Created $PHOENIX_EXTENDED_WINDOWS_PREFS"

    python3 build/convert.py "$PHOENIX_EXTENDED_WINDOWS_PREFS" "$PHOENIX_EXTENDED_WINDOWS_CFG"
fi

# SPECIALIZED CONFIGS

python3 build/convert.py "$PHOENIX_EXTENDED_UNIFIED_PREFS" "$PHOENIX_EXTENDED_UNIFIED_CFG"

cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_CFG"
cat "$PHOENIX_EXTENDED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_CFG" "$PHOENIX_SPECIALIZED_UNIFIED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG"

# GNU/LINUX

# Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG"

grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG"

# GNU/LINUX (FLATPAK)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Flatpak specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG"

    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG"
fi

# MACOS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [NON-FLATPAK-LINUX-ONLY] and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG"
fi

# MACOS (INTEL)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS Intel specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [NON-FLATPAK-LINUX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG"
fi

# WINDOWS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Windows specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY],
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_APPLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_DISCORD_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_ELEMENT_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_PHOTOPEA_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_TWITTER_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG"

    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG"
fi

# UI FIX

# GNU/LINUX

# Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [NO-LINUX], [NO-NON-FLATPAK-LINUX], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|NO-LINUX|NO-NON-FLATPAK-LINUX|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "$PHOENIX_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_UI_FIX_LINUX_CFG"

cat "$PHOENIX_EXTENDED_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_EXTENDED_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_EXTENDED_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_DISCORD_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_ELEMENT_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_TWITTER_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_YOUTUBE_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_CFG"

cat "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_CFG" "$PHOENIX_UI_FIX_LINUX_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG"
echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_CFG"

# GNU/LINUX (FLATPAK)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Flatpak UI-Fix specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [INTEL-OSX-ONLY], [NO-FLATPAK-LINUX], [NO-LINUX], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|INTEL-OSX-ONLY|NO-FLATPAK-LINUX|NO-LINUX|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_EXTENDED_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_EXTENDED_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_APPLE_MAPS_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_DISCORD_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_ELEMENT_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_PHOTOPEA_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_TWITTER_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_LINUX_FLATPAK_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_LINUX_FLATPAK_CFG" "$PHOENIX_UI_FIX_LINUX_FLATPAK_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_LINUX_FLATPAK_CFG"
fi

# MACOS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS UI-Fix specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-OSX], [NO-SILICON-OSX], [NON-FLATPAK-LINUX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-OSX|NO-SILICON-OSX|NON-FLATPAK-LINUX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "$PHOENIX_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_UI_FIX_OSX_CFG"

    cat "$PHOENIX_EXTENDED_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_EXTENDED_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_EXTENDED_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_DISCORD_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_ELEMENT_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_PHOTOPEA_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_TWITTER_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_CFG" "$PHOENIX_UI_FIX_OSX_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_CFG"
fi

# MACOS (INTEL)

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS Intel UI-Fix specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [LINUX-ONLY], [NO-INTEL-OSX], [NO-OSX], [NON-FLATPAK-LINUX-ONLY], [SILICON-OSX-ONLY], and [WINDOWS-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|LINUX-ONLY|NO-INTEL-OSX|NO-OSX|NON-FLATPAK-LINUX-ONLY|SILICON-OSX-ONLY|WINDOWS-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "$PHOENIX_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_EXTENDED_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_EXTENDED_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_APPLE_MAPS_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_DISCORD_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_ELEMENT_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_PHOTOPEA_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_TWITTER_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_OSX_INTEL_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_OSX_INTEL_CFG" "$PHOENIX_UI_FIX_OSX_INTEL_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_OSX_INTEL_CFG"
fi

# WINDOWS

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Windows UI-Fix specialized configs..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    # Remove lines containing [ANDROID-ONLY], [FLATPAK-LINUX-ONLY], [INTEL-OSX-ONLY], [LINUX-ONLY], [NO-WINDOWS], [NON-FLATPAK-LINUX-ONLY], [OSX-ONLY], and [SILICON-OSX-ONLY]
    grep -vE 'ANDROID-ONLY|FLATPAK-LINUX-ONLY|INTEL-OSX-ONLY|LINUX-ONLY|NO-WINDOWS|NON-FLATPAK-LINUX-ONLY|OSX-ONLY|SILICON-OSX-ONLY' "$PHOENIX_UI_FIX_UNIFIED_CFG" > "$PHOENIX_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_EXTENDED_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_EXTENDED_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_APPLE_MAPS_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_APPLE_MAPS_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_DISCORD_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_DISCORD_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_ELEMENT_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_ELEMENT_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_GOOGLE_MAPS_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_PHOTOPEA_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_PHOTOPEA_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_TWITTER_OSX_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_TWITTER_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_UI_FIX_WINDOWS_CFG"

    cat "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_WINDOWS_CFG" "$PHOENIX_UI_FIX_WINDOWS_CFG" > "$PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG"
    echo "Created $PHOENIX_SPECIALIZED_YOUTUBE_MUSIC_UI_FIX_WINDOWS_CFG"
fi

# POLICIES

jq -s '.[0] * .[1]' "$PHOENIX_UNIFIED_POLICIES" "$PHOENIX_BLOCKLIST_POLICIES" > /tmp/phoenix/temp1.json

jq -s '.[0] * .[1]' /tmp/phoenix/temp1.json "$PHOENIX_COOKIES_POLICIES" > /tmp/phoenix/temp2.json

jq -s '.[0] * .[1]' /tmp/phoenix/temp2.json "$PHOENIX_ONLY_POLICIES" > "$PHOENIX_POLICIES"

jq -s '.[0] * .[1]' "$PHOENIX_POLICIES" "$PHOENIX_UNIFIED_LINUX_POLICIES" > /tmp/phoenix/temp3.json

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Flatpak policies..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    jq -s '.[0] * .[1]' /tmp/phoenix/temp3.json "$PHOENIX_UNIFIED_LINUX_FLATPAK_POLICIES" > /tmp/phoenix/temp4.json
    jq -s '.[0] * .[1]' /tmp/phoenix/temp4.json "$PHOENIX_ONLY_LINUX_POLICIES" > /tmp/phoenix/temp5.json
    jq -s '.[0] * .[1]' /tmp/phoenix/temp5.json "$PHOENIX_ONLY_LINUX_FLATPAK_POLICIES" > "$PHOENIX_LINUX_FLATPAK_POLICIES"
fi

jq -s '.[0] * .[1]' /tmp/phoenix/temp3.json "$PHOENIX_UNIFIED_LINUX_NONFLATPAK_POLICIES" > /tmp/phoenix/temp6.json

jq -s '.[0] * .[1]' /tmp/phoenix/temp6.json "$PHOENIX_ONLY_LINUX_POLICIES" > /tmp/phoenix/temp7.json

jq -s '.[0] * .[1]' /tmp/phoenix/temp7.json "$PHOENIX_ONLY_LINUX_NONFLATPAK_POLICIES" > "$PHOENIX_LINUX_POLICIES"

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS policies..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    jq -s '.[0] * .[1]' "$PHOENIX_POLICIES" "$PHOENIX_UNIFIED_OSX_POLICIES" > /tmp/phoenix/temp8.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp8.json "$PHOENIX_UNIFIED_OSX_SILICON_POLICIES" > /tmp/phoenix/temp9.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp9.json "$PHOENIX_ONLY_OSX_POLICIES" > /tmp/phoenix/temp10.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp10.json "$PHOENIX_ONLY_OSX_SILICON_POLICIES" > "$PHOENIX_OSX_POLICIES_JSON"

    jq -s '.[0] * .[1]' /tmp/phoenix/temp8.json "$PHOENIX_UNIFIED_OSX_INTEL_POLICIES" > /tmp/phoenix/temp11.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp11.json "$PHOENIX_ONLY_OSX_POLICIES" > /tmp/phoenix/temp12.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp12.json "$PHOENIX_ONLY_OSX_INTEL_POLICIES" > "$PHOENIX_OSX_INTEL_POLICIES_JSON"

    python3 build/convert_json_to_plist.py "$PHOENIX_OSX_INTEL_POLICIES_JSON" "$PHOENIX_OSX_INTEL_POLICIES_PLIST"

    python3 build/convert_json_to_plist.py "$PHOENIX_OSX_POLICIES_JSON" "$PHOENIX_OSX_POLICIES_PLIST"
fi

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Windows policies..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
    jq -s '.[0] * .[1]' "$PHOENIX_POLICIES" "$PHOENIX_UNIFIED_WINDOWS_POLICIES" > /tmp/phoenix/temp13.json

    jq -s '.[0] * .[1]' /tmp/phoenix/temp13.json "$PHOENIX_ONLY_WINDOWS_POLICIES" > "$PHOENIX_WINDOWS_POLICIES"
fi

rm -rf /tmp/phoenix
