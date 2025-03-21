//
// The Phoenix shall rise from the ashes of what fell before it.

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

// Welcome to the heart of the Phoenix.
// This file contains preferences shared across all Phoenix configs, platforms (Desktop & Android), and Dove.

pref("browser.phoenix.version", "2025.03.20.1", locked);

/* INDEX 

000: ABOUT:CONFIG
001: DATA COLLECTION
002: MOZILLA CRAP™
003: TRACKING PROTECTION
004: FINGERPRINTING PROTECTION
005: DISK AVOIDANCE
006: DOWNLOADS
007: HTTP(S)
008: IMPLICIT CONNECTIONS
009: SEARCH & URL BAR
010: DNS
011: PROXIES
012: WEBRTC
013: MEDIA
014: ATTACK SURFACE REDUCTION
015: PASSWORDS & AUTHENTICATION
016: EXTENSIONS
017: AI
018: GEOLOCATION
019: PDF.js
020: SAFE BROWSING
021: DEBUGGING
022: MISC. PRIVACY
023: MISC. SECURITY
024: MISC.
025: PERFORMANCE
026: SCROLLING
027: Personal Touch 💜
028: UPDATES

*/

/*** 000 ABOUT:CONFIG ***/

/// Disable annoying warnings when attempting to access the about:config
pref("general.warnOnAboutConfig", false);

/// Ensure that about:config is always enabled
pref("general.aboutConfig.enable", true, locked); // [DEFAULT on Desktop]

pref("browser.phoenix.status.core", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...

/// Disable Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs
// https://bugzilla.mozilla.org/show_bug.cgi?id=1487578
pref("toolkit.telemetry.coverage.opt-out", true, locked); // [HIDDEN]

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
// https://firefox-source-docs.mozilla.org/tools/sanitizer/asan_nightly.html
// https://github.com/choller/firefox-asan-reporter
pref("asanreporter.apiurl", "", locked);
pref("asanreporter.clientid", "", locked);
pref("asanreporter.loglevel", 70);
pref("breakpad.reportURL", "", locked);
pref("toolkit.crashreporter.include_context_heap", false, locked);

/// Disable Data Reporting & Telemetry
/// We also configure "DisableTelemetry" & "ImproveSuggest" in policies on Desktop
// https://mozilla.github.io/policy-templates/#disabletelemetry 
// https://mozilla.github.io/policy-templates/#firefoxsuggest
// https://searchfox.org/mozilla-central/source/testing/geckodriver/src/prefs.rs
// https://wiki.mozilla.org/QA/Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html 
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
// https://searchfox.org/mozilla-central/source/remote/shared/RecommendedPreferences.sys.mjs
// https://searchfox.org/mozilla-central/source/testing/profiles/perf/user.js
pref("browser.places.interactions.enabled", false, locked); // https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js
pref("browser.rights.3.shown", true);
pref("browser.safebrowsing.features.emailtracking.datacollection.update", false, locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("captchadetection.actor.enabled", false, locked); // [DEFAULT - non-Nightly] Disable CAPTCHA Detection Pings https://searchfox.org/mozilla-central/source/toolkit/components/captchadetection
pref("captchadetection.loglevel", "Off");
pref("datareporting.dau.cachedUsageProfileID", "beefbeef-beef-beef-beef-beeefbeefbee", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/app/ClientID.sys.mjs#44
pref("datareporting.healthreport.documentServerURI", "", locked); // [HIDDEN]
pref("datareporting.healthreport.logging.consoleEnabled", false); // [HIDDEN]
pref("datareporting.healthreport.service.enabled", false, locked); // [HIDDEN]
pref("datareporting.healthreport.service.firstRun", false, locked); // [HIDDEN]
pref("datareporting.healthreport.uploadEnabled", false, locked);
pref("datareporting.policy.dataSubmissionEnabled", false, locked);
pref("datareporting.policy.dataSubmissionPolicyAccepted", false, locked);
pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true, locked);
pref("datareporting.policy.firstRunURL", "", locked);
pref("datareporting.usage.uploadEnabled", false, locked); // Disables sending "daily usage pings" to Mozilla - currently only on Nightly https://support.mozilla.org/kb/usage-ping-settings
pref("dom.security.unexpected_system_load_telemetry_enabled", false, locked);
pref("network.jar.record_failure_reason", false, locked); // https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#14397
pref("network.traffic_analyzer.enabled", false, locked); // https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#13191
pref("network.trr.confirmation_telemetry_enabled", false, locked);
pref("privacy.imageInputTelemetry.enableTestMode", false, locked); // [HIDDEN] "Event Telemetry" https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#15549
pref("privacy.trackingprotection.emailtracking.data_collection.enabled", false, locked);
pref("toolkit.content-background-hang-monitor.disabled", true, locked); // BHR https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#16720
pref("toolkit.telemetry.archive.enabled", false, locked);
pref("toolkit.telemetry.bhrPing.enabled", false, locked);
pref("toolkit.telemetry.cachedClientID", "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0", locked);
pref("toolkit.telemetry.cachedProfileGroupID", "decafdec-afde-cafd-ecaf-decafdecafde", locked);
pref("toolkit.telemetry.dap.helper.hpke", "", locked);
pref("toolkit.telemetry.dap.helper.url", "", locked);
pref("toolkit.telemetry.dap.leader.hpke", "", locked);
pref("toolkit.telemetry.dap.leader.url", "", locked);
pref("toolkit.telemetry.dap.logLevel", "Off");
pref("toolkit.telemetry.dap_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_helper", "", locked);
pref("toolkit.telemetry.dap_helper_owner", "", locked);
pref("toolkit.telemetry.dap_leader", "", locked);
pref("toolkit.telemetry.dap_leader_owner", "", locked);
pref("toolkit.telemetry.dap_task1_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_task1_taskid", "", locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_experiment_list", "[]", locked); // [DEFAULT]
pref("toolkit.telemetry.debugSlowSql", false); // [DEFAULT]
pref("toolkit.telemetry.enabled", false, locked);  // [DEFAULT - non-Nightly]
pref("toolkit.telemetry.firstShutdownPing.enabled", false, locked);
pref("toolkit.telemetry.healthping.enabled", false, locked); // [HIDDEN]
pref("toolkit.telemetry.log.level", "Error"); // [HIDDEN, DEFAULT] - To expose via about:config...
pref("toolkit.telemetry.newProfilePing.enabled", false, locked);
pref("toolkit.telemetry.pioneerId", "", locked); // [HIDDEN]
pref("toolkit.telemetry.previousBuildID", "", locked);
pref("toolkit.telemetry.reportingpolicy.firstRun", false, locked);
pref("toolkit.telemetry.server", "data;", locked);
pref("toolkit.telemetry.server_owner", "", locked);
pref("toolkit.telemetry.shutdownPingSender.backgroundtask.enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.shutdownPingSender.enabled", false, locked);
pref("toolkit.telemetry.shutdownPingSender.enabledFirstSession", false, locked); // [DEFAULT]
pref("toolkit.telemetry.testing.suppressPingsender", true, locked); // [HIDDEN]
pref("toolkit.telemetry.translations.logLevel", "Off");
pref("toolkit.telemetry.unified", false, locked);
pref("toolkit.telemetry.updatePing.enabled", false, locked);
pref("toolkit.telemetry.user_characteristics_ping.current_version", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.last_version_sent", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.logLevel", "Off");
pref("toolkit.telemetry.user_characteristics_ping.opt-out", true, locked);
pref("toolkit.telemetry.user_characteristics_ping.send-once", false, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.uuid", "", locked); // [DEFAULT]

/// Disable Origin Trials
// https://wiki.mozilla.org/Origin_Trials
pref("dom.origin-trials.enabled", false, locked);

/// Disable X-Frame Options Error Reporting
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/data/xfocsp-error-report-ping.html
pref("security.xfocsp.errorReporting.automatic", false, locked); // [DEFAULT]
pref("security.xfocsp.errorReporting.enabled", false, locked);

/// Remove unnecessary links
pref("datareporting.healthreport.infoURL", "");
pref("extensions.recommendations.privacyPolicyUrl", "");
pref("toolkit.crashreporter.infoURL", "");
pref("toolkit.datacollection.infoURL", "");

pref("browser.phoenix.status.core", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Disable the DoH Rollout
pref("doh-rollout.disable-heuristics", true, locked); // [HIDDEN]
pref("doh-rollout.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.skipHeuristicsCheck", true, locked); // [HIDDEN]
pref("doh-rollout.uri", "", locked); // [HIDDEN]

/// Disable Fakespot
pref("toolkit.shopping.ohttpConfigURL", "");
pref("toolkit.shopping.ohttpRelayURL", "");

/// Disable Firefox Relay
pref("signon.firefoxRelay.feature", "disabled"); // [HIDDEN - Thunderbird]

/// Disable "Privacy-Preserving Attribution"
// https://support.mozilla.org/kb/privacy-preserving-attribution
pref("dom.origin-trials.private-attribution.state", 2, locked); // [DEFAULT]
pref("dom.private-attribution.submission.enabled", false, locked); // [DEFAULT]

/// Disable recommendations
pref("extensions.getAddons.browseAddons", ""); // [HIDDEN - non-Android]
pref("extensions.getAddons.showPane", false);
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("extensions.recommendations.themeRecommendationUrl", "");
pref("extensions.webservice.discoverURL", ""); // [HIDDEN - non-Thunderbird]

/// Disable Remote Settings 'Preview' Buckets
// Nice to expose via about:config
pref("services.settings.preview_enabled", false); // [HIDDEN, DEFAULT]

/// Disable the Web Compatibility Reporter
// Harmless from a privacy perspective - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as attack surface reduction & a potential performance improvement
pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT on non-Nightly/ESR]
pref("extensions.webcompat-reporter.newIssueEndpoint", "");

/// Remove special privileges from Mozilla domains
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#privileged-mozilla-content
pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false, locked); // [DEFAULT on Firefox Desktop]
pref("browser.tabs.remote.separatedMozillaDomains", "", locked);
pref("dom.ipc.processCount.privilegedmozilla", 0, locked);
pref("extensions.webapi.testing", false, locked); // [DEFAULT] https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#5445
pref("extensions.webextensions.restrictedDomains", "");
pref("svg.context-properties.content.allowed-domains", "", locked); // [DEFAULT - Android/Thunderbird]

/// Remove tracking parameters from Mozilla URLs
pref("browser.backup.template.fallback-download.aurora", "https://www.mozilla.org/firefox/channel/desktop/#developer");
pref("browser.backup.template.fallback-download.beta", "https://www.mozilla.org/firefox/channel/desktop/#beta");
pref("browser.backup.template.fallback-download.esr", "https://www.mozilla.org/firefox/enterprise/#download");
pref("browser.backup.template.fallback-download.nightly", "https://www.mozilla.org/firefox/channel/desktop/#nightly");
pref("browser.backup.template.fallback-download.release", "https://www.mozilla.org/firefox/download/thanks/?s=direct");
pref("signon.firefoxRelay.manage_url", "https://relay.firefox.com/accounts/profile/");

pref("browser.phoenix.status.core", "002");

/*** 003 TRACKING PROTECTION ***/

/// Enable ETP Strict
// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop?as=u#w_strict-enhanced-tracking-protection
pref("browser.contentblocking.category", "strict", locked); // [HIDDEN]

/// Manually enable ETP/Strict protections...
// These are typically configured by ETP Strict - but unfortunately Firefox doesn't set ETP Strict on the browser's first run :/
// So we need to also manually configure them. We still also use ETP Strict (not 'Custom') due to our enforcement of it, so we should be covered by Mozilla changes/updates for protections.
// Manually specifying these is also useful for cases like Android: where all protections aren't enabled with ETP Strict, and on Thunderbird: where ETP Strict doesn't exist at all...
// We're also configuring the 'CookieBehavior' & 'EnableTrackingProtection' policies on desktop.

//// Block known cryptominers
pref("privacy.trackingprotection.cryptomining.enabled", true);

//// Block known email trackers
pref("privacy.trackingprotection.emailtracking.enabled", true);
pref("privacy.trackingprotection.emailtracking.pbmode.enabled", true);

//// Block known fingerprinters
pref("privacy.trackingprotection.fingerprinting.enabled", true);

//// Block known social trackers
pref("privacy.trackingprotection.socialtracking.enabled", true);

//// Block known trackers
pref("browser.safebrowsing.features.cryptomining.annotate.update", true); // [DEFAULT, HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.cryptomining.update", true); // [DEFAULT, HIDDEN - non-Android] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.emailtracking.update", true); // [DEFAULT, HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.fingerprinting.annotate.update", true); // [DEFAULT, HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.fingerprinting.update", true); // [DEFAULT, HIDDEN - non-Android] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.socialtracking.annotate.update", true); // [DEFAULT, HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.socialtracking.update", true); // [DEFAULT, HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.trackingAnnotation.update", true); // [DEFAULT, HIDDEN - non-Android] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.features.trackingProtection.update", true); // [DEFAULT, HIDDEN - non-Android] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.provider.mozilla.updateURL", "moz-sbrs:://antitracking"); // [DEFAULT - non-Thunderbird]
pref("privacy.trackingprotection.annotate_channels", true);
pref("privacy.trackingprotection.enabled", true);
pref("privacy.trackingprotection.pbmode.enabled", true);

//// Block known trackers using the `strict` (Level 2) list
/// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#15192
/// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#2804
pref("privacy.annotate_channels.strict_list.enabled", true);
pref("privacy.annotate_channels.strict_list.pbmode.enabled", true);

//// Block known tracking cookies
pref("network.cookie.cookieBehavior.trackerCookieBlocking", true);
pref("privacy.socialtracking.block_cookies.enabled", true);

//// Enable Bounce Tracking Protection
/// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_bounce-tracking-protection
/// https://searchfox.org/mozilla-central/source/toolkit/components/antitracking/bouncetrackingprotection/nsIBounceTrackingProtection.idl#11
pref("privacy.bounceTrackingProtection.enabled", true); // [HIDDEN - non-Thunderbird]
pref("privacy.bounceTrackingProtection.mode", 1); // [HIDDEN - Thunderbird]

//// Enable Query Parameter Stripping
/// https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/query-stripping/index.html
pref("privacy.query_stripping.enabled", true);
pref("privacy.query_stripping.enabled.pbmode", true);
pref("privacy.query_stripping.redirect", true);

//// Enable SmartBlock & UA overrides/injections
pref("extensions.webcompat.enable_shims", true); // [HIDDEN]
pref("extensions.webcompat.perform_injections", true); // [HIDDEN]
pref("extensions.webcompat.perform_ua_overrides", true); // [HIDDEN]

//// Enable State Partitioning
pref("privacy.partition.always_partition_third_party_non_cookie_storage", true);
pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false);
pref("privacy.partition.bloburl_per_partition_key", true);
pref("privacy.partition.network_state", true);
pref("privacy.partition.network_state.ocsp_cache", true);
pref("privacy.partition.network_state.ocsp_cache.pbmode", true);
pref("privacy.partition.serviceWorkers", true);

//// Enable Suspected Fingerprinters Protection (FPP)
/// https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters
pref("privacy.fingerprintingProtection", true);
pref("privacy.fingerprintingProtection.pbmode", true);
pref("privacy.reduceTimerPrecision", true); // [DEFAULT]

//// Enable TCP/dFPI
/// https://support.mozilla.org/kb/introducing-total-cookie-protection-standard-mode
/// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#2828
pref("network.cookie.cookieBehavior", 5);
pref("network.cookie.cookieBehavior.optInPartitioning", true);
pref("network.cookie.cookieBehavior.optInPartitioning.pbmode", true);
pref("network.cookie.cookieBehavior.pbmode", 5);

//// Ignore less restricted referer policies (than the default)
/// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#12979
pref("network.http.referer.disallowCrossSiteRelaxingDefault", true); // [DEFAULT] - for cross-site requests
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode", true); // [DEFAULT] - for cross-site requests in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode.top_navigation", true); // [DEFAULT] - for top navigations in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true); // for top navigations

pref("browser.phoenix.status.core", "003");

/*** 004 FINGERPRINTING PROTECTION ***/

/// Disable failIfMajorPerformanceCaveat in WebGL contexts
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/18603
pref("webgl.disable-fail-if-major-performance-caveat", true); // [DEFAULT]

/// Disable WebGPU
// Also provides attack surface reduction
// https://gpuweb.github.io/gpuweb/#privacy-considerations
// https://gpuweb.github.io/gpuweb/#security-considerations
// https://browserleaks.com/webgpu
pref("dom.webgpu.enabled", false); // [DEFAULT - non-Nightly]

/// Enable fdlibm for Math.sin, Math.cos, and Math.tan
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#8720
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/0dxAO-JsoXI/m/eEhjM9VsAgAJ
pref("javascript.options.use_fdlibm_for_sin_cos_tan", true); // [DEFAULT - non-Android/Windows/Thunderbird]

/// Enable light mode by default
// Matches with RFP & prevents exposing system theme
pref("layout.css.prefers-color-scheme.content-override", 1);

/// Round window sizes
pref("privacy.window.maxInnerHeight", 900); // [DEFAULT - non-Thunderbird]
pref("privacy.window.maxInnerWidth", 1600);

/// Prevent using system accent colors
pref("widget.non-native-theme.use-theme-accent", false); // [DEFAULT - non-Thunderbird Windows]

/// Prevent using system colors
pref("browser.display.use_system_colors", false); // [DEFAULT - non-Windows]

/// Prompt to spoof locale to en-US
pref("privacy.spoof_english", 0); // [DEFAULT]

pref("browser.phoenix.status.core", "004");

/*** 005 DISK AVOIDANCE ***/

/// Allow permission manager to write to disk
// This is already Firefox's default - but it's hidden, so this exposes it to the `about:config`
// https://searchfox.org/mozilla-central/source/extensions/permissions/PermissionManager.cpp#758
pref("permissions.memory_only", false); // [HIDDEN - DEFAULT]

/// Disable coloring visited links
pref("layout.css.visited_links_enabled", false);

/// Disable Search & Form History
// Can be leaked to sites...
// https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
pref("browser.formfill.enable", false);

/// Disable disk caching
pref("browser.cache.disk.enable", false);
pref("browser.cache.disk_cache_ssl", false);

/// Disable logging blocked domains to `about:protections`
pref("browser.contentblocking.database.enabled", false); // [DEFAULT - Android/Thunderbird]

/// Prevent adding downloads to "recent documents"...
pref("browser.download.manager.addToRecentDocs", false);

/// Prevent clearing passwords & site settings by default
pref("privacy.clearOnShutdown.siteSettings", false); // [DEFAULT, HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown_v2.siteSettings", false); // [DEFAULT, HIDDEN - Android/Thunderbird]

/// Prevent storing unnecessary extra session data
pref("browser.sessionstore.privacy_level", 2); // [HIDDEN - Thunderbird]

/// Prevent writing media cache (ex. for video streaming) to disk in private windows
pref("browser.privatebrowsing.forceMediaMemoryCache", true);

/// Remove cached files from browser windows opened with external applications
// https://bugzilla.mozilla.org/buglist.cgi?bug_id=302433,1738574
pref("browser.download.start_downloads_in_tmp_dir", true);
pref("browser.helperApps.deleteTempFileOnExit", true); // [DEFAULT - Thunderbird]

/// Remove files from session list & history when deleted in Firefox 
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js
pref("browser.download.clearHistoryOnDelete", 2); // [HIDDEN - Android/Thunderbird]

/// Sanitization
// Clear browsing history, cache, download history, and sessions on exit by default
pref("privacy.clearOnShutdown.cache", true);
pref("privacy.clearOnShutdown.downloads", true); // [HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown.history", true); // [HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown.sessions", true); // [HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true); // [DEFAULT, HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown_v2.cache", true); // [DEFAULT]
pref("privacy.clearOnShutdown_v2.downloads", true); // [HIDDEN]
pref("privacy.clearOnShutdown_v2.formdata", true); // [HIDDEN - Android/Thunderbird]
pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true); // [HIDDEN - Android/Thunderbird]
pref("privacy.sanitize.sanitizeOnShutdown", true);

pref("browser.phoenix.status.core", "005");

/*** 006 DOWNLOADS ***/

// Block insecure downloads
pref("dom.block_download_insecure", true); // [DEFAULT]

/// Disable extra download logging by default
// This lets us expose it in the about:config for Android/Thunderbird
pref("browser.download.loglevel", "Error"); // [DEFAULT, HIDDEN - Android/Thunderbird]

// Notify when downloading files
pref("browser.download.alwaysOpenPanel", true); // [DEFAULT - Desktop, HIDDEN - Android/Thunderbird]

/// Prompt before downloading files
pref("browser.download.always_ask_before_handling_new_types", true);
pref("browser.download.useDownloadDir", false); // [DEFAULT - Thunderbird]

pref("browser.phoenix.status.core", "006");

/*** 007 HTTP(S) ***/

/// Always preload intermediates
// https://wiki.mozilla.org/Security/CryptoEngineering/Intermediate_Preloading
pref("security.remote_settings.intermediates.enabled", true); // [DEFAULT]

/// Always warn on insecure webpages
pref("security.insecure_connection_text.enabled", true);
pref("security.insecure_connection_text.pbmode.enabled", true);
pref("security.ssl.treat_unsafe_negotiation_as_broken", true);

/// Always warn when submitting a form from HTTP to HTTPS, even on local IP addresses
pref("security.insecure_field_warning.ignore_local_ip_address", false);
pref("security.warn_submit_secure_to_insecure", true); // [DEFAULT]

/// Block access to AddonManager over insecure protocols
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#5452
pref("extensions.webapi.testing.http", false); // [DEFAULT]

/// Disable downgrades to insecure TLS 1.0/1.1
pref("security.tls.insecure_fallback_hosts", ""); // [DEFAULT]
pref("security.tls.version.enable-deprecated", false, locked); // [DEFAULT]

/// Disable sending background HTTP requests to websites that do not respond quickly to check if they support HTTPS
pref("dom.security.https_only_mode_send_http_background_request", false);

/// Disable third-party/OS-level root certificates
// I've been torn on how to handle this, but IMO the safest way forward is disabling this functionality in Firefox.
// This is commonly abused by malware/etc. and it's even overriden by certain software/garbage AV's...
// Ex. https://support.kaspersky.com/common/compatibility/14620#block3
// Since this is something programs actively try to override, I don't see a safe way to support this, so we'll lock it.
// We still allow users to manually import certificates into Firefox... 
// So we can ensure users are aware of certificates they add and are making this decision consciously.
// security.osclientcerts.autoload can be left alone - https://groups.google.com/a/mozilla.org/g/enterprise/c/XiW-ZidMaII
pref("security.enterprise_roots.enabled", false); // [DEFAULT - Android]

/// Disable TLS 1.3 0-RTT
// Not forward secret
// https://github.com/tlswg/tls13-spec/issues/1001
pref("network.http.http3.enable_0rtt", false); // For HTTP3 https://bugzilla.mozilla.org/show_bug.cgi?id=1689550
pref("security.tls.enable_0rtt_data", false);

/// Enable (+ enforce) Certificate Transparency
// https://wiki.mozilla.org/SecurityEngineering/Certificate_Transparency
pref("security.pki.certificate_transparency.mode", 2); // [DEFAULT - Nightly Desktop]
pref("security.pki.certificate_transparency.disable_for_hosts", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.disable_for_spki_hashes", ""); // [DEFAULT]

/// Enable CRLite revocation checks & prioritize over OCSP
// https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/
pref("security.pki.crlite_mode", 2); // [DEFAULT on Nightly]
pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT - Nightly Desktop]

/// Enable OCSP revocation checks + stapling
// (https://wikipedia.org/wiki/Online_Certificate_Status_Protocol
// https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
// https://blog.cloudflare.com/high-reliability-ocsp-stapling/#ocsp-must-staple
pref("security.OCSP.enabled", 1); // [DEFAULT - Desktop]
pref("security.ssl.enable_ocsp_must_staple", true); // [DEFAULT]
pref("security.ssl.enable_ocsp_stapling", true); // [DEFAULT]

/// Enable Post Quantum Key Agreement (Kyber)
pref("media.webrtc.enable_pq_dtls", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("network.http.http3.enable_kyber", true);
pref("security.tls.enable_kyber", true);

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning
pref("security.cert_pinning.enforcement_level", 2);

/// Enforce TLS 1.3 downgrade protection
// https://bugzilla.mozilla.org/show_bug.cgi?id=1576790
pref("security.tls.hello_downgrade_check", true); // [DEFAULT]

/// Enforce using HTTPS as much as possible
pref("dom.security.https_first", true);
pref("dom.security.https_first_for_custom_ports", true); // [DEFAULT, DEFENSE IN DEPTH]
pref("dom.security.https_first_pbm", true); // [DEFAULT]
pref("dom.security.https_first_schemeless", true);
pref("dom.security.https_only_mode", true);
pref("dom.security.https_only_mode.upgrade_local", true);
pref("dom.security.https_only_mode_pbm", true);
pref("security.mixed_content.block_active_content", true);
pref("security.mixed_content.block_display_content", true);
pref("security.mixed_content.block_object_subrequest", true);
pref("security.mixed_content.upgrade_display_content", true);
pref("security.mixed_content.upgrade_display_content.audio", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.image", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.video", true); // [DEFAULT]

/// Hard-fail OCSP revocation checks by default
// Significant security improvement
// https://github.com/arkenfox/user.js/issues/1576
pref("security.OCSP.require", true);

/// Only load secure websockets from HTTPS pages
pref("network.websocket.allowInsecureFromHTTPS", false); // [DEFAULT]

/// Require safe renegotiations
// Disables connections to servers without RFC 5746
// https://wiki.mozilla.org/Security:Renegotiation
pref("security.ssl.require_safe_negotiation", true);

/// Show detailed information on insecure warning pages
pref("browser.xul.error_pages.expert_bad_cert", true);

/// Show suggestions when an HTTPS page can not be found 
// Ex. If 'example.com' isn't secure, it may suggest 'www.example.com'
pref("dom.security.https_only_mode_error_page_user_suggestions", true);

pref("browser.phoenix.status.core", "007");

/*** 008 IMPLICIT CONNECTIONS ***/

/// Disable Early Hints
// https://developer.mozilla.org/docs/Web/HTTP/Status/103
// https://github.com/bashi/early-hints-explainer/blob/main/explainer.md
// Ex. like Cromite https://github.com/uazo/cromite/blob/master/build/patches/Client-hints-overrides.patch
pref("network.early-hints.enabled", false);
pref("network.early-hints.over-http-v1-1.enabled", false);
pref("network.early-hints.preconnect.enabled", false);
pref("network.early-hints.preconnect.max_connections", 0);

/// Disable Network Prefetching
// https://developer.mozilla.org/docs/Glossary/Prefetch
pref("dom.prefetch_dns_for_anchor_http_document", false); // https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42684
pref("dom.prefetch_dns_for_anchor_https_document", false); // [DEFAULT] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42684
pref("network.dns.disablePrefetch", true);
pref("network.dns.disablePrefetchFromHTTPS", true);
pref("network.dns.prefetch_via_proxy", false); // [DEFAULT]
pref("network.http.speculative-parallel-limit", 0); // [DEFAULT - Thunderbird]
pref("network.predictor.enable-hover-on-ssl", false); // [DEFAULT]
pref("network.predictor.enable-prefetch", false); // [DEFAULT]
pref("network.predictor.enabled", false);
pref("network.prefetch-next", false);

/// Disable Preconnect
// https://github.com/uBlockOrigin/uBlock-issues/issues/2913
// https://developer.mozilla.org/docs/Web/HTML/Attributes/rel/preconnect
pref("network.preconnect", false);

/// Disable Search Suggestions
// These prefs appear to have no impact on Android & Thunderbird, but they still appear in both by default... so we can set anyways
pref("browser.search.suggest.enabled", false); // [DEFAULT - Android]
pref("browser.search.suggest.enabled.private", false); // [DEFAULT]

/// Prevent middle mouse clicks from pasting clipboard contents by default
// Way too easy to accidentally press...
pref("middlemouse.paste", false);

/// Prevent middle mouse clicks on new tab button opening URLs or searches from clipboard
pref("browser.tabs.searchclipboardfor.middleclick", false);
pref("middlemouse.contentLoadURL", false); // [DEFAULT]

pref("browser.phoenix.status.core", "008");

/*** 009 SEARCH & URL BAR ***/

/// Allow using a different search engine in normal vs. private Windows
pref("browser.search.separatePrivateDefault.ui.enabled", true);

/// Always show Punycode
// Protects against phishing & IDN Homograph Attacks
// https://wikipedia.org/wiki/IDN_homograph_attack
pref("network.IDN_show_punycode", true);

/// Use same search engine in both normal & private browsing windows by default
// Otherwise, Firefox's default private search engine will set itself as Google, regardless of our default... :/
pref("browser.search.separatePrivateDefault", false);

pref("browser.phoenix.status.core", "009");

// 010 DNS

/// Always warn before falling back from DoH to system DNS
pref("network.trr.display_fallback_warning", true);
pref("network.trr_ui.show_fallback_warning_option", true);

/// Disable DoH Connectivity Checks
pref("network.connectivity-service.DNS_HTTPS.domain", "");
pref("network.trr.confirmationNS", "skip");

/// Disable EDNS Client Subnet (ECS) to prevent leaking general location data to authoritative DNS servers...
// https://wikipedia.org/wiki/EDNS_Client_Subnet
pref("network.trr.disable-ECS", true); // [DEFAULT]

/// Disable falling back to system DNS by default
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#13855
pref("network.trr.retry_on_recoverable_errors", true); // [DEFAULT]
pref("network.trr.strict_native_fallback", true); // https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/environment.rst#438

/// Enable DoH without fallback & Set to Quad9 by default
pref("network.trr.default_provider_uri", "https://dns.quad9.net/dns-query");
pref("network.trr.mode", 3);

/// Enable EncryptedClientHello
// https://blog.cloudflare.com/announcing-encrypted-client-hello
pref("network.dns.echconfig.enabled", true); // [DEFAULT]
pref("network.dns.http3_echconfig.enabled", true); // [DEFAULT]

/// Enable native DNS HTTPS Lookups
pref("network.dns.native_https_query", true); // [DEFAULT]

/// Expose the DoH bootstrap pref, but don't configure by default
// This is the DNS server Firefox uses to resolve the address of your DoH server
// By default, Firefox just uses the system DNS
// This value MUST match the address of the DoH server you're using
// Ex. you could set this to "9.9.9.9" for Quad9
// We won't configure this by default to prevent unexpected breakage for users when switching DNS providers, but it's hidden - so we can at least expose it in the about:config
pref("network.trr.bootstrapAddr", ""); // [DEFAULT, HIDDEN]

/// Fix IPv6 connectivity when DoH is enabled
// https://codeberg.org/divested/brace/pulls/5
pref("network.dns.preferIPv6", true);

/// Prevent disabling DoH from registry checks
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("network.notify.checkForNRPT", false);
pref("network.notify.checkForProxies", false);

/// Prevent sending headers for DoH requests
pref("network.trr.send_accept-language_headers", false); // [DEFAULT]
pref("network.trr.send_empty_accept-encoding_headers", true); // [DEFAULT]
pref("network.trr.send_user-agent_headers", false); // [DEFAULT]

pref("browser.phoenix.status.core", "010");

/*** 011 PROXIES ***/

// Prevent bypasses/leakage

/// Disable automatic failover from the proxy (if configured) to direct connections when certain system requests fail
// https://bugzilla.mozilla.org/show_bug.cgi?id=1720221
pref("network.proxy.failover_direct", false);

/// Disable GIO
// https://bugzilla.mozilla.org/1433507
pref("network.gio.supported-protocols", ""); // [HIDDEN]

/// Disable Uniform Naming Convention (UNC) file paths
// https://bugzilla.mozilla.org/1413868
pref("network.file.disable_unc_paths", true); // [HIDDEN]

/// Prevent bypassing the proxy (if configured) for system connections that include the `bypassProxy` flag
// https://bugzilla.mozilla.org/show_bug.cgi?id=1732792
pref("network.proxy.allow_bypass", false);

/// Use the proxy (if configured) for remote DNS lookups
pref("network.proxy.socks_remote_dns", true);
pref("network.proxy.socks5_remote_dns", true); // [DEFAULT]

pref("browser.phoenix.status.core", "011");

/*** 012 WEBRTC ***/

/// Allow user to silence notifications when screen sharing
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2452
pref("privacy.webrtc.allowSilencingNotifications", true); // [DEFAULT, HIDDEN - Android/Thunderbird]
pref("privacy.webrtc.hideGlobalIndicator", false); // [DEFAULT, HIDDEN - Android/Thunderbird]

/// Always sandbox Media Transport
// https://searchfox.org/mozilla-central/source/security/sandbox/common/SandboxSettings.cpp
pref("media.peerconnection.mtransport_process", true); // [DEFAULT, HIDDEN - Android/Thunderbird]

/// Enable global toggles for muting the camera/microphone
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2452
pref("privacy.webrtc.globalMuteToggles", true); // [HIDDEN - Android]

/// Enable mDNS Host Obfuscation to prevent leaking local IP addresses
// https://bugzilla.mozilla.org/show_bug.cgi?id=1588817
pref("media.peerconnection.ice.obfuscate_host_addresses", true); // [DEFAULT - Desktop]

/// Prevent WebRTC from bypassing the proxy (if configured)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790270
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/// Warn users when attempting to switch tabs in a window being shared over WebRTC
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2459
pref("privacy.webrtc.sharedTabWarning", true); // [HIDDEN - Android/Thunderbird]

pref("browser.phoenix.status.core", "012");

/*** 013 MEDIA ***/

/// Block media autoplay by default
// https://support.mozilla.org/kb/block-autoplay
pref("media.autoplay.default", 5);

/// Disable DRM
// Garbage technology with freedom, privacy, & security concerns
// https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next
pref("media.clearkey.persistent-license.enabled", false); // [DEFAULT]
pref("media.clearkey.test-key-systems.enabled", false); // [DEFAULT]
pref("media.eme.enabled", false);
pref("media.eme.encrypted-media-encryption-scheme.enabled", false);
pref("media.eme.hdcp-policy-check.enabled", false);
pref("media.eme.require-app-approval", true); // [DEFAULT (Android) - DEFENSE IN DEPTH]: Enforce locking DRM behind permission https://searchfox.org/mozilla-central/source/mobile/android/app/geckoview-prefs.js#304
pref("media.eme.widevine.experiment.enabled", false); // [DEFAULT - HIDDEN] Widevine L1 https://searchfox.org/mozilla-central/source/dom/media/eme/MediaKeySystemAccess.cpp#141
pref("media.gmp-widevinecdm.enabled", false);
pref("media.gmp-widevinecdm.visible", false);
pref("media.gmp-widevinecdm-l1.enabled", false); // [DEFAULT (Except for Nightly) - HIDDEN]
pref("media.gmp-widevinecdm-l1.visible", false); // [DEFAULT (Except for Nightly) - HIDDEN]

/// Disable OpenH264 (in favor of hardware decoding)
// Mozilla is currently shipping OpenH264 2.3.2, which is around ~2 years out of date... https://github.com/cisco/openh264/releases/tag/v2.3.1
// Currently susceptible to a high severity CVE: https://www.cve.org/CVERecord?id=CVE-2025-27091
// https://bugzilla.mozilla.org/show_bug.cgi?id=CVE-2025-27091
// Downloads are also still distributed over standard, unencrypted HTTP...
// https://searchfox.org/mozilla-central/source/toolkit/content/gmp-sources/openh264.json
pref("media.ffmpeg.allow-openh264", false); // [DEFAULT - non-Nightly]
pref("media.gmp-gmpopenh264.enabled", false);
pref("media.gmp-gmpopenh264.provider.enabled", false); // [HIDDEN]
pref("media.gmp-gmpopenh264.visible", false);
pref("media.webrtc.hw.h264.enabled", true); // [DEFAULT - Android] Enables H264 hardware decoding https://bugzilla.mozilla.org/show_bug.cgi?id=1717679

/// Validate GMP signature when updating
pref("media.gmp-manager.cert.checkAttributes", true); // [DEFAULT]
pref("media.gmp-manager.cert.requireBuiltIn", true); // [DEFAULT]
pref("media.gmp-manager.checkContentSignature", true); // [DEFAULT]

pref("browser.phoenix.status.core", "013");

/*** 014 ATTACK SURFACE REDUCTION ***/

/// Disable ASM.JS
// https://rh0dev.github.io/blog/2017/the-return-of-the-jit/
pref("javascript.options.asmjs", false);

/// Disable Graphite & SVG OpenType fonts
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg
pref("gfx.font_rendering.graphite.enabled", false);
pref("gfx.font_rendering.opentype_svg.enabled", false);

/// Disable JavaScript Just-in-time Compilation (JIT)
// https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/
// https://firefox-source-docs.mozilla.org/js/index.html#javascript-jits
// https://codeberg.org/rusty-snake/firefox-config/src/branch/main/assets/user-overrides.js#L60
pref("javascript.options.baselinejit", false); // Baseline Compiler
pref("javascript.options.blinterp", false); // Baseline Interpreter 
pref("javascript.options.ion", false); // WarpMonkey
pref("javascript.options.main_process_disable_jit", true); // [DEFAULT - iOS?] Main process https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#8761
pref("javascript.options.native_regexp", false); // irregexp https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/21865
pref("javascript.options.wasm_baselinejit", false); // WASM Baseline Compiler

/// Disable MathML
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml 
pref("mathml.disabled", true);

/// Disable SharedArrayBuffer using window.postMessage
// https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer
// https://developer.mozilla.org/docs/Web/API/Window/postMessage
// https://blog.mozilla.org/security/2018/01/03/mitigations-landing-new-class-timing-attack/
// https://github.com/tc39/ecma262/issues/1435
// By default, Firefox restricts the use of SharedArrayBuffer - this fully disables it.
pref("dom.postMessage.sharedArrayBuffer.bypassCOOP_COEP.insecure.enabled", false); // [DEFAULT]
pref("dom.postMessage.sharedArrayBuffer.withCOOP_COEP", false);

/// If JIT (Ion/WarpMonkey) is disabled, also disable it for extensions
// This is the default, but it's hidden - so setting it here lets us expose it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1599226
pref("javascript.options.jit_trustedprincipals", false); // [DEFAULT]

pref("browser.phoenix.status.core", "014");

/*** 015 PASSWORDS & AUTHENTICATION ***/

/// Always display a `reveal password` button in `password` `<input>` types 
// https://developer.mozilla.org/docs/Web/HTML/Element/input/password
pref("layout.forms.reveal-password-button.enabled", true);

/// Crash on insecure password input
pref("intl.allow-insecure-text-input", false); // [DEFAULT, HIDDEN - non-Nightly]

/// Disable Autofill
pref("signon.autofillForms", false);
pref("signon.autofillForms.http", false); // [DEFAULT]

/// Disable Basic authentication over HTTP
// This makes it require secure HTTPS
// https://chromeenterprise.google/policies/#BasicAuthOverHttpEnabled
// https://bugzilla.mozilla.org/show_bug.cgi?id=1763671
pref("network.http.basic_http_auth.enabled", false);

/// Disable formless capture of log-in credentials
// This gets very complicated very fast, and there's very little documentation on this - but TL;DR:
// Firefox's built-in password manager has historically prompted users to save passwords by detecting standard <form> elements and waiting for specific events (ex. `onsubmit`)
// The problem is that not all websites use <form> elements for password fields, meaning Firefox can't always use this standard method.
// So, in order to detect these "formless" password entries (to ask users whether they want to save the password), Firefox uses a heuristic that temporarily monitors & stores user keystrokes...
// Note that with this disabled, Firefox will still show a password icon in the URL bar that allows you to store credentials, this only impacts the actual pop-up (for sites with these "formless" password entires)
// Unfortunately, it appears that Fenix doesn't support showing a password icon in the URL bar like Firefox on desktop does - so we're going to override this (`signon.formlessCapture.enabled`) for Android (but we'll still keep formless capture disabled in private browsing with `signon.privateBrowsingCapture.enabled`, and we still disable the password manager itself by default anyways...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1119035#c2
// https://bugzilla.mozilla.org/show_bug.cgi?id=1166947
// https://bugzilla.mozilla.org/show_bug.cgi?id=1119077#c1
pref("signon.formlessCapture.enabled", false);
pref("signon.privateBrowsingCapture.enabled", false);

/// Disable Microsoft SSO
// https://www.microsoft.com/security/business/identity-access/microsoft-entra-single-sign-on
// https://support.mozilla.org/kb/windows-sso
pref("network.http.microsoft-entra-sso.container-enabled.0", false);
pref("network.http.microsoft-entra-sso.enabled", false); // [DEFAULT]
pref("network.http.windows-sso.container-enabled.0", false);
pref("network.http.windows-sso.enabled", false); // [DEFAULT]
pref("network.microsoft-sso-authority-list", ""); // DEFENSE IN DEPTH

/// Disable Negotiate authentication by default 
// This is modified by ex. RedHat/Fedora
// https://people.redhat.com/mikeb/negotiate/
pref("network.negotiate-auth.trusted-uris", ""); // [DEFAULT]

/// Disable Password Manager by default - Insecure & unencrypted
// You should instead use a proper solution (ex. Bitwarden)
// https://www.wired.com/2016/08/browser-password-manager-probably-isnt-enough/
// https://support.mozilla.org/kb/manage-your-logins-firefox-password-manager
// https://wiki.mozilla.org/Firefox/Features/Form_Autofill
pref("extensions.formautofill.addresses.enabled", false);
pref("extensions.formautofill.creditCards.enabled", false);
pref("signon.rememberSignons", false);

/// Disable password truncation
// https://www.ghacks.net/2020/05/18/firefox-77-wont-truncate-text-exceeding-max-length-to-address-password-pasting-issues/
pref("editor.truncate_user_pastes", false);

/// Enable strong password generation (if the Password Manager is enabled) by default
pref("signon.generation.enabled", true); // [DEFAULT]

/// Prevent cross-origin sub-resources from opening HTTP authentication dialogs to protect against phishing
// (Meaning dialogs for embedded items are only presented when originating from the same site)
// https://support.mozilla.org/questions/1245144
pref("network.auth.non-web-content-triggered-resources-http-auth-allow", false); // [DEFAULT - non-Thunderbird]
pref("network.auth.subresource-http-auth-allow", 1);
pref("network.auth.subresource-img-cross-origin-http-auth-allow", false); // [DEFAULT - non-Thunderbird]

/// Prevent websites from dictating whether to allow filling passwords
// https://bugzilla.mozilla.org/show_bug.cgi?id=956906
// https://blog.0xbadc0de.be/archives/124
pref("signon.storeWhenAutocompleteOff", true); // [DEFAULT]

pref("browser.phoenix.status.core", "015");

/*** 016 EXTENSIONS ***/

/// Allow LocalCDN to work on quarantined domains (if installed) by default
pref("extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true);

/// Allow Mullvad's extension to work on quarantined domains (if installed) by default
pref("extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true);

/// Block extensions signed with weak signature algorithms
pref("xpinstall.signatures.weakSignaturesTemporarilyAllowed", false); // [DEFAULT, HIDDEN]

/// Disable automatic installation/enablement of third party extensions in Firefox's installation directory
// https://support.mozilla.org/kb/deploying-firefox-with-extensions
pref("extensions.installDistroAddons", false); // [HIDDEN - non-Android, DEFAULT - Android]

/// Enable Add-on Distribution Control (Install Origins)
// Allows extensions to only be installed from websites they specify in their manifest
// https://groups.google.com/g/firefox-dev/c/U7GpHE4R-ZY
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#403
pref("extensions.install_origins.enabled", true);

/// Enable Mozilla's Extension Blocklist
pref("extensions.blocklist.enabled", true); // [DEFAULT]

/// Enable restricted/quarantined domains by default
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT]

/// Harden CSP policy
// Currently disables WebAssembly (WASM) & upgrades insecure requests
pref("extensions.webextensions.base-content-security-policy", "script-src 'self' https://* http://localhost:* http://127.0.0.1:* moz-extension: blob: filesystem: 'unsafe-eval' 'unsafe-inline'; upgrade-insecure-requests;");
pref("extensions.webextensions.base-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;"); // [DEFAULT]

/// Only allow installation and updates of extensions using Firefox's built-in certificates by default
pref("extensions.install.requireBuiltInCerts", true); // [HIDDEN]
pref("extensions.update.requireBuiltInCerts", true); // [HIDDEN]

/// Only allow installing extensions from profile & application directories (Prevents extensions being installed from the system/via other software)
// https://archive.is/DYjAM
// https://github.com/arkenfox/user.js/blob/master/user.js#L612
pref("extensions.autoDisableScopes", 15, locked); // [DEFAULT - non-Thunderbird] Defense in depth, ensures extensions installed via directories are disabled by default...
pref("extensions.enabledScopes", 5); // [HIDDEN]

/// Only allow installation of signed extensions by default
pref("xpinstall.whitelist.required", true); // [DEFAULT]

/// Prevent bypasing 3rd party extension install prompts
pref("extensions.postDownloadThirdPartyPrompt", false, locked); // [HIDDEN - Android/Thunderbird]

/// Prevent certain Mozilla extensions from accessing restricted/quarantined domains...
pref("extensions.quarantineIgnoredByUser.ads@mozac.org", false, locked); // Mozilla Android Components - Ads Telemetry...
pref("extensions.quarantineIgnoredByUser.cookies@mozac.org", false, locked); // Mozilla Android Components - Search Telemetry...
pref("extensions.quarantineIgnoredByUser.ddg@search.mozilla.org", false, locked); // DuckDuckGo - search engine...
pref("extensions.quarantineIgnoredByUser.wikipedia@search.mozilla.org", false, locked); // Wikipedia (en) - search engine...

/// Prevent unprivileged extensions from accessing experimental APIs by default
// https://searchfox.org/mozilla-central/source/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", false); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.core", "016");

/*** 017 AI ***/

// https://support.mozilla.org/kb/ai-chatbot

/// Disable AI functionality by default
pref("browser.ml.enable", false); // [DEFAULT - non-Nightly] - "Experimental Machine Learning Inference Engine"

/// Disable AI/ML "Autofill Experiment"
// https://searchfox.org/mozilla-central/source/toolkit/components/formautofill/MLAutofill.sys.mjs
pref("extensions.formautofill.ml.experiment.enabled", false); // [HIDDEN - Thunderbird]

pref("browser.phoenix.status.core", "017");

/*** 018 GEOLOCATION ***/

/// Disable logging Geolocation requests by default
// This is already Firefox's default setting - but setting here exposes it in the about:config since it's hidden...
// https://searchfox.org/mozilla-central/source/dom/system/NetworkGeolocationProvider.sys.mjs#21
pref("geo.provider.network.logging.enabled", false); // [DEFAULT - HIDDEN]

/// Disable "Region Updates"
// https://firefox-source-docs.mozilla.org/toolkit/modules/toolkit_modules/Region.html
pref("browser.region.network.url", "");
pref("browser.region.update.enabled", false);

/// Disable Wi-Fi Scanning
pref("browser.region.network.scan", false); // [DEFAULT] https://searchfox.org/mozilla-central/source/toolkit/modules/Region.sys.mjs#20
pref("geo.wifi.scan", false); // [HIDDEN] https://searchfox.org/mozilla-release/source/remote/shared/RecommendedPreferences.sys.mjs#299

/// Set BeaconDB as the network Geolocation provider
// Default is Google...
pref("geo.provider.network.url", "https://api.beacondb.net/v1/geolocate");

pref("browser.phoenix.status.core", "018");

/*** 019 PDF.js ***/

/// Disable JavaScript
pref("pdfjs.enableScripting", false);

/// Disable XFA
// https://learn.microsoft.com/deployedge/microsoft-edge-policies#viewxfapdfiniemodeallowedorigins
// https://insert-script.blogspot.com/2019/01/adobe-reader-pdf-callback-via-xslt.html
// https://www.sentinelone.com/blog/malicious-pdfs-revealing-techniques-behind-attacks/
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=xfa
// https://wikipedia.org/wiki/XFA
// Not even a standard...
pref("pdfjs.enableXfa", false);

/// Never allow documents to prevent copying text
pref("pdfjs.enablePermissions", false); // [DEFAULT]

/// Open PDFs inline where possible
pref("browser.download.open_pdf_attachments_inline", true); // [DEFAULT - Android]

/// Show sidebar by default when viewing PDFs
pref("pdfjs.sidebarViewOnLoad", 2);

pref("browser.phoenix.status.core", "019");

/*** 020 SAFE BROWSING ***/

/// By default, when you report a Safe Browsing false positive, it sends the URL to both Mozilla & Google (NOT PROXIED), as well as your locale to Mozilla
// Ex. https://en-us.phish-error.mozilla.com/?url=example.org - Which redirects you directly to https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=example.org 
// We can improve privacy & speed by sending the domain *only* to Google & without sending your locale to anyone
// We could also potentially strip tpl=mozilla which tells Google the request is from Firefox - though it looks like there is a different page for Firefox users with a better privacy policy, so we will leave it for now
// Unclear whether 'MalwareMistake' is used, but we can set it anyways
pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");

//// Similar behavior also appears to happen when you report a URL to Safe Browsing
pref("browser.safebrowsing.reportPhishURL", "https://safebrowsing.google.com/safebrowsing/report_phish/?tpl=mozilla&url=");

/// Disable the legacy Safe Browsing API (v2.2...)
// https://code.google.com/archive/p/google-safe-browsing/wikis/Protocolv2Spec.wiki
// Has been nonfunctional since October 2018
// https://security.googleblog.com/2018/01/announcing-turndown-of-deprecated.html
// Let's make sure it's not used for defense in depth (and attack surface reduction...)
pref("browser.safebrowsing.provider.google.advisoryName", "Google Safe Browsing (Legacy)"); // Label it so it's clearly distinguishable if it is ever enabled for whatever reason...
pref("browser.safebrowsing.provider.google.gethashURL", "");
pref("browser.safebrowsing.provider.google.updateURL", "");

/// Enable Safe Browsing by default
// This won't do anything if you don't have an API key from Google, though doesn't hurt...
// Harmless from a privacy perspective due to the below changes, also effective at preventing real-time malicious domains and downloads.
// We will of course **ALWAYS** give users the ability to disable.
// https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.blockedURIs.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.downloads.enabled", true); // [DEFAULT - non-Android]
pref("browser.safebrowsing.downloads.remote.url", "https://sb-ssl.google.com/safebrowsing/clientreport/download?key=%GOOGLE_SAFEBROWSING_API_KEY%"); // [DEFAULT]
pref("browser.safebrowsing.features.blockedURIs.update", true); // [DEFAULT, HIDDEN]
pref("browser.safebrowsing.features.downloads.update", true); // [DEFAULT, HIDDEN]
pref("browser.safebrowsing.features.malware.update", true); // [DEFAULT, HIDDEN - non-Android]
pref("browser.safebrowsing.features.phishing.update", true); // [DEFAULT, HIDDEN - non-Android] 
pref("browser.safebrowsing.malware.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.phishing.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.update.enabled", true); // [DEFAULT, HIDDEN]
pref("urlclassifier.downloadAllowTable", "goog-downloadwhite-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.downloadBlockTable", "goog-badbinurl-proto"); // [DEFAULT - non-Android]

/// Prevent sending metadata of downloaded files to Google
// https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work#w_how-does-phishing-and-malware-protection-work-in-firefox
// https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
pref("browser.safebrowsing.downloads.remote.enabled", false);

/// Prevent sharing data with Google
// https://bugzilla.mozilla.org/show_bug.cgi?id=1351147
pref("browser.safebrowsing.provider.google.dataSharing.enabled", false, locked); // [DEFAULT, HIDDEN - non-Android]
pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false, locked); // [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharingURL", "", locked);

/// Proxy Safe Browsing
// These are using the servers we've set up for IronFox, hosted on our Cloudflare storage bucket (in EU jurisdiction)
pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");

/// Show advanced details on pages blocked by Safe Browsing by default
pref("browser.xul.error_pages.show_safe_browsing_details_on_load", true); // [HIDDEN - Android/Thunderbird]

/// Unclear whether these are actually used or not, but looks like Firefox has some kind of functionality to view a "report" from Safe Browsing about the safety, history, & general status of a site
// By default, it unnecessarily redirects from ex. https://safebrowsing.google.com/safebrowsing/diagnostic?site=example.org to https://transparencyreport.google.com/safe-browsing/search?url=example.org
// We can skip the redirect to improve performance
pref("browser.safebrowsing.provider.google.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google4.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");

pref("browser.phoenix.status.core", "020");

/*** 021 DEBUGGING ***/

/// Always prompt before connecting to Remote Debugging...
pref("devtools.debugger.prompt-connection", true, locked); // [DEFAULT - non-Nightly]

/// Enforce local debugging only
pref("devtools.debugger.force-local", true, locked); // [DEFAULT]

/// Prevent logging URLs in Reader errors
pref("reader.errors.includeURLs", false); // [DEFAULT - Android/Thunderbird]

/// Restrict Remote Debugging to only remain enabled per-session
// https://firefox-source-docs.mozilla.org/devtools/backend/protocol.html
pref("devtools.debugger.remote-enabled", false, sticky); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.core", "021");

/*** 022 MISC. PRIVACY ***/

/// Disable Beacon API (Navigator.sendBeacon)
// I was originally against disabling this, but after careful consideration, I've changed my position.
// The explicit, stated purpose/use case of this API is for analytics/tracking.
// Websites *can* obtain the data shared from this API through other means; though the other ways to obtain it are more disruptive and less reliable.
// Analytics/tracking is evidently not a use case that we, as the user agent, should support or assist with.
// I don't see a justification for adding APIs/features to support this hostile behavior. We are the user agent and must act in the best interest of users...
// https://developer.mozilla.org/docs/Web/API/Beacon_API
// https://developer.mozilla.org/docs/Web/API/Navigator/sendBeacon
// https://udn.realityripple.com/docs/Web/API/Navigator/sendBeacon
// https://w3c.github.io/beacon/#privacy-and-security
// https://bugzilla.mozilla.org/show_bug.cgi?id=1454252
// Also disabled by ex. Cromite: https://github.com/uazo/cromite/blob/master/docs/FEATURES.md https://github.com/uazo/cromite/issues/1454
pref("beacon.enabled", false);

/// Disable Hyperlink Auditing (Click Tracking)
// https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/
pref("browser.send_pings", false); // [DEFAULT]
pref("browser.send_pings.max_per_link", 0); // [DEFENSE IN DEPTH]
pref("browser.send_pings.require_same_host", true); // [DEFENSE IN DEPTH]

/// Disable Network Error Logging
// https://developer.mozilla.org/docs/Web/HTTP/Network_Error_Logging
// https://w3c.github.io/network-error-logging/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1145235
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#12829
pref("network.http.network_error_logging.enabled", false); // [DEFAULT, HIDDEN - Thunderbird]

/// Disable Reporting API
// https://w3c.github.io/reporting/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1492036
pref("dom.reporting.crash.enabled", false); // [DEFAULT]
pref("dom.reporting.enabled", false); // [DEFAULT]
pref("dom.reporting.featurePolicy.enabled", false); // [DEFAULT]
pref("dom.reporting.header.enabled", false); // [DEFAULT]

/// Enable Cookie Banner Reduction
// https://support.mozilla.org/kb/cookie-banner-reduction
pref("cookiebanners.bannerClicking.enabled", true); // [DEFAULT]
pref("cookiebanners.cookieInjector.enabled", true); // [DEFAULT]
pref("cookiebanners.service.mode", 1);
pref("cookiebanners.service.mode.privateBrowsing", 1); // [DEFAULT - Nightly Android]
pref("cookiebanners.service.enableGlobalRules", true); // [DEFAULT]
pref("cookiebanners.service.enableGlobalRules.subFrames", true); // [DEFAULT]

/// Enable Cookies Having Independent Partitioned State (CHIPS)
// This allows websites to set cookies with a 'Partitioned' attribute, meaning they're limited in scope
// We still use ETP Strict for partioning anyways, so this could be useful as a defense in depth if a user decides to allow a specific domain (or domains) to access a third party cookie
// https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies
// https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#partitioned
// https://github.com/privacycg/CHIPS
pref("network.cookie.CHIPS.enabled", true); // [DEFAULT - Nightly]

/// Enable Do Not Track & Global Privacy Control
// Do Not Track is also covered by ETP Strict, pref to be removed soon...
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true); // [DEFAULT - non-Thunderbird]
pref("privacy.globalprivacycontrol.pbmode.enabled", true); // [DEFAULT - non-Thunderbird]

/// Enable Smartblock Embeds/Placeholders
// Makes certain resources click to load
pref("extensions.webcompat.smartblockEmbeds.enabled", true); // [DEFAULT - Nightly, HIDDEN - Android/Thunderbird]

/// Exclude third party trackers from TCP/dFPI storage access heuristics
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics
pref("privacy.restrict3rdpartystorage.heuristic.exclude_third_party_trackers", true); // [DEFAULT - Nightly]

/// Improve built-in query stripping to be on par with LibreWolf & Brave
// https://codeberg.org/librewolf/settings/src/branch/master/librewolf.cfg#L77
pref("privacy.query_stripping.strip_list", "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid");

/// Isolate permissions per container (if containers are enabled)
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("permissions.isolateBy.userContext", true);

/// Restrict tracking referers
pref("network.http.referer.defaultPolicy.trackers", 1);
pref("network.http.referer.defaultPolicy.trackers.pbmode", 1);

/// Strip tracking parameters from URLs when shared by default
pref("privacy.query_stripping.strip_on_share.enabled", true); // [DEFAULT - non-Android/Thunderbird]

/// Trim cross-origin referers (Like Safari)
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginTrimmingPolicy", 2);

pref("browser.phoenix.status.core", "022");

/*** 023 MISC. SECURITY ***/

/// Always prompt users for a certificate when websites request one, rather than automatically selecting one...
// https://www.stigviewer.com/stig/mozilla_firefox/2023-06-05/finding/V-251547
pref("security.default_personal_cert", "Ask Every Time", locked); // [DEFAULT]

/// Always run extensions OOP (out of process...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1613141
// https://bugzilla.mozilla.org/show_bug.cgi?id=1880856
// https://groups.google.com/g/tb-planning/c/p4MUTMNYBVo
pref("extensions.webextensions.remote", true); // [DEFAULT]

/// Always warn users before launching other apps
pref("network.protocol-handler.warn-external.mailto", true);
pref("network.protocol-handler.warn-external-default", true); // [DEFAULT]
pref("security.external_protocol_requires_permission", true); // [DEFAULT - non-Thunderbird] Removed from Firefox, but we'll keep for ESR for the time being

/// Apply CSP to internal browser.xhtml
pref("security.browser_xhtml_csp.enabled", true); // [DEFAULT, HIDDEN - Thunderbird]

/// Disable Accessibility Services
// "Firefox Accessibility Service is a technology built into Firefox that provides 3rd party applications running on the same device the ability to inspect, monitor, visualize, and alter web page content hosted within Firefox."
// https://web.archive.org/web/20240608190300/support.mozilla.org/en-US/kb/accessibility-services
pref("accessibility.force_disabled", 1);
pref("devtools.accessibility.enabled", false); // [HIDDEN - Android] https://firefox-source-docs.mozilla.org/devtools-user/accessibility_inspector/

/// Disable automatic updates for OpenSearch engines
// Doesn't appear to impact Mozilla's built-in search engines
// Also has privacy implications (extra unsolicited connections)
// https://firefox-source-docs.mozilla.org/toolkit/search/Preferences.html#hidden
// https://developer.mozilla.org/docs/Web/XML/Guides/OpenSearch#supporting_automatic_updates_for_opensearch_plugins
pref("browser.search.update", false); // [DEFAULT - Android]

/// Disable Content Analysis
/// We also set "ContentAnalysis" in policies
// https://mozilla.github.io/policy-templates/#contentanalysis
// https://github.com/chromium/content_analysis_sdk
pref("browser.contentanalysis.default_result", 0, locked); // [DEFAULT]
pref("browser.contentanalysis.enabled", false, locked); // [DEFAULT]
pref("browser.contentanalysis.interception_point.clipboard.enabled", false, locked); // [HIDDEN - Thunderbird]
pref("browser.contentanalysis.interception_point.drag_and_drop.enabled", false, locked); // [HIDDEN - Thunderbird]
pref("browser.contentanalysis.interception_point.file_upload.enabled", false, locked); // [HIDDEN - Thunderbird]
pref("browser.contentanalysis.interception_point.print.enabled", false, locked); // [HIDDEN - Thunderbird]
pref("browser.contentanalysis.show_blocked_result", true, locked); // [DEFAULT] - Always notify users when Content Analysis blocks access to something...

/// Disable Navigator Media Objects & getUserMedia Support in insecure contexts
// https://developer.mozilla.org/docs/Web/API/Navigator/mediaDevices
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("media.devices.insecure.enabled", false); // [DEFAULT]
pref("media.getusermedia.insecure.enabled", false); // [DEFAULT]

/// Enable the 'credentialless' COEP (Cross-Origin-Embedder-Policy) Header
pref("browser.tabs.remote.coep.credentialless", true); // [DEFAULT - non-Android stable]
pref("dom.origin-trials.coep-credentialless.state", 1);

/// Enable Element.setHTML
// https://bugzilla.mozilla.org/show_bug.cgi?id=1805632
// https://webdocs.dev/en-us/docs/web/api/element/sethtml
pref("dom.security.setHTML.enabled", true);

/// Enable GPU Sandboxing
// https://www.ghacks.net/2023/01/17/firefox-110-will-launch-with-gpu-sandboxing-on-windows/
pref("security.sandbox.gpu.level", 1); // [DEFAULT - Windows]

/// Enable Opaque Response Blocking
// https://github.com/annevk/orb
pref("browser.opaqueResponseBlocking", true); // [DEFAULT - non-Android]
pref("browser.opaqueResponseBlocking.javascriptValidator", true); // [DEFAULT]

/// Enable the Sanitizer API
// https://github.com/WICG/sanitizer-api
pref("dom.security.sanitizer.enabled", true);

/// Enable Spectre mitigations for isolated content
// Like Tor Browser
pref("javascript.options.spectre.disable_for_isolated_content", false);

/// Enforce Site Isolation + isolate all websites
// https://wiki.mozilla.org/Project_Fission
pref("browser.sessionstore.disable_platform_collection", false); // [DEFAULT - non-Thunderbird]
pref("dom.ipc.processCount.webIsolated", 1); // [DEFAULT - Android]
pref("fission.autostart", true); // [DEFAULT - non-Android]
pref("fission.autostart.session", true); // [DEFAULT - non-Android]
pref("fission.disableSessionHistoryInParent", false); // [DEFAULT - non-Android] SHIP, required for Fission
pref("gfx.webrender.all", true);

/// Enforce strict file:// Origin Policy
// https://stuffandnonsense.co.uk/blog/firefoxs_file_uri_origin_policy_and_web_fonts
// https://stackoverflow.com/questions/2856502/css-font-face-not-working-with-firefox-but-working-with-chrome-and-ie
pref("security.fileuri.strict_origin_policy", true); // [DEFAULT]

/// Enforce various important security-related prefs
pref("dom.block_external_protocol_in_iframes", true); // [DEFAULT]
pref("dom.block_external_protocol_navigation_from_sandbox", true); // [DEFAULT]
pref("security.all_resource_uri_content_accessible", false); // [DEFAULT]
pref("security.allow_eval_in_parent_process", false); //[DEFAULT - non-Android/Thunderbird]
pref("security.allow_eval_with_system_principal", false); // [DEFAULT - non-Android]
pref("security.allow_parent_unrestricted_js_loads", false); // [DEFAULT - non-Android/Thunderbird]
pref("security.allow_unsafe_parent_loads", false); // [DEFAULT]
pref("security.data_uri.block_toplevel_data_uri_navigations", true); // [DEFAULT]

/// Never expose shell access
// https://www.stigviewer.com/stig/mozilla_firefox/2019-12-12/finding/V-15771
pref("network.protocol-handler.external.shell", false, locked); // [DEFAULT]

/// Never skip the assertion that about:pages don't have content security policies (CSP)
// This is default on Standard Firefox releases, but not on ex. Thunderbird & other builds
pref("dom.security.skip_about_page_has_csp_assert", false); // [DEFAULT - non-Thunderbird]

/// Prevent marking JIT code pages as both writable and executable, only one or the other...
// Might cause issues in certain specific set-ups
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876632
pref("javascript.options.content_process_write_protect_code", true); // [DEFAULT - OpenBSD?]

/// Prevent remoteTypes from triggering process switches they shouldn't be able to...
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#1035
pref("browser.tabs.remote.enforceRemoteTypeRestrictions", true); // [DEFAULT - Nightly Desktop]

/// Protect against CSRF Attacks
// Like Chromium
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/6PZtLH7c6JQ
// https://hacks.mozilla.org/2020/08/changes-to-samesite-cookie-behavior/
// https://web.dev/articles/samesite-cookies-explained
// https://help.salesforce.com/s/articleView?id=000389944&type=1
// https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions
// https://web.dev/articles/schemeful-samesite
pref("network.cookie.sameSite.laxByDefault", true);
pref("network.cookie.sameSite.noneRequiresSecure", true); // [DEFAULT - non-Thunderbird]
pref("network.cookie.sameSite.schemeful", true); // [DEFAULT - Nightly]

/// Protect against MIME Exploits
// https://www.pcmag.com/encyclopedia/term/mime-exploit
pref("security.block_fileuri_script_with_wrong_mime", true);
pref("security.block_Worker_with_wrong_mime", true); // [DEFAULT]

/// Use a separate content process for `file://` URLs
pref("browser.tabs.remote.separateFileUriProcess", true); // [DEFAULT - non-Android]

/// Yes, this is a real pref... 
// https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("security.turn_off_all_security_so_that_viruses_can_take_over_this_computer", false, locked); // [DEFAULT, HIDDEN]

pref("browser.phoenix.status.core", "023");

/*** 024 MISC. ***/

/// Always allow installing "incompatible" add-ons
// Especially useful on Android & Thunderbird...
pref("extensions.strictCompatibility", false); // [DEFAULT - non-Thunderbird]

/// Block pop-ups by default
pref("dom.disable_open_during_load", true); // [DEFAULT - non-Thunderbird]

/// Disable Captive Portal Detection & Connectivity Checks
// Privacy & security concerns, and in general best handled by the OS.
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_network-detection
// https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy
pref("captivedetect.canonicalURL", "");
pref("network.captive-portal-service.enabled", false); // [DEFAULT - Android/Thunderbird]
pref("network.connectivity-service.DNSv4.domain", "");
pref("network.connectivity-service.DNSv6.domain", "");
pref("network.connectivity-service.enabled", false);
pref("network.connectivity-service.IPv4.url", "");
pref("network.connectivity-service.IPv6.url", "");

/// Disable WebVTT Testing Events
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("media.webvtt.testing.events", false); // [DEFAULT]

/// Force pop-up windows to open in new tabs instead
pref("browser.link.open_newwindow", 3); // [DEFAULT]
pref("browser.link.open_newwindow.restriction", 0); // [DEFAULT - Android/Thunderbird]

/// Limit what events can cause pop-ups
pref("dom.popup_allowed_events", "click dblclick");

/// Prevent scripts from moving, resizing, and messing with windows
pref("dom.disable_window_flip", true); // [DEFAULT - non-Android]
pref("dom.disable_window_move_resize", true); // [DEFAULT - Android]

pref("browser.phoenix.status.core", "024");

/*** 025 PERFORMANCE ***/

// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

pref("browser.cache.jsbc_compression_level", 3); // [Default = 0]
pref("browser.sessionstore.interval", 60000);
pref("browser.sessionhistory.max_total_viewers", 7); // [Default = -1 (Automatic)]
pref("content.notify.interval", 100000); // [Default = 120000] https://searchfox.org/mozilla-central/rev/c1180ea13e73eb985a49b15c0d90e977a1aa919c/modules/libpref/init/StaticPrefList.yaml#1824-1834
pref("extensions.logging.enabled", false); // [DEFAULT] https://searchfox.org/mozilla-central/source/mobile/android/app/geckoview-prefs.js#232
pref("gfx.canvas.accelerated", true); // [DEFAULT]
pref("gfx.canvas.accelerated.cache-items", 8192); // [DEFAULT - non-Thunderbird]
pref("gfx.canvas.accelerated.cache-size", 512); // [Default = 256]
pref("gfx.content.skia-font-cache-size", 20); // [Default = 5]
pref("gfx.webrender.compositor", true); // [DEFAULT - macOS/Windows]
pref("image.mem.decode_bytes_at_a_time", 32768); // [Default = 16384]
pref("image.mem.shared.unmap.min_expiration_ms", 120000); // [Default = 60000]
pref("layout.css.report_errors", false); // [DEFAULT - Android] https://searchfox.org/mozilla-central/source/mobile/android/app/geckoview-prefs.js#299
pref("media.cache_readahead_limit", 7200);
pref("media.cache_resume_threshold", 3600);
pref("media.memory_cache_max_size", 65536); // [Default = 8192]
pref("network.dnsCacheEntries", 1000); // [Default = 800 - Nightly Desktop, 400 - Non-Nightly Desktop]
pref("network.dnsCacheExpiration", 3600); // [Default = 60]
pref("network.dnsCacheExpirationGracePeriod", 240); // [Default = 60]
pref("network.http.max-persistent-connections-per-proxy", 48); // [Default = 20 - Android, 32 - non-Android]
pref("network.http.max-persistent-connections-per-server", 10); // [Default = 6]
pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // [Default = 3]

pref("browser.phoenix.status.core", "025");

/*** 026 SCROLLING ***/

pref("apz.autoscroll.enabled", true); // [DEFAULT]
pref("apz.overscroll.enabled", true); // [DEFAULT - non-Thunderbird]
pref("general.autoScroll", true); // [DEFAULT - non-Unix (excluding macOS)/Thunderbird, HIDDEN - Android]
pref("general.smoothScroll", true); // [DEFAULT - non-Thunderbird]

pref("browser.phoenix.status.core", "026");

/*** 027 Personal Touch 💜 ***/

/// Things that are  nice to have™
// Not directly privacy & security related

pref("browser.translations.automaticallyPopup", true); // [DEFAULT]
pref("browser.translations.enable", true); // [DEFAULT - non-Thunderbird]
pref("browser.translations.select.enable", true); // [DEFAULT - non-Android/Thunderbird]
pref("devtools.chrome.enabled", true); // [DEFAULT - Thunderbird]
pref("findbar.highlightAll", true); // Highlights all Findbar (Ctrl + F) results by default
pref("full-screen-api.transition-duration.enter", "0 0"); // [Default = 200 200]
pref("full-screen-api.transition-duration.leave", "0 0"); // [Default = 200 200]
pref("full-screen-api.warning.delay", -1); // [Default = 500, -1 = Automatic]
pref("full-screen-api.warning.timeout", 0); // [Default = 3000]
pref("media.webspeech.synth.dont_notify_on_error", true); // [HIDDEN] Disable annoying Web Speech API errors, especially relevant on Linux - https://searchfox.org/mozilla-central/source/browser/actors/SpeechDispatcherParent.sys.mjs#8
pref("security.xfocsp.hideOpenInNewWindow", false);
pref("services.settings.loglevel", "warn"); // [DEFAULT, HIDDEN] This pref allows controlling the log level of Remote Settings, set here to the default value so that it's exposed in the `about:config`
pref("toolkit.backgroundtasks.loglevel", "error"); // [DEFAULT, HIDDEN] To expose via the `about:config` https://searchfox.org/mozilla-central/source/toolkit/components/backgroundtasks/BackgroundTasksManager.sys.mjs
pref("ui.key.menuAccessKeyFocuses", false); // [DEFAULT - non-Windows/Linux] Prevent alt key from toggling menu bar by default
pref("view_source.syntax_highlight", true); // [DEFAULT - non-Thunderbird]
pref("view_source.wrap_long_lines", true); // [DEFAULT - Android]

pref("browser.phoenix.status.core", "027");

/*** 028 UPDATES ***/

/// Automatically update extensions by default
pref("extensions.systemAddon.update.enabled", true); // [DEFAULT]
pref("extensions.update.autoUpdateDefault", true); // [DEFAULT, HIDDEN - ANDROID]
pref("extensions.update.enabled", true); // [DEFAULT]
pref("media.gmp-manager.updateEnabled", true); // [DEFAULT, HIDDEN]

/// Check for extension/theme updates hourly
// Default is once every 24 hours
pref("extensions.update.interval", 3600);

/// Notify users for extension updates by default
// https://searchfox.org/mozilla-central/source/remote/shared/RecommendedPreferences.sys.mjs#253
pref("extensions.update.notifyUser", true); // [HIDDEN]

/// Sync with Remote Settings hourly, rather than the default of only once a day
// This is used for delivering lots of security-critical databases (Ex. CRLite/revocation checks, malicious add-on blocklists, etc...)
// So let's make sure our users are up to date as quick as possible
pref("services.settings.poll_interval", 3600);

pref("browser.phoenix.status.core", "028");

pref("browser.phoenix.status.core", "successfully applied :D", locked);


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

// This file contains preferences shared across Phoenix & Dove on Desktop.

/* INDEX 

001: DATA COLLECTION
002: MOZILLA CRAP™
003: DISK AVOIDANCE
004: HTTP(S)
005: MEDIA
006: ATTACK SURFACE REDUCTION
007: EXTENSIONS
008: GEOLOCATION
009: DEBUGGING
010: MISC. PRIVACY
011: MISC. SECURITY
012: PERFORMANCE
013: Personal Touch 💜
014: UPDATES
015: SPECIALIZED/CUSTOM CONFIGS

*/

/*** 001 DATA COLLECTION ***/

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [DEFAULT, HIDDEN - Thunderbird]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [DEFAULT - non-Nightly, HIDDEN - Thunderbird]

/// Disable Data Reporting & Telemetry
pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [DEFAULT]
pref("browser.urlbar.quicksuggest.onboardingDialogChoice", "reject_2", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/environment.rst https://searchfox.org/mozilla-central/source/browser/components/urlbar/tests/quicksuggest/browser/browser_quicksuggest_onboardingDialog.js

pref("browser.phoenix.status.desktop.common", "001");

/*** 002 MOZILLA CRAP™ ***/

/// Disable Recommendations
pref("extensions.getAddons.discovery.api_url", "data;"); // https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.ui.lastCategory", "addons://list/extension"); // [HIDDEN] Ensure default view of `about:addons` is local/installed extensions...

/// Remove special privileges from Mozilla domains
pref("permissions.manager.defaultsUrl", "", locked);
pref("services.sync.addons.trustedSourceHostnames", "");

pref("browser.phoenix.status.desktop.common", "002");

/*** 003 DISK AVOIDANCE ***/

/// Sanitization
// Checks the boxes for clearing browsing data when navigating to `about:preferences#privacy` -> `Cookies and Site Data` -> `Manage Data...`
pref("privacy.clearHistory.browsingHistoryAndDownloads", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.clearHistory.cache", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.clearHistory.formdata", true); // [HIDDEN - Thunderbird]
pref("privacy.clearHistory.historyFormDataAndDownloads", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.clearSiteData.browsingHistoryAndDownloads", true); // [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.cache", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.clearSiteData.formdata", true); // [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.historyFormDataAndDownloads", true); // [HIDDEN - Thunderbird]
pref("privacy.cpd.cache", true); // [DEFAULT]
pref("privacy.cpd.downloads", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.cpd.formdata", true); // [DEFAULT, HIDDEN - Thunderbird]
pref("privacy.cpd.history", true); // [DEFAULT]
pref("privacy.cpd.sessions", true); // [DEFAULT, HIDDEN - Thunderbird]

//// Except for cookies... (as this ignores `Allow` exceptions)
pref("privacy.clearHistory.cookiesAndStorage", false);
pref("privacy.clearSiteData.cookiesAndStorage", false);
pref("privacy.cpd.cookies", false);
pref("privacy.cpd.offlineApps", false); // [DEFAULT, HIDDEN - Thunderbird]

//// and passwords...
pref("privacy.cpd.passwords", false); // [DEFAULT, HIDDEN - Thunderbird]

/// Prevent automatically starting Firefox & restoring session after reboot on Windows [NO-OSX]
pref("toolkit.winRegisterApplicationRestart", false); // [NO-OSX]

/// Set default time range when manually clearing data to "everything"
pref("privacy.sanitize.timeSpan", 0);

pref("browser.phoenix.status.desktop.common", "003");

/*** 004 HTTP(S) ***/

/// Disable third-party/OS-level root certificates
// I've been torn on how to handle this, but IMO the safest way forward is disabling this functionality in Firefox.
// This is commonly abused by malware/etc. and it's even overriden by certain software/garbage AV's...
// Ex. https://support.kaspersky.com/common/compatibility/14620#block3
// Since this is something programs actively try to override, I don't see a safe way to support this, so we'll lock it.
// We still allow users to manually import certificates into Firefox... 
// So we can ensure users are aware of certificates they add and are making this decision consciously.
// security.osclientcerts.autoload can be left alone - https://groups.google.com/a/mozilla.org/g/enterprise/c/XiW-ZidMaII
// We also set "ImportEnterpriseRoots" in policies
// https://mozilla.github.io/policy-templates/#certificates--importenterpriseroots
pref("security.certerrors.mitm.auto_enable_enterprise_roots", false, locked);
pref("security.enterprise_roots.enabled", false, locked);

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning
pref("security.cert_pinning.enforcement_level", 2, locked);

pref("browser.phoenix.status.desktop.common", "004");

/*** 005 MEDIA ***/

/// Sandbox GMP on GNU/Linux [NO-OSX]
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml [NO-OSX]
pref("media.gmp.insecure.allow", false); // [DEFAULT] [NO-OSX]

/// Disable Microsoft PlayReady DRM [NO-OSX]
pref("media.eme.playready.enabled", false); // [NO-OSX]

/// Disable Windows Media Foundation Clearkey DRM [NO-OSX]
pref("media.eme.wmf.clearkey.enabled", false); // [DEFAULT] [NO-OSX]

/// Disable Windows Media Foundation Media Engine [NO-OSX]
// By default, it's enabled for protected content (DRM) [NO-OSX]
// Enabling it for standard content appears to cause video playback issues (ex. on YouTube) [NO-OSX]
// https://learn.microsoft.com/windows/win32/medfound/about-the-media-foundation-sdk [NO-OSX]
pref("media.wmf.media-engine.enabled", 0); // [NO-OSX]

/// Enable click to play UI for certain CSS skins by default...
// https://github.com/black7375/Firefox-UI-Fix/blob/master/css/leptonContent.css#L223
// https://github.com/black7375/Firefox-UI-Fix/wiki/Options#defaults-6
pref("userContent.player.click_to_play", true); // [HIDDEN]

/// Remove DRM toggle from `about:preferences#general`
pref("browser.eme.ui.enabled", false);

pref("browser.phoenix.status.desktop.common", "005");

/*** 006 ATTACK SURFACE REDUCTION ***/

/// Disable WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API
pref("permissions.default.xr", 2); // [HIDDEN on Thunderbird]

pref("browser.phoenix.status.desktop.common", "006");

/*** 007 EXTENSIONS ***/

// Enable panel for our own extension recommendations...
pref("extensions.getAddons.showPane", true); // [DEFAULT]

// Only allow installation of signed language packs & whitelisted extensions
pref("extensions.langpacks.signatures.required", true, locked); // [DEFAULT]
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT]

pref("browser.phoenix.status.desktop.common", "007");

/*** 008 GEOLOCATION [NO-OSX] ***/

// Disable Microsoft Location Services [WINDOWS] [NO-OSX]
pref("geo.provider.ms-windows-location", false); // [NO-OSX]

pref("browser.phoenix.status.desktop.common", "008"); // [NO-OSX]

/*** 009 DEBUGGING ***/

/// Enforce local debugging only
pref("devtools.inspector.remote", false, locked); // [DEFAULT]

pref("browser.phoenix.status.desktop.common", "009");

/*** 010 MISC. PRIVACY ***/

/// Disable Firefox Sync by default
// When signing in to Firefox Sync, this controls the items (checkboxes) that are set to sync (under about:preferences#sync).
// This allows the user to control and choose for themselves what they'd like to sync, rather than automatically syncing everything (like the default)
pref("services.sync.engine.addons", false);
pref("services.sync.engine.addresses", false); // [DEFAULT]
pref("services.sync.engine.bookmarks", false);
pref("services.sync.engine.creditcards", false); // [DEFAULT]
pref("services.sync.engine.history", false);
pref("services.sync.engine.passwords", false);
pref("services.sync.engine.prefs", false);
pref("services.sync.engine.tabs", false);

/// Disable sharing unnecessary version info as part of Firefox Sync
pref("services.sync.sendVersionInfo", false);

/// Enable Containers by default
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("privacy.userContext.enabled", true);

/// Prevent saving clipboard history/contents to the cloud... [WINDOWS] [NO-OSX]
pref("clipboard.copyPrivateDataToClipboardCloudOrHistory", false); // [DEFAULT] [NO-OSX]

/// Prevent sharing identifying info if a remote AutoConfig is being used
pref("autoadmin.append_emailaddr", false, locked); // [HIDDEN]

pref("browser.phoenix.status.desktop.common", "010");

/*** 011 MISC. SECURITY ***/

/// Disable GNOME Integration [LINUX] [NO-OSX]
// https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp [NO-OSX]
pref("browser.gnome-search-provider.enabled", false); // [HIDDEN] [NO-OSX]

/// Disable Win32k System Calls [WINDOWS] [NO-OSX]
// https://security.googleblog.com/2016/10/disclosing-vulnerabilities-to-protect.html [NO-OSX]
// https://docs.google.com/document/d/1gJDlk-9xkh6_8M_awrczWCaUuyr0Zd2TKjNBCiPO_G4/edit [NO-OSX]
pref("security.sandbox.content.win32k-disable", true); // [DEFAULT] [NO-OSX]
pref("security.sandbox.gmp.win32k-disable", true); // [NO-OSX]
pref("security.sandbox.socket.win32k-disable", true); // [DEFAULT] [NO-OSX]

/// Prevent hiding extensions
pref("devtools.aboutdebugging.showHiddenAddons", true, locked);

/// Prevent remote AutoConfig files (if being used) from gaining privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
pref("general.config.sandbox_enabled", true, locked);

pref("browser.phoenix.status.desktop.common", "011");

/*** 012 PERFORMANCE ***/

/// Disable certain UI animations
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h
pref("ui.panelAnimations", 0); // [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [HIDDEN]

/// Taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
pref("network.http.max-connections", 1800); // [Default = 900]

pref("browser.phoenix.status.desktop.common", "012");

/*** 013 Personal Touch 💜 ***/

/// Things that are  nice to have™
// Not directly privacy & security related

/// Developer tools...
pref("devtools.command-button-experimental-prefs.enabled", true); // [HIDDEN]
pref("devtools.command-button-measure.enabled", true);
pref("devtools.command-button-rulers.enabled", true);
pref("devtools.command-button-screenshot.enabled", true);
pref("devtools.debugger.ui.editor-wrapping", true); // Enables long line wrapping in developer tools https://discourse.mozilla.org/t/long-line-wrapping-in-developer-tools-css-editor-and-debugger-code-views/47058
pref("devtools.dom.enabled", true);
pref("devtools.netmonitor.persistlog", true); // Do not automatically clear log messages after page reloads/navigation
pref("devtools.webconsole.persistlog", true); // Do not automatically clear log messages after page reloads/navigation
pref("devtools.webconsole.timestampMessages", true); // Enable timestamps in the web console by default

/// Disable extra logging for policies by default
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config
// https://searchfox.org/mozilla-central/source/browser/components/BrowserGlue.sys.mjs#967
pref("browser.policies.loglevel", "error"); // [DEFAULT, HIDDEN]

/// Enable custom CSS by default
pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

/// Enable Spellcheck for both multi-line and single-line boxes
// [Default = 1, only checks multi-line boxes]
// https://codeberg.org/celenity/Phoenix/issues/33
pref("layout.spellcheckDefault", 2);

/// Expose hidden UI preferences in the about:config
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h
pref("ui.hideCursorWhileTyping", 1); // [DEFAULT, HIDDEN]
pref("ui.prefersReducedTransparency", 0); // [DEFAULT, HIDDEN]
pref("ui.scrollToClick", 1); // [HIDDEN]
pref("ui.useAccessibilityTheme", 0); // [DEFAULT, HIDDEN]

pref("browser.phoenix.status.desktop.common", "013");

/*** 014 UPDATES ***/

/// Browser Updates
pref("app.update.badgeWaitTime", 0); // Immediately show badge on hamburger menu when update is available
pref("app.update.notifyDuringDownload", true); // Ensure that users are notified when an update is downloaded
pref("app.update.promptWaitTime", 3600); // Decrease time between update prompts, default is very generous...

pref("browser.phoenix.status.desktop.common", "014");

/*** 015 SPECIALIZED/CUSTOM CONFIGS ***/

/// Configure remote AutoConfig files (if active)
pref("autoadmin.failover_to_cached", true);
pref("autoadmin.offline_failover", true);
pref("autoadmin.refresh_interval", 60);

pref("browser.phoenix.status.desktop.common", "015");

pref("browser.phoenix.status.desktop.common", "successfully applied :D", locked);

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
pref("services.sync.prefs.sync.sidebar.main.tools", true);
pref("services.sync.prefs.sync.sidebar.revamp", true);
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

/// Enable + customize the new Sidebar by default
pref("sidebar.main.tools", "bookmarks,syncedtabs,history"); // Removes AI Chat, adds Bookmarks
pref("sidebar.revamp", true); // [DEFAULT - Nightly]
pref("sidebar.visibility", "hide-sidebar"); // Hide by default

/// Enable Taskbar Tabs (PWAs) by default [WINDOWS] [NO-OSX]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1915736 [NO-OSX]
// https://windowsreport.com/firefox-is-bringing-web-apps-to-windows-11-with-taskbar-tabs-first-look/ [NO-OSX]
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

