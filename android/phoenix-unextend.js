//
// Unextend Phoenix...

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

// By default, IronFox uses Phoenix's 'Extended' Hardening config. This will cause breakage, and may not be desirable for everyone.
// So this exists to easily revert IronFox to use Phoenix's standard 'base'/recommended config instead.

/* INDEX 

001: FINGERPRINTING PROTECTION
002: WEBRTC
003: MISC. PRIVACY

*/

/*** 001 FINGERPRINTING PROTECTION ***/

/// Set FPP to only cover our default targets
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC,-JSLocale");

pref("browser.phoenix.status.unextended", "001");

/*** 002 WEBRTC ***/

/// Do not always exclude local IP addresses, even in trusted scenarios
pref("media.peerconnection.ice.no_host", false); // [DEFAULT]

/// Do not force a single candidate for ICE generation
pref("media.peerconnection.ice.default_address_only", false); // [DEFAULT]

/// Do not only use TURN servers/relays
// P2P
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/40#note_2884663
pref("media.peerconnection.ice.relay_only", false); // [DEFAULT]

pref("browser.phoenix.status.unextended", "002");

/*** 003 MISC. PRIVACY ***/

/// Always send cross-origin referers, regardless of if hosts match
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginPolicy", 0); // [DEFAULT]

pref("browser.phoenix.status.unextended", "003");

pref("browser.phoenix.status.unextended", "successfully applied :D");
