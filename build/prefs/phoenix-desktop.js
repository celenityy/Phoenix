
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

/// Add custom branding under `Firefox Updates` at `about:preferences#general`
// This will unfortunately only display if the version of Firefox you're using is repackaged (ex. Flatpaks/Linux distros)
pref("distribution.about", "Phoenix for Mozilla Firefox - 2025.04.27.1 💜", locked);

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
009: MEDIA
010: PASSWORDS & AUTHENTICATION
011: EXTENSIONS
012: AI
013: GEOLOCATION
014: MISC. PRIVACY
015: MISC.
016: PERFORMANCE
017: SYNC
018: Personal Touch 💜
019: UPDATES
020: SPECIALIZED/CUSTOM CONFIGS

*/

/*** 000 ABOUT:CONFIG ***/

/// Disable annoying warnings when attempting to access the about:config
pref("browser.aboutConfig.showWarning", false);

pref("browser.phoenix.status.desktop", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...

/// Disable Crash Reporting
// These specifically are used for tab crashes (`about:tabcrashed`)...
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
pref("browser.tabs.crashReporting.includeURL", false, locked); // [DEFAULT] - Defense in depth
pref("browser.tabs.crashReporting.sendReport", false, locked);

/// Disable Data Reporting & Telemetry
pref("browser.aboutwelcome.log", "off"); // [HIDDEN] Disable logging
pref("browser.newtabpage.activity-stream.feeds.telemetry", false, locked);
pref("browser.newtabpage.activity-stream.impressionId", "", locked);
pref("browser.newtabpage.activity-stream.telemetry", false, locked);
pref("browser.newtabpage.activity-stream.telemetry.privatePing.enabled", false, locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "", locked);
pref("browser.newtabpage.activity-stream.telemetry.surfaceId", "", locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.telemetry.ut.events", false, locked);
pref("browser.places.interactions.enabled", false, locked); // Disable interaction measurements https://searchfox.org/mozilla-central/source/browser/components/places/Interactions.sys.mjs
pref("browser.places.interactions.log", false); // [DEFAULT] [HIDDEN] Disable logging https://searchfox.org/mozilla-central/source/browser/components/places/Interactions.sys.mjs
pref("browser.privacySegmentation.preferences.show", false, locked); // [DEFAULT]
pref("browser.search.serpEventTelemetryCategorization.enabled", false, locked);
pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false, locked); // [DEFAULT] [HIDDEN]
pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [DEFAULT]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked);
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked);
pref("nimbus.telemetry.targetingContextEnabled", false, locked); // https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2001

/// Disable Default Browser Agent [WINDOWS] [NO-OSX]
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html [NO-OSX]
pref("default-browser-agent.enabled", false, locked); // [NO-OSX]

/// Disable Experiments/Studies
// (Shield/Normandy)
// https://mozilla.github.io/normandy/
// https://wiki.mozilla.org/Firefox/Shield/Shield_Studies
// https://support.mozilla.org/kb/shield
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_experiments-or-studies
// https://wiki.mozilla.org/Advocacy/heartbeat
pref("app.normandy.api_url", "", locked);
pref("app.normandy.enabled", false, locked);
pref("app.normandy.experiments.lazy_classify", true, locked); // [HIDDEN] [DEFENSE IN DEPTH] Prevent making client classification requests on every startup https://mozilla.github.io/normandy/dev/feature-experiments.html
pref("app.normandy.first_run", false, locked);
pref("app.normandy.last_seen_buildid", "", locked);
pref("app.normandy.logging.level", 70); // Limits logging to fatal only
pref("app.normandy.user_id", "", locked);
pref("messaging-system.log", "off"); // Disables logging

pref("browser.phoenix.status.desktop", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Clean-up Activity Stream (about:home)
// We also configure "FirefoxHome" in policies
// https://mozilla.github.io/policy-templates/#firefoxhome
// https://searchfox.org/mozilla-central/source/testing/geckodriver/src/prefs.rs
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml
pref("browser.newtabpage.activity-stream.asrouter.debugLogLevel", "error"); // [DEFAULT, HIDDEN] To expose via the `about:config` - https://searchfox.org/mozilla-central/source/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs
pref("browser.newtabpage.activity-stream.asrouter.providers.message-groups", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.useRemoteL10n", false);
pref("browser.newtabpage.activity-stream.debug", false); // [DEFAULT] [HIDDEN - non-Nightly] To expose via the `about:config`
pref("browser.newtabpage.activity-stream.discoverystream.config", "[]", locked);
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.feeds", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "", locked);
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.configURL", "", locked); // [NIGHTLY]
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.relayURL", "", locked); // [NIGHTLY]
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.dismissed", true, locked);
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.personalization.enabled", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.recs.personalized", false, locked);
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.user.enabled", false, locked);
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

/// Clear unnecessary/undesired Mozilla URLs
pref("app.normandy.shieldLearnMoreUrl", "");
pref("browser.newtabpage.activity-stream.support.url", "");

/// Disable add-on/feature recommendations
// https://support.mozilla.org/kb/recommendations-firefox
pref("browser.dataFeatureRecommendations.enabled", false, locked); // [DEFAULT]
pref("browser.discovery.sites", "");
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "null", locked);
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false, locked);
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false, locked);
pref("identity.fxaccounts.toolbar.syncSetup.panelAccessed", true, locked); // https://searchfox.org/mozilla-central/source/browser/base/content/browser-sync.js

/// Disable `about:welcome`/onboarding
// Privacy concerns - unsolicited connection
// Also just annoying :/
// https://searchfox.org/mozilla-central/source/browser/components/BrowserContentHandler.sys.mjs
pref("browser.aboutwelcome.enabled", false);
pref("browser.rights.3.shown", true); // [HIDDEN]
pref("browser.startup.homepage_override.mstone", "ignore", locked);
pref("browser.suppress_first_window_animation", true); // [DEFAULT]
pref("startup.homepage_override_nimbus_disable_wnp", true); // "What's New" Pages
pref("startup.homepage_override_url", "");
pref("startup.homepage_override_url_nimbus", ""); // [DEFAULT
pref("startup.homepage_welcome_url", "");
pref("startup.homepage_welcome_url.additional", ""); // [DEFAULT]

/// Disable Fakespot
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.fakespot.enabled", false);
pref("browser.shopping.experience2023.active", false);
pref("browser.shopping.experience2023.ads.enabled", false, locked); // [DEFAULT]
pref("browser.shopping.experience2023.ads.exposure", false, locked); // [HIDDEN]
pref("browser.shopping.experience2023.ads.userEnabled", false, locked);
pref("browser.shopping.experience2023.autoOpen.enabled", false); // [DEFAULT]
pref("browser.shopping.experience2023.autoOpen.userEnabled", false);
pref("browser.shopping.experience2023.control", false); // [HIDDEN]
pref("browser.shopping.experience2023.enabled", false); // [DEFAULT]
pref("browser.shopping.experience2023.integratedSidebar", false); // [DEFAULT]
pref("browser.shopping.experience2023.newPositionCard.hasSeen", true);
pref("browser.shopping.experience2023.optedIn", 2);
pref("browser.shopping.experience2023.shoppingSidebar", false);
pref("browser.shopping.experience2023.survey.enabled", false);
pref("browser.shopping.experience2023.survey.hasSeen", true);
pref("browser.urlbar.fakespot.featureGate", false); // [DEFAULT]
pref("browser.urlbar.suggest.fakespot", false);

/// Disable "Feature Tours"
pref("browser.firefox-view.feature-tour", '{"screen":"","complete":true}');
pref("browser.newtab.feature-tour", '{"screen":"","complete":true}'); // [HIDDEN]
pref("browser.pdfjs.feature-tour", '{"screen":"","complete":true}');

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
pref("browser.newtabpage.activity-stream.discoverystrean.merino-provider.ohttp.enabled", false); // [DEFAULT] [NIGHTLY]
pref("browser.urlbar.addons.featureGate", false);
pref("browser.urlbar.groupLabels.enabled", false);
pref("browser.urlbar.mdn.featureGate", false);
pref("browser.urlbar.merino.endpointURL", "");
pref("browser.urlbar.merino.providers", "");
pref("browser.urlbar.quicksuggest.contextualOptIn", false);
pref("browser.urlbar.quicksuggest.enabled", false, locked); // Firefox only seems to set this for new profiles if it's locked...
pref("browser.urlbar.quicksuggest.hideSettingsUI", true);
pref("browser.urlbar.quicksuggest.scenario", "offline");
pref("browser.urlbar.quicksuggest.shouldShowOnboardingDialog", false);
pref("browser.urlbar.quicksuggest.showedOnboardingDialog", true);
pref("browser.urlbar.quicksuggest.sponsoredPriority", false, locked);
pref("browser.urlbar.suggest.addons", false);
pref("browser.urlbar.suggest.mdn", false);
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false, locked); // Firefox only seems to set this for new profiles if it's locked...
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
pref("browser.newtabpage.activity-stream.discoverystream.sections.cards.enabled", false); // "Revised Pocket Story Card UI" https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml
pref("browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled", false);
pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
pref("browser.urlbar.pocket.featureGate", false);
pref("browser.urlbar.suggest.pocket", false);
pref("extensions.pocket.enabled", false);

/// Disable "Interest-based Content Relevance Ranking and Personalization"
// https://bugzilla.mozilla.org/show_bug.cgi?id=1886207
pref("toolkit.contentRelevancy.enabled", false, locked); // [DEFAULT]
pref("toolkit.contentRelevancy.ingestEnabled", false, locked); // [DEFAULT]
pref("toolkit.contentRelevancy.log", false); // [DEFAULT]

/// Disable mozAddonManager
// mozAddonManager prevents extensions from working on `addons.mozilla.org`/the specified domains
// This API also exposes a list of the user's installed add-ons to `addons.mozilla.org`/the specified domains...
// Note that the following preferences break installion of extensions on Android (from `addons.mozilla.org`) & Thunderbird (from `addons.thunderbird.net`)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.enabled", false);
pref("privacy.resistFingerprinting.block_mozAddonManager", true);

/// Disable the Mozilla Ad Routing Service (MARS) :/
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/ActivityStream.sys.mjs#221
pref("browser.newtabpage.activity-stream.feeds.adsfeed", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.spocs.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.tiles.enabled", false, locked); // [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.enabled", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.endpoint", "", locked);
pref("browser.newtabpage.activity-stream.unifiedAds.ohttp.enabled", false, locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.unifiedAds.spocs.enabled", false, locked);
pref("browser.newtabpage.activity-stream.unifiedAds.tiles.enabled", false, locked);

/// Disable Mozilla promotions
pref("browser.contentblocking.report.hide_vpn_banner", true, locked);
pref("browser.contentblocking.report.lockwise.enabled", false);
pref("browser.contentblocking.report.mobile-android.url", "", locked);
pref("browser.contentblocking.report.mobile-ios.url", "", locked);
pref("browser.contentblocking.report.monitor.enabled", false); // [DEFAULT]
pref("browser.contentblocking.report.proxy.enabled", false); // [DEFAULT]
pref("browser.contentblocking.report.proxy_extension.url", "", locked);
pref("browser.contentblocking.report.show_mobile_app", false, locked);
pref("browser.contentblocking.report.vpn.url", "", locked);
pref("browser.contentblocking.report.vpn-android.url", "", locked);
pref("browser.contentblocking.report.vpn-ios.url", "", locked);
pref("browser.contentblocking.report.vpn-promo.url", "", locked);
pref("browser.newtabpage.activity-stream.mobileDownloadModal.enabled", false, locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-a", false, locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-b", false, locked); // [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-c", false, locked); // [DEFAULT] [NIGHTLY]
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

/// Disable Mozilla.UITour
// https://mozilla.github.io/bedrock/uitour/#ui-tour
// https://firefox-source-docs.mozilla.org/browser/components/uitour/docs/index.html
// https://searchfox.org/mozilla-central/source/browser/components/uitour/UITourUtils.sys.mjs
pref("browser.uitour.enabled", false, locked);
pref("browser.uitour.loglevel", "Off");
pref("browser.uitour.requireSecure", true, locked); // [DEFAULT]
pref("browser.uitour.surveyDuration", 0, locked);
pref("browser.uitour.testingOrigins", "", locked); // [DEFAULT] [HIDDEN]
pref("browser.uitour.url", "", locked);

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
pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", '{"hidden":true}', locked);
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

/// Disable the "updated wallpaper experience" (V2)
// This causes Firefox to connect to `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/newtab-wallpapers-v2/...` on every browser launch after the user navigates to `about:home` :/
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#1422
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs#22
pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", false);

/// Disable the Web Compatibility Reporter
// Harmless from a privacy perspective - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as attack surface reduction & a potential performance improvement
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#3604
pref("ui.new-webcompat-reporter.enabled", false);
pref("ui.new-webcompat-reporter.new-report-endpoint", "https://phoenix.celenity.dev/issues"); // [HIDDEN] Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764

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

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html & https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("app.releaseNotesURL", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked);
pref("app.releaseNotesURL.aboutDialog", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked);
pref("app.releaseNotesURL.prompt", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked);
pref("app.update.url.details", "https://www.mozilla.org/firefox/notes", locked);
pref("app.update.url.manual", "https://www.mozilla.org/firefox/new", locked);
pref("browser.contentblocking.report.cookie.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_cross-site-tracking-cookies");
pref("browser.contentblocking.report.cryptominer.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_cryptominers");
pref("browser.contentblocking.report.fingerprinter.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_fingerprinters");
pref("browser.contentblocking.report.lockwise.how_it_works.url", "https://support.mozilla.org/kb/password-manager-remember-delete-edit-logins");
pref("browser.contentblocking.report.monitor.sign_in_url", "https://monitor.firefox.com/oauth/init");
pref("browser.contentblocking.report.monitor.url", "https://monitor.firefox.com/");
pref("browser.contentblocking.report.social.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_social-media-trackers");
pref("browser.contentblocking.report.tracker.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_tracking-content");
pref("browser.dictionaries.download.url", "https://addons.mozilla.org/language-tools/");
pref("browser.search.searchEnginesURL", "https://addons.mozilla.org/firefox/search-engines/");
pref("browser.xr.warning.infoURL", "https://support.mozilla.org/kb/webxr-permission-info-page");
pref("extensions.getAddons.get.url", "https://services.addons.mozilla.org/api/v4/addons/search/?guid=%IDS%");
pref("extensions.getAddons.link.url", "https://addons.mozilla.org/");
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/search?q=%TERMS%");
pref("extensions.update.background.url", "https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), 'current' app/browser version (currentAppVersion), and compatibility mode (compatMode)
pref("extensions.update.url", "https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&updateType=%UPDATE_TYPE%"); // Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), 'current' app/browser version (currentAppVersion), and compatibility mode (compatMode)
pref("lightweightThemes.getMoreURL", "https://addons.mozilla.org/themes/");
pref("pdfjs.altTextLearnMoreUrl", "https://support.mozilla.org/kb/pdf-alt-text");

pref("browser.phoenix.status.desktop", "002");

/*** 003 FINGERPRINTING PROTECTION ***/

/// Expose dynamic rounding of content dimensions (`privacy.resistFingerprinting.letterboxing`) in the `about:config`, but do not enable by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366
pref("privacy.resistFingerprinting.letterboxing", false); // [DEFAULT, HIDDEN]

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Features#fingerprinting
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC,-JSLocale");

/// Set FPP granular overrides (if the related target is enabled...)
// Currently covers:
// Barnes & Noble (barnesandnoble.com) - Disables spoofing screen coordinates (-ScreenRect) for account sign-in
// Chipotle (chipotle.com) - Disables timezone spoofing (-JSDateTimeUTC) for order confirmation/estimated arrival times
// Cinny (cinny.in) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny (pendora.io) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/Element (transfem.dev) - Disables timezone spoofing (-JSDateTimeUTC)
// Cinny/SchildiChat (the-apothecary.club) - Disables timezone spoofing (-JSDateTimeUTC)
// City Barbeque (citybbq.com) - Disables timezone spoofing (-JSDateTimeUTC) for estimated delivery times
// Cloudflare (cloudflare.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
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
// Epic Games (epicgames.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
// Proton Mail (proton.me) - Disables timezone spoofing (-JSDateTimeUTC)
// PSA Bypass Link (moviezapiya.fun) - Disables spoofing WebGL renderer info (-WebGLRenderInfo) - https://codeberg.org/celenity/Phoenix/issues/95
// Riverside.FM Studio (riverside.fm) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
// Stack Social (stacksocial.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
// TikTok (tiktok.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
// TileMan.io (tileman.io) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked) to prevent it from bombarding users with prompts despite not actually needing the permission...
// USPS (usps.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
// Yahoo! (yahoo.com) - Blocks canvas data extraction before user input (+CanvasExtractionBeforeUserInputIsBlocked), to prevent it from prompting users despite not needing the permission...
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"barnesandnoble.com","overrides":"-ScreenRect"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cloudflare.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"epicgames.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"moviezapiya.fun","overrides":"-WebGLRenderInfo"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"riverside.fm","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"stacksocial.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"tiktok.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"tileman.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"transfem.dev","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"usps.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"yahoo.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"}]');

pref("browser.phoenix.status.desktop", "003");

/*** 004 DISK AVOIDANCE ***/

/// Clear browsing history, download history, and sessions on exit by default
pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true); // [DEFAULT]
pref("privacy.clearOnShutdown_v2.downloads", true); // [HIDDEN]
pref("privacy.clearOnShutdown_v2.formdata", true);
pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true);

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

/// Enforce HTTPS-Only Mode
// We're not locking this for Android/Thundebird since it's unfortunately not possible to add exceptions there...
// https://gitlab.com/ironfox-oss/IronFox/-/issues/48
pref("dom.security.https_only_mode", true, locked);
pref("dom.security.https_only_mode_pbm", true, locked);

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

/// Highlight domains and other styling
// Protects against phishing
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/preferences.rst
pref("browser.urlbar.formatting.enabled", true); // [DEFAULT] [HIDDEN]

// Nice to have
pref("browser.urlbar.scotchBonnet.enableOverride", true); // [DEFAULT - Nightly] Adds Unified Search button to easily switch search engines in URL Bar - https://windowsreport.com/firefox-tests-dedicated-address-bar-button-for-easier-search-engine-switching/ + other tweaks
pref("browser.urlbar.shortcuts.actions", false); // [HIDDEN]
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
pref("browser.urlbar.restyleSearches", false); // [DEFAULT] [HIDDEN]
pref("browser.urlbar.showSearchTerms.enabled", false);
pref("browser.urlbar.showSearchTerms.featureGate", false);

pref("browser.phoenix.status.desktop", "007");

/*** 008 DNS ***/

/// Improve list of built-in DoH resolvers
pref("doh-rollout.provider-list", '[{"uri":"https://dns.quad9.net/dns-query","UIName":"Quad9 - Real-time Malware Protection","autoDefault":true},{"uri":"https://zero.dns0.eu","UIName":"DNS0 (ZERO) - Hardened Real-time Malware Protection","autoDefault":false},{"uri":"https://dns0.eu","UIName":"DNS0 - Real-time Malware Protection","autoDefault":false},{"uri":"https://base.dns.mullvad.net/dns-query","UIName":"Mullvad (Base) - Ad/Tracking/Limited Malware Protection","autoDefault":false},{"uri":"https://dns.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Ad/Tracking Protection","autoDefault":false},{"uri":"https://dns.mullvad.net/dns-query","UIName":"Mullvad - Unfiltered","autoDefault":false},{"uri":"https://wikimedia-dns.org/dns-query","UIName":"Wikimedia - Unfiltered","autoDefault":false},{"uri":"https://firefox.dns.nextdns.io/","UIName":"NextDNS (Public) - Unfiltered","autoDefault":false},{"uri":"https://unfiltered.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Unfiltered","autoDefault":false},{"uri":"https://kids.dns0.eu","UIName":"DNS0 - Kids","autoDefault":false},{"uri":"https://family.dns.mullvad.net/dns-query","UIName":"Mullvad (Family)","autoDefault":false},{"uri":"https://family.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Family Protection","autoDefault":false},{"uri":"https://extended.dns.mullvad.net/dns-query","UIName":"Mullvad (Extended) - Ad/Tracking/Limited Malware/Social Media Protection","autoDefault":false},{"uri":"https://all.dns.mullvad.net/dns-query","UIName":"Mullvad (All) - Ad/Tracking/Limited Malware/Social Media/Adult/Gambling Protection","autoDefault":false},{"uri":"https://security.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Malware Protection","autoDefault":false},{"uri":"https://mozilla.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Unfiltered (Stricter privacy policy)","autoDefault":false},{"uri":"https://family.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Adult Content/Malware Protection","autoDefault":false}]'); // [HIDDEN]

pref("browser.phoenix.status.desktop", "008");

/*** 009 MEDIA ***/

/// Remove DRM toggle from `about:preferences#general`
pref("browser.eme.ui.enabled", false);

pref("browser.phoenix.status.desktop", "009");

/*** 010 PASSWORDS & AUTHENTICATION ***/

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

pref("browser.phoenix.status.desktop", "010");

/*** 011 EXTENSIONS ***/

/// Block extensions signed with weak signature algorithms
pref("xpinstall.signatures.weakSignaturesTemporarilyAllowed", false); // [DEFAULT, HIDDEN]

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
pref("extensions.quarantineIgnoredByUser.swisscows@celenity.dev", false, locked); // Swisscows

/// Disable installation of add-ons + only allow enabling it per-session
// Includes extensions & themes
// This doesn't impact already installed add-ons & add-ons installed by policies
// Firefox will prompt to re-enable this when necessary
// Setting this pref to `sticky` causes it to reset per session, which is quite nice from a security perspective, as it allows users to enable this functionality only when it's necessary...
// Ex: A user attempts to install an extension, sees the extra prompt/warning, and selects `Enable` (which temporarily sets this pref to `true`...). The user then proceeds to install the extension. On the next launch of Firefox, this pref is reset back to `false`, meaning the ability to install extensions is fully disabled without them even thinking about it.
pref("xpinstall.enabled", false, sticky); // [HIDDEN]

/// Only allow installation of signed extensions by default
// Extensions are still limited to the sources we allow in policies...
pref("extensions.langpacks.signatures.required", true); // [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.desktop", "011");

/*** 012 AI ***/

// https://support.mozilla.org/kb/ai-chatbot

/// Add AI toggle at about:preferences#experimental
pref("browser.ml.chat.hideFromLabs", false);

/// Allow typing a custom prompt based on your selection (if pop-up when highlighting text is enabled)
pref("browser.ml.chat.shortcuts.custom", true); // [DEFAULT]

/// Disable AI functionality by default
pref("browser.ml.chat.enabled", false); // [DEFAULT] - AI Chatbot
pref("browser.ml.chat.shortcuts", false); // Pop-up when highlighting text

/// Disable Link Preview
// https://searchfox.org/mozilla-central/source/browser/components/genai/tests/browser/browser_link_preview.js
pref("browser.ml.linkPreview.enabled", false); // [DEFAULT] [NIGHTLY]

/// Remove privacy-invasive AI Chatbot providers
// (Anthropic Claude, ChatGPT, Google Gemini, and Le Chat Mistral)
// HuggingChat's privacy policy is OK, though it does leave room for improvement - best option out of the built-in
// https://searchfox.org/mozilla-central/source/browser/components/genai/GenAI.sys.mjs#63
pref("browser.ml.chat.providers", "huggingchat"); // [HIDDEN]

/// Set the default AI Chatbot (if enabled) to DuckDuckGo
// Unfortunately this is not compatible with the pop-up when selecting text. 
// Also currently not possible to add this as a persistent option.
pref("browser.ml.chat.provider", "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat");

pref("browser.phoenix.status.desktop", "012");

/*** 013 GEOLOCATION ***/

/// Block websites from prompting to access geolocation by default
pref("permissions.default.geo", 2);

/// Enable Apple Location Services for macOS
pref("geo.provider.use_corelocation", true); // [DEFAULT]

/// Enable Geoclue for GNU/Linux distros [NO-OSX]
pref("geo.provider.use_geoclue", true); // [DEFAULT] [NO-OSX]

/// Update info URL to ours so that users receive accurate information
pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo");

pref("browser.phoenix.status.desktop", "013");

/*** 014 MISC. PRIVACY ***/

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
pref("librewolf.uBO.assetsBootstrapLocation", "https://gitlab.com/celenityy/Phoenix/-/raw/pages/uBlock/assets.json");

pref("browser.phoenix.status.desktop", "014");

/*** 015 MISC. ***/

/// Block websites from prompting to display notifications by default
// I have yet to see a legitimate use-case for websites using push notifications...
// but I see them constantly abused for malicious purposes & spam :/
pref("permissions.default.desktop-notification", 2);

/// Disable Firefox's "Reset/Refresh Profile" prompt
// This could cause Phoenix users serious issues, especially those with custom configs/user.js files...
// We also configure the "DisableProfileRefresh" policy
// https://mozilla.github.io/policy-templates/#disableprofilerefresh 
pref("browser.disableResetPrompt", true, locked); // [HIDDEN]

/// Disable network connectivity status monitoring [NO-OSX]
// (Ex. used for automatically switching between offline & online mode) [NO-OSX]
// AFAICT this pref is no longer (maybe has never been?) present in Firefox, but Red Hat/Fedora sets it anyways for whatever reason... so we can still set it to `false` for consistency [NO-OSX]
pref("offline.autoDetect", false); // [HIDDEN] [NO-OSX]

/// Disable weather on `about:home` by default
pref("browser.newtabpage.activity-stream.showWeather", false);

/// Enable Firefox's newer 'Felt privacy' design for Private Browsing
pref("browser.privatebrowsing.felt-privacy-v1", true);

/// Hide the Firefox logo on `about:home` by default
pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", false);

/// Notify on Pop-up blocking by default
pref("privacy.popups.showBrowserMessage", true); // [DEFAULT]

/// Open links from external programs in new tabs by default
pref("browser.link.open_newwindow.override.external", 3);

/// Prevent websites from automatically refreshing
pref("accessibility.blockautorefresh", true);

/// Show advanced details on pages blocked by Safe Browsing by default
pref("browser.xul.error_pages.show_safe_browsing_details_on_load", true);

/// Show 'Always ask' for camera & microphone in the permissions drop-down (when that's what the user chose...)
pref("permissions.media.show_always_ask.enabled", true);

pref("browser.phoenix.status.desktop", "015");

/*** 016 PERFORMANCE ***/

pref("browser.sessionstore.max_tabs_undo", 7);

/// Disable sidebar animations by default
pref("sidebar.animation.enabled", false);

/// Disable tab hover previews by default
pref("browser.tabs.hoverPreview.enabled", false);
pref("browser.tabs.hoverPreview.showThumbnails", false);

/// Enable advanced performance settings at `about:preferences#general`
// Despite what the name suggests, Firefox will remain at the default/recommended performance settings - all this does is expose the UI settings...
pref("browser.preferences.defaultPerformanceSettings.enabled", false);

/// Enable VA-API by default [LINUX] [NO-OSX]
pref("media.ffmpeg.vaapi.enabled", true); // [NO-OSX]

pref("browser.phoenix.status.desktop", "016");

/*** 017 SYNC ***/

pref("services.sync.prefs.sync.browser.bookmarks.autoExportHTML", true);
pref("services.sync.prefs.sync.browser.bookmarks.openInTabClosesMenu", true);
pref("services.sync.prefs.sync.browser.compactmode.show", true);
pref("services.sync.prefs.sync.browser.download.open_pdf_attachments_inline", true);
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
pref("services.sync.prefs.sync.browser.search.openintab", true);
pref("services.sync.prefs.sync.browser.search.separatePrivateDefault.urlbarResult.enabled", true);
pref("services.sync.prefs.sync.browser.spin_cursor_while_busy", true);
pref("services.sync.prefs.sync.browser.tabs.groups.enabled", true);
pref("services.sync.prefs.sync.browser.tabs.loadBookmarksInTabs", true);
pref("services.sync.prefs.sync.browser.toolbars.bookmarks.visibility", true);
pref("services.sync.prefs.sync.browser.urlbar.openintab", true);
pref("services.sync.prefs.sync.browser.urlbar.suggest.calculator", true);
pref("services.sync.prefs.sync.browser.urlbar.suggest.clipboard", true);
pref("services.sync.prefs.sync.browser.urlbar.unitConversion.enabled", true);
pref("services.sync.prefs.sync.browser.urlbar.update2.engineAliasRefresh", true);
pref("services.sync.prefs.sync.browser.xul.error_pages.expert_bad_cert", true);
pref("services.sync.prefs.sync.browser.xul.error_pages.show_safe_browsing_details_on_load", true);
pref("services.sync.prefs.sync.devtools.chrome.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-measure.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-rulers.enabled", true);
pref("services.sync.prefs.sync.devtools.command-button-screenshot.enabled", true);
pref("services.sync.prefs.sync.devtools.dom.enabled", true);
pref("services.sync.prefs.sync.devtools.debugger.ui.editor-wrapping", true);
pref("services.sync.prefs.sync.dom.security.https_only_mode_error_page_user_suggestions", true);
pref("services.sync.prefs.sync.dom.security.https_only_mode_send_http_background_request", true);
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true);
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true);
pref("services.sync.prefs.sync.findbar.highlightAll", true);
pref("services.sync.prefs.sync.layout.forms.reveal-password-button.enabled", true);
pref("services.sync.prefs.sync.media.autoplay.blocking_policy", true);
pref("services.sync.prefs.sync.media.ffmpeg.vaapi.enabled", true);
pref("services.sync.prefs.sync.middlemouse.paste", true);
pref("services.sync.prefs.sync.network.IDN_show_punycode", true);
pref("services.sync.prefs.sync.pdfjs.sidebarViewOnLoad", true);
pref("services.sync.prefs.sync.privacy.webrtc.globalMuteToggles", true);
pref("services.sync.prefs.sync.security.xfocsp.hideOpenInNewWindow", true); // [ESR]
pref("services.sync.prefs.sync.sidebar.main.tools", true);
pref("services.sync.prefs.sync.sidebar.revamp", true);
pref("services.sync.prefs.sync.startup.homepage_override_nimbus_disable_wnp", true);
pref("services.sync.prefs.sync.view_source.wrap_long_lines", true);

pref("browser.phoenix.status.desktop", "017");

/*** 018 Personal Touch 💜 ***/

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
pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
pref("browser.newtabpage.activity-stream.showRecentSaves", false);
pref("browser.newtabpage.activity-stream.system.showWeather", true); // Allow enabling the weather on `about:home` - this only controls the UI setting, browser.newtabpage.activity-stream.showWeather is what controls whether the weather is actually displayed or not...
pref("browser.preferences.experimental", true); // [DEFAULT] Enable Firefox Labs (`about:preferences#experimental`)
pref("browser.preferences.experimental.hidden", false); // [DEFAULT] Enable Firefox Labs (`about:preferences#experimental`)
pref("browser.privateWindowSeparation.enabled", false); // [WINDOWS]
pref("browser.search.widget.inNavBar", true); // [HIDDEN]
pref("browser.spin_cursor_while_busy", true);
pref("browser.tabs.groups.enabled", true); // [DEFAULT - Nightly] Enable Tab Groups https://www.ghacks.net/2024/12/03/how-to-enable-tab-groups-in-firefox/
pref("browser.tabs.loadBookmarksInTabs", true);
pref("browser.tabs.unloadTabInContextMenu", true); // Adds an 'Unload Tab' option to context menu when right clicking tabs
pref("browser.toolbars.bookmarks.visibility", "always"); // Always show the Bookmarks toolbar by default https://support.mozilla.org/kb/bookmarks-toolbar-display-favorite-websites
pref("browser.translations.newSettingsUI.enable", true); // Enable improved UI in `about:preferences#general`

/// Clean-up default UI
pref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","back-button","forward-button","stop-reload-button","vertical-spacer","urlbar-container","_testpilot-containers-browser-action","fxa-toolbar-menu-button","developer-button","ublock0_raymondhill_net-browser-action","downloads-button","reset-pbm-toolbar-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks","personal-bookmarks"],"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","back-button","forward-button","vertical-spacer","stop-reload-button","urlbar-container","_testpilot-containers-browser-action","fxa-toolbar-menu-button","reset-pbm-toolbar-button","developer-button","ublock0_raymondhill_net-browser-action","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"vertical-tabs":[]},"seen":["reset-pbm-toolbar-button","developer-button","_testpilot-containers-browser-action","ublock0_raymondhill_net-browser-action","reset-pbm-toolbar-button","_testpilot-containers-browser-action","ublock0_raymondhill_net-browser-action","developer-button"],"dirtyAreaCache":["nav-bar","vertical-tabs","PersonalToolbar","unified-extensions-area","TabsToolbar","unified-extensions-area","nav-bar","vertical-tabs"],"currentVersion":21,"newElementCount":7}');

/// Disable annoying "A simpler highlighter can be enabled in the settings..." banner when using developer tools
pref("devtools.inspector.simple-highlighters.message-dismissed", true); // [HIDDEN]

/// Disable extra logging for policies by default
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config
// https://searchfox.org/mozilla-central/source/browser/components/enterprisepolicies/Policies.sys.mjs
pref("browser.policies.loglevel", "error"); // [DEFAULT, HIDDEN]

/// Enable Backup UI settings (at `about:preferences#general`)
pref("browser.backup.preferences.ui.enabled", true);

/// Enable + customize the new Sidebar by default
pref("browser.toolbarbuttons.introduced.sidebar-button", false); // Prevents Sidebar from automatically opening and closing on first launch - also needs `browser.uiCustomization.state`
pref("sidebar.backupState", '{"command":"","launcherWidth":0,"launcherExpanded":false,"launcherVisible":false}'); // Hide by default
pref("sidebar.main.tools", "bookmarks,syncedtabs,history"); // Removes AI Chat, adds Bookmarks
pref("sidebar.revamp", true); // [DEFAULT - Nightly]
pref("sidebar.visibility", "hide-sidebar"); // Hide by default

/// Enable Taskbar Tabs (PWAs) by default [WINDOWS] [NO-OSX]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1915736 [NO-OSX]
// https://windowsreport.com/firefox-is-bringing-web-apps-to-windows-11-with-taskbar-tabs-first-look/ [NO-OSX]
pref("browser.taskbarTabs.enabled", true); // [HIDDEN] [NO-OSX]

pref("browser.phoenix.status.desktop", "018");

/*** 019 UPDATES ***/

// Browser Updates

/// Enable a dialog/pop-up on major upgrades
pref("browser.startup.upgradeDialog.enabled", true);

pref("browser.phoenix.status.desktop", "019");

/*** 020 SPECIALIZED/CUSTOM CONFIGS [NO-OSX] [NO-SPEC]***/

/// Enable support for custom/specialized configs... [NO-OSX] [NO-SPEC]
pref("general.config.filename", "phoenix.cfg"); // [NO-OSX] [NO-SPEC]
pref("general.config.obscure_value", 0); // [NO-OSX] [NO-SPEC]
pref("general.config.vendor", "phoenix"); // [NO-OSX] [NO-SPEC]

pref("browser.phoenix.status.desktop", "020"); // [NO-OSX] [NO-SPEC]

pref("browser.phoenix.status.desktop", "successfully applied :D", locked);

