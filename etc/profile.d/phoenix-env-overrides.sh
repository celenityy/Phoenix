#!/bin/sh

# Environment variables for GNU/Linux distros that further harden Firefox for Phoenix
# Also impacts other Mozilla software (like Thunderbird)

# Disable Crash Reporting
# https://firefox-source-docs.mozilla.org/toolkit/crashreporter/crashreporter/index.html#user-specified-environment-variables
export MOZ_CRASHREPORTER=0;
export MOZ_CRASHREPORTER_DISABLE=1;
export MOZ_CRASHREPORTER_NO_REPORT=1;
export MOZ_CRASHREPORTER_URL="data;";

# Enable Wayland
# Credit to Rasmus: https://askubuntu.com/users/13884/rasmus
# https://askubuntu.com/questions/1456684/how-to-initialize-firefox-on-wayland-always-by-default
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi
