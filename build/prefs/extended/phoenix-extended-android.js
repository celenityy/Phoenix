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

// This file contains preferences specific to Phoenix (Extended) on Android.

/* INDEX 

001: FINGERPRINTING PROTECTION

*/

/*** 001 FINGERPRINTING PROTECTION ***/

/// Further harden FPP...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Extended#fingerprinting
// Compared to standard, this just removes '-JSDateTimeUTC' - meaning timezone is spoofed to UTC-0
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasImageExtractionPrompt,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSLocale");

pref("browser.phoenix.status.extended.android", "001");

/*** 002 MISC. PRIVACY + SECURITY ***/

/// Disable WebGL
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://blog.browserscan.net/docs/webgl-fingerprinting
// https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern
// On desktop we're no longer setting/recommending this in favor of the built-in `Block WebGL` filterlist in uBlock Origin (and I'm sure we'll also override this on IronFox once we get our custom config working...), but on Android we can't control uBlock Origin/set policies, so let's make sure this is disabled.
pref("webgl.disabled", true);

pref("browser.phoenix.status.extended.android", "002");

pref("browser.phoenix.status.extended.android", "successfully applied :D", locked);

