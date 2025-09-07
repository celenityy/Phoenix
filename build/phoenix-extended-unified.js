
//

//
// Copyright (C) 2024-2025 celenity
//
// This file is part of Phoenix.
//
// Phoenix is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
// Phoenix is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with Phoenix. If not, see https://www.gnu.org/licenses/.
//

// This file contains preferences shared across Phoenix 'Extended' configs.

/* INDEX 

001: FINGERPRINTING PROTECTION
002: WEBRTC
003: ATTACK SURFACE REDUCTION
004: MISC. PRIVACY + SECURITY (ANDROID ONLY)
005: MISC. PRIVACY

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[ANDROID-ONLY] = This preference should ONLY be set for Android
[FLATPAK-LINUX-ONLY] = This preference should ONLY be set for GNU/Linux (Flatpak)
[LINUX-ONLY] = This preference should ONLY be set for GNU/Linux
[INTEL-OSX-ONLY] = This preference should ONLY be set for macOS on Intel
[NON-FLATPAK-LINUX-ONLY] = This preference should ONLY be set for GNU/Linux (non-Flatpak)
[OSX-ONLY] = This preference should ONLY be set for macOS
[SILICON-OSX-ONLY] = This preference should ONLY be set for macOS on Apple Silicon
[WINDOWS-ONLY] = This preference should ONLY be set for Windows

[NO-ANDROID] = This preference should be set everywhere, EXCEPT for Android
[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-NON-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (non-Flatpak)
[NO-MAIL] = This preference should be set everywhere, EXCEPT for Thunderbird (Useful for ex. Dove)
[NO-OSX] = This preference should be set everywhere, EXCEPT for macOS
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
[NO-SILICON-OSX] = This preference should be set everywhere, EXCEPT for macOS on Apple Silicon
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

/// Add custom branding under `Firefox Updates` at `about:preferences#general` [NO-ANDROID]
// This will unfortunately only display if the version of Firefox you're using is repackaged (ex. Flatpaks/Linux distros) [NO-ANDROID]
pref("distribution.about", "Phoenix: Extended for Mozilla Firefox - 2025.09.07.1 💜", locked); // [NO-ANDROID]

/*** 001 FINGERPRINTING PROTECTION ***/

/// Enable dynamic rounding of content dimensions [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366 [NO-ANDROID] [NO-MAIL]
pref("privacy.resistFingerprinting.letterboxing", true); // [NO-ANDROID] [NO-MAIL]

/// Further harden FPP...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Extended#fingerprinting
// Compared to standard, this just removes '-JSDateTimeUTC' - meaning timezone is spoofed to UTC-0
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate"); // [NO-ANDROID] [NO-MAIL]
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-CanvasImageExtractionPrompt"); // [ANDROID-ONLY]
pref("browser.phoenix.status.extended", "001");

/*** 002 WEBRTC ***/
// This will likely break WebRTC...

/// Always exclude local IP addresses, even in trusted scenarios
pref("media.peerconnection.ice.no_host", true);

/// Force a single candidate for ICE generation
pref("media.peerconnection.ice.default_address_only", true);

/// Only use TURN servers/relays
// No P2P
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/40#note_2884663
pref("media.peerconnection.ice.relay_only", true);

pref("browser.phoenix.status.extended", "002");

/*** 003 ATTACK SURFACE REDUCTION ***/

/// Disable WebAssembly (WASM)
// https://spectrum.ieee.org/more-worries-over-the-security-of-web-assembly
pref("javascript.options.wasm", false);

pref("browser.phoenix.status.extended", "003");

/*** 004 MISC. PRIVACY + SECURITY ***/

/// Disable WebGL [ANDROID-ONLY]
// PRIVACY: Fingerprinting concerns [ANDROID-ONLY]
// SECURITY: Attack Surface Reduction [ANDROID-ONLY]
// https://blog.browserscan.net/docs/webgl-fingerprinting [ANDROID-ONLY]
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern [ANDROID-ONLY]
// On desktop we're no longer setting/recommending this in favor of the built-in `Block WebGL` filterlist in uBlock Origin, but on Android, we can't necessarily control uBlock Origin/set policies, so let's just make sure this is disabled. [ANDROID-ONLY]
pref("webgl.disabled", true); // [ANDROID-ONLY]

pref("browser.phoenix.status.extended", "004");

/*** 005 MISC. PRIVACY ***/

/// Only send cross-origin referers if hosts match
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginPolicy", 2);

pref("browser.phoenix.status.extended", "005");

pref("browser.phoenix.status.extended", "successfully applied :D", locked);
