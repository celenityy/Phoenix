#
# Copyright (C) 2024-2026 celenity
#
# This file is part of Phoenix.
#
# Phoenix is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#
# Phoenix is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with Phoenix. If not, see https://www.gnu.org/licenses/.
#

# Environment variables for GNU/Linux distros that further harden Firefox for Phoenix
# Also impacts other Mozilla software (like Thunderbird)

# Disable Mozilla's ASan Crash Reporter
## https://searchfox.org/firefox-main/rev/409e9501/toolkit/xre/nsEmbedFunctions.cpp#260
## https://firefox-source-docs.mozilla.org/tools/sanitizer/asan_nightly.html
## https://github.com/choller/firefox-asan-reporter
export MOZ_DISABLE_ASAN_REPORTER=1;

# Disable Mozilla's Crash Reporter
## https://firefox-source-docs.mozilla.org/toolkit/crashreporter/crashreporter/index.html#user-specified-environment-variables
export MOZ_CRASHREPORTER='';
export MOZ_CRASHREPORTER_DISABLE=1;
export MOZ_CRASHREPORTER_NO_REPORT=1;
export MOZ_CRASHREPORTER_URL='data;';

# Disable SSLKEYLOGGING
## https://bugzilla.mozilla.org/show_bug.cgi?id=1183318
## https://bugzilla.mozilla.org/show_bug.cgi?id=1915224
export SSLKEYLOGFILE='';

# Enable Wayland
## Credit to Rasmus: https://askubuntu.com/users/13884/rasmus
## https://askubuntu.com/questions/1456684/how-to-initialize-firefox-on-wayland-always-by-default
if [ "${XDG_SESSION_TYPE}" == 'wayland' ]; then
    export MOZ_ENABLE_WAYLAND=1;
fi
