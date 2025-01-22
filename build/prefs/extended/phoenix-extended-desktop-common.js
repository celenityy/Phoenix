//

// This file contains preferences shared across Phoenix (Extended) & Dove on Desktop.

// 001 ADVANCED FINGERPRINTING PROTECTION

/// Enable dynamic rounding of content dimensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", true);

pref("browser.phoenix.extended.desktop.common.status", "001", locked);

// 002 EXTENSIONS

// Only allow signed language packs & whitelisted extensions...

pref("extensions.langpacks.signatures.required", true, locked); // [DEFAULT]
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT]

pref("browser.phoenix.extended.desktop.common.status", "002", locked);

pref("browser.phoenix.extended.desktop.status", "successfully applied :D", locked);

