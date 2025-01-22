//

// This file contains preferences specific to Phoenix (Extended) on Desktop.

// 001 ADVANCED FINGERPRINTING PROTECTION

/// Further harden FPP...
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// Compared to standard, this just removes '-JSDateTimeUTC' - meaning timezone is spoofed to UTC-0...

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate");

pref("browser.phoenix.extended.desktop.status", "001");

pref("browser.phoenix.extended.desktop.status", "successfully applied :D", locked);

