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

// This file contains preferences specific to Phoenix on Android.

// 001 MOZILLA CRAP™

/// Remove Mozilla URL tracking params

pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/android/search?q=%TERMS%");

pref("browser.phoenix.status.android", "001");

// 002 EXTENSIONS

/// Only allow signed extensions by default

pref("extensions.langpacks.signatures.required", true); // [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [DEFAULT]

pref("browser.phoenix.status.android", "002");

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
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// DoorDash (doordash.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mozilla.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Favicon.io (favicon.io)  - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks downloading converted files
// GitLab (gitlab.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Jersey Mike's (jerseymikes.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// miniPaint (viliusle.github.io) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks extracting/saving projects (https://codeberg.org/celenity/Phoenix/issues/68)
// Photopea (photopea.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pornhub (pornhub.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks thumbnail seeking
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// Watch Duty (watchduty.org) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues
// X/Twitter (x.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...

pref("privacy.fingerprintingProtection.granularOverrides", "[{\"firstPartyDomain\": \"arcticfoxes.net\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"aria.im\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"bsky.app\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"brave.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"chipotle.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"cinny.in\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"citybbq.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"discord.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"doordash.com\", \"overrides\": \"-JSDateTimeUTC\"},  {\"firstPartyDomain\": \"element.io\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"favicon.io\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"gitlab.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"jerseymikes.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"mozilla.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"photopea.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"pornhub.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"proton.me\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"unredacted.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"viliusle.github.io\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"watchduty.org\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}, {\"firstPartyDomain\": \"x.com\", \"overrides\": \"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt\"}]");

/// Enable dynamic rounding of content dimensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN]

pref("browser.phoenix.status.android", "003");

// 004 PASSWORDS & AUTHENTICATION

/// Re-enable formless capture in standard windows
// See `018` at `Phoenix-Core` for details
// We still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/11

pref("signon.formlessCapture.enabled", true); // [DEFAULT]

pref("browser.phoenix.status.android", "004");

// 005 ATTACK SURFACE REDUCTION

/// Re-enable the JIT Baseline Interpreter, due to severe performance issues some users have been experiencing...
// ex. https://gitlab.com/ironfox-oss/IronFox/-/issues/18

pref("javascript.options.blinterp", true); // [DEFAULT]

pref("browser.phoenix.status.android", "005");

// 006 MISC. SECURITY

/// Always warn users before launching other apps...

pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.status.android", "006");

// 007 MEDIA

/// Disable Widevine MediaDrm/MediaKeySystem
// https://developer.android.com/reference/android/media/MediaDrm
// https://bugzilla.mozilla.org/show_bug.cgi?id=1306219

pref("media.mediadrm-widevinecdm.visible", false);

pref("browser.phoenix.status.android", "007");

// 008 PERFORMANCE

pref("browser.sessionstore.max_tabs_undo", 7);
pref("network.http.max-connections", 256); // [Default = 128]

pref("browser.phoenix.status.android", "008");

pref("browser.phoenix.status.android", "successfully applied :D", locked);

