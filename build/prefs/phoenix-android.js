//

// This file contains preferences specific to Phoenix on Android.

// 001 MOZILLA CRAP™

/// Remove Mozilla URL tracking params

pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/android/search?q=%TERMS%");

pref("browser.phoenix.android.status", "001");

// 002 EXTENSIONS

/// Only allow signed extensions by default

pref("extensions.langpacks.signatures.required", true); // [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [DEFAULT]

pref("browser.phoenix.android.status", "002");

// 003 FINGERPRINTING PROTECTION

/// Harden FPP (which we already enable above) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// https://discuss.privacyguides.net/t/does-partial-resistfingerprinting-make-any-sense/18827/4
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Bluesky (bsky.app) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Brave Search (brave.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mozilla.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Favicon.io (favicon.io)  - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks downloading converted files
// GitLab (gitlab.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Photopea (photopea.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pornhub (pornhub.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks thumbnail seeking
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// Watch Duty (watchduty.org) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues
// X/Twitter (x.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...

pref("privacy.fingerprintingProtection.granularOverrides", "[{\"firstPartyDomain\": \"arcticfoxes.net\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"aria.im\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"bsky.app\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"brave.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"cinny.in\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"discord.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"element.io\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"favicon.io\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"gitlab.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"mozilla.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"photopea.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"pornhub.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"proton.me\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"unredacted.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"watchduty.org\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"x.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}]");

/// Enable dynamic rounding of content dimensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN]

pref("browser.phoenix.android.status", "003");

// 004 ATTACK SURFACE REDUCTION

// Re-enable the JIT Baseline Interpreter, due to severe performance issues some users have been experiencing...
// ex. https://gitlab.com/ironfox-oss/IronFox/-/issues/18

pref("javascript.options.blinterp", true); // [DEFAULT]

pref("browser.phoenix.android.status", "004");

// 005 MISC. SECURITY

// Always warn users before launching other apps...

pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.android.status", "005");

// 006 MEDIA

/// Disable Widevine MediaDrm/MediaKeySystem
// https://developer.android.com/reference/android/media/MediaDrm
// https://bugzilla.mozilla.org/show_bug.cgi?id=1306219

pref("media.mediadrm-widevinecdm.visible", false);

pref("browser.phoenix.android.status", "006");

pref("browser.phoenix.android.status", "successfully applied :D", locked);

