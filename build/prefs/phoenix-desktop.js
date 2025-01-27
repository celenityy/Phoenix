//

// This file contains preferences specific to Phoenix on desktop.

// 001 MOZILLA CRAP™

/// Prevent Mozilla domains from having special privileges
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#privileged-mozilla-content
// This breaks installing extensions on Android & Thunderbird :/

pref("privacy.resistFingerprinting.block_mozAddonManager", true);

/// Remove Mozilla URL tracking params

pref("app.releaseNotesURL", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("app.releaseNotesURL.aboutDialog", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("app.releaseNotesURL.prompt", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("browser.contentblocking.report.monitor.sign_in_url", "https://monitor.firefox.com/oauth/init");
pref("browser.contentblocking.report.monitor.url", "https://monitor.firefox.com/");
pref("browser.contentblocking.report.vpn.url", "https://vpn.mozilla.org/");
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/firefox/search?q=%TERMS%");
pref("signon.firefoxRelay.manage_url", "https://relay.firefox.com/accounts/profile/");

pref("browser.phoenix.desktop.status", "001");

// 002 GEOLOCATION

/// Update info URL to ours so that users receive accurate information

pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo");

pref("browser.phoenix.desktop.status", "002");

// 003 EXTENSIONS

// Only allow signed extensions
// I'd like to unlock these in the future (We already don't lock it on Android)
// - But I still have concerns for desktop due to malware attempting to override this.
// Will have to do more thinking and find the best approach.

pref("xpinstall.signatures.required", true, locked); // [DEFAULT]

pref("browser.phoenix.desktop.status", "003");

// 004 FINGERPRINTING PROTECTION

/// Harden FPP (which we already enable above) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// https://discuss.privacyguides.net/t/does-partial-resistfingerprinting-make-any-sense/18827/4
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-JSDateTimeUTC");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Apple Maps (apple.com) - Disables spoofing WebGL render capability (-WebGLRenderCapability) - causes complete breakage
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)

pref("privacy.fingerprintingProtection.granularOverrides", "[{\"firstPartyDomain\": \"apple.com\", \"overrides\": \"-WebGLRenderCapability\"}, {\"firstPartyDomain\": \"discord.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"element.io\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"proton.me\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"unredacted.org\", \"overrides\": \"-JSDateTimeUTC\"}]");

/// Expose dynamic rounding of content dimensions to users, but do not enable by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", false); // [DEFAULT, HIDDEN]

pref("browser.phoenix.desktop.status", "004");

/// 005 MISC. PRIVACY

/// Set LibreWolf/forks to use our custom enhanced uBlock Origin config by default
// We do not support LibreWolf at the moment, but this will be beneficial if that ever changes in the future.

pref("librewolf.uBO.assetsBootstrapLocation", "https://phoenix.celenity.dev/uBlock/assets.json");

pref("browser.phoenix.desktop.status", "005");

/// 006 MISC.

/// Set homepage to about:home, this is typically default, but overriden by some distro-packaged versions of Firefox (ex. Fedora)
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#325

pref("browser.startup.homepage", "about:home"); // [DEFAULT]
pref("browser.startup.page", 1); // [DEFAULT]

pref("browser.phoenix.desktop.status", "006");

// 007 Personal Touch 💜

/// Clean-up default UI

pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"_testpilot-containers-browser-action\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"downloads-button\",\"unified-extensions-button\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"_testpilot-containers-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"unified-extensions-area\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":4}");

pref("browser.phoenix.desktop.status", "007");

// 008 Enable support for custom/specialized configs...

pref("general.config.filename", "phoenix.cfg");
pref("general.config.obscure_value", 0);
pref("general.config.vendor", "phoenix");

pref("browser.phoenix.desktop.status", "008");

pref("browser.phoenix.desktop.status", "successfully applied :D", locked);

