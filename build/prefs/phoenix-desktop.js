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

// This file contains preferences specific to Phoenix on desktop.

/* INDEX 

000: ABOUT:CONFIG
001: DATA COLLECTION
002: MOZILLA CRAP™
003: FINGERPRINTING PROTECTION
004: DISK AVOIDANCE
005: HTTP(S)
006: IMPLICIT CONNECTIONS
007: SEARCH & URL BAR
008: DNS
009: PASSWORDS & AUTHENTICATION
010: EXTENSIONS
011: AI
012: GEOLOCATION
013: MISC. PRIVACY
014: MISC.
015: PERFORMANCE
016: SYNC
017: Personal Touch 💜
018: UPDATES
019: SPECIALIZED/CUSTOM CONFIGS

*/

/*** 000 ABOUT:CONFIG ***/

/// Disable annoying warnings when attempting to access the about:config
pref("browser.aboutConfig.showWarning", false);

pref("browser.phoenix.status.desktop", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...

/// Disable Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs
pref("toolkit.coverage.enabled", false, locked); // [DEFAULT]
pref("toolkit.coverage.endpoint.base", "", locked);
pref("toolkit.coverage.log-level", 70); // Limits logging to fatal only
pref("toolkit.coverage.opt-out", true, locked); // [HIDDEN]

/// Disable Crash Reporting
// These specifically are used for tab crashes (`about:tabcrashed`)...
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
pref("browser.tabs.crashReporting.includeURL", false, locked); // [DEFAULT] - Defense in depth
pref("browser.tabs.crashReporting.sendReport", false, locked);

/// Disable Data Reporting & Telemetry
pref("browser.aboutwelcome.log", "off"); // Disable logging
pref("browser.newtabpage.activity-stream.feeds.telemetry", false, locked);
pref("browser.newtabpage.activity-stream.impressionId", "", locked);
pref("browser.newtabpage.activity-stream.telemetry", false, locked);
pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "", locked);
pref("browser.newtabpage.activity-stream.telemetry.ut.events", false, locked);
pref("browser.privacySegmentation.preferences.show", false, locked); // [DEFAULT, at least on Nightly]
pref("browser.search.serpEventTelemetryCategorization.enabled", false, locked);
pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false, locked); // [DEFAULT, HIDDEN]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked);
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked);
pref("nimbus.telemetry.targetingContextEnabled", false, locked); // https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2001

/// Disable Default Browser Agent [WINDOWS] [NO-OSX]
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html [NO-OSX]
pref("default-browser-agent.enabled", false, locked); // [NO-OSX]

/// Disable Shield Studies/Normandy/Nimbus
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

/// Remove unnecessary links
pref("app.normandy.shieldLearnMoreUrl", "");

pref("browser.phoenix.status.desktop", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Clean-up Activity Stream (about:home)
// We also configure "FirefoxHome" in policies
// https://mozilla.github.io/policy-templates/#firefoxhome
// https://searchfox.org/mozilla-central/source/testing/geckodriver/src/prefs.rs
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml
pref("browser.newtabpage.activity-stream.asrouter.debugLogLevel", "error"); // [DEFAULT, HIDDEN] To expose via the `about:config`... // https://searchfox.org/mozilla-central/source/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.message-groups", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.useRemoteL10n", false);
pref("browser.newtabpage.activity-stream.discoverystream.config", "[]", locked);
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.feeds", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.dismissed", true, locked);
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.personalization.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.recs.personalized", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint", "", locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint-query", "", locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.maybeDisplay", false, locked);
pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false, locked);
pref("browser.newtabpage.activity-stream.feeds.recommendationprovider", false, locked);
pref("browser.newtabpage.activity-stream.feeds.snippets", false, locked);
pref("browser.newtabpage.activity-stream.showSponsored", false, locked);
pref("browser.newtabpage.activity-stream.system.showSponsored", false, locked);
pref("messaging-system.askForFeedback", false, locked);

/// Disable `about:welcome`/onboarding
// Privacy concerns - unsolicited connection
// Also just annoying...
pref("browser.aboutwelcome.enabled", false);
pref("browser.startup.homepage_override.mstone", "ignore");
pref("browser.suppress_first_window_animation", true); // [DEFAULT]
pref("browser.usedOnWindows10.introURL", ""); // [HIDDEN] https://searchfox.org/mozilla-central/source/remote/shared/RecommendedPreferences.sys.mjs
pref("startup.homepage_override_url", "");
pref("startup.homepage_override_url_nimbus", ""); // [DEFAULT
pref("startup.homepage_welcome_url", "");
pref("startup.homepage_welcome_url.additional", ""); // [DEFAULT]

/// Disable Fakespot
pref("browser.newtabpage.activity-stream.contextualContent.fakespot.enabled", false);
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.fakespot.enabled", false);
pref("browser.shopping.experience2023.active", false);
pref("browser.shopping.experience2023.ads.enabled", false, locked); // [DEFAULT]
pref("browser.shopping.experience2023.ads.exposure", false, locked); // [HIDDEN]
pref("browser.shopping.experience2023.ads.userEnabled", false, locked);
pref("browser.shopping.experience2023.autoOpen.enabled", false); // [DEFAULT]
pref("browser.shopping.experience2023.autoOpen.userEnabled", false);
pref("browser.shopping.experience2023.enabled", false); // [DEFAULT]
pref("browser.shopping.experience2023.integratedSidebar", false); // [DEFAULT]
pref("browser.shopping.experience2023.optedIn", 2);
pref("browser.shopping.experience2023.shoppingSidebar", false);
pref("browser.shopping.experience2023.survey.enabled", false);
pref("browser.shopping.experience2023.survey.hasSeen", true);
pref("browser.urlbar.fakespot.featureGate", false); // [DEFAULT]
pref("browser.urlbar.suggest.fakespot", false);

/// Disable "Feature Tours"
pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");
pref("browser.newtab.feature-tour", "{\"screen\":\"\",\"complete\":true}"); // [HIDDEN]
pref("browser.pdfjs.feature-tour", "{\"screen\":\"\",\"complete\":true}");

/// Disable fetching favicons for `about:home` from Mozila's remote Tippy Top service
// https://superuser.com/questions/1358289/how-are-the-icons-for-top-sites-in-the-firefox-new-tab-rendered/1495054#1495054
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1151
pref("browser.newtabpage.activity-stream.feeds.favicon", false);
pref("browser.newtabpage.activity-stream.tippyTop.service.endpoint", ""); // [HIDDEN]

/// Disable Firefox Suggest
// We also configure "FirefoxSuggest" & "UrlbarInterventions" in policies
// https://mozilla.github.io/policy-templates/#firefoxsuggest
// https://mozilla.github.io/policy-templates/#usermessaging
// https://mozilla-services.github.io/merino/firefox.html
// https://github.com/mozilla-services/merino-py
pref("browser.newtabpage.activity-stream.discoverystream.merino-feed-experiment", false);
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.enabled", false);
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.endpoint", "");
pref("browser.urlbar.addons.featureGate", false);
pref("browser.urlbar.groupLabels.enabled", false);
pref("browser.urlbar.mdn.featureGate", false);
pref("browser.urlbar.merino.endpointURL", "");
pref("browser.urlbar.merino.providers", "");
pref("browser.urlbar.quicksuggest.contextualOptIn", false);
pref("browser.urlbar.quicksuggest.enabled", false, locked); // Firefox only seems to set this for new profiles unless it's locked...
pref("browser.urlbar.quicksuggest.hideSettingsUI", true);
pref("browser.urlbar.quicksuggest.scenario", "offline");
pref("browser.urlbar.quicksuggest.shouldShowOnboardingDialog", false);
pref("browser.urlbar.quicksuggest.showedOnboardingDialog", true);
pref("browser.urlbar.quicksuggest.sponsoredPriority", false, locked);
pref("browser.urlbar.suggest.addons", false);
pref("browser.urlbar.suggest.mdn", false);
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false, locked); // Firefox only seems to set this for new profiles unless it's locked...
pref("browser.urlbar.suggest.quicksuggest.sponsored", false, locked);
pref("browser.urlbar.suggest.trending", false);
pref("browser.urlbar.suggest.weather", false);
pref("browser.urlbar.suggest.yelp", false);
pref("browser.urlbar.trending.featureGate", false);
pref("browser.urlbar.weather.featureGate", false);
pref("browser.urlbar.yelp.featureGate", false);

/// Disable Pocket
pref("browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", false);
pref("browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled", false);
pref("browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled", false);
pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
pref("browser.urlbar.pocket.featureGate", false);
pref("browser.urlbar.suggest.pocket", false);
pref("extensions.pocket.enabled", false);

/// Disable "Interest-based Content Relevance Ranking"
// https://bugzilla.mozilla.org/show_bug.cgi?id=1886207
pref("toolkit.contentRelevancy.enabled", false, locked);
pref("toolkit.contentRelevancy.ingestEnabled", false, locked);
pref("toolkit.contentRelevancy.log", false, locked);

/// Disable the Mozilla Ad Routing Service (MARS) :/
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/ActivityStream.sys.mjs#221
pref("browser.newtabpage.activity-stream.feeds.adsfeed", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.spocs.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.tiles.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.enabled", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.endpoint", "", locked);
pref("browser.newtabpage.activity-stream.unifiedAds.spocs.enabled", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.tiles.enabled", false, locked);

/// Disable Mozilla promotions
pref("browser.contentblocking.report.hide_vpn_banner", true, locked);
pref("browser.contentblocking.report.lockwise.enabled", false);
pref("browser.contentblocking.report.monitor.enabled", false); // [DEFAULT]
pref("browser.contentblocking.report.proxy.enabled", false); // [DEFAULT]
pref("browser.contentblocking.report.proxy_extension.url", "", locked);
pref("browser.contentblocking.report.show_mobile_app", false, locked);
pref("browser.contentblocking.report.vpn-android.url", "", locked);
pref("browser.contentblocking.report.vpn-ios.url", "", locked);
pref("browser.contentblocking.report.vpn-promo.url", "", locked);
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightDismissed", true);
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightEnabled", false);
pref("browser.preferences.moreFromMozilla", false, locked);
pref("browser.privatebrowsing.vpnpromourl", "", locked);
pref("browser.promo.cookiebanners.enabled", false, locked); // [DEFAULT]
pref("browser.promo.focus.enabled", false, locked);
pref("browser.promo.pin.enabled", false, locked);
pref("browser.protections_panel.infoMessage.seen", true); // Disables ETP Banner
pref("browser.vpn_promo.enabled", false, locked);
pref("cookiebanners.ui.desktop.showCallout", false);
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled", false, locked);
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.monitorEnabled", false, locked);
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.relayEnabled", false, locked);
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.vpnEnabled", false, locked);
pref("identity.mobilepromo.android", "", locked);
pref("identity.mobilepromo.ios", "", locked);
pref("identity.sendtabpromo.url", "", locked);

/// Disable recommendations
pref("browser.dataFeatureRecommendations.enabled", false, locked); // [DEFAULT]
pref("browser.discovery.enabled", false);
pref("browser.discovery.sites", "");
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false, locked);
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false, locked);

/// Disable "Top Sites"/Sponsored content/etc.
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml
pref("browser.newtabpage.activity-stream.default.sites", "");
pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesPlacement.enabled", false, locked);
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false, locked);
pref("browser.newtabpage.activity-stream.improvesearch.noDefaultSearchTile", true); // [DEFAULT]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", "");
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", "");
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false, locked);
pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", "{\"hidden\":true}", locked);
pref("browser.newtabpage.activity-stream.feeds.system.topstories", false, locked); // Controls the visibility of the `about:home` setting
pref("browser.newtabpage.pinned", '[]'); // [HIDDEN]
pref("browser.partnerlink.attributionURL", "", locked);
pref("browser.partnerlink.campaign.topsites", "", locked);
pref("browser.topsites.component.enabled", false, locked); // [DEFAULT]
pref("browser.topsites.contile.enabled", false, locked);
pref("browser.topsites.contile.endpoint", "", locked);
pref("browser.topsites.contile.sov.enabled", false, locked);
pref("browser.topsites.useRemoteSetting", false, locked);
pref("browser.urlbar.sponsoredTopSites", false, locked);

/// Disable the Web Compatibility Reporter
// Harmless from a privacy perspective - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as attack surface reduction & a potential performance improvement
pref("ui.new-webcompat-reporter.enabled", false); // https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#3604
pref("ui.new-webcompat-reporter.reason-dropdown", 0); // Do not ask users for a reason... https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#3275
pref("ui.new-webcompat-reporter.send-more-info-link", false); // [DEFAULT on non-Nightly]

/// Prevent checking if Firefox is the default browser
pref("browser.shell.checkDefaultBrowser", false);
pref("browser.shell.skipDefaultBrowserCheckOnFirstRun", true);

/// Prevent checking if Firefox is the default mailto: handler
// https://bugzilla.mozilla.org/show_bug.cgi?id=1864216
pref("browser.mailto.dualPrompt", false); // [DEFAULT]

/// Prevent checking if Firefox is the default PDF viewer
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js
pref("browser.shell.checkDefaultPDF", false); // [HIDDEN]
pref("browser.shell.checkDefaultPDF.silencedByUser", true); // [HIDDEN]

/// Remove special privileges from Mozilla domains
// https://firefox-source-docs.mozilla.org/browser/components/uitour/docs/index.html
pref("browser.uitour.enabled", false, locked);
pref("browser.uitour.loglevel", "Off");
pref("browser.uitour.requireSecure", true, locked); // [DEFAULT]
pref("browser.uitour.surveyDuration", 0, locked);
pref("browser.uitour.url", "", locked);
pref("privacy.resistFingerprinting.block_mozAddonManager", true); // This breaks installing extensions on Android & Thunderbird :/

/// Remove tracking parameters from Mozilla URLs
pref("app.releaseNotesURL", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("app.releaseNotesURL.aboutDialog", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("app.releaseNotesURL.prompt", "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/releasenotes");
pref("browser.contentblocking.report.monitor.sign_in_url", "https://monitor.firefox.com/oauth/init");
pref("browser.contentblocking.report.monitor.url", "https://monitor.firefox.com/");
pref("browser.contentblocking.report.vpn.url", "https://vpn.mozilla.org/");
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/%LOCALE%/firefox/search?q=%TERMS%");

pref("browser.phoenix.status.desktop", "002");

/*** 003 FINGERPRINTING PROTECTION ***/

/// Expose dynamic rounding of content dimensions (`privacy.resistFingerprinting.letterboxing`) in the `about:config`, but do not enable by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366
pref("privacy.resistFingerprinting.letterboxing", false); // [DEFAULT, HIDDEN]

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC");

/// Unbreak websites with FPP (if the related target is enabled...)
// Currently covers:
// Apple Maps (apple.com) - Disables spoofing WebGL render capability (-WebGLRenderCapability) - Causes complete breakage
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Discord (discord.com) - Disables timezone spoofing (-JSDateTimeUTC)
// DoorDash (doordash.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Element (arcticfoxes.net) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (aria.im) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (element.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (mozilla.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Element (unredacted.org) - Disables timezone spoofing (-JSDateTimeUTC)
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
pref("privacy.fingerprintingProtection.granularOverrides", "[{\"firstPartyDomain\": \"apple.com\", \"overrides\": \"-WebGLRenderCapability\"}, {\"firstPartyDomain\": \"arcticfoxes.net\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"aria.im\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"chipotle.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"cinny.in\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"citybbq.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"discord.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"doordash.com\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"element.io\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"mozilla.org\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"proton.me\", \"overrides\": \"-JSDateTimeUTC\"}, {\"firstPartyDomain\": \"unredacted.org\", \"overrides\": \"-JSDateTimeUTC\"}]");

pref("browser.phoenix.status.desktop", "003");

/*** 004 DISK AVOIDANCE ***/

/// Disable collection/generation of background thumbnails
// https://searchfox.org/mozilla-central/source/toolkit/components/thumbnails/PageThumbs.sys.mjs#629
pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN]

/// Disable favicons in shortcuts
// Prevents .ico files from persisting, even after deletion
pref("browser.shell.shortcutFavicons", false);

/// Disable LaterRun
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41568
// https://bugzilla.mozilla.org/show_bug.cgi?id=1200639
pref("browser.laterrun.enabled", false); // [DEFAULT]

/// Disable logging blocked domains to `about:protections`
pref("browser.contentblocking.cfr-milestone.enabled", false);

/// Enable a fire button in Private Browsing Windows to reset the session
pref("browser.privatebrowsing.resetPBM.enabled", true); // [DEFAULT - Nightly]

// Prevent automatically sharing Firefox Sync accounts
pref("identity.fxaccounts.migrateToDevEdition", false);

/// Prevent clearing cookies by default
pref("privacy.clearOnShutdown.cookies", false);
pref("privacy.clearOnShutdown.offlineApps", false); // [DEFAULT]
pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);

/// Prevent clearing site settings at `about:preferences#privacy` -> `Cookies and Site Data` -> `Manage Data...` by default
pref("privacy.clearHistory.siteSettings", false); // [DEFAULT]
pref("privacy.clearSiteData.siteSettings", false); // [DEFAULT]
pref("privacy.cpd.siteSettings", false); // [DEFAULT]

/// Prevent exposing content in the window title for Private Browsing windows
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js
pref("privacy.exposeContentTitleInWindow.pbm", false);

/// Use `Custom settings' for history at at `about:preferences#privacy` -> `History` by default
pref("privacy.history.custom", true);

pref("browser.phoenix.status.desktop", "004");

/*** 005 HTTP(S) ***/

/// Enable MITM Detection
// https://github.com/arkenfox/user.js/issues/740
// https://bugzilla.mozilla.org/show_bug.cgi?id=1529643
pref("security.certerrors.mitm.priming.enabled", true); // [DEFAULT]

/// Enforce HTTPS-Only Mode
// We're not locking this for Android/Thundebird since it's unfortunately not possible to add exceptions there...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/48
pref("dom.security.https_only_mode", true, locked);
pref("dom.security.https_only_mode_pbm", true, locked);

/// Restrict certificate error exceptions to only last for the current session
pref("security.certerrors.permanentOverride", false);

pref("browser.phoenix.status.desktop", "005");

/*** 006 IMPLICIT CONNECTIONS ***/

/// Disable Search Suggestions
pref("browser.urlbar.showSearchSuggestionsFirst", false);
pref("browser.urlbar.suggest.searches", false);

/// Disable speculative pre-connections
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_speculative-pre-connections
pref("browser.places.speculativeConnect.enabled", false);
pref("browser.urlbar.speculativeConnect.enabled", false);

/// Prevent leaking single word searches to DNS provider
pref("browser.fixup.dns_first_for_single_words", false); // [DEFAULT]
pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0); // [DEFAULT]

pref("browser.phoenix.status.desktop", "006");

/*** 007 SEARCH & URL BAR ***/

/// Disable autofill/autocompletion of URLs by default
pref("browser.urlbar.autoFill", false);

/// Disable suggestions for "Recent Searches" 
// We disable search & form History anyways
pref("browser.urlbar.recentsearches.featureGate", false);
pref("browser.urlbar.suggest.recentsearches", false);

/// Disable URL trimming
pref("browser.urlbar.trimHttps", false);
pref("browser.urlbar.trimURLs", false);

/// Enable a prompt to use Private Browsing
pref("browser.search.separatePrivateDefault.urlbarResult.enabled", true); // [HIDDEN]

/// Enable the UI to add custom search engines at about:preferences#search
pref("browser.urlbar.update2.engineAliasRefresh", true); // [HIDDEN]

/// Exclude JavaScript URLS from results
pref("browser.urlbar.filter.javascript", true); // [DEFAULT]

// Nice to have
pref("browser.urlbar.suggest.bookmark", true); // [DEFAULT]
pref("browser.urlbar.suggest.calculator", true);
pref("browser.urlbar.suggest.clipboard", false);
pref("browser.urlbar.suggest.engines", false);
pref("browser.urlbar.suggest.history", false);
pref("browser.urlbar.suggest.openpage", true); // [DEFAULT]
pref("browser.urlbar.suggest.quickactions", false);
pref("browser.urlbar.unitConversion.enabled", true);

/// Remove default Search Engine Placeholders
pref("browser.urlbar.placeholderName", "");
pref("browser.urlbar.placeholderName.private", "");

/// Show the URL instead of search terms
pref("browser.urlbar.showSearchTerms.enabled", false);
pref("browser.urlbar.showSearchTerms.featureGate", false);

pref("browser.phoenix.status.desktop", "007");

/*** 008 DNS ***/

/// Improve list of built-in DoH resolvers
pref("doh-rollout.provider-list", '[{"UIName":"Quad9 - Real-time Malware Protection","uri":"https://dns.quad9.net/dns-query"}, {"UIName":"DNS0 (ZERO) - Hardened Real-time Malware Protection","uri":"https://zero.dns0.eu"}, {"UIName":"DNS0 - Real-time Malware Protection","uri":"https://dns0.eu"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware Protection","uri":"https://base.dns.mullvad.net/dns-query"}, {"UIName":"AdGuard (Public) - Ad/Tracking Protection","uri":"https://dns.adguard-dns.com/dns-query"}, {"UIName":"Mullvad - No Filtering","uri":"https://dns.mullvad.net/dns-query"}, {"UIName":"Wikimedia - No Filtering","uri":"https://wikimedia-dns.org/dns-query"}, {"UIName":"AdGuard (Public) - No Filtering","uri":"https://unfiltered.adguard-dns.com/dns-query"}, {"UIName":"DNS0 - Kids","uri":"https://kids.dns0.eu"}, {"UIName":"Mullvad - Family","uri":"https://family.dns.mullvad.net/dns-query"}, {"UIName":"AdGuard (Public) - Family Protection","uri":"https://family.adguard-dns.com/dns-query"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware/Social Media Protection","uri":"https://extended.dns.mullvad.net/dns-query"}, {"UIName":"Mullvad - Ad/Tracking/Limited Malware/Social Media/Adult/Gambling Protection","uri":"https://all.dns.mullvad.net/dns-query"}]'); // [HIDDEN]

pref("browser.phoenix.status.desktop", "008");

/*** 009 PASSWORDS & AUTHENTICATION ***/

/// Enable alerts for breached & vulnerable passwords (if the Password Manager is enabled) by default
// Harmless, never sends passwords or sensitive data to Mozilla
// https://support.mozilla.org/kb/mozilla-monitor-faq#w_does-mozilla-monitor-know-my-passwords
// https://blog.mozilla.org/security/2018/06/25/scanning-breached-accounts-k-anonymity/
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js
pref("signon.management.page.breach-alerts.enabled", true); // [DEFAULT]
pref("signon.management.page.vulnerable-passwords.enabled", true); // [DEFAULT]

/// Protect against password spoofing for cross-domain auth requests
// https://bugzilla.mozilla.org/show_bug.cgi?id=791594
pref("privacy.authPromptSpoofingProtection", true); // [DEFAULT]

pref("browser.phoenix.status.desktop", "009");

/*** 010 EXTENSIONS ***/

/// Add our own extension recommendations
// https://codeberg.org/celenity/Phoenix/wiki/Recommended-Extensions
// https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.getAddons.discovery.api_url", "https://phoenix.celenity.dev/extensions/recommendations.json");
pref("extensions.recommendations.privacyPolicyUrl", "https://phoenix.celenity.dev/privacy#extension-recommendations");

/// Block our current search 'extensions' from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.brave-leta@celenity.dev", false, locked); // Mullvad Leta (Brave)
pref("extensions.quarantineIgnoredByUser.ddg@celenity.dev", false, locked); // DuckDuckGo
pref("extensions.quarantineIgnoredByUser.duckduckgo-html@celenity.dev", false, locked); // DuckDuckGo HTML
pref("extensions.quarantineIgnoredByUser.duckduckgo-lite@celenity.dev", false, locked); // DuckDuckGo Lite
pref("extensions.quarantineIgnoredByUser.google-leta@celenity.dev", false, locked); // Mullvad Leta (Google)
pref("extensions.quarantineIgnoredByUser.mojeek@celenity.dev", false, locked); // Mojeek
pref("extensions.quarantineIgnoredByUser.no-search@celenity.dev", false, locked); // No Search
pref("extensions.quarantineIgnoredByUser.startpage@celenity.dev", false, locked); // Startpage
pref("extensions.quarantineIgnoredByUser.swisscows@celenity.dev", false, locked); // Swisscows

/// Block our deprecated search 'extensions' for defense in depth from accessing restricted/quarantined domains
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.bravesearch@celenity.dev", false, locked); // Brave Search
pref("extensions.quarantineIgnoredByUser.ecosia@celenity.dev", false, locked); // Ecosia
pref("extensions.quarantineIgnoredByUser.kagi@celenity.dev", false, locked); // Kagi
pref("extensions.quarantineIgnoredByUser.kagi-html@celenity.dev", false, locked); // Kagi HTML
pref("extensions.quarantineIgnoredByUser.leta-brave@celenity.dev", false, locked); // Mullvad Leta (Brave)
pref("extensions.quarantineIgnoredByUser.leta-google@celenity.dev", false, locked); // Mullvad Leta (Google)
pref("extensions.quarantineIgnoredByUser.metager@celenity.dev", false, locked); // MetaGer
pref("extensions.quarantineIgnoredByUser.qwant@celenity.dev", false, locked); // Qwant
pref("extensions.quarantineIgnoredByUser.qwant-junior@celenity.dev", false, locked); // Qwant Junior

/// Only allow installation of signed extensions by default
// Extensions are still limited to the sources we allow in policies...
pref("extensions.langpacks.signatures.required", true); // [DEFAULT]
pref("xpinstall.signatures.required", true); // [DEFAULT]

pref("browser.phoenix.status.desktop", "010");

/*** 011 AI ***/

// https://support.mozilla.org/kb/ai-chatbot

/// Add AI toggle at about:preferences#experimental
pref("browser.ml.chat.hideFromLabs", false);

/// Allow typing a custom prompt based on your selection (if pop-up when highlighting text is enabled)
pref("browser.ml.chat.shortcuts.custom", true); // [DEFAULT]

/// Disable AI functionality by default
pref("browser.ml.chat.enabled", false); // [DEFAULT] - AI Chatbot
pref("browser.ml.chat.shortcuts", false); // Pop-up when highlighting text

/// Remove privacy-invasive AI Chatbot providers
// (Anthropic Claude, ChatGPT, Google Gemini, and Le Chat Mistral)
// HuggingChat's privacy policy is OK, though it does leave room for improvement - best option out of the built-in
// https://searchfox.org/mozilla-central/source/browser/components/genai/GenAI.sys.mjs#63
pref("browser.ml.chat.providers", "huggingchat"); // [HIDDEN]

/// Set the default AI Chatbot (if enabled) to DuckDuckGo
// Unfortunately this is not compatible with the pop-up when selecting text. 
// Also currently not possible to add this as a persistent option.
pref("browser.ml.chat.provider", "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat");

pref("browser.phoenix.status.desktop", "011");

/*** 012 GEOLOCATION ***/

/// Block websites from prompting to access geolocation by default
pref("permissions.default.geo", 2);

/// Enable Apple Location Services for macOS
pref("geo.provider.use_corelocation", true); // [DEFAULT]

/// Enable Geoclue for GNU/Linux distros [NO-OSX]
pref("geo.provider.use_geoclue", true); // [DEFAULT] [NO-OSX]

/// Update info URL to ours so that users receive accurate information
pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo");

pref("browser.phoenix.status.desktop", "012");

/*** 013 MISC. PRIVACY ***/

/// Enable container isolation of `about:home` content
pref("browser.discovery.containers.enabled", true); // [DEFAULT]

/// Enable the (new) UI for browser profiles
pref("browser.profiles.enabled", true);

/// Enable the UI for Containers at `about:preferences#general` (`about:preferences#containers`)
// We also include the Firefox Multi-Account Containers extension by default
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("privacy.userContext.ui.enabled", true); // [DEFAULT - Nightly]

/// Enable the UI for Cookie Banner Reduction at `about:preferences#privacy`
// https://support.mozilla.org/kb/cookie-banner-reduction
pref("cookiebanners.ui.desktop.enabled", true);

/// Prevent Firefox from automatically guessing which container to open an external link in (if containers are enabled)
// Instead, stick to the default
// This can lead to cross contamination for those who keep separate containers exclusively for specific websites
// https://bugzilla.mozilla.org/show_bug.cgi?id=1874599#c8
pref("browser.link.force_default_user_context_id_for_external_opens", true);

/// Set homepage to `about:home`
// This is typically the default, but overriden by some distro-packaged versions of Firefox (ex. Fedora)
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#325
pref("browser.startup.homepage", "about:home"); // [DEFAULT]
pref("browser.startup.page", 1); // [DEFAULT]

/// Set LibreWolf/forks to use our custom enhanced uBlock Origin config by default
// We do not support LibreWolf at the moment, but this will be beneficial if that changes in the future
// https://phoenix.celenity.dev/content-blocking
pref("librewolf.uBO.assetsBootstrapLocation", "https://codeberg.org/celenity/Phoenix/raw/branch/pages/uBlock/assets.json");

pref("browser.phoenix.status.desktop", "013");

/*** 014 MISC. ***/

/// Block websites from prompting to display notifications by default
// I have yet to see a legitimate use-case for websites using push notifications...
// but I see them constantly abused for malicious purposes & spam :/
pref("permissions.default.desktop-notification", 2);

/// Disable Firefox's "Reset/Refresh Profile" prompt
// This could cause Phoenix users serious issues, especially those with custom configs/user.js files...
// We also configure the "DisableProfileRefresh" policy
// https://mozilla.github.io/policy-templates/#disableprofilerefresh 
pref("browser.disableResetPrompt", true, locked); // [HIDDEN]

/// Disable weather on `about:home` by default
pref("browser.newtabpage.activity-stream.showWeather", false);

/// Enable Firefox's newer 'Felt privacy' design for Private Browsing & Certificate Errors
pref("browser.privatebrowsing.felt-privacy-v1", true);
pref("security.certerrors.felt-privacy-v1", true);

/// Hide the Firefox logo on `about:home` by default
pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", false);

/// Notify on Pop-up blocking by default
pref("privacy.popups.showBrowserMessage", true); // [DEFAULT]

/// Show 'Always ask' for camera & microphone in the permissions drop-down (when that's what the user chose...)
pref("permissions.media.show_always_ask.enabled", true);

pref("browser.phoenix.status.desktop", "014");

/*** 015 PERFORMANCE ***/

pref("browser.sessionstore.max_tabs_undo", 7);

/// Disable sidebar animations by default
pref("sidebar.animation.enabled", false);

/// Enable VA-API by default [LINUX] [NO-OSX]
pref("media.ffmpeg.vaapi.enabled", true); // [NO-OSX]

pref("browser.phoenix.status.desktop", "015");

/*** 016 SYNC ***/

pref("services.sync.prefs.sync.browser.bookmarks.autoExportHTML", true);
pref("services.sync.prefs.sync.browser.bookmarks.openInTabClosesMenu", true);
pref("services.sync.prefs.sync.browser.compactmode.show", true);
pref("services.sync.prefs.sync.browser.download.open_pdf_attachments_inline", true);
pref("services.sync.prefs.sync.browser.mailto.dualPrompt", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.enabled", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showRecentSaves", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showWeather", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-dark", true);
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-light", true);
pref("services.sync.prefs.sync.browser.preferences.experimental", true);
pref("services.sync.prefs.sync.browser.privatebrowsing.resetPBM.enabled", true);
pref("services.sync.prefs.sync.browser.privateWindowSeparation.enabled", true);
pref("services.sync.prefs.sync.browser.profiles.enabled", true);
pref("services.sync.prefs.sync.browser.search.openintab", true);
pref("services.sync.prefs.sync.browser.search.separatePrivateDefault.ui.enabled", true);
pref("services.sync.prefs.sync.browser.search.separatePrivateDefault.urlbarResult.enabled", true);
pref("services.sync.prefs.sync.browser.spin_cursor_while_busy", true);
pref("services.sync.prefs.sync.browser.tabs.groups.enabled", true);
pref("services.sync.prefs.sync.browser.tabs.loadBookmarksInTabs", true);
pref("services.sync.prefs.sync.browser.toolbars.bookmarks.visibility", true);
pref("services.sync.prefs.sync.browser.translations.alwaysTranslateLanguages", true);
pref("services.sync.prefs.sync.browser.translations.enable", true);
pref("services.sync.prefs.sync.browser.translations.neverTranslateLanguages", true);
pref("services.sync.prefs.sync.browser.urlbar.openintab", true);
pref("services.sync.prefs.sync.browser.urlbar.suggest.calculator", true);
pref("services.sync.prefs.sync.browser.urlbar.suggest.clipboard", true);
pref("services.sync.prefs.sync.browser.urlbar.unitConversion.enabled", true);
pref("services.sync.prefs.sync.browser.urlbar.update2.engineAliasRefresh", true);
pref("services.sync.prefs.sync.browser.xul.error_pages.expert_bad_cert", true);
pref("services.sync.prefs.sync.browser.xul.error_pages.show_safe_browsing_details_on_load", true);
pref("services.sync.prefs.sync.cookiebanners.service.mode", true);
pref("services.sync.prefs.sync.cookiebanners.service.mode.privateBrowsing", true);
pref("services.sync.prefs.sync.cookiebanners.ui.desktop.enabled", true);
pref("services.sync.prefs.sync.devtools.chrome.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-measure.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-rulers.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-screenshot.enabled", true);
pref("services.sync.prefs.sync.devtools.dom.enabled", true);
pref("services.sync.prefs.sync.devtools.debugger.ui.editor-wrapping", true);
pref("services.sync.prefs.sync.doh-rollout.provider-list", true);
pref("services.sync.prefs.sync.dom.security.https_only_mode_error_page_user_suggestions", true);
pref("services.sync.prefs.sync.dom.security.https_only_mode_send_http_background_request", true);
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true);
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true);
pref("services.sync.prefs.sync.findbar.highlightAll", true);
pref("services.sync.prefs.sync.javascript.options.wasm", true);
pref("services.sync.prefs.sync.layout.forms.reveal-password-button.enabled", true);
pref("services.sync.prefs.sync.media.autoplay.blocking_policy", true);
pref("services.sync.prefs.sync.media.ffmpeg.vaapi.enabled", true);
pref("services.sync.prefs.sync.middlemouse.paste", true);
pref("services.sync.prefs.sync.network.http.referer.XOriginPolicy", true);
pref("services.sync.prefs.sync.network.IDN_show_punycode", true);
pref("services.sync.prefs.sync.network.trr.custom_uri", true);
pref("services.sync.prefs.sync.network.trr.mode", true);
pref("services.sync.prefs.sync.network.trr.uri", true);
pref("services.sync.prefs.sync.pdfjs.sidebarViewOnLoad", true);
pref("services.sync.prefs.sync.permissions.default.camera", true);
pref("services.sync.prefs.sync.permissions.default.desktop-notification", true);
pref("services.sync.prefs.sync.permissions.default.geo", true);
pref("services.sync.prefs.sync.permissions.default.microphone", true);
pref("services.sync.prefs.sync.permissions.default.xr", true);
pref("services.sync.prefs.sync.privacy.resistFingerprinting.letterboxing", true);
pref("services.sync.prefs.sync.privacy.spoof_english", true);
pref("services.sync.prefs.sync.privacy.userContext.ui.enabled", true);
pref("services.sync.prefs.sync.privacy.webrtc.globalMuteToggles", true);
pref("services.sync.prefs.sync.security.OCSP.require", true);
pref("services.sync.prefs.sync.security.ssl.require_safe_negotiation", true);
pref("services.sync.prefs.sync.security.xfocsp.hideOpenInNewWindow", true);
pref("services.sync.prefs.sync.signon.management.page.vulnerable-passwords.enabled", true);
pref("services.sync.prefs.sync.startup.homepage_override_nimbus_disable_wnp", true);
pref("services.sync.prefs.sync.view_source.wrap_long_lines", true);
pref("services.sync.prefs.sync.webgl.disabled", true);

pref("browser.phoenix.status.desktop", "016");

/*** 017 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

pref("browser.bookmarks.autoExportHTML", true); // Export bookmarks to a bookmarks.html file
pref("browser.bookmarks.openInTabClosesMenu", false); // Don't automatically close bookmarks menu after selecting a bookmark
pref("browser.compactmode.show", true);
pref("browser.menu.showViewImageInfo", true); // [DEFAULT - Developer Edition]
pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
pref("browser.newtabpage.activity-stream.feeds.wallpaperfeed", true); // [DEFAULT] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs
pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false);
pref("browser.newtabpage.activity-stream.newtabWallpapers.customColor.enabled", true); // https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs
pref("browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.enabled", true); // https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs
pref("browser.newtabpage.activity-stream.newtabWallpapers.enabled", true); // [DEFAULT] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs
pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", true); // [DEFAULT] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs
pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
pref("browser.newtabpage.activity-stream.showRecentSaves", false);
pref("browser.newtabpage.activity-stream.system.showWeather", true); // Allow enabling the weather on `about:home` - this only controls the UI setting, browser.newtabpage.activity-stream.showWeather is what controls whether the weather is actually displayed or not...
pref("browser.preferences.experimental", true); // [DEFAULT]
pref("browser.preferences.experimental.hidden", false); // [DEFAULT]
pref("browser.privateWindowSeparation.enabled", false); // [WINDOWS]
pref("browser.search.widget.inNavBar", true); // [HIDDEN]
pref("browser.spin_cursor_while_busy", true);
pref("browser.tabs.groups.enabled", true); // [DEFAULT - Nightly] Enable Tab Groups https://www.ghacks.net/2024/12/03/how-to-enable-tab-groups-in-firefox/
pref("browser.tabs.loadBookmarksInTabs", true);
pref("browser.tabs.unloadTabInContextMenu", true); // Adds an 'Unload Tab' option to context menu when right clicking tabs
pref("browser.toolbars.bookmarks.visibility", "always"); // Always show the Bookmarks toolbar by default https://support.mozilla.org/kb/bookmarks-toolbar-display-favorite-websites
pref("browser.translations.newSettingsUI.enable", true); // Enable improved UI in `about:preferences`

/// Clean-up default UI
pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"_testpilot-containers-browser-action\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"developer-button\",\"ublock0_raymondhill_net-browser-action\",\"downloads-button\",\"unified-extensions-button\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"_testpilot-containers-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"unified-extensions-area\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":4}");

/// Enable Taskbar Tabs (PWAs) by default [WINDOWS] [NO-OSX]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1915736
// https://windowsreport.com/firefox-is-bringing-web-apps-to-windows-11-with-taskbar-tabs-first-look/
pref("browser.taskbarTabs.enabled", true); // [HIDDEN] [NO-OSX]

pref("browser.phoenix.status.desktop", "017");

/*** 018 UPDATES ***/

// Browser Updates

/// Display "What's New" Pages by default
pref("startup.homepage_override_nimbus_disable_wnp", false); // [DEFAULT]

/// Enable a dialog/pop-up on major upgrades
pref("browser.startup.upgradeDialog.enabled", true);

pref("browser.phoenix.status.desktop", "018");

/*** 019 SPECIALIZED/CUSTOM CONFIGS [NO-OSX] [NO-SPEC]***/

/// Enable support for custom/specialized configs... [NO-OSX] [NO-SPEC]
pref("general.config.filename", "phoenix.cfg"); // [NO-OSX] [NO-SPEC]
pref("general.config.obscure_value", 0); // [NO-OSX] [NO-SPEC]
pref("general.config.vendor", "phoenix"); // [NO-OSX] [NO-SPEC]

pref("browser.phoenix.status.desktop", "019"); // [NO-OSX] [NO-SPEC]

pref("browser.phoenix.status.desktop", "successfully applied :D", locked);

