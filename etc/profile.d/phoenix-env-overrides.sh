#!/bin/sh

# Environment variables for GNU/Linux distros that further harden Firefox for Phoenix

# Enable Wayland
export MOZ_ENABLE_WAYLAND=1;

# Disable Crash Reporting
export MOZ_CRASHREPORTER_NO_REPORT=1;
export MOZ_CRASHREPORTER_URL="";
export MOZ_CRASHREPORTER_DISABLE=1;
export MOZ_CRASHREPORTER_AUTO_SUBMIT=0;
export MOZ_CRASHREPORTER=0;

# Disable Telemetry
export MOZ_SERVICES_HEALTHREPORT=0;
export MOZ_NORMANDY=0;
export MOZ_TELEMETRY_REPORTING=0;
export MOZ_ASAN_REPORTER=0;
export MOZ_GLEAN_ANDROID=0;

# Misc.
export MOZ_REQUIRE_SIGNING=1;
export MOZ_DISABLE_PARENTAL_CONTROLS=1;

# Branding
export MOZ_APP_VENDOR="Phoenix";