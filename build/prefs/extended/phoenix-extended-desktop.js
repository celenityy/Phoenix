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

// This file contains preferences specific to Phoenix (Extended) on Desktop.

/* INDEX 

001: FINGERPRINTING PROTECTION

*/

/*** 001 FINGERPRINTING PROTECTION ***/

/// Further harden FPP...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Extended#fingerprinting
// Compared to standard, this just removes '-JSDateTimeUTC' - meaning timezone is spoofed to UTC-0
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSLocale");

pref("browser.phoenix.status.extended.desktop", "successfully applied :D", locked);

