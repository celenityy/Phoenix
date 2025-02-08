//

// This file contains preferences specific to Phoenix on desktop.

// 001 DATA COLLECTION

/// Shield Studies/Normandy/Nimbus
// https://mozilla.github.io/normandy/
// https://wiki.mozilla.org/Firefox/Shield/Shield_Studies
// https://support.mozilla.org/kb/shield
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_experiments-or-studies
// https://wiki.mozilla.org/Advocacy/heartbeat
// https://experimenter.info/
// resource://nimbus/ExperimentAPI.sys.mjs

pref("app.normandy.api_url", "", locked);
pref("app.normandy.enabled", false, locked);
pref("app.normandy.first_run", false, locked);
pref("app.normandy.last_seen_buildid", "", locked);
pref("app.normandy.logging.level", 70); // Limits logging to fatal only
pref("app.normandy.user_id", "", locked);
pref("app.shield.optoutstudies.enabled", false, locked);
pref("messaging-system.log", "off"); // Disables logging
pref("messaging-system.rsexperimentloader.enabled", false, locked);
pref("messaging-system.rsexperimentloader.collection_id", "", locked);
pref("nimbus.appId", "", locked); // https://searchfox.org/mozilla-central/source/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js

/// Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs

pref("toolkit.coverage.enabled", false, locked); // [DEFAULT]
pref("toolkit.coverage.endpoint.base", "", locked);
pref("toolkit.coverage.log-level", 70); // Limits logging to fatal only
pref("toolkit.coverage.opt-out", true, locked); // [HIDDEN]

/// Misc. Telemetry

pref("browser.aboutwelcome.log", "off"); // Disable logging
pref("browser.privacySegmentation.preferences.show", false, locked); // [DEFAULT, at least on Nightly]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked);
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked);

pref("browser.phoenix.desktop.status", "001");

// 002 MOZILLA CRAP™

/// Kill about:welcome & Onboarding

pref("browser.aboutwelcome.enabled", false);

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

pref("browser.phoenix.desktop.status", "002");

// 003 DNS

/// Improve list of built-in DoH resolvers

pref("doh-rollout.provider-list", '[{"UIName":"Quad9 - Real-time Malware Protection","uri":"https://dns.quad9.net/dns-query"}, {"UIName":"DNS0 (ZERO) - Hardened Real-time Malware Protection","uri":"https://zero.dns0.eu"}, {"UIName":"DNS0 - Real-time Malware Protection","uri":"https://dns0.eu"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware Protection","uri":"https://base.dns.mullvad.net/dns-query"}, {"UIName":"AdGuard (Public) - Ad/Tracking Protection","uri":"https://dns.adguard-dns.com/dns-query"}, {"UIName":"Mullvad - No Filtering","uri":"https://dns.mullvad.net/dns-query"}, {"UIName":"Wikimedia - No Filtering","uri":"https://wikimedia-dns.org/dns-query"}, {"UIName":"AdGuard (Public) - No Filtering","uri":"https://unfiltered.adguard-dns.com/dns-query"}, {"UIName":"DNS0 - Kids","uri":"https://kids.dns0.eu"}, {"UIName":"Mullvad - Family","uri":"https://family.dns.mullvad.net/dns-query"}, {"UIName":"AdGuard (Public) - Family Protection","uri":"https://family.adguard-dns.com/dns-query"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware/Social Media Protection","uri":"https://extended.dns.mullvad.net/dns-query"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware/Social Media/Adult/Gambling Protection","uri":"https://all.dns.mullvad.net/dns-query"}]'); // [HIDDEN]

pref("browser.phoenix.desktop.status", "003");

// 004 GEOLOCATION

/// Blocks websites from accessing geolocation by default

pref("permissions.default.geo", 2);

/// Update info URL to ours so that users receive accurate information

pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo");

/// Configure OS Geolocation providers

pref("geo.provider.use_corelocation", true); // [DEFAULT] - Enable Apple Location Services for macOS
pref("geo.provider.use_geoclue", true); // [DEFAULT] - Enable Geoclue for Linux distros

pref("browser.phoenix.desktop.status", "004");

// 005 EXTENSIONS

// Only allow signed extensions
// I'd like to unlock these in the future (We already don't lock it on Android)
// - But I still have concerns for desktop due to malware attempting to override this.
// Will have to do more thinking and find the best approach.

pref("xpinstall.signatures.required", true, locked); // [DEFAULT]

pref("browser.phoenix.desktop.status", "005");

// 006 FINGERPRINTING PROTECTION

/// Harden FPP (which we already enable above) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/issues/46
// https://discuss.privacyguides.net/t/does-partial-resistfingerprinting-make-any-sense/18827/4
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html

pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-HttpUserAgent,-JSDateTimeUTC");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Apple Maps (apple.com) - Disables spoofing WebGL render capability (-WebGLRenderCapability) - Causes complete breakage
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mozilla.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)

pref("privacy.fingerprintingProtection.granularOverrides", "[{\"firstPartyDomain\": \"apple.com\", \"overrides\": \"-WebGLRenderCapability\"}, {\"firstPartyDomain\": \"arcticfoxes.net\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"aria.im\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"cinny.in\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"discord.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"element.io\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"mozilla.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"proton.me\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"unredacted.org\", \"overrides\": \"-JSDateTimeUTC\"}]");

/// Expose dynamic rounding of content dimensions to users, but do not enable by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366

pref("privacy.resistFingerprinting.letterboxing", false); // [DEFAULT, HIDDEN]

pref("browser.phoenix.desktop.status", "006");

/// 007 MISC. PRIVACY

/// Set LibreWolf/forks to use our custom enhanced uBlock Origin config by default
// We do not support LibreWolf at the moment, but this will be beneficial if that ever changes in the future.

pref("librewolf.uBO.assetsBootstrapLocation", "https://codeberg.org/celenity/Phoenix/raw/commit/08d147ee865c1d740540e8ec83c758d7a4df3e8b/uBlock/assets.json");

pref("browser.phoenix.desktop.status", "007");

/// 008 MISC.

/// Block web notifications by default
/// I have yet to see a legitimate use-case for websites using push notifications...
// but I see them constantly abused for malicious purposes & spam

pref("permissions.default.desktop-notification", 2);

/// Set homepage to about:home, this is typically default, but overriden by some distro-packaged versions of Firefox (ex. Fedora)
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#325

pref("browser.startup.homepage", "about:home"); // [DEFAULT]
pref("browser.startup.page", 1); // [DEFAULT]

/// Add our own extension recommendations...

pref("extensions.getAddons.discovery.api_url", "https://phoenix.celenity.dev/extensions/recommendations.json"); // https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.recommendations.privacyPolicyUrl", "https://phoenix.celenity.dev/privacy#extension-recommendations");

pref("browser.phoenix.desktop.status", "008");

// 009 Personal Touch 💜

/// Clean-up default UI

pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"_testpilot-containers-browser-action\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"downloads-button\",\"unified-extensions-button\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"_testpilot-containers-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"unified-extensions-area\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":4}");

pref("browser.phoenix.desktop.status", "009");

// 010 Enable support for custom/specialized configs...

pref("general.config.filename", "phoenix.cfg");
pref("general.config.obscure_value", 0);
pref("general.config.vendor", "phoenix");

pref("browser.phoenix.desktop.status", "010");

pref("browser.phoenix.desktop.status", "successfully applied :D", locked);

