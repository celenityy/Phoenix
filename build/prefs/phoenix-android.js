
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

001: DATA COLLECTION
002: MOZILLA CRAP™
003: FINGERPRINTING PROTECTION
004: DNS
005: MEDIA
006: PASSWORDS & AUTHENTICATION
007: EXTENSIONS
008: DEBUGGING
009: MISC. PRIVACY
010: MISC. SECURITY
011: PERFORMANCE

*/

/*** 001 DATA COLLECTION ***/

/// Disable OHTTP Telemetry
// https://searchfox.org/mozilla-central/source/widget/android/OhttpHelper.cpp
pref("network.ohttp.configURL", "", locked); // [NIGHTLY]
pref("network.ohttp.relayURL", "", locked); // [NIGHTLY]

pref("browser.phoenix.status.android", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Clear unnecessary/undesired Mozilla URLs
pref("extensions.getAddons.langpacks.url", ""); // Functionality isn't supported on Android, so no need to connect there - ex. https://services.addons.mozilla.org/api/v4/addons/language-tools/?app=android&type=language&appversion=138.0.1

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html & https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("extensions.getAddons.get.url", "https://services.addons.mozilla.org/api/v4/addons/search/?guid=%IDS%");
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/android/search?q=%TERMS%");
pref("extensions.update.background.url", "https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("extensions.update.url", "https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("pdfjs.altTextLearnMoreUrl", "https://support.mozilla.org/kb/pdf-alt-text");

pref("browser.phoenix.status.android", "002");

/*** 003 FINGERPRINTING PROTECTION ***/

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Android#fingerprinting
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC,-JSLocale");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Amazon (amazon.ae) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.ca) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.cn) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.co.jp) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.co.uk) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.co.za) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com.au) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com.be) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com.br) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com.tr) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.com.mx) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.de) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.eg) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.es) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.fr) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.ie) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.in) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.it) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.nl) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.pl) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.sa) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.se) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon (amazon.sg) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), to prevent it from prompting users despite not needing the permission...
// Amazon Log-in (loginwithamazon.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// Apple (apple.com) - (ex. for Apple ID Sign-in/Apple Pay) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// Apple (cdn-apple.com) - (ex. for Apple ID Sign-in/Apple Pay) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// Apple News (apple.news) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate) + in first-party contexts: Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & CanvasImageExtractionPrompt)
// Bluesky (bsky.app) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures... - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Brave Search (brave.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny (pendora.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/Element (transfem.dev) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/SchildiChat (the-apothecary.club) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Cloudflare (cloudflare.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop..., + enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access - and additionally, in third party contexts: spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// CVS (cvs.com) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Discord (discord.gg) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate) + in first-party contexts: Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt) + in third-party contexts: Spoofs locale (+JSLocale)
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
// Epic Games (epicgames.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Favicon.io (favicon.io)  - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks downloading converted files, + enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access
// GitLab (gitlab.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures...
// Google (goo.gl) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), spoofs frame rate (+FrameRate), and spoofs locale (+JSLocale) + in first-party contexts: Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt)
// Google reCAPTCHA (recaptcha.net) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs Frame Rate (+FrameRate)
// Google reCAPTCHA (recaptcha.net.cn) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs Frame Rate (+FrameRate)
// Google reCAPTCHA (recaptcha-cn.net) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs Frame Rate (+FrameRate)
// Gravatar (gravatar.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), spoofs Frame Rate (+FrameRate), and spoofs locale (+JSLocale)
// GSI Maps (gsi.go.jp) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage (ex. https://maps.gsi.go.jp/index_3d.html?z=16&lat=35.653225&lon=139.73539700000003&pxsize=1024&ls=std#&cpx=-54.107&cpy=162.515&cpz=99.300&cux=-0.518&cuy=0.245&cuz=0.820&ctx=1.324&cty=20.508&ctz=33.599&a=1&b=0&dd=0)
// Harkins Theatres (harkins.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks seat selection (https://github.com/brave/brave-browser/issues/35750)
// HD Rezka (rezka-ua.in) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// iCloud (icloud.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// iCloud (icloud.com.cn) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Instagram (cdninstagram.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Instagram (instagram.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Jersey Mike's (jerseymikes.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues on Maps
// Letterboxd (letterboxd.com) - Disables spoofing screen coordinates (-ScreenRect) to properly display the mobile page instead of desktop (https://github.com/webcompat/web-bugs/issues/150661)
// LinkedIn (licdn.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// LinkedIn (linkedin.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Megacloud (megacloud.blog) - Allows canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt), and allows extracting canvas data in third party contexts (-CanvasExtractionFromThirdPartiesIsBlocked - Fixes video playback on various websites (ex. anicrush.to, aniwatchtv.to, & hianimez.to) - https://codeberg.org/celenity/Phoenix/issues/96
// Megacloud (megacloud.store) - Allows canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt), and allows extracting canvas data in third party contexts (-CanvasExtractionFromThirdPartiesIsBlocked - Fixes video playback on various websites (ex. arc018.to) - https://codeberg.org/celenity/Phoenix/issues/96
// miniPaint (viliusle.github.io) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks extracting/saving projects (https://codeberg.org/celenity/Phoenix/issues/68)
// nPerf (nperf.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Photopea (photopea.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes complete breakage
// Pinterest (pinimg.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// Pinterest (pinterest.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs frame rate (+FrameRate)
// Pogo (pogo.com) - Allows `pogospike.com` to extract canvas data (-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt) - Fixes display issues (ex. https://www.pogo.com/games/word-whomp/play)
// Pogo (pogospike.com) - Allows canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Fixes display issues (ex. https://www.pogo.com/games/word-whomp/play)
// Pornhub (pornhub.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks thumbnail seeking
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// PSA Bypass Link (moviezapiya.fun) - Disables spoofing WebGL renderer info (-WebGLRenderInfo) - https://codeberg.org/celenity/Phoenix/issues/95, + enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access
// Reddit (redd.it) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Reddit (reddit.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop... - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Reddit (redditmedia.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop... - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Reddit (redditstatic.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Riverside.FM Studio (riverside.fm) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Southwest (southwest.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), as it doesn't need access and attempts to prompt users for it on desktop...
// Stack Social (stacksocial.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// TikTok (tiktok.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop... - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// TileMan.io (tileman.io) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop..., as it doesn't need access and attempts to prompt users for it on desktop...
// USPS (usps.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Vimeo (vimeo.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Vimeo (vimeocdn.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Watch Duty (watchduty.org) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Causes display issues
// X/Twitter (t.co) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), spoofs frame rate (+FrameRate), and spoofs locale (+JSLocale) + in first-party contexts: Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt)
// X/Twitter (twimg.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs locale (+JSLocale)
// X/Twitter (twitter.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// X/Twitter (x.com) - Allows (randomized) first party canvas data extraction (-CanvasExtractionBeforeUserInputIsBlocked & -CanvasImageExtractionPrompt) - Breaks uploading profile pictures... - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Yahoo! (yahoo.com) - Blocks (randomized) canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// YouTube (googlevideo.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), and spoofs locale (+JSLocale)
// YouTube (youtu.be) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme), spoofs frame rate (+FrameRate), and spoofs locale (+JSLocale) + in first-party contexts: Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt)
// YouTube (youtube.com) - In third party contexts: Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// YouTube (youtube-nocookie.com) - Enables timezone spoofing (+JSDateTimeUTC) as it doesn't need access, and spoofs CSS `prefers-color-scheme` (+CSSPrefersColorScheme)
// Zoho (zoho.com) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Zoho (zoho.com.au) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Zoho (zoho.eu) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Zoho (zoho.in) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Zoho (zoho.jp) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
// Zoho (zoho.sa) -  Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked & +CanvasImageExtractionPrompt), as it doesn't need access and attempts to prompt users for it on desktop...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"amazon.ae","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.ca","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.uk","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.za","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.br","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.mx","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.tr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.de","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.eg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.es","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.fr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.ie","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.it","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.nl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.pl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.se","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.sg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"apple.news","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"brave.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"bsky.app","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cloudflare.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"cvs.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"discord.gg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"epicgames.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"favicon.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gitlab.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"goo.gl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"gsi.go.jp","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"harkins.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"icloud.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"icloud.com.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"jerseymikes.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"letterboxd.com","overrides":"-ScreenRect"},{"firstPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"megacloud.store","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"moviezapiya.fun","overrides":"-WebGLRenderInfo,+JSDateTimeUTC"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nperf.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pogo.com","thirdPartyDomain":"pogospike.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"photopea.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pogospike.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pornhub.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"reddit.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"redditmedia.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"rezka-ua.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"riverside.fm","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"southwest.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"stacksocial.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"t.co","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"tiktok.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"tileman.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"transfem.dev","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"usps.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"viliusle.github.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"watchduty.org","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"x.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"yahoo.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"youtu.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"zoho.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"}{"firstPartyDomain":"zoho.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.eu","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.news","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"bsky.app","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdn-apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdninstagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cloudflare.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"discord.gg","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"goo.gl","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"googlevideo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"gravatar.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"instagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"licdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"linkedin.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"loginwithamazon.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.store","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"moviezapiya.fun","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinimg.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinterest.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net.cn","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha-cn.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redd.it","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"reddit.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditmedia.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditstatic.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"t.co","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"tileman.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"tiktok.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twitter.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twimg.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeocdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"x.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtu.be","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"}]');

pref("browser.phoenix.status.android", "003");

/*** 004 DNS ***/

/// Temporarily exclude certain captive portal domains from DNS over HTTPS by default
// Android unfortunately doesn't currently prompt users to fallback from DNS over HTTPS when a site can't be found (like desktop does), which causes unexpected breakage for users, as it leaves them without a clear explanation of the issue and a way to add the exceptions.
// I don't love the idea of doing this... so again, to clarify: these are temporary will be removed once Firefox adds the fallback UI.
// Domains taken from: https://badblock.celenity.dev/#captive-whitelist
pref("network.trr.builtin-excluded-domains", "localhost,local,aainflight.com,acwifi.com,aircanadawifi.com,airtime.geemedia.com,alaskawifi.com,amtrakconnect.com,amtrakwifi.com,ana-inflight-wifi.com,app-yoda.arubathena.com,aruba.odyssys.net,arubanetworks.com,arubanetworks.com.cn,asset-acms.anuvu.cloud,auth.hpe.com,bap.aws.opennetworkexchange.net,btwifi.com,captive.o2wifi.co.uk,captive-2020.aio.cloudauth.net,captive-2022.aio.cloudauth.net,captivemgr.o2wifi.net.uk,captiveportal-login.belex.com,carnivalwifi.com,cbp-guest.cbp.dhs.gov,cdnhotspot.afd.azureedge.net,cdnhotspot.azureedge.net,central.access.network,cfr-mprtuam-01.cops.us1.pr.anuvu.cloud,checkout.aa.com,cloud.imedia.ie,connect.edge.ihg.com,connect-edge.ihg.com,connected.xfinity.com,controller.access.network,cust.blueprintrf.com,deltawifi.com,device-yoda2.arubadev.cloud.hpe.com,dlrguest-captive.disney.com,ee-wifi.ee.co.uk,etihadwi-fly.com,fedsso.yum.com,flyfi.com,freewlan.sbb.ch,gogoinair.com,gogoinflight.com,gp1.wendys.com,guestinternet.com,guestinternet.com.s3-website-us-east-1.amazonaws.com,hiltonwifi.com,hotspotportals.com,hs.imedia.ie,httpforever.com,iceportal.de,inflight.pacwisp.net,inflight-wifi.com,inflightinternet.com,internal2-public-device-nc-nlb-b71ba3c951b09682.elb.us-west-2.amazonaws.com,internal2-public-device-nlb-2e2273d4267c0682.elb.us-west-2.amazonaws.com,internetupgrade.marriott.com,kong-gtw-portal-apse2prod5-lb-1386339370.ap-southeast-2.elb.amazonaws.com,kong-gtw-portal-eu-lb-1104785228.eu-central-1.elb.amazonaws.com,kong-gtw-portal-mec1prod6-lb-2104849938.me-central-1.elb.amazonaws.com,kong-gtw-portal-production-lb-686216184.us-west-1.elb.amazonaws.com,kong-gtw-portal-use1prod2-lb-291057632.us-east-1.elb.amazonaws.com,krisworld.singaporeair.com,kw.sq.com,landing.sbb.ch,loggedin.wifigem.it,login.attwifi.com,login.cloud5.com,login.cloudi-fi.net,login.innflux.com,login.wifigem.com,login.windstream.com,login-awe-cluster.attwifi.com,login-federated.windstream.com,lounge.aa.com,lpv.attwifi.com,lufthansa-flynet.com,managedwifi.xfinity.com,massportwifi.com,marriottwifi.com,medallionclass.com,mscwifi.com,msftguest-virtual.partners.extranet.microsoft.com,mt1.datavalet.io,network-auth.com,neverssl.com,nossl.com,ofc-yoda2.arubadev.cloud.hpe.com,onboard.eurostar.com,onboard.sbb.ch,onboardicafe.com,portal.ac2.mist.com,portal.ac5.mist.com,portal.ac6.mist.com,portal.eu.mist.com,portal.gc1.mist.com,portal.gc2.mist.com,portal.gc3.mist.com,portal.mist.com,portal.moovmanage.com,qa-connect-edge.ihg.com,rcs.arubathena.com,rcs-m.arubathena.com,rcs-ng-yoda2.arubadev.cloud.hpe.com,regio-guide.de,rsc.att.com,rsc.wayport.net,rougewifi.com,sbux-j3.datavalet.io,sbux-portal.globalreachtech.com,sbux-portal.odyssys.net,secure.11os.com,secure.datavalet.io,secure.wayport.net,secure-login.attwifi.com,service.thecloud.net,shop.ba.com,singaporeair-krisworld.com,sso.wendys.com,stage.connect.edge.ihg.com,starbucks-east.datavalet.io,stay.marriottbonvoy.com,southwestwifi.com,thalysnet.com,thd.cloudauth.net,timhortonswifi.com,tvgreyhound.com,unitedprivatescreening.com,unitedwifi.com,universal-orlando.ampthink.com,viasat.com,virginwifi.com,wanderingwifi.com,we.windstream.com,weconnect.wendys.com,wifi.airasia.com,wifi.bahn.de,wifi.cathaypacific.com,wifi.delta.com,wifi.esa.com,wifi.kfc.com,wifi1.kfc.com,wifi2.kfc.com,wifi.panerabread.com,wifi.singaporeair.com,wifi.sncf,wifi.starbucks.com,wifi.tgv-lyria.com,wifi.tgvlyria.com,wifi.united.com,wifi.united.com.edgekey.net,wifi.we.co,wifi.xfinity.com,wifi-viarail.ca,wifi-xdb.boingohotspot.net,wifihotspot.io,wifilauncher.com,wifilauncher.com.s3-website.us-east-1.amazonaws.com,wifilrn-ch2-1p.xfinity.com,wifionboard.com,wirelessportal.americanexpress.com,wirelessportal.americanexpress.com.akadns.net,wirelessportal2.americanexpress.com.akadns.net,wlb1-1579773356.us-east-1.elb.amazonaws.com,yoda-cgqa.arubathena.com,yoda-cgqa-elb.arubathena.com,yoda2-ofc-nlb-f4f923213a2189c7.elb.us-west-2.amazonaws.com,yoda2-public-device-nlb-8343995ce4714f6f.elb.us-west-2.amazonaws.com,yoda2-rcs-nlb-0c9df3882f3f7416.elb.us-west-2.amazonaws.com,zugportal.de");

pref("browser.phoenix.status.android", "004");

/*** 005 MEDIA ***/

/// Add DRM notes
pref("media.eme.enabled.3.note", "You will also need to enable the CDM.");
pref("media.eme.enabled.4.note", "See media.mediadrm-widevinecdm.visible");
pref("media.gmp-widevinecdm.0.note", "See media.mediadrm-widevinecdm.visible");
pref("media.gmp-widevinecdm-l1.0.note", "See media.mediadrm-widevinecdm.visible");

/// Disable HLS
// This uses an additional external library (ExoPlayer), and poses privacy & security concerns
// This is already the default for all platforms except Android
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/29859
pref("media.hls.enabled", false);

/// Disable Widevine MediaDrm/MediaKeySystem
// https://developer.android.com/reference/android/media/MediaDrm
// https://bugzilla.mozilla.org/show_bug.cgi?id=1306219
pref("media.mediadrm-widevinecdm.visible", false);

/// Ensure we don't download the Widevine CDM from GMP...
// Users should toggle `media.mediadrm-widevinecdm.visible` instead of these, so let's lock them to avoid confusion and prevent unexpected behavior/issues/users unnecessarily compromising privacy and security...
pref("media.gmp-widevinecdm.enabled", false, locked); // [HIDDEN]
pref("media.gmp-widevinecdm.visible", false, locked); // [HIDDEN]
pref("media.gmp-widevinecdm-l1.enabled", false, locked); // [DEFAULT - non-Nightly] [HIDDEN]
pref("media.gmp-widevinecdm-l1.visible", false, locked); // [DEFAULT - non-Nightly] [HIDDEN]

/// Require permission for websites to use EME
// https://bugzilla.mozilla.org/show_bug.cgi?id=1620102
// https://searchfox.org/mozilla-central/source/dom/media/eme/MediaKeySystemAccessPermissionRequest.h
pref("media.eme.require-app-approval", true); // [DEFAULT]

pref("browser.phoenix.status.android", "005");

/*** 006 PASSWORDS & AUTHENTICATION ***/

/// Re-enable formless capture in standard windows
// See `015` at `Phoenix-Core` for details
// We still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/11
pref("signon.formlessCapture.enabled", true); // [DEFAULT]

pref("browser.phoenix.status.android", "007");

/*** 008 EXTENSIONS ***/

/// Block extensions signed with weak signature algorithms
pref("xpinstall.signatures.weakSignaturesTemporarilyAllowed", false); // [DEFAULT, HIDDEN]

/// Enable installation of add-ons by default
// Note that this does NOT apply to `Recommended` extensions (collecitons) found at `Settings` -> `Advanced` -> `Extensions`.
// Unfortunately doesn't have a prompt when disabled like Desktop :(
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

pref("browser.phoenix.status.android", "008");

/*** 009 DEBUGGING ***/

/// Disable sending console output to logcat by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1415318
pref("consoleservice.logcat", false);
pref("geckoview.console.enabled", false);

/// Limit GeckoView's log level to "Warn" by default
pref("geckoview.logging", "Warn"); // [DEFAULT - non-Debug]

pref("browser.phoenix.status.android", "009");

/*** 010 MISC. PRIVACY ***/

/// Disable TLS session identifiers
// Fingerprinting/tracking concerns
// I'm not worried about this for desktop since these are session-only, but I feel like the situation is very different for Android. Users likely leave the app open (and by extension: keep their browsing session active) for days at a time, much longer than on Desktop.
// So this does concern me and I think it's worth setting here.
// For reference, this is also disabled by ex. Cromite
// https://arxiv.org/abs/1810.07304
pref("security.ssl.disable_session_identifiers", true);

pref("browser.phoenix.status.android", "010");

/*** 011 MISC. SECURITY ***/

/// Always warn users before launching other apps
pref("network.protocol-handler.warn-external.file", true);
pref("network.protocol-handler.warn-external.sms", true);
pref("network.protocol-handler.warn-external.tel", true);
pref("network.protocol-handler.warn-external.vnd.youtube", true);

pref("browser.phoenix.status.android", "011");

/*** 012 PERFORMANCE ***/

pref("browser.sessionstore.max_tabs_undo", 7);
pref("dom.ipc.processCount", 2); // [DEFAULT]
pref("network.http.max-connections", 256); // [Default = 128]

pref("browser.phoenix.status.android", "012");

pref("browser.phoenix.status.android", "successfully applied :D", locked);

