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

/* INDEX 

001: MOZILLA CRAP™
002: FINGERPRINTING PROTECTION
003: MEDIA
004: ATTACK SURFACE REDUCTION
005: PASSWORDS & AUTHENTICATION
006: EXTENSIONS
007: MISC. SECURITY
008: PERFORMANCE

*/

/*** 001 MOZILLA CRAP™ ***/

/// Remove tracking parameters from Mozilla URLs
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/android/search?q=%TERMS%");

pref("browser.phoenix.status.android", "001");

/*** 002 FINGERPRINTING PROTECTION ***/

/// Enable dynamic rounding of content dimensions
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366
pref("privacy.resistFingerprinting.letterboxing", true); // [HIDDEN]

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Android#fingerprinting
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC,-JSLocale");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Bluesky (bsky.app) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Brave Search (brave.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny (pendora.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/Element (transfem.dev) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/SchildiChat (the-apothecary.club) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// DoorDash (doordash.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (bitcoinist.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (chatwave.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (duesen.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (flieger.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (g24.at) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (gemeinsam.jetzt) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (gnulinux.club) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (hot-chilli.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (kosmikdog.eu) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mtrx.nz) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (neat.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (nitro.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (nope.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (oblak.be) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (pcriot.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (rollenspiel.chat) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (socialnetwork24.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (studichat.de) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (synod.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (utwente.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (we2.ee) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (yatrix.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Favicon.io (favicon.io)  - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks downloading converted files
// GitLab (gitlab.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Jersey Mike's (jerseymikes.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// miniPaint (viliusle.github.io) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks extracting/saving projects (https://codeberg.org/celenity/Phoenix/issues/68)
// Photopea (photopea.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pornhub (pornhub.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks thumbnail seeking
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// Watch Duty (watchduty.org) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues
// X/Twitter (x.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain": "arcticfoxes.net", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "aria.im", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "bitcoinist.org", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "bsky.app", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "brave.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "chatwave.org", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "chipotle.com", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "cinny.in", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "citybbq.com", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "discord.com", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "doordash.com", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "duesen.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "element.io", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "favicon.io", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "flieger.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "g24.at", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "gemeinsam.jetzt", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "gitlab.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "gnulinux.club", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "hot-chilli.im", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "jerseymikes.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "kosmikdog.eu", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "mtrx.nz", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "neat.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "nitro.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "nope.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "oblak.be", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "pcriot.org", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "pendora.io", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "photopea.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "pornhub.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "proton.me", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "rollenspiel.chat", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "socialnetwork24.com", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "studichat.de", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "synod.im", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "the-apothecary.club", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "transfem.dev", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "unredacted.org", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "utwente.io", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "viliusle.github.io", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "watchduty.org", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "we2.ee", "overrides": "-JSDateTimeUTC"}, {"firstPartyDomain": "x.com", "overrides": "-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"}, {"firstPartyDomain": "yatrix.org", "overrides": "-JSDateTimeUTC"}]');

pref("browser.phoenix.status.android", "002");

/*** 003 MEDIA ***/

/// Disable Widevine MediaDrm/MediaKeySystem
// https://developer.android.com/reference/android/media/MediaDrm
// https://bugzilla.mozilla.org/show_bug.cgi?id=1306219
pref("media.mediadrm-widevinecdm.visible", false);

pref("browser.phoenix.status.android", "003");

/*** 004 ATTACK SURFACE REDUCTION ***/

/// Re-enable the JIT Baseline Interpreter, due to severe performance issues some users have been experiencing...
// ex. https://gitlab.com/ironfox-oss/IronFox/-/issues/18
pref("javascript.options.blinterp", true); // [DEFAULT]

pref("browser.phoenix.status.android", "004");

/*** 005 PASSWORDS & AUTHENTICATION ***/

/// Re-enable formless capture in standard windows
// See `015` at `Phoenix-Core` for details
// We still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/11
pref("signon.formlessCapture.enabled", true); // [DEFAULT]

pref("browser.phoenix.status.android", "005");

/*** 006 EXTENSIONS ***/

/// Enable installation of add-ons
// Note that this does NOT apply to `Recommended` extensions (collecitons) found at `Settings` -> `Advanced` -> `Extensions`.
// Setting here to expose via the `about:config`...
pref("xpinstall.enabled", true); // [DEFAULT, HIDDEN]

/// Enable mozAddonManager
// mozAddonManager prevents extensions from working on `addons.mozilla.org`/the specified domains
// This API also exposes a list of the user's installed add-ons to `addons.mozilla.org`/the specified domains...
// But it's required for the installation of extensions from `addons.mozilla.org`, so let's ensure it's enabled by default to prevent issues
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.enabled", true);
pref("privacy.resistFingerprinting.block_mozAddonManager", false); // [DEFAULT]

/// Only allow installation of signed extensions by default
pref("extensions.langpacks.signatures.required", true); // [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.android", "006");

/*** 007 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.status.android", "007");

/*** 008 PERFORMANCE ***/

pref("browser.sessionstore.max_tabs_undo", 7);
pref("network.http.max-connections", 256); // [Default = 128]

pref("browser.phoenix.status.android", "008");

pref("browser.phoenix.status.android", "successfully applied :D", locked);

