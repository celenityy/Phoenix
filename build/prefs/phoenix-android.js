//

// This file contains preferences specific to Phoenix on Android.

// 001 MOZILLA CRAP™

/// Remove Mozilla URL tracking params

pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/android/search?q=%TERMS%");

pref("browser.phoenix.android.status", "001");

// 002 SAFE BROWSING

/// Enable Safe Browsing by default

pref("browser.safebrowsing.features.malware.update", true); // [DEFAULT]
pref("browser.safebrowsing.features.phishing.update", true); // [DEFAULT]

pref("browser.phoenix.android.status", "002");

// 003 EXTENSIONS

/// Only allow signed extensions

pref("xpinstall.signatures.required", true); // [DEFAULT]

pref("browser.phoenix.android.status", "003");

// 004 FINGERPRINTING PROTECTION

/// Harden FPP (which we already enable above) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// https://discuss.privacyguides.net/t/does-partial-resistfingerprinting-make-any-sense/18827/4
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC");

/// Enable dynamic rounding of content dimensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN]

pref("browser.phoenix.android.status", "004");

// 005 MISC. SECURITY

// Always warn users before launching other apps...

pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.android.status", "005");

pref("browser.phoenix.android.status", "successfully applied :D", locked);

