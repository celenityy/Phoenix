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

pref("browser.phoenix.version", "2025.12.23.1", locked);

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
021: MISC. PRIVACY + SECURITY
022: MISC. PRIVACY
023: MISC. SECURITY
024: MISC.
025: DEBUGGING
026: PERFORMANCE
027: Personal Touch 💜
028: UPDATES
029: FIREFOX HOME
030: FIREFOX SUGGEST (DESKTOP ONLY)
031: SYNC (DESKTOP ONLY)
032: LIBREWOLF (DESKTOP ONLY)
033: SPECIALIZED/CUSTOM CONFIGS (DESKTOP ONLY)

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[LINUX-ONLY] = This preference should ONLY be set for GNU/Linux
[LINUX-NON-FLATPAK-ONLY] = This preference should ONLY be set for GNU/Linux (non-Flatpak)

[NO-ANDROID] = This preference should be set everywhere, EXCEPT for Android
[NO-FLATPAK-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux (Flatpak)
[NO-MAIL] = This preference should be set everywhere, EXCEPT for Thunderbird (Useful for ex. Dove)
[NO-OSX] = This preference should be set everywhere, EXCEPT for macOS
[NO-INTEL-OSX] = This preference should be set everywhere, EXCEPT for macOS on Intel
[NO-SILICON-OSX] = This preference should be set everywhere, EXCEPT for macOS on Apple Silicon
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

/*** BRANDING ***/

pref("app.support.vendor", "Phoenix: 2025.12.23.1"); // [NO-MAIL] [HIDDEN] `about:support` -> `Version`
pref("distribution.about", "Phoenix for Mozilla Firefox - 2025.12.23.1 💜", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] `about:preferences#general` -> `Firefox Updates` - `distribution.id` and `distribution.version` must be set for this to display, see details below

/// Distribution ID and version must be set for `distribution.about` to display [LINUX-ONLY]
// `default` matches Mozilla's stock/default value - setting this to anything else could potentially compromise privacy (as this value is shared with Mozilla via the browser update endpoint) [LINUX-ONLY]
// For now, we only want to set these on Linux - since Mozilla offers EME-free builds on macOS and Linux that use different values here - so it's unclear how they'd interact [LINUX-ONLY]
pref("distribution.id", "default", locked); // [LINUX-ONLY] [HIDDEN]
pref("distribution.version", "default", locked); // [LINUX-ONLY] [HIDDEN]

/*** 000: ABOUT:CONFIG ***/

/// Disable warning when attempting to access `about:config`
pref("browser.aboutConfig.showWarning", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - Thunderbird]
pref("general.warnOnAboutConfig", false); // [NO-ANDROID] [ESR]

/// Ensure that the `about:config` is always enabled
pref("general.aboutConfig.enable", true, locked); // [DEFAULT - non-Android]

/// Ensure our policies aren't overriden...
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/enterprisepolicies/EnterprisePoliciesParent.sys.mjs#22
pref("browser.policies.perUserDir", false, locked); // [LINUX-ONLY] [NO-MAIL] RedHat/Fedora-specific
pref("toolkit.policies.perUserDir", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...
// These also provide Attack Surface Reduction

/// Block domains
// Any domains listed here are redirected to `127.0.0.1`
// We'll use this primarily for Mozilla ad/telemetry domains, but we'll also use it for ads & trackers that appear on Mozilla properties and services, as well as ad/tracking/telemetry domains that appear on other default connections/services
// Ex. We use DuckDuckGo as our default search engine, so we'll include their analytics domains
// On IronFox, we link to our GitLab releases via the `What's New` alert, so we'll also cover their analytics domains, etc...
// But generally we'll want to keep this limited in favor of ex. uBlock Origin & other mechanisms.
pref("network.dns.localDomains", "250analytics.com,a.omappapi.com,activity-stream-icons.services.mozilla.com,ads.allizom.org,ads.mozilla.org,ads.nonprod.webservices.mozgcp.net,ads.prod.webservices.mozgcp.net,ads-img.mozilla.org,analytics.getpocket.com,analytics.google.com,analytics.withgoogle.com,anf1.fuzzing.mozilla.org,anonymco.com,api.divviup.org,asan-nightly-frontend-elb-1348905149.us-east-2.elb.amazonaws.com,braze.com,contile.services.mozilla.com,contile-images.services.mozilla.com,classify-client.nonprod.webservices.mozgcp.net,classify-client.prod.webservices.mozgcp.net,classify-client.services.mozilla.com,crash-reports.allizom.org,crash-reports.mozilla.com,crash-reports-xpsp2.mozilla.com,crash-stacks.mozilla.com,crash-stats.allizom.org,crash-stats.mozilla.com,crash-stats.mozilla.org,dap.services.mozilla.com,dap.nonprod.webservices.mozgcp.net,dap.prod.webservices.mozgcp.net,dap-09-3.api.divviup.org,data.mozilla.com,data-ingestion.prod.dataops.mozgcp.net,dataops.mozgcp.net,dataservices.mozgcp.net,debug-ping-preview.firebaseapp.com,discovery.addons.allizom.org,discovery.addons.mozilla.org,discovery.addons-dev.allizom.org,divviup.org,download-stats.mozilla.org,download-stats.r53-2.services.mozilla.com,experimenter.services.mozilla.com,experimenter.nonprod.webservices.mozgcp.net,experimenter.prod.webservices.mozgcp.net,fhr.data.mozilla.com,fhr.r53-2.services.mozilla.com,firefox-android-home-recommendations.getpocket.com,firefox-dns-perf-test.net,fuzzing.mozilla.org,google-analytics.com,google-analytics-cn.com,googleanalytics.com,googlesyndication.com,googlesyndication-cn.com,googletagmanager.com,googletagmanager-cn.com,googletagservices.com,googletagservices-cn.com,improving.duckduckgo.com,incoming.glean.example.com,incoming.telemetry.mozilla.org,incoming.thunderbird.net,incoming-telemetry.thunderbird.net,ingestion-edge.prod.dataops.mozgcp.net,location.services.mozilla.com,locprod1-elb-eu-west-1.prod.mozaws.net,locprod2-elb-us-west-2.prod.mozaws.net,metrics-content.duckduckgo.com,new-sentry.gitlab.net,nonprod.classify-client.nonprod.webservices.mozgcp.net,normandy.cdn.mozilla.net,normandy.nonprod.cloudops.mozgcp.net,normandy.prod.cloudops.mozgcp.net,normandy-cdn.services.mozilla.com,omappapi.com,pipeline-incoming-prod-elb-149169523.us-west-2.elb.amazonaws.com,prod.ads.prod.webservices.mozgcp.net,prod.classify-client.prod.webservices.mozgcp.net,prod.dap.prod.webservices.mozgcp.net,prod.data-ingestion.prod.dataops.mozgcp.net,prod.dataops.mozgcp.net,prod.experimenter.prod.webservices.mozgcp.net,prod.ingestion-edge.prod.dataops.mozgcp.net,prod.sentry.prod.cloudops.mozgcp.net,prod-classifyclient.normandy.prod.cloudops.mozgcp.net,profile.accounts.firefox.com,sdk.iad-05.braze.com,search.r53-2.services.mozilla.com,search.services.mozilla.com,self-repair.mozilla.org,self-repair.r53-2.services.mozilla.com,sentry.gitlab.net,sentry.io,sentry.nonprod.cloudops.mozgcp.net,sentry.prod.cloudops.mozgcp.net,sentry.prod.mozaws.net,sitereview.zscaler.com,snippets.allizom.org,snippets.cdn.mozilla.net,snippets.mozilla.com,snippets-prod.frankfurt.moz.works,snippets-prod.moz.works,snippets-prod.oregon-b.moz.works,snippets-stage.moz.works,snippets-stage.oregon-b.moz.works,snowplow.trx.gitlab.net,snowplowalb-1011729428.us-east-1.elb.amazonaws.com,snowplowprd.trx.gitlab.net,snowplowprdnlb-1490493263.us-east-2.elb.amazonaws.com,socorro.nonprod.webservices.mozgcp.net,socorro.prod.webservices.mozgcp.net,socorro-collector.services.mozilla.com,socorro-webapp-allizom.stage.mozaws.net,socorro-webapp.services.mozilla.com,spocs.getpocket.com,spocs.getpocket.dev,spocs.mozilla.net,ssl.google-analytics.com,ssl-google-analytics.l.google.com,stage.sentry.nonprod.cloudops.mozgcp.net,start.fedoraproject.org,start.thunderbird.net,start.ubuntu.com,start-stage.thunderbird.net,survey.mozilla.com,tagmanager.google.com,talkback.mozilla.org,talkback-public.mozilla.org,talkback-reports.mozilla.org,telemetry-coverage.mozilla.org,telemetry-coverage.r53-2.services.mozilla.com,telemetry-experiment.cdn.mozilla.net,telemetry-incoming.r53-2.services.mozilla.com,telemetry-incoming-a.r53-2.services.mozilla.com,telemetry-incoming-b.r53-2.services.mozilla.com,telemetry-prod-1054754349.us-east-1.elb.amazonaws.com,tiles-cdn.prod.ads.prod.webservices.mozgcp.net,updates.thunderbird.net,updates-stage.thunderbird.net,use-application-dns.net,vf.startpage.com,widgets.getpocket.com,www.250analytics.com,www.anonymco.com,www.google-analytics.com,www.google-analytics-cn.com,www.googleanalytics.com,www.googlesyndication.com,www.googlesyndication-cn.com,www.googletagmanager.com,www.googletagmanager-cn.com,www.googletagservices.com,www.googletagservices-cn.com,www.sentry.io,www-google-analytics.l.google.com,www-googletagmanager.l.google.com");

/// Disable automatic upload of profiler data (from `about:logging`) to Mozilla
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#3743
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#3753
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/aboutLogging.mjs#616
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/aboutLogging.mjs#642
// https://searchfox.org/firefox-main/rev/16707ce1/toolkit/content/aboutLogging/profileSaveUploadLogic.mjs#13
pref("toolkit.aboutLogging.uploadProfileToCloud", false); // [DEFAULT - non-Android]
pref("toolkit.aboutlogging.uploadProfileUrl", ""); // [HIDDEN]

/// Disable Browser Search/Usage Telemetry metrics
// https://searchfox.org/firefox-main/source/browser/docs/BrowserUsageTelemetry.rst
// https://searchfox.org/firefox-main/source/browser/components/search/BrowserSearchTelemetry.sys.mjs
// https://searchfox.org/firefox-main/source/browser/modules/BrowserUsageTelemetry.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/content/widgets/tabbox.js
pref("browser.engagement.ctrlTab.has-used", true, locked); // [HIDDEN - Android/Thunderbird]
pref("browser.engagement.downloads-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.fxa-toolbar-menu-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.home-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.library-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.sidebar-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.total_uri_count.pbm", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.engagement.search_counts.pbm", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.search.totalSearches", 100, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/urlbar/UrlbarInput.sys.mjs#3193

/// Disable Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/firefox-main/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs
// https://bugzilla.mozilla.org/show_bug.cgi?id=1487578
pref("toolkit.coverage.enabled", false, locked); // [DEFAULT] [HIDDEN - Android/Thunderbird]
pref("toolkit.coverage.endpoint.base", "", locked); // [DEFAULT - Android/Thunderbird] [HIDDEN - Android/Thunderbird]
pref("toolkit.coverage.log-level", 70); // [HIDDEN] Limits logging to fatal only
pref("toolkit.coverage.opt-out", true, locked); // [HIDDEN]
pref("toolkit.telemetry.coverage.opt-out", true, locked); // [HIDDEN]

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
// https://firefox-source-docs.mozilla.org/tools/sanitizer/asan_nightly.html
// https://github.com/choller/firefox-asan-reporter
// https://searchfox.org/firefox-main/source/toolkit/modules/AsanReporter.sys.mjs
pref("asanreporter.apiurl", "", locked); // [HIDDEN - non-MOZ_ASAN_REPORTER builds] [DEFAULT - non-MOZ_ASAN_REPORTER builds]
pref("asanreporter.clientid", "unknown", locked); // [HIDDEN - non-MOZ_ASAN_REPORTER builds] [DEFAULT]
pref("asanreporter.loglevel", 70); // [HIDDEN]
pref("breakpad.reportURL", "", locked);
pref("browser.crashReports.crashPull", false, locked); // [DEFAULT] Do not request crash reports for background processes from users https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/crash-reports-ondemand/changeset?_expected=0
pref("browser.crashReports.requestedNeverShowAgain", true, locked); // Do not request crash reports for background processes from users https://searchfox.org/firefox-main/source/toolkit/components/crashes/RemoteSettingsCrashPull.sys.mjs
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - non-Nightly]
pref("browser.tabs.crashReporting.includeURL", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [DEFENSE IN DEPTH] (This is for `about:tabcrashed`)
pref("browser.tabs.crashReporting.sendReport", false, locked); // [NO-ANDROID] [NO-MAIL] (This is for `about:tabcrashed`)
pref("toolkit.crashreporter.include_context_heap", false, locked); // [DEFAULT - non-Nightly]

/// Disable Data Reporting & Telemetry
/// We also configure "DisableTelemetry" & "ImproveSuggest" in policies on Desktop
// https://mozilla.github.io/policy-templates/#disabletelemetry 
// https://mozilla.github.io/policy-templates/#firefoxsuggest
// https://wiki.mozilla.org/QA/Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
// https://searchfox.org/firefox-release/source/toolkit/components/glean/xpcom/FOG.cpp
// https://searchfox.org/firefox-release/source/toolkit/components/telemetry/app/TelemetryUtils.sys.mjs
pref("browser.aboutwelcome.entrypoint", "", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Ensure entrypoint to `about:welcome` is not recorded and ex. submitted for telemetry https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/aboutwelcome/actors/AboutWelcomeChild.sys.mjs#266
pref("browser.safebrowsing.features.emailtracking.datacollection.update", false, locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264
pref("captchadetection.actor.enabled", false, locked); // Disable CAPTCHA Detection Pings https://searchfox.org/firefox-main/source/toolkit/components/captchadetection/CaptchaDetectionPingUtils.sys.mjs
pref("captchadetection.hasUnsubmittedData", false, locked); // [HIDDEN] Disable CAPTCHA Detection Pings https://searchfox.org/firefox-main/source/toolkit/components/captchadetection/CaptchaDetectionPingUtils.sys.mjs
pref("captchadetection.loglevel", "Off");
pref("datareporting.dau.cachedUsageProfileID", "beefbeef-beef-beef-beef-beeefbeefbee", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/app/ClientID.sys.mjs#45
pref("datareporting.dau.cachedUsageProfileGroupID", "b0bacafe-b0ba-cafe-b0ba-cafeb0bacafe", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/app/ClientID.sys.mjs#46
pref("datareporting.healthreport.uploadEnabled", false, locked); // [DEFAULT - Android] Required for Firefox Labs on Desktop
pref("datareporting.policy.dataSubmissionEnabled", false, locked);
pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true, locked); // [DEFAULT - non-MOZILLA_OFFICIAL builds]
pref("datareporting.policy.firstRunURL", "", locked);
pref("datareporting.usage.uploadEnabled", false, locked); // [HIDDEN - ANDROID] [DEFAULT - Android] Disables "daily usage pings" https://support.mozilla.org/kb/usage-ping-settings
pref("dom.security.unexpected_system_load_telemetry_enabled", false, locked); // [DEFAULT - non-Nightly]
pref("extensions.dataCollectionPermissions.enabled", false, locked); // https://support.mozilla.org/kb/extension-data-collection https://extensionworkshop.com/documentation/develop/firefox-builtin-data-consent/
pref("extensions.telemetry.EnvironmentAddonBuilder", false, locked); // [HIDDEN - non-Android] [NIGHTLY] Do not use Glean for add-on telemetry https://bugzilla.mozilla.org/show_bug.cgi?id=1981496 https://searchfox.org/firefox-main/rev/d285a4fb/toolkit/mozapps/extensions/AddonManager.sys.mjs#4801
pref("network.jar.record_failure_reason", false, locked); // [DEFAULT - non-Nightly] https://searchfox.org/firefox-release/rev/9d94f5e3/modules/libpref/init/StaticPrefList.yaml#15576
pref("network.traffic_analyzer.enabled", false, locked); // https://searchfox.org/firefox-release/rev/9d94f5e3/modules/libpref/init/StaticPrefList.yaml#14262
pref("network.trr.confirmation_telemetry_enabled", false, locked);
pref("nimbus.telemetry.targetingContextEnabled", false, locked); // [HIDDEN - ANDROID/THUNDERBIRD] [DEFAULT - Artifact builds] Targeting context telemetry - https://searchfox.org/firefox-release/rev/9d94f5e3/browser/app/profile/firefox.js#2139
pref("privacy.trackingprotection.emailtracking.data_collection.enabled", false, locked);
pref("telemetry.fog.aboutGlean.debugTag", "", locked); // [NO-ANDROID] [HIDDEN] Do not set a debug ping tag https://searchfox.org/firefox-main/rev/4258ca07/toolkit/content/aboutGlean.js#122
pref("telemetry.fog.artifact_build", false, locked); // [DEFAULT - non-Artifact builds] Disable JOG to prevent runtime registration of metrics https://firefox-source-docs.mozilla.org/toolkit/components/glean/dev/jog.html https://firefox-source-docs.mozilla.org/toolkit/components/glean/dev/preferences.html#internal-preferences
pref("telemetry.fog.test.activity_limit", -1, locked); // Disable activity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.test.inactivity_limit", -1, locked); // Disable inactivity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.init_on_shutdown", false, locked); // Prevent Glean from initializing on shutdown https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/docs/dev/preferences.md#49
pref("telemetry.fog.test.localhost_port", 70000, locked); // Force telemetry pings to be sent to localhost instead of Mozilla's servers, if they're somehow enabled... (port just has to be higher than 0, I chose 70000 as its invalid) - https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/docs/dev/preferences.md#15
pref("telemetry.glean.internal.finalInactive", false, locked); // [HIDDEN] [DEFAULT] Disable early shutdown pings https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/xpcom/FOG.cpp#148
pref("telemetry.glean.internal.maxPingsPerMinute", 0, locked); // [HIDDEN] Prevent Glean from sending pings https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/glean/xpcom/FOG.cpp#133
pref("telemetry.number_of_site_origin.min_interval", 999999999, locked);
pref("toolkit.content-background-hang-monitor.disabled", true, locked); // BHR https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundhangmonitor/BackgroundHangMonitor.cpp#597
pref("toolkit.telemetry.archive.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.bhrPing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.cachedClientID", "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0", locked); // [HIDDEN]
pref("toolkit.telemetry.cachedProfileGroupID", "decafdec-afde-cafd-ecaf-decafdecafde", locked); // [HIDDEN]
pref("toolkit.telemetry.collectInterval", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.dap.helper.hpke", "", locked);
pref("toolkit.telemetry.dap.helper.url", "", locked);
pref("toolkit.telemetry.dap.leader.hpke", "", locked);
pref("toolkit.telemetry.dap.leader.url", "", locked);
pref("toolkit.telemetry.dap.logLevel", "Off");
pref("toolkit.telemetry.dap_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_task1_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_task1_taskid", "", locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_enabled", false, locked); // [DEFAULT]
pref("toolkit.telemetry.dap_visit_counting_experiment_list", "[]", locked); // [DEFAULT]
pref("toolkit.telemetry.debugSlowSql", false); // [DEFAULT]
pref("toolkit.telemetry.enabled", false, locked);  // [DEFAULT - non-Nightly]
pref("toolkit.telemetry.eventping.maximumFrequency", 999999999, locked); // [HIDDEN] Disable `event` pings
pref("toolkit.telemetry.eventping.minimumFrequency", 999999999, locked); // [HIDDEN] Disable `event` pings
pref("toolkit.telemetry.firstShutdownPing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.healthping.enabled", false, locked); // [HIDDEN]
pref("toolkit.telemetry.initDelay", 999999999, locked); // [HIDDEN] Prevent the Telemetry component from initializing
pref("toolkit.telemetry.log.dump", false); // [HIDDEN] [DEFAULT] - To expose via the `about:config`
pref("toolkit.telemetry.log.level", "Fatal"); // [HIDDEN] [Default: Warn]
pref("toolkit.telemetry.minSubsessionLength", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.newProfilePing.delay", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.newProfilePing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.overrideUpdateChannel", "release", locked); // [HIDDEN] [DEFENSE IN DEPTH] Always report channel as `release`, regardless of actual value https://docs.telemetry.mozilla.org/concepts/channels/channel_normalization
pref("toolkit.telemetry.previousBuildID", "", locked); // [HIDDEN]
pref("toolkit.telemetry.reportingpolicy.firstRun", false, locked); // [HIDDEN]
pref("toolkit.telemetry.scheduler.idleTickInterval", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.scheduler.tickInterval", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.send.overrideOfficialCheck", false, locked); // [HIDDEN] [DEFAULT] Never send pings on unofficial builds - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.server", "data;", locked);
pref("toolkit.telemetry.server_owner", "", locked);
pref("toolkit.telemetry.shutdownPingSender.backgroundtask.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - desktop Firefox]
pref("toolkit.telemetry.shutdownPingSender.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.shutdownPingSender.enabledFirstSession", false, locked); // [HIDDEN - Android] [DEFAULT]
pref("toolkit.telemetry.testing.disableFuzzingDelay", false, locked); // [HIDDEN] [DEFAULT] [DEFENSE IN DEPTH] Always delay sending pings between 0-1 AM
pref("toolkit.telemetry.testing.overridePreRelease", false, locked); // [HIDDEN] [DEFAULT] Never record extended/prelease data on release channels - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.testing.overrideProductsCheck", false, locked); // [DEFAULT] Limit probes to only what is supported on the current product - https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
pref("toolkit.telemetry.testing.suppressPingsender", true, locked); // [HIDDEN]
pref("toolkit.telemetry.translations.logLevel", "Off");
pref("toolkit.telemetry.unified", false, locked); // [DEFAULT - Android]
pref("toolkit.telemetry.untrustedModulesPing.frequency", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.updatePing.enabled", false, locked); // [HIDDEN - Android]
pref("toolkit.telemetry.user_characteristics_ping.current_version", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.last_version_sent", 0, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.logLevel", "Off");
pref("toolkit.telemetry.user_characteristics_ping.opt-out", true, locked);
pref("toolkit.telemetry.user_characteristics_ping.send-once", false, locked); // [DEFAULT]
pref("toolkit.telemetry.user_characteristics_ping.uuid", "", locked); // [DEFAULT]
pref("urlclassifier.features.emailtracking.datacollection.allowlistTables", "", locked); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264
pref("urlclassifier.features.emailtracking.datacollection.blocklistTables", "", locked); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/SafeBrowsing.sys.mjs#264


/// Disable Experiments/Studies
// (Shield/Nimbus/Normandy)
// https://support.mozilla.org/kb/shield
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_experiments-or-studies
// https://experimenter.info/
// https://wiki.mozilla.org/Firefox/Shield/Shield_Studies
// https://mozilla.github.io/normandy/
// https://wiki.mozilla.org/Advocacy/heartbeat
// resource://nimbus/ExperimentAPI.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js
pref("app.normandy.run_interval_seconds", 0, locked); // [HIDDEN - Android/Thunderbird] Prevent fetching experiments - This pref is also used by Nimbus https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#801
pref("app.normandy.api_url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.experiments.lazy_classify", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFENSE IN DEPTH] Prevent making client classification requests on every startup https://mozilla.github.io/normandy/dev/feature-experiments.html
pref("app.normandy.first_run", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.last_seen_buildid", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.logging.level", 70); // [NO-ANDROID] [NO-MAIL] Limit logging to fatal only
pref("app.normandy.user_id", "", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("app.shield.optoutstudies.enabled", false, locked); // [HIDDEN - Android/Thunderbird] Required for Firefox Labs on Desktop
pref("messaging-system.rsexperimentloader.collection_id", ""); // [DEFAULT: `nimbus-desktop-experiments`] Required for Firefox Labs on Desktop
pref("nimbus.appId", ""); // [HIDDEN] [DEFAULT: `firefox-desktop`] Required for Firefox Labs on Desktop
pref("nimbus.profileId", "", locked); // [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/ExperimentAPI.sys.mjs#80 - We also set this as a user pref in `phoenix-user-pref.cfg`, to ensure that Firefox properly uses/recognizes it
pref("nimbus.profilesdatastoreservice.enabled", false, locked); // Disable writing to the NimbusEnrollments table database https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#617
pref("nimbus.profilesdatastoreservice.read.enabled", false, locked); // Disable reading from the NimbusEnrollments table database https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#628
pref("nimbus.profilesdatastoreservice.sync.enabled", false, locked); // Disable syncing NimbusEnrollments data https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#425 https://searchfox.org/firefox-main/rev/16707ce1/toolkit/components/nimbus/lib/Enrollments.sys.mjs#638

/// Disable Firefox Labs (`about:preferences#experimental`) [NO-ANDROID] [NO-MAIL]
// Firefox Labs requires experiments and telemetry to be enabled (see specific prefs below) [NO-ANDROID] [NO-MAIL]
// When experiments and telemetry are not enabled, this seems to cause a broken/empty "Firefox Labs" section to appear at the bottom of pages at `about:preferences` [NO-ANDROID] [NO-MAIL]
// From my testing, the following prefs specifically are required for Firefox Labs to work (these are also indicated above): [NO-ANDROID] [NO-MAIL]
// `app.shield.optoutstudies.enabled` -> `true` [NO-ANDROID] [NO-MAIL]
// `datareporting.healthreport.uploadEnabled` -> `true` [NO-ANDROID] [NO-MAIL]
// `messaging-system.rsexperimentloader.collection_id` -> `nimbus-desktop-experiments` [NO-ANDROID] [NO-MAIL]
// `nimbus.appId` -> `firefox-desktop` [NO-ANDROID] [NO-MAIL]
// You'll also need to remove the `DisableFirefoxStudies` and `DisableTelemetry` policies [NO-ANDROID] [NO-MAIL]
pref("browser.preferences.experimental", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Glean redesign/navigation category at `about:glean`
// This isn't really a major issue for us, but we don't want or support Glean, so I see no reason not to set this
// https://searchfox.org/firefox-main/rev/cd6acbe9/toolkit/content/aboutGlean.js#215
pref("about.glean.redesign.enabled", false, locked); // [NO-ANDROID] [HIDDEN - non-Desktop Firefox] [DEFAULT]


/// Disable Origin Trials
// https://wiki.mozilla.org/Origin_Trials
pref("dom.origin-trials.enabled", false);

/// Remove partner attribution
// These are *only* used for telemetry, and could potentially be used for fingerprinting
pref("app.distributor", "", locked); // [HIDDEN] [DEFAULT]
pref("app.distributor.channel", "", locked); // [HIDDEN] [DEFAULT]
pref("mozilla.partner.id", "", locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "001");

/*** 002 MOZILLA CRAP™ ***/

// Some of these also provide Attack Surface Reduction

/// Clear unnecessary/undesired Mozilla URLs
pref("app.feedback.baseURL", ""); // [NO-ANDROID]
pref("app.normandy.shieldLearnMoreUrl", ""); // [NO-ANDROID] [NO-MAIL]
pref("datareporting.healthreport.infoURL", ""); // [NO-ANDROID]
pref("extensions.recommendations.privacyPolicyUrl", ""); // [DEFAULT - Android]
pref("toolkit.datacollection.infoURL", ""); // [NO-ANDROID]

/// Disable `about:welcome`/onboarding
// Privacy concerns - unsolicited connections
// Also just annoying and undesired for our use case :/
// https://searchfox.org/firefox-main/source/browser/components/BrowserContentHandler.sys.mjs
pref("browser.aboutwelcome.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.aboutwelcome.log", "off"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Disable logging
pref("browser.preonboarding.enabled", false); // [HIDDEN - Android/Thunderbird] [DEFAULT - Linux] Disable the preonboarding modal https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#874 https://searchfox.org/firefox-main/rev/643d7328/toolkit/components/telemetry/app/TelemetryReportingPolicy.sys.mjs#638
pref("browser.rights.3.shown", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.startup.firstrunSkipsHomepage", false); // [NO-ANDROID] [NO-MAIL] Ensure we never skip the homepage (ex. upon update/in favor of the onboarding) https://searchfox.org/firefox-release/rev/9d94f5e3/browser/app/profile/firefox.js#323
pref("browser.startup.homepage_override.buildID", "20100101", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Ex. matches what Tor Browser uses
pref("browser.startup.homepage_override.mstone", "ignore", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.startup.upgradeDialog.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/components/asrouter/docs/first-run.md#69
pref("browser.suppress_first_window_animation", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("startup.homepage_override_nimbus_disable_wnp", true); // [NO-ANDROID] [NO-MAIL] "What's New" Pages
pref("startup.homepage_override_url", ""); // [NO-ANDROID] [NO-MAIL]
pref("startup.homepage_override_url_nimbus", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("startup.homepage_welcome_url", ""); // [NO-ANDROID] [NO-MAIL]
pref("startup.homepage_welcome_url.additional", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable add-on/feature recommendations
// https://support.mozilla.org/kb/recommendations-firefox
// https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/content/aboutaddons.js
// https://searchfox.org/firefox-main/source/browser/components/enterprisepolicies/Policies.sys.mjs
pref("browser.dataFeatureRecommendations.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.discovery.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - Android/Thunderbird]
pref("browser.discovery.sites", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.translations.mostRecentTargetLanguages", "en-US"); // https://searchfox.org/firefox-main/rev/4258ca07/browser/components/enterprisepolicies/Policies.sys.mjs#2829
pref("browser.translations.panelShown", true, locked); // [HIDDEN]
pref("extensions.getAddons.browseAddons", ""); // [HIDDEN - non-Android]
pref("extensions.getAddons.discovery.api_url", "data;");
pref("extensions.getAddons.showPane", false); // [HIDDEN]
pref("extensions.htmlaboutaddons.recommendations.enabled", false);
pref("extensions.recommendations.hideNotice", true, locked); // [HIDDEN] "Some of these recommendations are personalized..." banner
pref("extensions.recommendations.themeRecommendationUrl", "");
pref("extensions.ui.lastCategory", "addons://list/extension"); // [HIDDEN] [DEFAULT = `addons://discover/`] Ensure default view of `about:addons` is always local/installed extensions
pref("extensions.webservice.discoverURL", ""); // [HIDDEN - non-Thunderbird]

/// Disable DoH Rollout/heuristics/steering
// This helps ensure Firefox doesn't override our/the user's DoH settings...
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHConfig.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHController.sys.mjs
// https://searchfox.org/firefox-main/source/toolkit/components/doh/DoHHeuristics.sys.mjs
// https://searchfox.org/firefox-main/source/netwerk/docs/dns/dns-over-https-trr.md
pref("doh-rollout._testing", true, locked); // [HIDDEN]
pref("doh-rollout.disable-heuristics", true, locked); // [HIDDEN]
pref("doh-rollout.doneFirstRun", true, locked); // [HIDDEN]
pref("doh-rollout.doorhanger-decision", "UIDisabled", locked); // [HIDDEN]
pref("doh-rollout.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.mode", 5, locked); // [HIDDEN]
pref("doh-rollout.provider-steering.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.provider-steering.provider-list", "", locked); // [HIDDEN]
pref("doh-rollout.self-enabled", false, locked); // [HIDDEN]
pref("doh-rollout.skipHeuristicsCheck", true, locked); // [HIDDEN]
pref("doh-rollout.trr-selection.enabled", false, locked); // [HIDDEN]
pref("doh-rollout.trr-selection.provider-list", "", locked); // [HIDDEN]
pref("doh-rollout.uri", "", locked); // [HIDDEN]
pref("network.android_doh.autoselect_enabled", false, locked); // [HIDDEN - non-Android] https://searchfox.org/firefox-main/rev/82e2435f/mobile/android/geckoview/src/main/java/org/mozilla/geckoview/GeckoRuntimeSettings.java#1773

/// Disable DoH performance measurements
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/BrowserGlue.sys.mjs#1155
// https://searchfox.org/firefox-main/source/toolkit/components/doh/TRRPerformance.sys.mjs
pref("doh-rollout.trrRace.canonicalDomain", ""); // [HIDDEN] [Default = firefox-dns-perf-test.net]
pref("doh-rollout.trrRace.complete", true); // [HIDDEN]
pref("doh-rollout.trrRace.enabled", false); // [HIDDEN]
pref("doh-rollout.trrRace.popularDomains", ""); // [HIDDEN]
pref("doh-rollout.trrRace.randomSubdomainCount", 0); // [HIDDEN]

/// Disable 'Essential Domains Fallback'
// My concern here is the fact that this is fetched from Remote Settings - this could potentially be used to bypass our internal domain blocklist above + the firewall of users if they themselves choose to block specific domains for whatever reason
// I don't have a problem with this being a local dump though, as I can understand the usefulness of this (and being local would mitigate my concerns here) - but I'm not comfortable with the remote part
// This is currently unused anyways...
// https://searchfox.org/firefox-main/source/netwerk/base/EssentialDomainsRemoteSettings.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/moz-essential-domain-fallbacks/changeset?_expected=0
pref("network.essential_domains_fallback", false); // [DEFAULT]

/// Disable Fakespot
pref("toolkit.shopping.ohttpConfigURL", "");
pref("toolkit.shopping.ohttpRelayURL", "");

/// Disable "Feature Tours" [NO-ANDROID] [NO-MAIL]
pref("browser.firefox-view.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtab.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.pdfjs.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL]

/// Disable fetching Firefox Relay's "allowlist" and "denylist"
// Should reduce network activity, and also allows users of Relay to use it anywhere if desired (+ should reduce nags from the browser about it in general)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1926974
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxrelay-allowlist/changeset?_expected=0
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxrelay-denylist/changeset?_expected=0
// https://searchfox.org/firefox-main/rev/c82adde5/toolkit/components/satchel/integrations/FirefoxRelay.sys.mjs#42
pref("signon.firefoxRelay.allowListRemoteSettingsCollection", ""); // [HIDDEN]
pref("signon.firefoxRelay.denyListRemoteSettingsCollection", ""); // [HIDDEN]

/// Disable fetching Password Manager rules remotely by default
// (Used for identifying password forms on websites)
// Last update was January 2023... also included locally as a dump anyways (resource://app/defaults/settings/main/password-recipes.json), so I don't see a reason to fetch these remotely
// https://bugzilla.mozilla.org/show_bug.cgi?id=1134852
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/password-recipes/changeset?_expected=0
pref("signon.recipes.remoteRecipes.enabled", false);

/// Disable Firefox Bridge [NO-ANDROID] [NO-MAIL]
// Uses native messaging to share browsing data with other browsers (Chromium) [NO-ANDROID] [NO-MAIL]
// Interesting concept, but due to the obvious potential privacy and security concerns, I feel that this is something that should be left to the user to enable [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#948 [NO-ANDROID] [NO-MAIL]
pref("browser.firefoxbridge.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable the Firefox Messaging System [NO-ANDROID]
// https://firefox-source-docs.mozilla.org/browser/components/asrouter/docs/index.html [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouter.sys.mjs#1863 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs#200 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js#26 [NO-ANDROID]
pref("app.update.background.messaging.targeting.snapshot.intervalSec", -1); // [NO-ANDROID] Disable targeting information background updates: https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/update/BackgroundUpdate.sys.mjs#827
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.message-groups", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.newtabmessaging", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1569 https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/NewTabMessaging.sys.mjs
pref("browser.profiles.created", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Ensure Firefox thinks we've used/enabled multiple profiles (this passes `hasSelectableProfiles`: https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouter.sys.mjs#1874 + https://searchfox.org/firefox-main/rev/ac83682a/browser/components/asrouter/modules/ASRouterTargeting.sys.mjs#676)
pref("messaging-system.askForFeedback", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("messaging-system.log", "off"); // [NO-ANDROID] [NO-MAIL] Disables logging
pref("messaging-system.profile.messagingProfileId", -1, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Firefox thinks this is the only profile it can send targetting messages to. As this profile ID does not exist, it tricks Firefox into never sending targetting messages.
pref("messaging-system.profile.singleProfileMessaging.disable", false); // [NO-ANDROID] [NO-MAIL] This makes Firefox only send targetting messages to the profile defined by `messaging-system.profile.messagingProfileId`

/// Disable Firefox Relay by default
pref("signon.firefoxRelay.feature", "disabled"); // [HIDDEN - Thunderbird]

/// Disable import of Mozilla's default bookmarks [NO-ANDROID] [NO-MAIL]
// We also disable the default bookmarks via the `NoDefaultBookmarks` policy [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/268969d4/browser/components/places/PlacesBrowserStartup.sys.mjs#63 [NO-ANDROID] [NO-MAIL]
pref("browser.bookmarks.restore_default_bookmarks", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Ensure the browser never tries to restore/import the default bookmarks
pref("browser.bookmarks.testing.skipDefaultBookmarksImport", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] NOTE: This only appears to work in automation, but doesn't hurt to set anyways https://searchfox.org/firefox-main/rev/82e2435f/browser/components/places/PlacesBrowserStartup.sys.mjs#210
pref("browser.places.importBookmarksHTML", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] This is a clever hack that effectively tricks Firefox into skipping the process of importing default bookmarks - instead it will try to import bookmarks from a HTML file that doesn't exist by default, hence, Firefox will import nothing - This is also nice to set here to expose this pref via `about:config`, as its hidden

/// Disable "Interest-based Content Relevance Ranking and Personalization"
// https://bugzilla.mozilla.org/show_bug.cgi?id=1886207
pref("toolkit.contentRelevancy.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.ingestEnabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.log", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Disable IP Protection (Mozilla VPN) [NO-ANDROID] [NO-MAIL]
// This is a paid Mozilla service, so it doesn't make sense for us to leave this enabled by default [NO-ANDROID] [NO-MAIL]
// If people really do want to use it, they can though - they'll just need to enable it themselves manually [NO-ANDROID] [NO-MAIL]
// https://vpn.mozilla.org/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/ipprotection/docs/Preferences.rst [NO-ANDROID] [NO-MAIL]
pref("browser.ipProtection.added", true); // [NO-ANDROID] [NO-MAIL] Prevent pinning the IP Protection widget in the navigation bar https://searchfox.org/firefox-main/rev/82e2435f/browser/components/ipprotection/IPProtection.sys.mjs#145
pref("browser.ipProtection.autoStartEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ipProtection.autoStartPrivateEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ipProtection.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ipProtection.features.autoStart", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ipProtection.optedOut", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.ipProtection.userEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable Mozilla nags/promotions
pref("browser.contentblocking.report.hide_vpn_banner", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.lockwise.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.mobile-android.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.mobile-ios.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.monitor.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.contentblocking.report.proxy.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.contentblocking.report.proxy_extension.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.show_mobile_app", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-android.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-ios.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-promo.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.vpnpromourl", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.promo.cookiebanners.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#756
pref("browser.promo.focus.disallowed_regions", "xx");
pref("browser.promo.focus.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#722
pref("browser.promo.pin.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#734
pref("browser.protections_panel.infoMessage.seen", true, locked); // [NO-ANDROID] [NO-MAIL] Disables ETP Banner
pref("browser.send_to_device_locales", "", locked); // [HIDDEN - Android/Thunderbird] Disables "Send to Device" email promotions https://searchfox.org/firefox-main/rev/dc1c78e9/browser/app/profile/firefox.js#2503 https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#789 https://searchfox.org/firefox-main/rev/dc1c78e9/browser/components/preferences/moreFromMozilla.js#273
pref("browser.vpn_promo.disallowed_regions", "xx");
pref("browser.vpn_promo.enabled", false, locked); // [HIDDEN - Android/Thunderbird] https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/modules/BrowserUtils.sys.mjs#692
pref("cookiebanners.ui.desktop.showCallout", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("identity.fxaccounts.toolbar.accessed", true, locked); // [NO-ANDROID] [NO-MAIL] Used for Activity Stream/onboarding targeting https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/asrouter/modules/ASRouterTargeting.sys.mjs#98 https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/asrouter/modules/OnboardingMessageProvider.sys.mjs#2506
pref("privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings", true, locked); // Disables nag/onboarding to configure ETP exception lists https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/all.js#3342 https://searchfox.org/firefox-main/rev/dc1c78e9/netwerk/url-classifier/UrlClassifierExceptionListService.sys.mjs#200
pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true, locked); // [NO-ANDROID] [NO-MAIL] Promo card for dragging tabs when vertical tabs are enabled (sidebar.verticalTabs) https://searchfox.org/firefox-main/rev/839a8725/browser/components/sidebar/SidebarManager.sys.mjs#158
pref("trailhead.firstrun.didHandleCampaignAction", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Disable marketing/attribution/"campaign" actions on first run https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/asrouter/modules/ASRouterTargeting.sys.mjs#269 https://searchfox.org/firefox-main/rev/a7d872e9/browser/components/aboutwelcome/actors/AboutWelcomeParent.sys.mjs#271

/// Disable Mozilla.UITour [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/bedrock/uitour/#ui-tour [NO-ANDROID] [NO-MAIL]
// https://firefox-source-docs.mozilla.org/browser/components/uitour/docs/index.html [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/uitour/UITourUtils.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.loglevel", "Off"); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.requireSecure", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.uitour.surveyDuration", 0, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.testingOrigins", "", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.uitour.url", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Pocket [NO-ANDROID] [NO-MAIL]
pref("extensions.pocket.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable "Privacy-Preserving Attribution"
// https://support.mozilla.org/kb/privacy-preserving-attribution
pref("dom.origin-trials.private-attribution.state", 2, locked); // [DEFAULT]
pref("dom.private-attribution.submission.enabled", false, locked); // [DEFAULT]

/// Disable Remote Permissions
// This currently only allows overriding behavior for HTTPS-First + localhost
// In general, I don't think there should be remote/default overrides for a feature like this (or permissions in general...), best left up to the user
// https://searchfox.org/firefox-main/source/extensions/permissions/docs/remote.rst
// https://searchfox.org/firefox-main/source/extensions/permissions/RemotePermissionService.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/remote-permissions/changeset?_expected=0
pref("permissions.manager.remote.enabled", false);

/// Disable Remote Settings 'Preview' Buckets
// Nice to expose via about:config
pref("services.settings.preview_enabled", false); // [HIDDEN] [DEFAULT]

/// Disable search attribution [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/comm-central/source/mozilla/toolkit/components/search/AppProvidedSearchEngine.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.search.param.search_rich_suggestions", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable the Web Compatibility Reporter
// Harmless - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as a potential performance improvement
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#4511
pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT - Release/ESR]
pref("extensions.webcompat-reporter.newIssueEndpoint", "https://phoenix.celenity.dev/issues"); // Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764
pref("media.decoder-doctor.new-issue-endpoint", "https://phoenix.celenity.dev/issues"); // For decoding errors https://searchfox.org/firefox-main/rev/82e2435f/browser/actors/DecoderDoctorParent.sys.mjs#83
pref("ui.new-webcompat-reporter.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("ui.new-webcompat-reporter.new-report-endpoint", "https://phoenix.celenity.dev/issues"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764

/// Hide the "More from Mozilla" settings tab (`about:preferences#moreFromMozilla`) [NO-ANDROID] [NO-MAIL]
pref("browser.preferences.moreFromMozilla", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Opt out of add-on metadata updates
// Note: This prevents themes from displaying previews in `about:addons`
// https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/
pref("extensions.getAddons.cache.enabled", false);

/// Prevent checking if Firefox is the default browser [NO-ANDROID] [NO-MAIL]
pref("browser.shell.checkDefaultBrowser", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shell.skipDefaultBrowserCheckOnFirstRun", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Prevent checking if Firefox is the default `mailto:` handler [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1864216 [NO-ANDROID] [NO-MAIL]
pref("browser.mailto.dualPrompt", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Prevent checking if Firefox is the default PDF viewer [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#284 [NO-ANDROID] [NO-MAIL]
pref("browser.shell.checkDefaultPDF", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN - non-Windows]
pref("browser.shell.checkDefaultPDF.silencedByUser", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN - non-Windows]

/// Remove special privileges from Mozilla domains
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#privileged-mozilla-content
pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false, locked); // [DEFAULT - non-Firefox Desktop]
pref("browser.tabs.remote.separatedMozillaDomains", "", locked);
pref("dom.ipc.processCount.privilegedmozilla", 0, locked);
pref("extensions.webextensions.restrictedDomains", "");
pref("permissions.manager.defaultsUrl", ""); // [HIDDEN - Android] [DEFAULT - Android]
pref("svg.context-properties.content.allowed-domains", "", locked); // [DEFAULT - Android/Thunderbird]

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html + https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("app.releaseNotesURL", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.releaseNotesURL.aboutDialog", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.releaseNotesURL.prompt", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.update.url.details", "https://www.mozilla.org/firefox/notes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.update.url.manual", "https://www.mozilla.org/firefox/new", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.backup.template.fallback-download.aurora", "https://www.mozilla.org/firefox/channel/desktop/#developer");
pref("browser.backup.template.fallback-download.beta", "https://www.mozilla.org/firefox/channel/desktop/#beta");
pref("browser.backup.template.fallback-download.esr", "https://www.mozilla.org/firefox/enterprise/#download");
pref("browser.backup.template.fallback-download.nightly", "https://www.mozilla.org/firefox/channel/desktop/#nightly");
pref("browser.backup.template.fallback-download.release", "https://www.mozilla.org/firefox/download/thanks/?s=direct");
pref("browser.contentblocking.report.cookie.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_cross-site-tracking-cookies"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.cryptominer.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_cryptominers"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.fingerprinter.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_fingerprinters"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.lockwise.how_it_works.url", "https://support.mozilla.org/kb/password-manager-remember-delete-edit-logins"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.monitor.sign_in_url", "https://monitor.firefox.com/oauth/init"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.monitor.url", "https://monitor.firefox.com/"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.social.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_social-media-trackers"); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.tracker.url", "https://support.mozilla.org/kb/trackers-and-scripts-firefox-blocks-enhanced-track#w_tracking-content"); // [NO-ANDROID] [NO-MAIL]
pref("browser.dictionaries.download.url", "https://addons.mozilla.org/language-tools/"); // [NO-ANDROID] [NO-MAIL]
pref("browser.lna.warning.infoURL", "https://support.mozilla.org/kb/control-personal-device-local-network-permissions-firefox"); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.support.url", "https://support.mozilla.org/kb/new-tab"); // [NO-ANDROID] [NO-MAIL]
pref("browser.xr.warning.infoURL", "https://support.mozilla.org/kb/webxr-permission-info-page"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.abuseReport.amoFormURL", "https://addons.mozilla.org/feedback/addon/%addonID%/");
pref("extensions.blocklist.addonItemURL", "https://addons.mozilla.org/blocked-addon/%addonID%/%addonVersion%/");
pref("extensions.getAddons.link.url", "https://addons.mozilla.org/"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/search?q=%TERMS%"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.update.background.url", "https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // [NO-MAIL] Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("extensions.update.url", "https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // [NO-MAIL] Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("lightweightThemes.getMoreURL", "https://addons.mozilla.org/themes/"); // [NO-ANDROID] [NO-MAIL]
pref("pdfjs.altTextLearnMoreUrl", "https://support.mozilla.org/kb/pdf-alt-text");
pref("pdfjs.commentLearnMoreUrl", "https://support.mozilla.org/kb/view-pdf-files-firefox-or-choose-another-viewer#w_add-a-comment-to-a-pdf");
pref("signon.firefoxRelay.learn_more_url", "https://support.mozilla.org/kb/relay-integration#w_frequently-asked-questions");
pref("signon.firefoxRelay.manage_url", "https://relay.firefox.com/accounts/profile/");
pref("signon.firefoxRelay.privacy_policy_url", "https://www.mozilla.org/privacy/subscription-services/");
pref("signon.firefoxRelay.terms_of_service_url", "https://www.mozilla.org/about/legal/terms/subscription-services/");

/// Skip Mozilla's `Privacy Notice` and `Terms of Use`
// https://github.com/mozilla/policy-templates/pull/1212
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/enterprisepolicies/Policies.sys.mjs#2806
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/docs/internals/preferences.rst#208
pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 999, locked);
pref("datareporting.policy.dataSubmissionPolicyNotifiedTime", "32503679999000", locked);
pref("termsofuse.acceptedDate", "32503679999000", locked); // [HIDDEN - Android/Thunderbird]
pref("termsofuse.acceptedVersion", 999, locked); // [HIDDEN - Android/Thunderbird]
pref("termsofuse.bypassNotification", true, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT - builds without MOZILLA_OFFICIAL]

pref("browser.phoenix.status", "002");

/*** 003 TRACKING PROTECTION ***/

/// Allow users to add URLs to ETP via the `about:config`
// Typically hidden, but can be useful useful, so we can expose this via the `about:config` to make it easier for users to find/add entries
// https://developer.mozilla.org/docs/Web/Privacy/Guides/Storage_Access_Policy#adding_custom_domains_to_the_tracking_protection_list
pref("urlclassifier.trackingAnnotationTable.testEntries", ""); // [HIDDEN] [DEFAULT]

/// Allow users to exclude URLs from ETP via the `about:config`
// These are typically hidden, but very useful (especially for testing/working around breakage), so we can expose these via the `about:config` to make it easier for users to find/add exclusions
pref("privacy.rejectForeign.allowList", ""); // [DEFAULT]
pref("urlclassifier.features.consentmanager.annotate.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.cryptomining.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.emailtracking.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.fingerprinting.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.features.socialtracking.skipURLs", ""); // [HIDDEN] [DEFAULT]
pref("urlclassifier.trackingSkipURLs", ""); // [HIDDEN] [DEFAULT]

/// Disable exceptions for minor issues by default
pref("privacy.trackingprotection.allow_list.convenience.enabled", false);

/// Enable ETP Strict
// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_strict-enhanced-tracking-protection
pref("browser.contentblocking.category", "strict", locked); // [HIDDEN]

/// Manually enable ETP/Strict protections...
// These are typically configured by ETP Strict - but unfortunately Firefox doesn't set ETP Strict on the browser's first run :/
// So we need to also manually configure them. We still also use ETP Strict (not 'Custom') due to our enforcement of it, so we should be covered by Mozilla changes/updates for protections.
// Manually specifying these is also useful for cases like Android: where all protections aren't enabled with ETP Strict, and on Thunderbird: where ETP Strict doesn't exist at all...
// We're also configuring the 'CookieBehavior' and 'EnableTrackingProtection' policies on desktop.

//// Block known consent managers (CMPs)
pref("privacy.trackingprotection.consentmanager.annotate_channels", true); // [DEFAULT]
pref("privacy.trackingprotection.consentmanager.skip.enabled", false); // [DEFAULT]
pref("privacy.trackingprotection.consentmanager.skip.pbmode.enabled", false);

//// Block known cryptominers
pref("privacy.trackingprotection.cryptomining.enabled", true); // [DEFAULT - non-Thunderbird]

//// Block known email trackers
pref("privacy.trackingprotection.emailtracking.enabled", true);
pref("privacy.trackingprotection.emailtracking.pbmode.enabled", true); // [DEFAULT]

//// Block known fingerprinters
// Including ones classified as "anti-fraud": https://bugzilla.mozilla.org/show_bug.cgi?id=1962092
pref("privacy.trackingprotection.antifraud.annotate_channels", true); // [DEFAULT] [NIGHTLY]
pref("privacy.trackingprotection.antifraud.skip.enabled", false); // [DEFAULT] [NIGHTLY]
pref("privacy.trackingprotection.antifraud.skip.pbmode.enabled", false); // [NIGHTLY]
pref("privacy.trackingprotection.fingerprinting.enabled", true); // [DEFAULT - non-Thunderbird]

//// Block known social trackers
pref("privacy.trackingprotection.socialtracking.enabled", true);

//// Block known trackers
pref("privacy.trackingprotection.annotate_channels", true); // [DEFAULT]
pref("privacy.trackingprotection.enabled", true);
pref("privacy.trackingprotection.pbmode.enabled", true); // [DEFAULT - non-Android]

//// Block known trackers using the `strict` (Level 2) list
/// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#16075
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#3609
pref("privacy.annotate_channels.strict_list.enabled", true); // [DEFAULT - Android]
pref("privacy.annotate_channels.strict_list.pbmode.enabled", true); // [DEFAULT]

//// Block known tracking cookies
pref("network.cookie.cookieBehavior.trackerCookieBlocking", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop]
pref("privacy.socialtracking.block_cookies.enabled", true); // [DEFAULT]

//// Enable Bounce Tracking Protection
/// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_bounce-tracking-protection
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/antitracking/bouncetrackingprotection/nsIBounceTrackingProtection.idl#10
pref("privacy.bounceTrackingProtection.mode", 1); // [DEFAULT - Nightly]
pref("privacy.bounceTrackingProtection.requireStatefulBounces", false); // [DEFAULT - Nightly] Protect against all bounce trackers, instead of just those who access cookies/storage https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#4930

//// Enable Query Parameter Stripping
/// https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/query-stripping/index.html
pref("privacy.query_stripping.enabled", true);
pref("privacy.query_stripping.enabled.pbmode", true);
pref("privacy.query_stripping.redirect", true); // [DEFAULT]

//// Enable SmartBlock and Web Compatibility interventions by default
pref("extensions.pictureinpicture.enable_picture_in_picture_overrides", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/pictureinpicture/lib/picture_in_picture_overrides.js#19 https://searchfox.org/firefox-main/source/browser/extensions/pictureinpicture/data/picture_in_picture_overrides.js Controls PiP overrides
pref("extensions.webcompat.enable_interventions", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.enable_shims", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.perform_injections", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.perform_ua_overrides", true); // [HIDDEN] [DEFAULT - non-Thunderbird]
pref("extensions.webcompat.smartblockEmbeds.enabled", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - Desktop] - Enables Embeds/Placeholders to make certain resources click to load

//// Enable State Partitioning
pref("network.fetch.cache_partition_cross_origin", true); // [DEFAULT] Cross origin fetch/XHR requests
pref("privacy.partition.always_partition_third_party_non_cookie_storage", true); // [DEFAULT]
pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false); // [DEFAULT]
pref("privacy.partition.bloburl_per_partition_key", true); // [DEFAULT]
pref("privacy.partition.network_state", true); // [DEFAULT]
pref("privacy.partition.network_state.ocsp_cache", true); // [DEFAULT]
pref("privacy.partition.network_state.ocsp_cache.pbmode", true); // [DEFAULT]
pref("privacy.partition.serviceWorkers", true); // [DEFAULT]

//// Enable Suspected Fingerprinters Protection (FPP)
/// https://support.mozilla.org/kb/firefox-protection-against-fingerprinting#w_suspected-fingerprinters
pref("privacy.fingerprintingProtection", true);
pref("privacy.fingerprintingProtection.pbmode", true); // [DEFAULT]
pref("privacy.reduceTimerPrecision", true); // [DEFAULT]

//// Enable TCP/dFPI
/// https://support.mozilla.org/kb/introducing-total-cookie-protection-standard-mode
/// https://searchfox.org/firefox-main/rev/dc1c78e9/toolkit/components/nimbus/FeatureManifest.yaml#3633
pref("network.cookie.cookieBehavior", 5); // [DEFAULT - non-Thunderbird]
pref("network.cookie.cookieBehavior.optInPartitioning", true);
pref("network.cookie.cookieBehavior.optInPartitioning.pbmode", true);
pref("network.cookie.cookieBehavior.pbmode", 5); // [DEFAULT - non-Thunderbird]

//// Ignore less restricted referer policies (than the default)
/// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#13615
pref("network.http.referer.disallowCrossSiteRelaxingDefault", true); // [DEFAULT] - for cross-site requests
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode", true); // [DEFAULT] - for cross-site requests in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode.top_navigation", true); // [DEFAULT] - for top navigations in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true); // for top navigations

/// Enable exceptions required to avoid major breakage by default
pref("privacy.trackingprotection.allow_list.baseline.enabled", true); // [DEFAULT]
pref("privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs", true, locked); // Skip migration, so that `privacy.trackingprotection.allow_list.baseline.enabled` isn't overriden to `false` https://searchfox.org/firefox-main/rev/dc1c78e9/netwerk/url-classifier/UrlClassifierExceptionListService.sys.mjs#254

/// Lower the network priority of known trackers (if not blocked for whatever reason...)
pref("privacy.trackingprotection.lower_network_priority", true);

pref("browser.phoenix.status", "003");

/*** 004 FINGERPRINTING PROTECTION ***/

/// Add notes to help prevent users from making themselves unnecessarily fingerprintable
// We need to keep Android notes under ~50 characters to prevent them from being cut off/un-readable; isn't an issue on Desktop
pref("dom.webmidi.enabled.0.NOTE", "Changing this value is unnecessary...");
pref("dom.webmidi.enabled.1.NOTE", "and WILL aid fingerprinting.");
pref("dom.webmidi.enabled.2.NOTE", "Set 'dom.sitepermsaddon-provider.enabled' to 'false'...");
pref("dom.webmidi.enabled.3.NOTE", "and 'dom.webmidi.gated' to 'true' instead.");
pref("geo.enabled.0.NOTE", "Changing this value is unnecessary...");
pref("geo.enabled.1.NOTE", "and WILL aid fingerprinting.");
pref("geo.enabled.2.NOTE", "To block Geolocation, set 'permissions.default.geo' to '2' instead."); // [NO-ANDROID] [NO-MAIL]
pref("pdfjs.disabled.0.NOTE", "Changing this value is unnecessary, and it WILL aid fingerprinting. To disable PDF.js, set 'browser.helperApps.showOpenOptionForPdfJS' to 'false' instead."); // [NO-ANDROID]

/// Always load fonts bundled with Firefox
// The default is -1 - which loads bundled fonts, EXCEPT on "low-memory" devices
// Hence, this could add extra entropy/add an extra fingerprinting vector for users on "low-memory" devices
// In general, this will ensure all users have the same standard behavior here
// https://bugzilla.mozilla.org/show_bug.cgi?id=1686274
// https://searchfox.org/firefox-main/rev/82e2435f/gfx/thebes/gfxFT2FontList.cpp#1625
pref("gfx.bundled-fonts.activate", 1);

/// Disable the ability to switch locales without requiring a restart [NO-ANDROID]
// Currently appears to be buggy and inconsistent - and thus could be potentially fingerprintable, so I think it's best to leave off to be safe [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42349#note_3057563 [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/42771#note_3057587 [NO-ANDROID]
pref("intl.multilingual.liveReload", false); // [NO-ANDROID] [DEFAULT - non-Firefox release/beta]
pref("intl.multilingual.liveReloadBidirectional", false); // [NO-ANDROID] [DEFAULT]

/// Disable failIfMajorPerformanceCaveat in WebGL contexts
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/18603
pref("webgl.disable-fail-if-major-performance-caveat", true); // [DEFAULT]

/// Disable VP9 Benchmark
// This means that VP9 will always be enabled regardless of performance benchmarks (unless on a plaform where this isn't supported)
// This likely also results in a performance improvement, so that's nice
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/22548
pref("media.benchmark.vp9.threshold", 0);

/// Do not use the theme's toolbar color scheme for in-content pages by default
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/LightweightThemeConsumer.sys.mjs#17
pref("browser.theme.unified-color-scheme", false); // [HIDDEN - non-Thunderbird] [DEFAULT - non-Thunderbird]

/// Enable canvas randomization for the browser chrome
pref("privacy.resistFingerprinting.randomization.canvas.disable_for_chrome", false); // [DEFAULT]

/// Enable fdlibm for Math.sin, Math.cos, and Math.tan
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#9422
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/0dxAO-JsoXI/m/eEhjM9VsAgAJ
pref("javascript.options.use_fdlibm_for_sin_cos_tan", true); // [DEFAULT - non-Windows]

/// Enable light mode by default
// Matches with RFP & prevents exposing system theme
pref("layout.css.prefers-color-scheme.content-override", 1);


/// Expose dynamic rounding of content dimensions (`privacy.resistFingerprinting.letterboxing`) in the `about:config`, but do not enable by default (except for Android: see note below) [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366 [NO-MAIL]
pref("privacy.resistFingerprinting.letterboxing", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Harden FPP (which we enable at `003` above) to match RFP with a few exceptions...
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/firefox-main/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC"); // [NO-ANDROID] [NO-MAIL]

/// If FPP/RFP is disabled, limit font visibility to base system fonts + fonts from optional language packs
// We could set this to 1 to only allow base system fonts - but this is already covered by FPP/RFP. So if one disables RFP/FPP or adds an override, I think it's reasonable to allow fonts from language packs - as that may be the reason they've disabled it. I see no reason to ever expose user-installed fonts though.
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#10128
pref("layout.css.font-visibility", 2);

/// Prevent enumeration of media devices
// Exceptions can be set via the `media.devices.enumerate.legacy.allowlist` pref
// https://bugzilla.mozilla.org/show_bug.cgi?id=1528042
pref("media.devices.enumerate.legacy.enabled", false); // [DEFAULT]

/// Prevent exposing WebGL Renderer Info
// This is equivalent to the RFP/FPP 'WebGLRenderInfo' target
// Useful to ensure users are protected if they disable FPP for whatever reason, or if they just disable ETP/Strict for a specific site/add an exception
// https://searchfox.org/firefox-main/source/dom/canvas/SanitizeRenderer.cpp
pref("webgl.enable-renderer-query", false); // Spoofs "Vendor" and "Renderer" to "Mozilla" (Like the `WebGLRenderInfo` target does)
pref("webgl.override-unmasked-renderer", "Mozilla"); // Spoofs "Unmasked Renderer" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query)
pref("webgl.override-unmasked-vendor", "Mozilla"); // Spoofs "Unmasked Vendor" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query)
pref("webgl.sanitize-unmasked-renderer", false); // Prevents the "Unmasked Renderer" under Debug Info from being set to "Generic Renderer"; we instead set it to "Mozilla" to always match FPP/RFP

/// Prevent pre-allocating content processes
// These can cause certain values/settings to persist, even after a user changes them - which could result in leakage/fingerprinting concerns
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#preallocated-content
pref("dom.ipc.processPrelaunch.enabled", false);
pref("dom.ipc.processPrelaunch.fission.number", 0);

/// Prevent using system accent colors
pref("widget.non-native-theme.use-theme-accent", false); // [DEFAULT - non-Thunderbird Windows]

/// Prevent using system colors
// The `ui.use_standins_for_native_colors` pref does the same thing as the 'UseStandinsForNativeColors' RFP/FPP target (so it shouldn't interfere with FPP/RFP)
// But I also want to set this here to ensure users are protected if they disable FPP for whatever reason, or if they disable ETP/Strict for a specific site/add an exception
// https://searchfox.org/firefox-main/rev/82e2435f/layout/style/PreferenceSheet.cpp#69
pref("browser.display.document_color_use", 1); // [DEFAULT - non-Windows] Contrast Control, supersedes `browser.display.use_system_colors` https://github.com/arkenfox/user.js/issues/1965
pref("browser.display.use_system_colors", false); // [DEFAULT - non-Windows]
pref("ui.use_standins_for_native_colors", true);

/// Prompt to spoof locale to en-US
pref("privacy.spoof_english", 0); // [DEFAULT]

/// Provide example templates to make it easier for users to set custom FPP overrides if needed
pref("privacy.fingerprintingProtection.granularOverrides.0.example", '[{"firstPartyDomain":"example1.invalid","overrides":"+ProtectionIWantToEnableOnThisWebsite,-ProtectionIWantToDisableOnThisWebsite"},{"firstPartyDomain":"*","thirdPartyDomain":"example2.invalid","overrides":"+ThirdPartyDomainsAreSupportedToo"}]');
pref("privacy.fingerprintingProtection.overrides.0.example", "+ProtectionIWantToEnableGlobally,-ProtectionIWantToDisableGlobally");

/// Reset the fingerprinting randomization key daily (in addition to per-session/when the browser restarts)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1816064
pref("privacy.resistFingerprinting.randomization.daily_reset.enabled", true);
pref("privacy.resistFingerprinting.randomization.daily_reset.private.enabled", true);

/// Round window sizes
// Also ensure we always skip earlyBlankFirstPaint to ensure windows are properly sized: https://bugzilla.mozilla.org/show_bug.cgi?id=1448423
pref("browser.startup.blankWindow", false); // [DEFAULT - non-Windows, non-Linux Nightly]
pref("privacy.resistFingerprinting.skipEarlyBlankFirstPaint", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("privacy.window.maxInnerHeight", 900); // [DEFAULT - non-Android/Thunderbird]
pref("privacy.window.maxInnerWidth", 1600);

/// Set a fixed temporary storage limit
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41065
// https://bugzilla.mozilla.org/show_bug.cgi?id=1781277
pref("dom.quotaManager.temporaryStorage.fixedLimit", 52428800); // Ex. matches what Tor Browser uses & what Firefox uses by default in most cases

/// Set FPP granular overrides (if the related target is enabled...)
// See here for details: https://codeberg.org/celenity/Phoenix/wiki/FPP-Overrides
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"google.ad","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ae","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.al","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.am","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.as","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.at","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.az","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ba","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.be","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bf","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bi","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bj","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bs","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.bt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.by","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ca","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cat","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cd","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cf","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ch","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ci","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ao","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.bw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ck","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.cr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.id","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.il","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.in","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.jp","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ke","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.kr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ls","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ma","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.mz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.nz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.th","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.tz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ug","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.uk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.uz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.ve","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.vi","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.za","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.zm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.co.zw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.af","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ag","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ar","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.au","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.bd","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.bh","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.bn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.bo","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.br","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.bz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.co","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.cu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.cy","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.do","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ec","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.eg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.et","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.fj","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.gh","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.gi","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.gt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.hk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.jm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.kh","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.kw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.lb","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ly","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.mm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.mt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.mx","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.my","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.na","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ng","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ni","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.np","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.om","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.pa","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.pe","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.pg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ph","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.pk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.pr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.py","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.qa","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.sa","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.sb","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.sg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.sl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.sv","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.tj","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.tr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.tw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.ua","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.uy","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.vc","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.com.vn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cv","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.cz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.de","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.dj","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.dk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.dm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.dz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ee","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.es","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.fi","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.fm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.fr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ga","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ge","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.gg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.gl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.gm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.gr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.gy","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.hn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.hr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ht","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.hu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ie","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.im","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.iq","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.is","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.it","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.je","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.jo","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.kg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ki","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.kz","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.la","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.li","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.lk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.lt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.lu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.lv","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.md","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.me","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ml","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mv","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.mw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ne","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.nl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.no","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.nr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.nu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.pl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.pn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ps","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.pt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ro","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.rs","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ru","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.rw","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sc","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.se","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sh","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.si","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sk","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.so","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.sr","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.st","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.td","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.tg","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.tl","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.tm","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.tn","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.to","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.tt","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.vu","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"google.ws","overrides":"+CanvasRandomization,-JSDateTimeUTC"},{"firstPartyDomain":"aa.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"abeto.co","overrides":"-WebGLRenderCapability"},{"firstPartyDomain":"amazon.ae","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.ca","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.uk","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.za","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.br","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.mx","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.tr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.de","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.eg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.es","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.fr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.ie","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.it","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.nl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.pl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.se","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.sg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"animepahe.ru","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"annas-archive.org","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.com.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.news","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"bahn.expert","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"barnesandnoble.com","overrides":"-ScreenRect"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cloudflare.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+JSDateTimeUTC"},{"firstPartyDomain":"cryptpad.fr","thirdPartyDomain":"cryptpad.info","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"cvs.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"discord.gg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"dropbox.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"enza.fun","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"epicgames.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"figma.com","overrides":"-WebGLRenderCapability"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"goo.gl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"hoyoverse.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"klippy.pro","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"kroger.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"medium.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"mega.nz","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pogo.com","thirdPartyDomain":"pogospike.com","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"reddit.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"redditmedia.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"rezka-ua.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"riverside.fm","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"salespanel.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"southwest.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"stacksocial.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"starlink.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"t.co","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"temoos.app","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"tiktok.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"tileman.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"usps.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"vsynctester.com","overrides":"-ReduceTimerPrecision"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"yahoo.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"youtu.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"zennioptical.com","thirdPartyDomain":"fittingbox.com","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"zoho.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.eu","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.news","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"bsky.app","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdn-apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdninstagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cloudflare.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"discord.gg","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"goo.gl","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"googlevideo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"gravatar.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"instagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"licdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"linkedin.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"loginwithamazon.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.store","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"moviezapiya.fun","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinimg.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinterest.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pornhub.com","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net.cn","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha-cn.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redd.it","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"reddit.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditmedia.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditstatic.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"t.co","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"tiktok.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"tileman.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twitter.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twimg.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeocdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"x.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtu.be","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"}]'); // [NO-ANDROID] [NO-MAIL]

/// Set target video resolution to 1080p
pref("privacy.resistFingerprinting.target_video_res", 1080); // [DEFAULT]

/// Set zoom levels on a per-site basis
// Changing the zoom level globally can be fingerprintable
// Note: We also set the "SiteSpecificZoom" FPP/RFP target
pref("browser.zoom.siteSpecific", true); // [DEFAULT - non-Android]

/// So people don't freak out when they see RFP isn't enabled...
// We need to keep Android notes under ~50 characters to prevent them from being cut off/un-readable; isn't an issue on Desktop
pref("privacy.resistFingerprinting.0.NOTE", "RFP is disabled on purpose.");
pref("privacy.resistFingerprinting.1.NOTE", "We use a hardened configuration of FPP instead.");
pref("privacy.resistFingerprinting.2.NOTE", "Using RFP is not recommended or supported.");

pref("browser.phoenix.status", "004");

/*** 005 DISK AVOIDANCE ***/

/// Allow permission manager to write to disk
// This is already Firefox's default - but it's hidden, so this exposes it via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/permissions/PermissionManager.cpp#765
pref("permissions.memory_only", false); // [HIDDEN] [DEFAULT]

/// Allow users to automatically delete files downloaded in Private Browsing
// (browser.download.deletePrivate controls the functionality itself)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790641
pref("browser.download.enableDeletePrivate", true); // [DEFAULT - Nightly]

/// Check the boxes for clearing browsing data when navigating to `about:preferences#privacy` -> `Cookies and Site Data` -> `Manage Data...` by default [NO-ANDROID]
pref("privacy.clearHistory.browsingHistoryAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearHistory.cache", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearHistory.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearHistory.historyFormDataAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearSiteData.browsingHistoryAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.cache", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.clearSiteData.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearSiteData.historyFormDataAndDownloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.cpd.cache", true); // [NO-ANDROID] [DEFAULT]
pref("privacy.cpd.downloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.cpd.formdata", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("privacy.cpd.history", true); // [NO-ANDROID] [DEFAULT]
pref("privacy.cpd.sessions", true); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

//// Except for cookies... (as this ignores `Allow` exceptions) [NO-ANDROID]
pref("privacy.clearHistory.cookiesAndStorage", false); // [NO-ANDROID]
pref("privacy.clearSiteData.cookiesAndStorage", false); // [NO-ANDROID]
pref("privacy.cpd.cookies", false); // [NO-ANDROID]
pref("privacy.cpd.offlineApps", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

//// and passwords... [NO-ANDROID]
pref("privacy.cpd.passwords", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]

/// Clear browsing history, download history, and sessions on exit by default [NO-ANDROID]
pref("privacy.clearOnShutdown.downloads", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearOnShutdown.history", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearOnShutdown.sessions", true); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("privacy.clearOnShutdown_v2.downloads", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("privacy.clearOnShutdown_v2.formdata", true); // [NO-ANDROID] [NO-MAIL]
pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true); // [NO-ANDROID] [NO-MAIL]

/// Clear cache on exit by default
// We also disable disk cache entirely below...
pref("privacy.clearOnShutdown.cache", true);
pref("privacy.clearOnShutdown_v2.cache", true); // [DEFAULT - Desktop Firefox]
pref("privacy.sanitize.sanitizeOnShutdown", true);

/// Decrease the number of tabs saved in Session Store [NO-MAIL]
// Also improves performance [NO-MAIL]
// (Default = 10 for Android, 25 elsewhere) [NO-MAIL]
pref("browser.sessionstore.max_tabs_undo", 7); // [NO-MAIL]

/// Disable back/forward cache (bfcache)
// This helps ensure that sensitive data/user state is discarded as soon as possible
// https://web.dev/articles/bfcache
// https://github.com/uazo/cromite/blob/master/docs/FEATURES.md
// https://github.com/uazo/cromite/issues/1649
// https://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers#Possible_values_and_their_effects
pref("browser.sessionhistory.max_total_viewers", 0); // (Default = -1 (Automatic) - which is 8 unless you're using a device with under 1GB of RAM)
pref("fission.bfcacheInParent", false);

/// Disable collection/generation of background thumbnails
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/thumbnails/PageThumbs.sys.mjs#631
pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN]

/// Disable collection/generation of wireframes
// https://searchfox.org/firefox-main/source/browser/components/sessionstore/PageWireframes.sys.mjs
pref("browser.history.collectWireframes", false); // [DEFAULT]

/// Disable coloring visited links
pref("layout.css.visited_links_enabled", false);

/// Disable disk cache
pref("browser.cache.disk.enable", false);
pref("browser.cache.disk_cache_ssl", true); // [DEFAULT] Controls disk cache for secure (HTTPS) resources, depends on `browser.cache.disk.enable` (which is why we're keeping this on by default)

/// Disable favicons in shortcuts [NO-ANDROID]
// Prevents .ico files from persisting, even after deletion [NO-ANDROID]
pref("browser.shell.shortcutFavicons", false); // [NO-ANDROID] [HIDDEN - Thunderbird]

/// Disable LaterRun [NO-ANDROID] [NO-MAIL]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41568 [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1200639 [NO-ANDROID] [NO-MAIL]
pref("browser.laterrun.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable logging blocked domains to `about:protections` [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.cfr-milestone.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.cfr-milestone.milestone-shown-time", "999999999"); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.contentblocking.cfr-milestone.update-interval", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.contentblocking.database.enabled", false); // [DEFAULT - Android/Thunderbird]

/// Disable Search & Form History
// Can be leaked to sites...
// https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
pref("browser.formfill.enable", false);



/// Disable WebRTC history
// History will still gather when `about:webrtc` is open
// Also likely improves performance...
pref("media.aboutwebrtc.hist.enabled", false); // [DEFAULT - non-Nightly]

/// Disable window state restoration
// https://searchfox.org/firefox-main/rev/16707ce1/xpfe/appshell/AppWindow.cpp#2404
pref("browser.restoreWindowState.disabled", true);

/// Enable a fire button in Private Browsing Windows to reset the session [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.resetPBM.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]

/// Enable the "Forget" button by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/components/customizableui/CustomizableWidgets.sys.mjs#576 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/components/enterprisepolicies/Policies.sys.mjs#950 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/locales/en-US/browser/policies/policies-descriptions.ftl#81 [NO-ANDROID] [NO-MAIL]
pref("privacy.panicButton.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Increase the interval between between Session Store save operations
// Also improves performance
// (Default = 10000 (10 secs) for Android, 15000 (15 secs) elsewhere)
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/sessionstore/docs/utils.rst#20
pref("browser.sessionstore.interval", 60000); // 1 minute


/// Prevent clearing cookies by default
pref("privacy.clearOnShutdown.cookies", false); // [NO-ANDROID] [NO-MAIL]
pref("privacy.clearOnShutdown.offlineApps", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false); // [NO-ANDROID] [NO-MAIL]

/// Prevent clearing passwords & site settings by default
pref("privacy.clearOnShutdown.siteSettings", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("privacy.clearOnShutdown_v2.siteSettings", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Prevent clearing site settings at `about:preferences#privacy` -> `Cookies and Site Data` -> `Manage Data...` by default [NO-ANDROID] [NO-MAIL]
pref("privacy.clearHistory.siteSettings", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("privacy.clearSiteData.siteSettings", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("privacy.cpd.siteSettings", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Prevent exposing content in the window title for Private Browsing windows [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2619 [NO-ANDROID] [NO-MAIL]
pref("privacy.exposeContentTitleInWindow.pbm", false); // [NO-ANDROID] [NO-MAIL]

/// Prevent storing unnecessary extra session data
pref("browser.sessionstore.privacy_level", 2); // [HIDDEN - Thunderbird]

/// Prevent writing media cache (ex. for video streaming) to disk in private windows
pref("browser.privatebrowsing.forceMediaMemoryCache", true);

/// Remove cached files from browser windows opened with external applications
// https://bugzilla.mozilla.org/buglist.cgi?bug_id=302433,1738574
pref("browser.download.start_downloads_in_tmp_dir", true);
pref("browser.helperApps.deleteTempFileOnExit", true); // [DEFAULT - Thunderbird]

/// Remove files from session list & history when deleted in Firefox [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#833 [NO-ANDROID] [NO-MAIL]
pref("browser.download.clearHistoryOnDelete", 2); // [NO-ANDROID] [NO-MAIL]

/// Set default time range when manually clearing data to "everything" [NO-ANDROID]
pref("privacy.sanitize.timeSpan", 0); // [NO-ANDROID]

/// Use `Custom settings' for history at `about:preferences#privacy` -> `History` by default [NO-ANDROID] [NO-MAIL]
pref("privacy.history.custom", true); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "005");

/*** 006 DOWNLOADS ***/

/// Block insecure downloads
pref("dom.block_download_insecure", true); // [DEFAULT]

/// Disable extra download logging by default
// This lets us expose it in the about:config for Android/Thunderbird
pref("browser.download.loglevel", "Error"); // [DEFAULT, HIDDEN - Android/Thunderbird]

/// Notify when downloading files
pref("browser.download.alwaysOpenPanel", true); // [DEFAULT - Desktop] [HIDDEN - Android/Thunderbird]

/// Prevent adding downloads to "recent documents"...
pref("browser.download.manager.addToRecentDocs", false);

/// Prompt before downloading files
pref("browser.download.always_ask_before_handling_new_types", true);
pref("browser.download.useDownloadDir", false); // [DEFAULT - Thunderbird]

pref("browser.phoenix.status", "006");

/*** 007 HTTP(S) ***/

/// Allow users to bypass invalid certificate errors by default
// (To expose the preference via the `about:config`)
pref("security.certerror.hideAddException", false); // [HIDDEN] [DEFAULT]

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

/// Disable the automatic import of OS client authentication certificates
// (Ex. smart cards)
// This prevents loading Mozilla's PKCS#11 module (which then loads these certificates from the OS store).
// AFAICT this functionality is quite obscure, use is seemingly nonexistent outside of very specific environments (ex. enterprise/government).
// Those who do actually use this functionality may also not want the browser to automatically import/expose these certificates, as they have many other uses.
// These certificates can also still be imported in browser settings anyways, so those who do need to use this functionality still can that way.
// So I no reason to leave this enabled by default - disabling it reduces attack surface and gives more control to users.
// (For reference, Tor Browser also disables this)
// https://blog.mozilla.org/security/2020/04/14/expanding-client-certificates-in-firefox-75/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1637807
pref("security.osclientcerts.autoload", false); // [DEFAULT - Thunderbird]

/// Disable downgrades to insecure TLS 1.0/1.1
pref("security.tls.insecure_fallback_hosts", ""); // [DEFAULT]
pref("security.tls.version.enable-deprecated", false, locked); // [DEFAULT]

/// Disable insecure ciphers (Like Chromium & Tor Browser)
// https://gitlab.torproject.org/tpo/applications/mullvad-browser/-/issues/361#note_3089049
// https://bugzilla.mozilla.org/show_bug.cgi?id=1600437
// https://bugzilla.mozilla.org/show_bug.cgi?id=1036765
pref("security.ssl3.dhe_rsa_aes_128_sha", false); // [DEFAULT]
pref("security.ssl3.dhe_rsa_aes_256_sha", false); // [DEFAULT]
pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false); // [DEFAULT - Nightly] TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false); // [DEFAULT - Nightly] TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA

/// Disable OCSP revocation checks
//
// So, my current understanding:
// According to Mozilla blog: "With CRLite, Firefox periodically downloads a compact encoding of the set of all revoked certificates that appear in Certificate Transparency logs. Firefox stores this encoding locally, updates it every 12 hours, and queries it privately every time a new TLS connection is created."
// and: "Of course, no browser is performing daily downloads of all CRLs. For a more meaningful comparison, we can consider Chrome’s CRLSets. These are hand-picked sets of revocations that are delivered to Chrome users daily. Recent CRLSets weigh in at 600 kB and include about 1% of all revocations (thirty-five thousand of the four million total). Firefox’s CRLite implementation uses half the bandwidth, updates twice as frequently, and includes all revocations."
// According to MDN: "Firefox desktop from version 135 requires CT log inclusion for all certificates issued by certificate authorities in Mozilla's Root CA Program".
//
// What this means for us:
// 1. We enforce Certificate Transparency (CT) below (security.pki.certificate_transparency.mode -> 2)
// 2. Mozilla requires CAs in their program to implement CT, and we disable using the system's root CAs below (security.certerrors.mitm.auto_enable_enterprise_roots + security.enterprise_roots.enabled)
// 3. We enable + enforce CRLite below (security.pki.crlite_mode -> 2, security.remote_settings.crlite_filters.enabled -> true)
// 4. CRLite works by using CT logs, AND includes ALL revocations from those logs
// 5. Therefore, since we're only trusting CAs that use CT, and since CRLite is covering ALL revocations from CT, we can reasonably conclude that CRLite is covering all revocatons, and thus, OCSP should be superfluous
// So, I'm comfortable finally retiring OCSP... :) - Great to see how far this has come
// https://wikipedia.org/wiki/Online_Certificate_Status_Protocol
// https://hacks.mozilla.org/2025/08/crlite-fast-private-and-comprehensive-certificate-revocation-checking-in-firefox/
// https://developer.mozilla.org/docs/Web/Security/Certificate_Transparency#browser_requirements
// https://github.com/arkenfox/user.js/issues/1576
pref("security.OCSP.enabled", 0); // [NO-MAIL]
pref("security.OCSP.require", false); // [NO-MAIL] [DEFAULT]

/// Disable Parental Controls
// https://searchfox.org/firefox-main/source/toolkit/components/parentalcontrols/nsIParentalControlsService.idl
// https://searchfox.org/firefox-main/rev/cb527813/netwerk/protocol/http/nsHttpHandler.cpp#537
// https://searchfox.org/firefox-main/rev/cb527813/docshell/base/CanonicalBrowsingContext.cpp#3696
// https://searchfox.org/firefox-main/source/toolkit/locales-preview/aboutRestricted.ftl
pref("network.parental_controls_cached_state", false, locked); // [DEFAULT]
pref("security.restrict_to_adults.always", false, locked); // [DEFAULT]
pref("security.restrict_to_adults.respect_platform", false, locked); // [DEFAULT]

/// Disable sending background HTTP requests to websites that do not respond quickly to check if they support HTTPS
pref("dom.security.https_only_mode_send_http_background_request", false);

/// Disable third-party/OS-level root certificates
// I've been torn on how to handle this, but IMO the safest way forward is disabling this functionality in Firefox
// This is commonly abused by malware/etc. and it's even overriden by certain software/garbage AV's...
// Ex. https://support.kaspersky.com/common/compatibility/14620#block3
// Since this is something programs actively try to override, I don't see a safe way to support this, so we'll lock it
// We still allow users to manually import certificates into Firefox... 
// So we can ensure users are aware of certificates they add and are making this decision consciously
// This is also important to ensure that Certificate Transparency is properly enforced, since it (`security.pki.certificate_transparency.mode`) only covers roots issued by Mozilla
// https://wiki.mozilla.org/SecurityEngineering/Certificate_Transparency#Certificate_Transparency_Support_in_Firefox
// We also set "ImportEnterpriseRoots" in policies [NO-ANDROID]
// https://mozilla.github.io/policy-templates/#certificates--importenterpriseroots [NO-ANDROID]
pref("security.certerrors.mitm.auto_enable_enterprise_roots", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("security.enterprise_roots.enabled", false, locked); // [NO-ANDROID]

//// Ensure HTTP/3 isn't disabled when/if third-party/OS-level root certificates are found
pref("network.http.http3.disable_when_third_party_roots_found", false);

/// Disable TLS 1.3 0-RTT
// Not forward secret
// https://github.com/tlswg/tls13-spec/issues/1001
pref("network.http.http3.enable_0rtt", false); // For HTTP3 https://bugzilla.mozilla.org/show_bug.cgi?id=1689550
pref("security.tls.enable_0rtt_data", false);

/// Enable (+ enforce) Certificate Transparency
// https://wiki.mozilla.org/SecurityEngineering/Certificate_Transparency
pref("security.pki.certificate_transparency.disable_for_hosts", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.disable_for_spki_hashes", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.mode", 2); // [DEFAULT - non-Nightly Android]

/// Enable CRLite revocation checks (and prioritize over OCSP)
// https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/
pref("security.pki.crlite_channel", "default"); // [DEFAULT - non-Android] Use CRLite clubcards that contain all revocations, instead of just "priority" revocations
pref("security.pki.crlite_mode", 2); // [DEFAULT - Nightly]
pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT - non-Android]

/// Enable Delegated Credentials
// https://wikipedia.org/wiki/Delegated_credential
pref("security.tls.enable_delegated_credentials", true); // [DEFAULT]

/// Enable MITM Detection
// https://github.com/arkenfox/user.js/issues/740
// https://bugzilla.mozilla.org/show_bug.cgi?id=1529643
pref("security.certerrors.mitm.priming.enabled", true); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]
pref("security.certerrors.mitm.priming.endpoint", "https://mitmdetection.services.mozilla.com/"); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]

/// Enable OCSP stapling
// https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
// https://blog.cloudflare.com/high-reliability-ocsp-stapling/#ocsp-must-staple
pref("security.ssl.enable_ocsp_must_staple", true); // [DEFAULT]
pref("security.ssl.enable_ocsp_stapling", true); // [DEFAULT]

/// Enable Post Quantum Key Agreement (Kyber)
pref("media.webrtc.enable_pq_dtls", true); // [DEFAULT]
pref("media.webrtc.enable_pq_hybrid_kex", true); // [NIGHTLY] [DEFAULT]
pref("media.webrtc.send_mlkem_keyshare", true); // [NIGHTLY] [DEFAULT]
pref("network.http.http3.enable_kyber", true); // [DEFAULT - non-Android]
pref("security.tls.client_hello.send_p256_keyshare", true); // [DEFAULT]
pref("security.tls.enable_kyber", true); // [DEFAULT - non-Android]

/// Enable prompts for unsafe HTTP redirects
// https://searchfox.org/firefox-main/rev/16707ce1/modules/libpref/init/all.js#1189
// https://bugzilla.mozilla.org/show_bug.cgi?id=677754
// https://searchfox.org/firefox-main/rev/16707ce1/netwerk/protocol/http/nsHttpChannel.cpp#3687
pref("network.http.prompt-temp-redirect", true);

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning
pref("security.cert_pinning.enforcement_level", 2);

/// Enforce TLS 1.3 downgrade protection
// https://bugzilla.mozilla.org/show_bug.cgi?id=1576790
pref("security.tls.hello_downgrade_check", true); // [DEFAULT]

/// Enforce using HTTPS as much as possible
pref("dom.securecontext.allowlist", ""); // [HIDDEN] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/dom/security/nsMixedContentBlocker.cpp#270
pref("dom.security.https_first", true);
pref("dom.security.https_first_for_custom_ports", true); // [DEFAULT] DEFENSE IN DEPTH
pref("dom.security.https_first_for_local_addresses", true);
pref("dom.security.https_first_for_unknown_suffixes", true);
pref("dom.security.https_first_pbm", true); // [DEFAULT]
pref("dom.security.https_first_schemeless", true);
pref("dom.security.https_only_mode", true);
pref("dom.security.https_only_mode", true, locked); // [NO-ANDROID] [NO-MAIL] Locked for Desktop due to being a critical privacy/security feature, but not locked for Android/Thunderbird since it's unfortunately not yet possible to add exceptions there - https://gitlab.com/ironfox-oss/IronFox/-/issues/48
pref("dom.security.https_only_mode.upgrade_local", true);
pref("dom.security.https_only_mode_pbm", true);
pref("dom.security.https_only_mode_pbm", true, locked); // [NO-ANDROID] [NO-MAIL] Locked for Desktop due to being a critical privacy/security feature, but not locked for Android/Thunderbird since it's unfortunately not yet possible to add exceptions there - https://gitlab.com/ironfox-oss/IronFox/-/issues/48
pref("security.mixed_content.block_active_content", true);
pref("security.mixed_content.block_display_content", false); // [DEFAULT] Unnecessary with the "security.mixed_content.upgrade_display_content" pref - "security.mixed_content.upgrade_display_content" tries to upgrade mixed content by default and still blocks it if fails, this pref ("security.mixed_content.block_display_content") just blocks all mixed content entirely, causing unnecessary breakage for users. https://github.com/mozilla/policy-templates/issues/1141
pref("security.mixed_content.block_object_subrequest", true);
pref("security.mixed_content.upgrade_display_content", true);
pref("security.mixed_content.upgrade_display_content.audio", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.image", true); // [DEFAULT]
pref("security.mixed_content.upgrade_display_content.video", true); // [DEFAULT]

/// Ensure that the browser omits credentials when making network requests by default
// https://searchfox.org/firefox-main/rev/4dad4a9a/modules/libpref/init/StaticPrefList.yaml#13568
pref("network.fetch.systemDefaultsToOmittingCredentials", true); // [DEFAULT]

/// Ensure we use the HSTS preload list
// https://searchfox.org/firefox-main/rev/82e2435f/security/manager/ssl/nsSiteSecurityService.cpp#799
pref("network.stricttransportsecurity.preloadlist", true); // [DEFAULT]

/// If HTTPS-Only Mode is disabled in favor of HTTPS-First, prevent automatically exempting domains (to ensure we always try HTTPS first...)
pref("dom.security.https_first_add_exception_on_failure", false);

/// Only allow certificate error exceptions per-session
pref("security.certerrors.permanentOverride", false); // [HIDDEN - Android/Thunderbird]

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

pref("browser.phoenix.status", "007");

/*** 008 IMPLICIT CONNECTIONS ***/

/// Disable Early Hints (Like Cromite)
// https://github.com/uazo/cromite/blob/master/build/patches/Client-hints-overrides.patch
// https://developer.mozilla.org/docs/Web/HTTP/Status/103
// https://github.com/bashi/early-hints-explainer/blob/main/explainer.md
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

/// Disable speculative pre-connections [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_speculative-pre-connections [NO-ANDROID] [NO-MAIL]
pref("browser.places.speculativeConnect.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.speculativeConnect.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Prevent leaking single word searches to DNS provider [NO-ANDROID] [NO-MAIL]
pref("browser.fixup.dns_first_for_single_words", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Prevent middle mouse clicks from pasting clipboard contents by default
// Way too easy to accidentally press...
pref("middlemouse.paste", false);

/// Prevent middle mouse clicks on new tab button opening URLs or searches from clipboard
pref("browser.tabs.searchclipboardfor.middleclick", false);
pref("middlemouse.contentLoadURL", false); // [DEFAULT]

pref("browser.phoenix.status", "008");

/*** 009 SEARCH & URL BAR ***/

/// Allow using a different search engine in normal vs. private Windows [NO-MAIL]
pref("browser.search.separatePrivateDefault.ui.enabled", true); // [NO-MAIL]

/// Always show Punycode
// Protects against phishing & IDN Homograph Attacks
// https://wikipedia.org/wiki/IDN_homograph_attack
pref("network.IDN_show_punycode", true);

/// Disable autofill/autocompletion of URLs by default [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.autoFill", false); // [NO-ANDROID] [NO-MAIL]

/// Disable the button to switch search engines when `browser.urlbar.scotchBonnet.enableOverride` is `false` by default [NO-ANDROID] [NO-MAIL]
// Currently broken [NO-ANDROID] [NO-MAIL]
// https://windowsreport.com/firefox-tests-dedicated-address-bar-button-for-easier-search-engine-switching/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/themes/shared/identity-block/identity-block.css#33 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.searchModeSwitcher.featureGate", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Disable clipboard suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderClipboard.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.clipboard.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.clipboard", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Firefox's new 'Unified Trust Panel' by default [NO-ANDROID] [NO-MAIL]
// This prevents setting per-site exceptions for the built-in cookie banner blocker [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trustPanel.featureGate", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable history suggestions by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderInputHistory.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.history", false); // [NO-ANDROID] [NO-MAIL]

/// Disable quick actions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// (Ex. When searching "settings", this causes a "Manage settings" result to appear) [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/quick-actions-firefox-search-bar [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/ActionsProviderQuickActions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quickactions.showPrefs", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] UI
pref("browser.urlbar.secondaryActions.featureGate", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.urlbar.shortcuts.actions", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] `@actions` shortcut
pref("browser.urlbar.suggest.quickactions", false); // [NO-ANDROID] [NO-MAIL] suggestions

/// Disable the quick actions onboarding [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#222 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quickactions.timesToShowOnboardingLabel", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable recent search suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderRecentSearches.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.recentsearches.featureGate", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.recentsearches", false); // [NO-ANDROID] [NO-MAIL]

/// Disable search engine suggestions (Tab to search) by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderTabToSearch.sys.mjs [NO-ANDROID] [NO-MAIL]
// Way too obnoxious... [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.engines", false); // [NO-ANDROID] [NO-MAIL]

/// Disable search engine suggestion (Tab to search) onboarding results [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#574 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.tabToSearch.onboard.interactionsLeft", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable search suggestions by default
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderSearchSuggestions.sys.mjs
// `browser.search.suggest.enabled` and `browser.search.suggest.enabled.private` appear to have no impact on Android & Thunderbird, but they're still defined there by default.. so we can set them anyways
pref("browser.search.suggest.enabled", false); // [DEFAULT - Android]
pref("browser.search.suggest.enabled.private", false); // [DEFAULT]
pref("browser.urlbar.showSearchSuggestionsFirst", false); // [NO-ANDROID] [NO-MAIL] UI
pref("browser.urlbar.suggest.searches", false); // [NO-ANDROID] [NO-MAIL]

/// Disable search tips [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderSearchTips.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.searchTips.test.ignoreShowLimits", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Ensure we don't bypass checks that prevent tips from being shown https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#406
pref("browser.urlbar.tipShownCount.searchTip_onboard", 999, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Onboarding search tip https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#578
pref("browser.urlbar.tipShownCount.searchTip_redirect", 999, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Redirect search tip https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#581

/// Disable trending searches by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/use-google-trending-search-firefox-address-bar [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.trending", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trending.featureGate", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable URL trimming [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trimHttps", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trimURLs", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Display the search bar at `Customize toolbar...` [NO-ANDROID] [NO-MAIL]
pref("browser.search.widget.inNavBar", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Enable bookmark suggestions by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderBookmarkKeywords.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.bookmark", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable the calculator by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderCalculator.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.calculator", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable the new URL bar/search UI by default [NO-ANDROID] [NO-MAIL]
// Adds Unified Search button to easily switch search engines in URL Bar, among other tweaks
// https://windowsreport.com/firefox-tests-dedicated-address-bar-button-for-easier-search-engine-switching/ [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.scotchBonnet.enableOverride", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable local keyword shortcuts by default [NO-ANDROID] [NO-MAIL]
// (ex. `@bookmarks` for searching bookmarks) [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderRestrictKeywords.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarView.sys.mjs#3107 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#403 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.searchRestrictKeywords.featureGate", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Enable open tab suggestions by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderOpenTabs.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.openpage", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable rich suggestions by default [NO-ANDROID] [NO-MAIL]
// (Ex. this displays images and additional info alongside suggestions from Google) [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#386 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.richSuggestions.featureGate", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable the Rust-based Search Engine Selector
// https://bugzilla.mozilla.org/show_bug.cgi?id=1914143
pref("browser.search.rustSelector.featureGate", true); // [DEFAULT]

/// Enable the "Search in Private Window" result by default [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/search/SearchService.sys.mjs#1228 [NO-MAIL]
pref("browser.search.separatePrivateDefault.urlbarResult.enabled", true); // [NO-MAIL] [HIDDEN]

/// Enable shortcut suggestions by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderTopSites.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.topsites", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable suggestions to add/use search engines on OpenSearch-compatible sites by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#83 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/ActionsProviderContextualSearch.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.contextualSearch.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable unit conversion by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderUnitConversion.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.unitConversion.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Ensure the default search engine is set to DuckDuckGo [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.placeholderName", "DuckDuckGo"); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.placeholderName.private", "DuckDuckGo"); // [NO-ANDROID] [NO-MAIL]

/// Exclude JavaScript URLS from results [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.filter.javascript", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Expose the pref to enable debug badges in the `about:config`, but do not enable by default [NO-ANDROID] [NO-MAIL]
// (Ex. labels adaptive history results with "A" and semantic history results with "S") [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/themes/shared/urlbarView.css#361 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.showDebuggingIcons", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Expose the UI to add custom search engines at `about:preferences#search` [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.update2.engineAliasRefresh", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Expose the UI to switch search engines for individual searches [NO-ANDROID] [NO-MAIL]
// "This time, search with..." [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarSearchOneOffs.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#392 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.scotchBonnet.disableOneOffs", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Highlight domains and other styling [NO-ANDROID] [NO-MAIL]
// Protects against phishing [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/docs/preferences.rst#138 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.formatting.enabled", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// If search suggestions are enabled, use OHTTP for superior privacy
// Currently only supports Google
// https://searchfox.org/firefox-main/rev/4258ca07/toolkit/components/search/SearchSuggestionController.sys.mjs#545
// https://searchfox.org/firefox-main/rev/4258ca07/toolkit/components/nimbus/FeatureManifest.yaml#357
pref("browser.search.suggest.ohttp.enabled", true); // [DEFAULT - non-Firefox Desktop]
pref("browser.search.suggest.ohttp.featureGate", true); // [HIDDEN - non-Firefox Desktop]

/// If URL trimming is enabled, untrim on user interaction [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.untrimOnUserInteraction.featureGate", true); // [NO-ANDROID] [NO-MAIL]

/// Notify users if their default search engine has been removed
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/search/SearchService.sys.mjs#2030
pref("browser.search.removeEngineInfobar.enabled", true); // [DEFAULT]

/// Show full URLs instead of search terms [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.restyleSearches", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.urlbar.showSearchTerms.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.showSearchTerms.featureGate", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Use the same search engine in normal and private browsing windows by default
// (DuckDuckGo for us)
pref("browser.search.separatePrivateDefault", false);

pref("browser.phoenix.status", "009");

/*** 010 DNS ***/

/// Customize list of built-in DoH resolvers [NO-ANDROID] [NO-MAIL]
pref("doh-rollout.provider-list", '[{"uri":"https://dns.quad9.net/dns-query","UIName":"Quad9 🇨🇭","autoDefault":true},{"uri":"https://dns.adguard-dns.com/dns-query","UIName":"AdGuard 🇨🇾","autoDefault":false},{"uri":"https://unfiltered.adguard-dns.com/dns-query","UIName":"AdGuard (Unfiltered) 🇨🇾","autoDefault":false},{"uri":"https://mozilla.cloudflare-dns.com/dns-query","UIName":"Cloudflare 🇺🇸","autoDefault":false},{"uri":"https://security.cloudflare-dns.com/dns-query","UIName":"Cloudflare (Malware Protection) 🇺🇸","autoDefault":false},{"uri":"https://noads.joindns4.eu/dns-query","UIName":"DNS4EU (Ad Blocking) 🇨🇿","autoDefault":false},{"uri":"https://protective.joindns4.eu/dns-query","UIName":"DNS4EU (Protective) 🇨🇿","autoDefault":false},{"uri":"https://unfiltered.joindns4.eu/dns-query","UIName":"DNS4EU (Unfiltered) 🇨🇿","autoDefault":false},{"uri":"https://base.dns.mullvad.net/dns-query","UIName":"Mullvad (Base) 🇸🇪","autoDefault":false},{"uri":"https://dns.mullvad.net/dns-query","UIName":"Mullvad (Unfiltered) 🇸🇪","autoDefault":false},{"uri":"https://firefox.dns.nextdns.io/","UIName":"NextDNS 🇺🇸","autoDefault":false},{"uri":"https://wikimedia-dns.org/dns-query","UIName":"Wikimedia 🇺🇸","autoDefault":false}]'); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable DoH Connectivity Checks
pref("network.connectivity-service.DNS_HTTPS.domain", "");
pref("network.trr.confirmationNS", "skip");
pref("network.trr.skip-check-for-blocked-host", true); // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#1062

/// Disable EDNS Client Subnet (ECS) to prevent leaking general location data to authoritative DNS servers...
// https://wikipedia.org/wiki/EDNS_Client_Subnet
pref("network.trr.disable-ECS", true); // [DEFAULT]

/// Disable falling back to system DNS by default
pref("network.trr.retry_on_recoverable_errors", true); // https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/nsHostResolver.cpp#1351
pref("network.trr.strict_native_fallback", true); // https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/telemetry/docs/data/environment.rst#418

/// Disable nsNotifyAddrListener
// (Ex. used for disabling DoH if certain conditions are met)
// https://searchfox.org/firefox-main/source/netwerk/system/win32/nsNotifyAddrListener.cpp
pref("network.notify.changed", false);
pref("network.notify.checkForNRPT", false);
pref("network.notify.checkForProxies", false);
pref("network.notify.dnsSuffixList", false);
pref("network.notify.initial_call", false);
pref("network.notify.IPv6", false); // [DEFAULT - Windows]
pref("network.notify.resolvers", false);

/// Enable DNS Rebinding Protection
// (Some like ex. LibreWolf set this to `true`...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1672528
pref("network.trr.allow-rfc1918", false); // [DEFAULT]

/// Enable DoH without fallback & Set to Quad9 by default
pref("network.trr.default_provider_uri", "https://dns.quad9.net/dns-query");
pref("network.trr.mode", 3);

/// Enable EncryptedClientHello
// https://blog.cloudflare.com/announcing-encrypted-client-hello
pref("network.dns.echconfig.enabled", true); // [DEFAULT]
pref("network.dns.http3_echconfig.enabled", true); // [DEFAULT]

/// Enable native DNS HTTPS Lookups
pref("network.dns.native_https_query", true); // [DEFAULT - non-macOS]

/// Enable TLS SNI Slicing
// Useful for circumenting certain forms of censorship, ex. from the Great Firewall of China
// https://github.com/uazo/cromite/issues/2403
// https://github.com/net4people/bbs/issues/505
// https://searchfox.org/firefox-main/diff/cb527813/modules/libpref/init/StaticPrefList.yaml#15350
pref("network.http.http3.sni-slicing", true); // [DEFAULT]

/// Ensure we clear cache upon changing DoH prefs
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#440
pref("network.trr.clear-cache-on-pref-change", true); // [DEFAULT]

/// Expose the DoH bootstrap pref, but don't configure by default
// This is the DNS server Firefox uses to resolve the address of your DoH server
// By default, Firefox just uses the system DNS
// This value MUST match the address of the DoH server you're using
// Ex. you could set this to "9.9.9.9" for Quad9
// We won't configure this by default to prevent unexpected breakage for users when switching DNS providers, but it's hidden - so we can at least expose it in the about:config
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRService.cpp#903
pref("network.trr.bootstrapAddr", ""); // [HIDDEN] [DEFAULT]

/// Fix IPv6 connectivity when DoH is enabled
// https://codeberg.org/divested/brace/pulls/5
pref("network.dns.preferIPv6", true);

/// Prevent bypassing DoH for /etc/HOSTS entries by default
// Protects against HOSTS file hijacking
// https://www.malwarebytes.com/blog/news/2016/09/hosts-file-hijacks
// https://www.microsoft.com/wdsi/threats/malware-encyclopedia-description?Name=SettingsModifier:Win32/HostsFileHijack
// https://www.microcenter.com/tech_center/article/6472/how-to-clean-the-windows-hosts-file-if-malware-has-tampered-with-it
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/dns/TRRServiceBase.cpp#359
pref("network.trr.exclude-etc-hosts", false);

/// Prevent sending headers for DoH requests
pref("network.trr.send_accept-language_headers", false); // [DEFAULT]
pref("network.trr.send_empty_accept-encoding_headers", true); // [DEFAULT]
pref("network.trr.send_user-agent_headers", false); // [DEFAULT]


pref("browser.phoenix.status", "010");

/*** 011 PROXIES ***/

/// Prevent Firefox from automatically using the system's proxy configuration by default
// This is commonly abused by content filtering/monitoring/MITM software & malware (just like third-party/OS-level root certificates...)
// There are of course legitimate use cases for proxies, but those require manual set-up anyways... let's ensure the user is always in control and making the conscious decision to use a proxy (if at all)
// Also helps with performance as a bonus
// https://bugzilla.mozilla.org/show_bug.cgi?id=500983
// https://bugzilla.mozilla.org/show_bug.cgi?id=500983#c7
// https://superuser.com/questions/169303/why-are-my-browsers-suddenly-configured-to-use-a-proxy
pref("network.proxy.type", 0);

// Prevent bypasses/leakage

/// Always start proxy extensions (if installed) as soon as possible, instead of waiting for the first browser window to open
pref("extensions.webextensions.early_background_wakeup_on_request", true); // [HIDDEN - non-Android] [DEFAULT - Android]

/// Disable automatic failover from the proxy (if configured) to direct connections when certain system requests fail
// https://bugzilla.mozilla.org/show_bug.cgi?id=1720221
pref("network.proxy.failover_direct", false);

/// Disable file:///net
// https://bugzilla.mozilla.org/show_bug.cgi?id=1412081
// (This unfortunately breaks file upload on Android ATM)
pref("network.file.path_blacklist", "/net"); // [NO-ANDROID] [HIDDEN]

/// Disable GIO
// https://bugzilla.mozilla.org/1433507
pref("network.gio.supported-protocols", ""); // [HIDDEN]

/// Disable Uniform Naming Convention (UNC) file paths
// https://bugzilla.mozilla.org/1413868
pref("network.file.disable_unc_paths", true); // [HIDDEN]

/// Disable Wi-Fi Tickler
// Ex. disabled by the Proxy Bypass Protection build argument
// https://searchfox.org/firefox-main/source/netwerk/base/Tickler.h
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/base/Tickler.cpp#127
pref("network.tickle-wifi.enabled", false); // [DEFAULT - non-Android]

/// Prevent bypassing the proxy (if configured) for system connections that include the `bypassProxy` flag
// https://bugzilla.mozilla.org/show_bug.cgi?id=1732792
pref("network.proxy.allow_bypass", false);

/// Use the proxy (if configured) for remote DNS lookups
pref("network.proxy.socks_remote_dns", true);
pref("network.proxy.socks5_remote_dns", true); // [DEFAULT]

pref("browser.phoenix.status", "011");

/*** 012 WEBRTC ***/

/// Allow user to silence notifications when screen sharing
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2590
pref("privacy.webrtc.allowSilencingNotifications", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("privacy.webrtc.hideGlobalIndicator", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Always sandbox Media Transport
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/common/SandboxSettings.cpp#185
pref("media.peerconnection.mtransport_process", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Enable global toggles for muting the camera/microphone
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2595
pref("privacy.webrtc.globalMuteToggles", true); // [HIDDEN - Android]

/// Enable mDNS Host Obfuscation to prevent leaking local IP addresses
// https://bugzilla.mozilla.org/show_bug.cgi?id=1588817
pref("media.peerconnection.ice.obfuscate_host_addresses", true); // [DEFAULT - non-Android]

/// Prevent WebRTC from bypassing the proxy (if configured)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790270
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/// Warn users when attempting to switch tabs in a window being shared over WebRTC
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2599
pref("privacy.webrtc.sharedTabWarning", true); // [HIDDEN - Android/Thunderbird]

pref("browser.phoenix.status", "012");

/*** 013 MEDIA ***/

/// Add DRM notes
pref("media.eme.enabled.0.NOTE", "DRM/EME is NOT supported or recommended.");
pref("media.eme.enabled.1.NOTE", "Enabling it WILL compromise your privacy/security.");
pref("media.eme.enabled.2.NOTE", "Proceed at your own caution.");
pref("media.eme.enabled.3.NOTE", "Disable media.eme.require-app-approval if you haven't already."); // [NO-ANDROID] [NO-MAIL]
pref("media.eme.enabled.4.NOTE", "You will also need to enable GMP and a CDM."); // [NO-ANDROID] [NO-MAIL]
pref("media.eme.enabled.5.NOTE", "See media.gmp-manager.updateEnabled & media.gmp-widevinecdm.enabled."); // [NO-ANDROID] [NO-MAIL]

/// Block media autoplay by default
// https://support.mozilla.org/kb/block-autoplay
// `media.geckoview.autoplay.request.testing` is used when `media.geckoview.autoplay.request` is set to `true` (ex. on GeckoView/Fenix) - when `media.geckoview.autoplay.request` is false, `media.autoplay.default` appears to be used instead
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#12909
pref("media.autoplay.default", 5);
pref("media.geckoview.autoplay.request.testing", 2); // [DEFAULT: 0 - Follows the Autoplay site permission]

/// Configure the media autoplay blocking policy
// https://wiki.mozilla.org/Media/block-autoplay#What_strategy_does_Firefox_use_for_blocking_autoplay?
// Values are:
// 0 (Default): Sticky - Autoplay is blocked until the user interacts with a page, and is allowed indefinitely (until the user refreshes the page or navigates to a different page)
// 1: Transient - Autoplay is blocked until the user interacts with a page, BUT it is only allowed until a certain amount of time passes (controlled by `dom.user_activation.transient.timeout`)
// 2: Click-to-play - Autoplay is always blocked; media will only play on user interaction of the desired media
// 2 is ideal on paper (and we used to use that value, at least on Phoenix Extended), but it unfortunately causes breakage and prevents media from playing at all on certain websites - so I believe 1 is a nice balance/compromise
pref("media.autoplay.blocking_policy", 1);

/// Disable Encrypted Media Extensions (EME) (DRM)
// Garbage technology with privacy, security, and freedom concerns
// https://www.w3.org/TR/encrypted-media/
// https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next
// https://celenity.dev/posts/thoughts/drm/
// (For testing: https://bitmovin.com/demos/drm)
// NOTE: EME also requires Content Decryption Modules (CDMs) to function
// By default, when EME is enabled, Firefox automatically enables/installs Google Widevine on all platforms, in addition to Microsoft PlayReady on Windows
// Unlike Firefox, when EME is enabled, we don't automatically enable any CDMs (see prefs below) - instead, we allow the user to decide which CDM they prefer to use with EME, instead of making that choice for them - allowing the user to remain in control
// NOTE: The standard "media.eme.enabled" pref only disables PROPRIETARY CDMs - Firefox on Desktop also enables an additional CDM (Clear Key: https://www.w3.org/TR/encrypted-media-2/#clear-key), which is ALWAYS active, even when the EME pref is disabled... (For reference, Clear Key has previously had security vulnerabilities: https://www.mozilla.org/security/advisories/mfsa2016-77/ (Tor Browser disables Clear Key FWIW) - and while Clear Key is open source, it still implements basic content protection (such as preventing users from downloading videos... https://bugzilla.mozilla.org/show_bug.cgi?id=1136707#c18))
// BUT: To work around this, we leverage the `media.eme.require-app-approval` pref. This pref was originally intended for Android to block EME unless the user grants permission. However, when this pref is set on Desktop, since there's no way for users to grant permission to use EME like on Android, it ends up blocking EME entirely - INCLUDING Clear Key
// (For testing Clear Key: https://cpearce.github.io/mse-eme/ + https://reference.dashif.org/dash.js/latest/samples/drm/clearkey.html)
// So essentially:
// On Desktop: want to use EME, but ONLY with an open source CDM (Clear Key)? Set `media.eme.require-app-approval` to `false` and don't touch anything else. Otherwise, set `media.eme.enabled` to `true` AND `media.eme.require-app-approval` to `false`, and enable your preferred CDM(s) below
// On Android: want to use EME at all? Set `media.eme.enabled` to `true` (Do NOT touch `media.eme.require-app-approval`), and enable your preferred CDM below (Currently Android only supports Widevine)
pref("browser.eme.ui.enabled", false); // [NO-ANDROID] [NO-MAIL] UI settings/toggle
pref("media.eme.enabled", false);
pref("media.eme.require-app-approval", true); // [DEFAULT - Android] https://bugzilla.mozilla.org/show_bug.cgi?id=1620102 https://searchfox.org/firefox-main/rev/82e2435f/dom/media/eme/MediaKeySystemAccessPermissionRequest.h#17

//// Disable the Google Widevine CDM by default (if EME is enabled)
/// https://developers.google.com/widevine/drm/overview
/// NOTE: Widevine on Desktop requires Gecko Media Plugins (GMP) - which we also disable by default, see below
pref("media.gmp-widevinecdm.enabled", false); // [NO-ANDROID] [NO-MAIL]


/// Disable Gecko Media Plugins (GMP)
// This is currently only used for DRM and OpenH264 (both of which we disable)
// So this helps reduce attack surface (and unwanted network activity...)
// https://wiki.mozilla.org/GeckoMediaPlugins
// https://blog.pearce.org.nz/2019/06/firefoxs-gecko-media-plugin-eme.html
// NOTE: We previously set `media.gmp-provider.enabled` to `false`, but it turns out that pref is essentially useless... all it does is hide installed plug-ins from `about:addons` (and prevents manually triggered add-on updates from checking for GMP updates); it doesn't actually disable GMP or plug-ins installed by it, it doesn't prevent the installation or update of GMP plug-ins, etc...
// The `media.gmp-manager.updateEnabled` pref is a better fit, as it (combined with the `media.gmp-manager.allowLocalSources` pref) effectively block all GMP downloads/updates
// https://github.com/arkenfox/user.js/issues/709
pref("media.gmp-manager.updateEnabled", false); // [HIDDEN]

/// Disable GMP local sources
// When combined with `media.gmp-manager.updateEnabled`, this blocks all GMP downloads/updates
// When GMP is enabled (`media.gmp-manager.updateEnabled` set to `true`), this is still useful - as it ensures the GMP plug-ins that Firefox installs are always the latest versions available (instead of being outdated/potentially vulnerable), directly from Mozilla
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/GMPInstallManager.sys.mjs#53
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/GMPUtils.sys.mjs#180
pref("media.gmp-manager.allowLocalSources", false);

/// Disable GMP logging by default (to expose via the `about:config`)
pref("media.gmp.log.dump", false); // [HIDDEN] [DEFAULT]
pref("media.gmp.log.level", 70); // [HIDDEN] Limits logging to fatal only


/// Disable OpenH264 (in favor of hardware decoding)
// Mozilla has previously shipped outdated versions of OpenH264 - ex. 2.3.2, which was ~2 years out of date... https://github.com/cisco/openh264/releases/tag/v2.3.1
// The outdated version shipped by Mozilla was subject to a high severity CVE: https://www.cve.org/CVERecord?id=CVE-2025-27091
// https://bugzilla.mozilla.org/show_bug.cgi?id=CVE-2025-27091
// Downloads were also still distributed over standard, unencrypted HTTP for a very long time, but thankfully now do appear to be distributed over HTTPS, so at least there's that
// https://searchfox.org/firefox-main/source/toolkit/content/gmp-sources/openh264.json
pref("media.ffmpeg.allow-openh264", false); // [DEFAULT - Nightly]
pref("media.gmp-gmpopenh264.enabled", false);
pref("media.gmp-gmpopenh264.provider.enabled", false); // [LINUX-ONLY] RedHat/Fedora-specific
pref("media.gmp-gmpopenh264.visible", false); // Don't display in UI/`about:addons`
pref("media.webrtc.hw.h264.enabled", true); // [DEFAULT - Android] Enables H264 hardware decoding https://bugzilla.mozilla.org/show_bug.cgi?id=1717679

/// Enable click to play UI for certain CSS skins by default [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/blob/master/css/leptonContent.css#L223 [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/wiki/Options#defaults-6 [NO-ANDROID]
pref("userContent.player.click_to_play", true); // [NO-ANDROID] [HIDDEN]

/// If GMP is enabled (via `media.gmp-manager.updateEnabled`), ensure that installed plug-ins are visible/exposed in `about:addons`
pref("media.gmp-provider.enabled", true); // [DEFAULT - non-Thunderbird]

/// Sandbox GMP [LINUX-ONLY]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/gmp/GMPServiceParent.cpp#1039 [LINUX-ONLY]
pref("media.gmp.insecure.allow", false); // [LINUX-ONLY] [DEFAULT]

/// Validate signature when updating GMP (if enabled)
pref("media.gmp-manager.cert.checkAttributes", true); // [DEFAULT]
pref("media.gmp-manager.cert.requireBuiltIn", true); // [DEFAULT]
pref("media.gmp-manager.checkContentSignature", true); // [DEFAULT]

pref("browser.phoenix.status", "013");

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
// https://codeberg.org/rusty-snake/firefox-config/src/commit/c8c157b28aad9a52d3bca63b3152b4d11fd62093/assets/user-overrides.js#L46
// https://codeberg.org/celenity/Phoenix/issues/93
// NOTE: Unfortunately, for WebAssembly (WASM) to function, either WASM-Baseline (javascript.options.wasm_baselinejit) OR WASM-Ion (javascript.options.wasm_optimizingjit) MUST be enabled. I've chosen to disable WASM-Ion here, as I think that's the safer bet, due to it having a larger attack surface than WASM-Baseline.
pref("javascript.options.baselinejit", false); // Baseline Compiler
pref("javascript.options.ion", false); // WarpMonkey
pref("javascript.options.jithints", false); // Eager baseline hints https://bugzilla.mozilla.org/show_bug.cgi?id=1831572
pref("javascript.options.main_process_disable_jit", true); // [DEFAULT - iOS] Disable all JITs for the (critical/especially sensitive) parent process https://searchfox.org/firefox-main/rev/1c6a8b56/xpcom/build/XPCOMInit.cpp#239 https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#parent-process
pref("javascript.options.native_regexp", false); // irregexp JIT, for regex evaluation https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#8741 https://searchfox.org/firefox-main/rev/dc1c78e9/js/xpconnect/src/XPCJSContext.cpp#901
pref("javascript.options.wasm_optimizingjit", false); // WASM-Ion (BaldrMonkey)

/// Disable JPEG-XL
// https://github.com/mozilla/standards-positions/pull/1064
pref("image.jxl.enabled", false); // [DEFAULT]

/// Disable MathML
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml 
pref("mathml.disabled", true);

/// Disable shared memory allocation from the parent process to content processes
// https://searchfox.org/firefox-main/rev/dc1c78e9/modules/libpref/init/StaticPrefList.yaml#9130
// https://searchfox.org/firefox-main/rev/dc1c78e9/dom/ipc/ContentParent.cpp#2415
// (For reference, Firefox disables this alongside other JITs in Safe mode: https://searchfox.org/firefox-main/rev/dc1c78e9/js/xpconnect/src/XPCJSContext.cpp#904)
pref("javascript.options.self_hosted.use_shared_memory", false);

/// Disable SharedArrayBuffer using window.postMessage
// https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer
// https://developer.mozilla.org/docs/Web/API/Window/postMessage
// https://blog.mozilla.org/security/2018/01/03/mitigations-landing-new-class-timing-attack/
// https://github.com/tc39/ecma262/issues/1435
// By default, Firefox restricts the use of SharedArrayBuffer - this fully disables it.
pref("dom.postMessage.sharedArrayBuffer.bypassCOOP_COEP.insecure.enabled", false); // [DEFAULT]
pref("dom.postMessage.sharedArrayBuffer.withCOOP_COEP", false); // [NO-MAIL]

/// Disable WebVR/WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API
pref("permissions.default.xr", 2); // [HIDDEN - Android/Thunderbird]

/// If JIT (Ion/WarpMonkey) is disabled, also disable it for extensions
// This is the default, but it's hidden - so setting it here lets us expose it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1599226
pref("javascript.options.jit_trustedprincipals", false); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "014");

/*** 015 PASSWORDS & AUTHENTICATION ***/

/// Allow filling passwords on all websites, even if they try to block it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=956906
// https://blog.0xbadc0de.be/archives/124
pref("signon.storeWhenAutocompleteOff", true); // [DEFAULT]

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
pref("signon.formlessCapture.enabled", false); // [NO-ANDROID]
pref("signon.privateBrowsingCapture.enabled", false);

/// Disable Microsoft SSO
// https://www.microsoft.com/security/business/identity-access/microsoft-entra-single-sign-on
// https://support.mozilla.org/kb/windows-sso
pref("network.http.microsoft-entra-sso.container-enabled.0", false);
pref("network.http.microsoft-entra-sso.enabled", false); // [DEFAULT]
pref("network.http.windows-sso.container-enabled.0", false);
pref("network.http.windows-sso.enabled", false); // [DEFAULT]
pref("network.microsoft-sso-authority-list", ""); // DEFENSE IN DEPTH

/// Disable NTLM
// https://www.silverfort.com/blog/understanding-the-security-risks-of-ntlm/
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://mozilla.github.io/policy-templates/#authentication
pref("network.auth.force-generic-ntlm", false); // [DEFAULT]
pref("network.auth.force-generic-ntlm-v1", false); // [DEFAULT]
pref("network.automatic-ntlm-auth.allow-non-fqdn", false); // [DEFAULT]
pref("network.automatic-ntlm-auth.allow-proxies", false);
pref("network.automatic-ntlm-auth.trusted-uris", ""); // [DEFAULT]

/// Disable NTLM/SPNEGO SSO in Private Browsing
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://mozilla.github.io/policy-templates/#authentication
pref("network.auth.private-browsing-sso", false); // [DEFAULT] [DEFENSE IN DEPTH]

/// Disable Password Manager by default - Insecure & unencrypted
// You should instead use a proper solution (ex. Bitwarden)
// https://www.wired.com/2016/08/browser-password-manager-probably-isnt-enough/
// https://support.mozilla.org/kb/manage-your-logins-firefox-password-manager
// https://wiki.mozilla.org/Firefox/Features/Form_Autofill
pref("browser.preferences.config_warning.warningPasswordManager.dismissed", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] By default, when `privacy.ui.status_card` is enabled, Firefox displays a warning (at `about:preferences#privacy`) when the password manager is disabled, and encourages users to re-enable it due to it affecting "privacy and security". This warning is inaccurate/questionable; we disable this intentionally, and shouldn't nag users to re-enable it.
pref("extensions.formautofill.addresses.enabled", false);
pref("extensions.formautofill.addresses.supported", "on"); // This feature is currently only exposed in certain regions by default. We set the browser's region to a dummy value ("XX"), so we need to skip that region check and ensure this is always available.
pref("extensions.formautofill.creditCards.enabled", false);
pref("extensions.formautofill.creditCards.supported", "on"); // [DEFAULT]
pref("signon.rememberSignons", false); // [NO-MAIL]

/// Disable password truncation
// https://www.ghacks.net/2020/05/18/firefox-77-wont-truncate-text-exceeding-max-length-to-address-password-pasting-issues/
pref("editor.truncate_user_pastes", false);

/// Disable SPNEGO
// https://www.ibm.com/think/x-force/critical-remote-code-execution-vulnerability-spnego-extended-negotiation-security-mechanism
// https://htmlpreview.github.io/?https://github.com/mdn/archived-content/blob/main/files/en-us/mozilla/integrated_authentication/raw.html
// https://people.redhat.com/mikeb/negotiate/
// https://mozilla.github.io/policy-templates/#authentication
pref("network.negotiate-auth.allow-non-fqdn", false); // [DEFAULT]
pref("network.negotiate-auth.allow-proxies", false);
pref("network.negotiate-auth.delegation-uris", ""); // [DEFAULT]
pref("network.negotiate-auth.trusted-uris", ""); // [DEFAULT] Modified by ex. RedHat/Fedora

/// Enable alerts for breached and vulnerable passwords (if the Password Manager is enabled) by default [NO-ANDROID] [NO-MAIL]
// Harmless, never sends passwords or sensitive data to Mozilla [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/firefox-password-manager-alerts-breached-websites [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/mozilla-monitor-faq#w_does-mozilla-monitor-know-my-passwords [NO-ANDROID] [NO-MAIL]
// https://blog.mozilla.org/security/2018/06/25/scanning-breached-accounts-k-anonymity/ [NO-ANDROID] [NO-MAIL]
pref("signon.management.page.breach-alerts.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("signon.management.page.vulnerable-passwords.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable anti-spoof confirmation prompts
pref("network.auth.confirmAuth.enabled", true);

/// Enable strong password generation (if the Password Manager is enabled) by default
pref("signon.generation.enabled", true); // [DEFAULT]

/// If the PaymentRequest API is enabled, ensure we always require user interaction...
pref("dom.payments.request.user_interaction_required", true); // [DEFAULT]

/// Prevent cross-origin sub-resources from opening HTTP authentication dialogs to protect against phishing
// (Meaning dialogs for embedded items are only presented when originating from the same site)
// https://support.mozilla.org/questions/1245144
pref("network.auth.non-web-content-triggered-resources-http-auth-allow", false); // [NO-MAIL] [DEFAULT - non-Thunderbird]
pref("network.auth.subresource-http-auth-allow", 1); // [NO-MAIL]
pref("network.auth.subresource-img-cross-origin-http-auth-allow", false); // [DEFAULT - non-Thunderbird]

/// Protect against password spoofing for cross-domain auth requests [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=791594 [NO-ANDROID] [NO-MAIL]
pref("privacy.authPromptSpoofingProtection", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

pref("browser.phoenix.status", "015");

/*** 016 EXTENSIONS ***/

/// Allow enabling/disabling extensions per-container (if containers are enabled)
// This could allow for some extremely useful use-cases...
// Ex. With the Multi-Account Containers extension, you could use this to only allow certain extensions to access certain websites, regardless of the extension's permissions
pref("extensions.userContextIsolation.defaults.restricted", "[]"); // [HIDDEN] [DEFAULT]
pref("extensions.userContextIsolation.enabled", true); // [HIDDEN]

/// Allow certain trustworthy extensions to run on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.{290ce447-2abb-4d96-8384-7256dd4a1c43}", true); // Runet Censorship Bypass
pref("extensions.quarantineIgnoredByUser.{446900e4-71c2-419f-a6a7-df9c091e268b}", true); // Bitwarden
pref("extensions.quarantineIgnoredByUser.{5d0d1f87-5991-42d3-98c3-54878ead1ed1}", true); // Censor Tracker
pref("extensions.quarantineIgnoredByUser.{6c00218c-707a-4977-84cf-36df1cef310f}", true); // Port Authority
pref("extensions.quarantineIgnoredByUser.{73a6fe31-595d-460b-a920-fcc0f8843232}", true); // NoScript
pref("extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true); // LocalCDN
pref("extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true); // Mullvad
pref("extensions.quarantineIgnoredByUser.78272b6fa58f4a1abaac99321d503a20@proton.me", true); // Proton Pass
pref("extensions.quarantineIgnoredByUser.adguard-vpn@adguard.com", true); // AdGuard VPN
pref("extensions.quarantineIgnoredByUser.adguardadblocker@adguard.com", true); // AdGuard
pref("extensions.quarantineIgnoredByUser.crxviewer-firefox@robwu.nl", true); // Extension source viewer - important since we add AMO (`addons.mozilla.org`) to our restricted/quarantined domain list
pref("extensions.quarantineIgnoredByUser.foxyproxy@eric.h.jung", true); // FoxyProxy
pref("extensions.quarantineIgnoredByUser.foxyproxy-basic@eric.h.jung", true); // FoxyProxy Basic
pref("extensions.quarantineIgnoredByUser.idcac-pub@guus.ninja", true); // I still don't care about cookies
pref("extensions.quarantineIgnoredByUser.jid1-BoFifL9Vbdl2zQ@jetpack", true); // Decentraleyes
pref("extensions.quarantineIgnoredByUser.jid1-KtlZuoiikVfFew@jetpack", true); // GNU LibreJS
pref("extensions.quarantineIgnoredByUser.jid1-MnnxcxisBPnSXQ@jetpack", true); // Privacy Badger
pref("extensions.quarantineIgnoredByUser.jid1-MnnxcxisBPnSXQ-eff@jetpack", true); // Privacy Badger (from eff.org)
pref("extensions.quarantineIgnoredByUser.keepassxc-browser@keepassxc.org", true); // KeePassXC-Browser
pref("extensions.quarantineIgnoredByUser.skipredirect@sblask", true); // Skip Redirect
pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true); // uBlock Origin
pref("extensions.quarantineIgnoredByUser.uBOLiteRedux@raymondhill.net", true); // uBlock Origin Lite
pref("extensions.quarantineIgnoredByUser.vpn@proton.ch", true); // Proton VPN
pref("extensions.quarantineIgnoredByUser.@testpilot-containers", true); // Firefox Multi-Account Containers

/// Always allow installing "incompatible" add-ons
// Especially useful on Android & Thunderbird...
pref("extensions.strictCompatibility", false); // [DEFAULT - non-Thunderbird Release/Beta]

/// Always run extensions OOP (out of process...)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1613141
// https://bugzilla.mozilla.org/show_bug.cgi?id=1880856
// https://groups.google.com/g/tb-planning/c/p4MUTMNYBVo
pref("extensions.webextensions.remote", true); // [DEFAULT]

/// Block extensions signed with weak signature algorithms [NO-MAIL]
pref("xpinstall.signatures.weakSignaturesTemporarilyAllowed", false); // [NO-MAIL] [HIDDEN] [DEFAULT]

/// Clear default list of sites allowed to install add-ons
pref("xpinstall.whitelist.add", "", locked); // [HIDDEN - non-Android] [DEFAULT - non-Android]


/// Disable add-on sideloading
// Only allows installing extensions from profile & application directories (Prevents extensions being installed from the system/via other software)
// https://archive.is/DYjAM
// https://support.mozilla.org/kb/deploying-firefox-with-extensions
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/AddonSettings.sys.mjs#125
pref("extensions.autoDisableScopes", 15, locked); // [DEFAULT - non-Thunderbird] Defense in depth, ensures sideloaded extensions are always disabled by default...
pref("extensions.enabledScopes", 5); // [HIDDEN]
pref("extensions.installDistroAddons", false); // [HIDDEN - non-Android] [DEFAULT - Android]
pref("extensions.sideloadScopes", 0); // [HIDDEN]
pref("extensions.startupScanScopes", 0); // [HIDDEN - Android] [DEFAULT - non-Thunderbird]

/// Disable the AMO Abuse Report API (`navigator.mozAddonManager.reportAbuse`)
// This depends on mozAddonManager anyways, which we disable below
// Users can still report add-ons from within Firefox using the standard form (`extensions.addonAbuseReport.url`), this just prevents using the API from the browser itself directly
// https://mozilla.github.io/addons-server/topics/api/abuse.html
pref("extensions.addonAbuseReport.url", "");

/// Disable installation of add-ons by default [DESKTOP]
// We also reset this per-session by setting it as a user pref in `phoenix-user-pref.cfg` [DESKTOP]
// Includes extensions and themes
// Does NOT apply to Android's `Recommended` extensions (collections) found at `Settings` -> `Advanced` -> `Extensions`
// This doesn't impact already installed add-ons and add-ons installed by policies
// Firefox (on Desktop) and Thunderbird will prompt to re-enable this when necessary
// Unfortunately Android doesn't have a prompt like this :( - so we won't disable this by default there - but we'll still set the pref to `true` to expose it via the `about:config` 
// We're also setting this as a user pref, which is quite nice from a security perspective - as it allows users to enable this functionality only when it's necessary...
// Ex: A user attempts to install an extension, sees the extra prompt/warning, and selects `Enable` (which temporarily sets this pref to `true`...). The user then proceeds to install the extension. On the next launch of Firefox/Thunderbird, this pref is reset back to `false`, meaning the ability to install extensions is fully disabled without them even thinking about it
pref("xpinstall.enabled", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] So the default is `false`

/// Disable mozAddonManager
// mozAddonManager has various privacy (fingerprinting) and security (added attack surface) concerns.
// It also bypasses the permission prompt to install add-ons, and prevents add-ons (like uBlock Origin) from working on `addons.mozilla.org` (`addons.thunderbird.net` for Thunderbird).
// Note that disabling mozAddonManager unfortunately breaks installation of extensions from `addons.mozilla.org` on Android. It also typically breaks installation of extensions from `addons.thunderbird.net` on Thunderbird as well, but we have a clever work-around for Dove.
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
// https://github.com/thunderbird/addons-server/issues/332
pref("extensions.webapi.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("extensions.webapi.testing", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains
pref("extensions.webapi.testing.http", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains using insecure protocols
pref("privacy.resistFingerprinting.block_mozAddonManager", true); // [NO-ANDROID] [NO-MAIL]

/// Enable Add-on Distribution Control (Install Origins)
// Prevents extensions being installed from websites that they don't specify in their manifest
// https://groups.google.com/g/firefox-dev/c/U7GpHE4R-ZY
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#341
pref("extensions.install_origins.enabled", true);

/// Enable optional permission prompts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1392176
pref("extensions.webextOptionalPermissionPrompts", true); // [DEFAULT]

/// Enable Mozilla's Extension Blocklist
pref("extensions.blocklist.enabled", true); // [DEFAULT]

/// Enable Manifest V3
// https://blog.mozilla.org/addons/2022/05/18/manifest-v3-in-firefox-recap-next-steps/
pref("extensions.manifestV3.enabled", true); // [DEFAULT]

/// Enable restricted/quarantined domains by default, and use our own list instead of Mozilla's
// Mozilla's list unfortunately hasn't been updated in ~2 years (FWIW: Our list includes all of their entries in addition to our own)
// We can use this to prevent less trustworthy add-ons from running on sensitive websites, while still allowing important/legitimate ones and content blockers (like uBlock Origin) to run on them
// Also useful, since we disable Mozilla's restrictions on certain domains that prevent ALL extensions from running on them (like AMO) - so we can add back some level of protection there
// Domains we add here can include downloads for add-ons/software, payment/banking, medical/health, password managers, sign-in pages, file storage, etc.
// Firefox on Desktop also shows a UI when the user is on a restricted domain, and to indicate which add-ons can't run
// https://support.mozilla.org/kb/quarantined-domains
// Mozilla's current list: https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/addons-manager-settings/changeset?_expected=0
pref("extensions.remoteSettings.disabled", true); // [HIDDEN] Used for downloading/updating Mozilla's list https://searchfox.org/firefox-main/source/toolkit/mozapps/extensions/docs/AMRemoteSettings-overview.rst
pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT]
pref("extensions.quarantinedDomains.list", "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br,10.0.0.1,192.168.1.1,192.168.50.1,1password.ca,1password.com,1password.eu,365online.com,account.amd.com,account.apple.com,account.asus.com,account.brave.com,account.collegeboard.org,account.live.com,account.microcenter.com,account.microsoft.com,account.nordpass.com,account.proton.me,account.sony.com,account.t-mobile.com,account-api.proton.me,accounts.1password.ca,accounts.1password.com,accounts.1password.eu,accounts.ent.1password.com,accounts.fedoraproject.org,accounts.firefox.com,accounts.google.com,accounts.nintendo.com,accounts.pixiv.net,accounts.scdn.co,accounts.snapchat.com,accounts.spotify.com,acs-home-prod-login-fde-hhd4d2h9drbfg7hy.a02.azurefd.net,addons.allizom.org,addons.mozilla.org,addons.thunderbird.net,admin.google.com,adyen.com,agrd.io,agreementexpress.net,alipay.com,alipayobjects.com,alipayplus.com,amazon.syf.com,amazonpay.in,amp.pandora.com,anz.com,anz.com.au,ap.www.namecheap.com,apay-us.amazon.com,api.pnc.com,api.stripe.com,api-auth.soundcloud.com,app.1password.ca,app.1password.com,app.1password.eu,app.advancedmd.com,app.dashlane.com,app.privacy.com,app.tuta.com,appleconnect.apple.com,appleid.apple.com,appleid.cdn-apple.com,applepay.cdn-apple.com,apply.commonapp.org,apps.apple.com,apps.microsoft.com,apps.obtainium.imranr.dev,api-dashboard.search.brave.com,apt.izzysoft.de,archive.mozilla.org,archlinux.org,argenta.be,artists.soundcloud.com,artists.spotify.com,asrock.com,asrockchina.com.cn,assets.loginwithamazon.com,att-yahoo.att.net,attestation.app,aur.archlinux.org,auth.adguard.io,auth.adguardaccount.com,auth.hulu.com,auth.meta.com,auth.max.com,auth.mozilla.auth0.com,auth.openai.com,auth.services.adobe.com,auth.sharefile.io,auth.synchronybank.com,auth.uber.com,auth.wikimedia.org,auth.zennioptical.com,b.stripecdn.com,bancogalicia.com.ar,bank99.at,bankaust.com.au,bankaustria.at,bankdirekt.at,bankeasy.com,bankofamerica.com,bankofireland.com,bankvic.com.au,belfius.be,belkart.by,belveb.by,bendigobank.com.au,binance.com,binance.us,bisq.network,bitpay.com,bitwarden.com,bkash.com,bnpparibasfortis.be,bobpony.com,braintree-api.com,braintreegateway.com,brave.com,brave-browser-apk-beta.s3.brave.com,brave-browser-apk-nightly.s3.brave.com,brave-browser-apk-release.s3.brave.com,build.opensuse.org,businessaccess.citibank.citigroup.com,businessonline-boi.com,cakepay.com,cakewallet.com,calendar.proton.me,calyxos.org,cardcomplete.com,cash.app,cbaccount.collegeboard.org,cbzsecure.com,cdn.akamai.steamstatic.com,cdn.mullvad.net,cdn.plaid.com,cdn.sso.mozilla.com,cdimage.debian.org,checkout.com,coinspot.com.au,commbank.com.au,console.accrescent.app,console.aws.amazon.com,console.cloud.google.com,consumer.intel.com,copr.fedorainfracloud.org,creditcall.com,crelan.be,cromite.org,dash.cloudflare.com,developer.apple.com,developer.nvidia.com,discord.gg,dist.torproject.org,dl.google.com,donate.torproject.org,download.cdn.mozilla.net,download.fedoraproject.org,download.gigabyte.com,download.lineageos.org,download.mozilla.org,download-installer.cdn.mozilla.net,download-installer-origin.cdn.mozilla.net,download-origin.cdn.mozilla.net,drive.google.com,drive.proton.me,dsadata.intel.com,easybanking.unifi-digitalbanking.com,easybankint.com,ebanking.easybank.at,eff.org,ente.io,epicmychart.nychhc.org,epicmychart.optum.com,etoro.com,f-droid.org,fdroid.ironfoxoss.org,fdroid.link,fedoraproject.org,flatex.at,flathub.org,flex.okta.com,franciscanmychart.org,franklincollege.okta.com,ftp.eu.mozilla.org,ftp.mozilla.org,ftp.prod.mozaws.net,ftp.prod.mozilla.org,ftp-ssl.mozilla.org,ftp-test.mozilla.org,galicia.ar,gateway.bank,gatewaybank.bank,gatewaybank.com.au,gatewayfirst.com,gds.google.com,geogroup.okta.com,george.sparkasse.at,george-business.sparkasse.at,gfgsa.com,google-admin.corp.google.com,grapheneos.org,greasyfork.org,guardarian.com,heartland.us,heartlandpaymentsystems.com,heartlandportico.com,hellobank.be,hendrick.okta.com,hpc.freedompay.com,hsbc.com,hsbc.com.au,icard.com,id.fedoraproject.org,id.sonyentertainmentnetwork.com,id.spectrum.net,identity.corp.google.com,identity.doordash.com,identity.eset.com,identity.gtm.eset.com,identity.kde.org,identity.lego.com,identity.walmart.com,idmsa.apple.com,idmsa.apple.com.cn,idmsac.apple.com,idp.ddp.akoya.com,idp.iam.mozilla.com,iforgot.apple.com,ing.com,ing.com.au,ingwb.com,iparitet.by,itsme-id.com,js.stripe.com,kairoscope.org,kbc.be,kdrp.okta.com,keytradebank.be,klarna.com,kraken.com,laptop-updates.brave.com,lastpass.com,lineageos.org,login.aa.com,login.advancedmd.com,login.amd.com,login.aol.com,login.corp.google.com,login.disney.com,login.eset.com,login.gov,login.kroger.com,login.live.com,login.mailbox.org,login.microsoftonline.com,login.nvgs.nvidia.com,login.okta.com,login.sparkasse.at,login.tailscale.com,login.wikimedia.org,login.yahoo.com,login.yahoo.net,login.xfinity.com,login-app.advancedmd.com,login-dev.advancedmd.com,login-no1a.www.tiktok.com,login3.id.hp.com,login4.fisglobal.com,lowes.syf.com,m.stripe.com,m.stripe.network,mail.proton.me,mailbox.org,marmon.okta.com,matrix.to,mblogin.verizonwireless.com,mebank.com.au,merchant-ui-api.stripe.com,microg.org,mirrorbits.lineageos.org,linuxmint.com,login.pnc.com,molly.im,monero.com,mpay24.com,msauth.net,msauthimages.net,msdl.gravesoft.dev,msftauth.net,msftauthimages.net,msp.nordpass.com,mt-bank.net,mtb.com,mullvad.net,my.collegeboard.org,my.dish.com,my.disney.com,my.eir.ie,myaccount.google.com,myaccount.microsoft.com,myaccounts.wizards.com,mychart.albanymed.org,mychart.asante.org,mychart.atlantichealth.org,mychart.austinregionalclinic.com,mychart.azacp.com,mychart.bmc.org,mychart.carolinaeasthealth.com,mychart.ccf.org,mychart.centracare.com,mychart.childrenscolorado.org,mychart.clevelandclinic.org,mychart.crmcwy.org,mychart.duly.com,mychart.ecommunity.com,mychart.hopkinsmedicine.org,mychart.inova.org,mychart.kansashealthsystem.com,mychart.lovelace.com,mychart.mainehealth.org,mychart.med.utah.edu,mychart.metrohealth.net,mychart.multicare.org,mychart.mwhc.com,mychart.nghs.com,mychart.nortonhealthcare.org,mychart.ohiohealth.com,mychart.orlandohealth.com,mychart.premierhealthpartners.org,mychart.selfregional.org,mychart.sfdph.org,mychart.sih.net,mychart.stcharleshealthcare.org,mychart.texashealth.org,mychart.tmcaz.com,mychart.uchospitals.edu,mychart.uconn.edu,mychart.uihealthcare.org,mychart.uillinois.edu,mychart.upstate.edu,mychart.urmc.rochester.edu,mychartonline.umassmemorial.org,myhealthchart.com,mysignins.microsoft.com,mysinaichicago.org,mystate.com.au,nab.com.au,nmi.com,nordaccount.com,nordpass.com,nordstrom.okta.com,noscript.net,novantmychart.org,nrc.okta.com,oauth.xfinity.com,oidc.idp.clogin.att.com,ok1static.oktacdn.com,ok2static.oktacdn.com,ok7static.oktacdn.com,okta.jumbo.com,oldsecond.com,onedrive.com,onedrive.live.com,online.citi.com,open-banking.pnc.com,openuserjs.org,outlook.com,outlook.office365.com,ow2-cqm-01.advancedmd.com,panel.nordpass.com,paritetbank.by,pass.proton.me,passwordreset.microsoftonline.com,passwords.google,passwords.google.com,patientportal.advancedmd.com,pay.amazon.co.jp,pay.amazon.co.uk,pay.amazon.com,pay.amazon.de,pay.amazon.es,pay.amazon.eu,pay.amazon.fr,pay.amazon.it,pay.google.com,pay.viasat.com,paybox.com,paybox.com.co,payconiq.be,payeezystrg.z19.web.core.windows.net,payments.amazon.com,payments-amazon.com,payoneer.com,payscout.com,paysend.com,payu.com,paywire.com,play.google.com,plex.direct,portal.corp.google.com,poste.dz,pp-wfe-100.advancedmd.com,ppixiv.org,privacybadger.org,probo.ddp.akoya.com,prod.idp.collegeboard.org,productdelivery.mozilla-backup.org,production.plaid.com,profile.theguardian.com,proton.me,protonapps.com,psendbank.com,qdoba-prod.us.auth0.com,raiffeisen.at,rb.okta.com,register.gitlab.gnome.org,register.mailbox.org,registerdisney.go.com,release.calyxinstitute.org,releases.mozilla.org,renault-bank-direkt.de,renaultbank.es,renaultbank.fr,retoswap.com,revolut.com,rh.okta.com,rpmfusion.org,secure.chase.com,secure.informaction.com,secure.login.gov,secure.myvirtua.org,secure.pnc.com,secure.sndcdn.com,secure.soundcloud.com,secure.verizon.com,secure-api.pnc.com,secure-qa.pnc.com,securelogin.synchronybank.com,secureonline.pnc.com,secureonline.yourstatebank.com,send.vis.ee,signal.org,signin.att.com,signin.aws.amazon.com,signin.costco.com,signin.ebay.com,signin-static-js.att.com,signup.ebay.com,skydrive.com,smartpay.profitstars.com,sso.canvaslms.com,sso.fachschaften.org,sso.kroger.com,sso.mozilla.com,sso.redhat.com,start.1password.ca,start.1password.com,start.1password.eu,static.adguard.com,static.adtidy.org,stgeorge.com.au,store.epicgames.com,store.nintendo.com.hk,studio.youtube.com,tam.onecampus.com,tpeweb.paybox.com,tuta.com,u.bank,ubank.bank,ubank.com.au,ubuntu.com,unbelgin.com,unionpayintl.com,unzer.com,up.com.au,us.download.nvidia.com,usaepay.com,usbank.com,vault.bitwarden.com,vault.bitwarden.eu,venmo.com,verifone.com,viewmychart.com,vpn.proton.me,wallet.google,wallet.google.com,wallet.proton.me,wero-wallet.eu,westpac.co.nz,westpac.com.au,wiki.lineageos.org,wise.com,www.365online.com,www.chase.com,www.citi.com,www.citidirect.com,www.cromite.org,www.dashlane.com,www.debian.org,www.easybank.at,www.easybanking.net,www.eff.org,www.epicgames.com,www.firefox.com,www.franciscanmychart.org,www.gigabyte.com,www.icloud.com,www.icloud.com.cn,www.intel.com,www.lineageos.org,www.linuxmint.com,www.macquarie.com.au,www.mozilla.org,www.mychart.org,www.noscript.net,www.onlinebanking.pnc.com,www.paypal.com,www.paypalobjects.com,www.pnc.com,www.privacy.com,www.privatebank.citibank.com,www.sparkasse.at,www.synchrony.com,www.synchronymastercard.com,www.thunderbird.net,www.torproject.org,www.virustotal.com,www.wintrustbank.com,www.wintrustdigitalbanking.com,www.xmrbazaar.com,www.yourstatebank.com,xmrbazaar.com");
pref("extensions.quarantinedDomains.uiDisabled", false); // [HIDDEN] [DEFAULT] UI

/// Enable userScripts
// userScripts ran this way run in separate isolated sandboxes
// https://wiki.mozilla.org/WebExtensions/UserScripts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1875475
pref("extensions.userScripts.mv3.enabled", true); // [DEFAULT]
pref("extensions.webextensions.userScripts.enabled", true); // [DEFAULT]

/// Ensure Firefox Multi-Account Containers can access all containers by default (if installed)
pref("extensions.userContextIsolation.@testpilot-container.restricted", "[]"); // [HIDDEN]

/// Ensure uBlock Origin can access all containers by default (if installed)
pref("extensions.userContextIsolation.uBlock0@raymondhill.net.restricted", "[]"); // [HIDDEN]

/// Ensure Web Compatibility interventions use the MV3 API instead of the older MV2 one
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#4118
pref("extensions.webcompat.useScriptingAPI", true); // [DEFAULT]

/// Harden CSP policy
// Compared to Firefox's default, this:
// Blocks scripts unless they're loaded from the same origin
// Blocks unsafe eval() - including WebAssembly (WASM)
// Upgrades network requests to HTTPS
// Etc...
pref("extensions.webextensions.base-content-security-policy", "script-src 'self' 'unsafe-inline'; upgrade-insecure-requests;"); // [NO-ANDROID] `unsafe-inline` is required for Web Compatibility interventions (`about:compat`)
pref("extensions.webextensions.base-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;"); // [DEFAULT]

/// Never allow installing extensions without first prompting the user
pref("extensions.postDownloadThirdPartyPrompt", false, locked); // [HIDDEN - Android/Thunderbird] https://github.com/arkenfox/user.js/issues/1090
pref("xpinstall.whitelist.directRequest", false); // [HIDDEN] For direct URL requests https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4488
pref("xpinstall.whitelist.fileRequest", false); // [HIDDEN - non-Android] [DEFAULT - Android] For `file://` requests https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4500
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT] This is the `Warn you when websites try to install add-ons` setting at `about:preferences#privacy`

/// Only allow installation and updates of extensions using Firefox's built-in certificates by default
pref("extensions.install.requireBuiltInCerts", true); // [HIDDEN]
pref("extensions.update.requireBuiltInCerts", true); // [HIDDEN]

/// Only allow installation of signed extensions by default [NO-MAIL]
// Unfortunately not supported on Thunderbird :( [NO-MAIL]
pref("extensions.langpacks.signatures.required", true); // [NO-MAIL] [DEFAULT - non-Thunderbird]
pref("xpinstall.signatures.required", true); // [NO-MAIL] [DEFAULT - non-Thunderbird]

/// Prevent automatically granting MV3 extensions optional host permissions by default
// These permissions can still be enabled manually at `about:addons`, from the 'Permissions' tab at the extension's settings page
pref("extensions.originControls.grantByDefault", false);

/// Prevent certain undesired extensions from running on restricted/quarantined domains
// By default, Mozilla allows all add-ons they "recommend" to run on restricted/quarantined domains: https://support.mozilla.org/kb/add-on-badges#w_recommended-extensions
// This prevents some of those add-ons from running on our list of sensitive domains
pref("extensions.quarantineIgnoredByUser.{00000f2a-7cde-4f20-83ed-434fcb420d71}", false); // Imagus
pref("extensions.quarantineIgnoredByUser.{1018e4d6-728f-4b20-ad56-37578a4de76b}", false); // Flagfox
pref("extensions.quarantineIgnoredByUser.{154cddeb-4c8b-4627-a478-c7e5b427ffdf}", false); // PopUpOFF - Popup and overlay blocker
pref("extensions.quarantineIgnoredByUser.{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}", false); // Search by Image
pref("extensions.quarantineIgnoredByUser.{32af1358-428a-446d-873e-5f8eb5f2a72e}", false); // Download All Images
pref("extensions.quarantineIgnoredByUser.{3c078156-979c-498b-8990-85f7987dd929}", false); // Sidebery
pref("extensions.quarantineIgnoredByUser.{4a313247-8330-4a81-948e-b79936516f78}", false); // Image Search Options
pref("extensions.quarantineIgnoredByUser.{506e023c-7f2b-40a3-8066-bc5deb40aebe}", false); // Gesturefy
pref("extensions.quarantineIgnoredByUser.{52bda3fd-dc48-4b3d-a7b9-58af57879f1e}", false); // Stylebot
pref("extensions.quarantineIgnoredByUser.{531906d3-e22f-4a6c-a102-8057b88a1a63}", false); // SingleFile
pref("extensions.quarantineIgnoredByUser.{5384767E-00D9-40E9-B72F-9CC39D655D6F}", false); // EPUBReader
pref("extensions.quarantineIgnoredByUser.{54e2eb33-18eb-46ad-a4e4-1329c29f6e17}", false); // Block Site
pref("extensions.quarantineIgnoredByUser.{63d150c4-394c-4275-bc32-c464e76a891c}", false); // Audio Equalizer
pref("extensions.quarantineIgnoredByUser.{79b2e4de-8fb4-4ccc-b9f6-362ac2fb74b2}", false); // Measure-it
pref("extensions.quarantineIgnoredByUser.{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}", false); // Stylus
pref("extensions.quarantineIgnoredByUser.{7b1bf0b6-a1b9-42b0-b75d-252036438bdc}", false); // YouTube High Definition
pref("extensions.quarantineIgnoredByUser.{91aa5abe-9de4-4347-b7b5-322c38dd9271}", false); // Clippings
pref("extensions.quarantineIgnoredByUser.{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}", false); // User-Agent Switcher and Manager
pref("extensions.quarantineIgnoredByUser.{a9c2ad37-e940-4892-8dce-cd73c6cbbc0c}", false); // Feedbro
pref("extensions.quarantineIgnoredByUser.{b9acf540-acba-11e1-8ccb-001fd0e08bd4}", false); // Easy Youtube Video Downloader Express
pref("extensions.quarantineIgnoredByUser.{b9db16a4-6edc-47ec-a1f4-b86292ed211d}", false); // Video DownloadHelper
pref("extensions.quarantineIgnoredByUser.{c2c003ee-bd69-42a2-b0e9-6f34222cb046}", false); // Auto Tab Discard
pref("extensions.quarantineIgnoredByUser.{c5867acc-54c9-4074-9574-04d8818d53e8}", false); // Livemarks
pref("extensions.quarantineIgnoredByUser.{d07ccf11-c0cd-4938-a265-2a4d6ad01189}", false); // Web Archives
pref("extensions.quarantineIgnoredByUser.{d37dc5d0-431d-44e5-8c91-49419370caa1}", false); // FoxClocks
pref("extensions.quarantineIgnoredByUser.{DDC359D1-844A-42a7-9AA1-88A850A938A8}", false); // DownThemAll!
pref("extensions.quarantineIgnoredByUser.{de22fd49-c9ab-4359-b722-b3febdc3a0b0}", false); // Popup Blocker (strict)
pref("extensions.quarantineIgnoredByUser.{e839c3f9-298e-4cd0-99e0-464431cb7c34}", false); // Foxy Gestures
pref("extensions.quarantineIgnoredByUser.{e90f5de4-8510-4515-9f67-3b6654e1e8c2}", false); // Dictionary Anywhere
pref("extensions.quarantineIgnoredByUser.addon@darkreader.org", false); // Dark Reader
pref("extensions.quarantineIgnoredByUser.adb@mozilla.org", false, locked); // Firefox DevTools ADB Extension
pref("extensions.quarantineIgnoredByUser.ads@mozac.org", false, locked); // Mozilla Android Components - Ads Telemetry
pref("extensions.quarantineIgnoredByUser.ATBC@EasonWong", false); // Adaptive Tab Bar Color
pref("extensions.quarantineIgnoredByUser.cookies@mozac.org", false, locked); // Mozilla Android Components - Search Telemetry
pref("extensions.quarantineIgnoredByUser.copyplaintext@eros.man", false); // Copy PlainText
pref("extensions.quarantineIgnoredByUser.customscrollbars@computerwhiz", false); // Custom Scrollbars
pref("extensions.quarantineIgnoredByUser.dont-track-me-google@robwu.nl", false); // Don't track me Google
pref("extensions.quarantineIgnoredByUser.ddg@search.mozilla.org", false, locked); // DuckDuckGo - search engine
pref("extensions.quarantineIgnoredByUser.deArrow@ajay.app", false); // DeArrow
pref("extensions.quarantineIgnoredByUser.emoji@saveriomorelli.com", false); // Emoji
pref("extensions.quarantineIgnoredByUser.firefox@ghostery.com", false); // Ghostery
pref("extensions.quarantineIgnoredByUser.foxytab@eros.man", false); // Ghostery
pref("extensions.quarantineIgnoredByUser.jid0-dsq67mf5kjjhiiju2dfb6kk8dfw@jetpack", false); // FoxyTab
pref("extensions.quarantineIgnoredByUser.jid1-KdTtiCj6wxVAFA@jetpack", false); // Swift Selection Search
pref("extensions.quarantineIgnoredByUser.jid1-q4sG8pYhq8KGHs@jetpack", false); // AdBlocker for YouTube™
pref("extensions.quarantineIgnoredByUser.jid1-QoFqdK4qzUfGWQ@jetpack", false); // Dark Background and Light Text
pref("extensions.quarantineIgnoredByUser.juraj.masiar@gmail.com_ScrollAnywhere", false); // ScrollAnywhere
pref("extensions.quarantineIgnoredByUser.languagetool-webextension@languagetool.org", false); // LanguageTool
pref("extensions.quarantineIgnoredByUser.leechblockng@proginosko.com", false); // LeechBlock NG
pref("extensions.quarantineIgnoredByUser.linkgopher@oooninja.com", false); // Link Gopher
pref("extensions.quarantineIgnoredByUser.printedit-we@DW-dev", false); // Print Edit WE
pref("extensions.quarantineIgnoredByUser.s3download@statusbar", false); // Download Manager (S3)
pref("extensions.quarantineIgnoredByUser.simple-tab-groups@drive4ik", false); // Simple Tab Groups
pref("extensions.quarantineIgnoredByUser.snaplinks@snaplinks.mozdev.org", false); // Snap Links
pref("extensions.quarantineIgnoredByUser.soundfixer@unrelenting.technology", false); // SoundFixer
pref("extensions.quarantineIgnoredByUser.sponsorBlocker@ajay.app", false); // SponsorBlock
pref("extensions.quarantineIgnoredByUser.stefanvandamme@stefanvd.net", false); // Turn Off the Lights
pref("extensions.quarantineIgnoredByUser.tabby@whatsyouridea.com", false); // Tabby - Window and Tab Manager
pref("extensions.quarantineIgnoredByUser.tranquility@ushnisha.com", false); // Tranquility Reader
pref("extensions.quarantineIgnoredByUser.treestyletab@piro.sakura.ne.jp", false); // Tree Style Tabs
pref("extensions.quarantineIgnoredByUser.wikipedia@search.mozilla.org", false, locked); // Wikipedia (en) - search engine
pref("extensions.quarantineIgnoredByUser.worldwide@radio", false); // Worldwide Radio
pref("extensions.quarantineIgnoredByUser.zoompage-we@DW-dev", false); // Zoom Page WE

/// Prevent certain undesired websites from prompting to install add-ons by default
pref("xpinstall.blacklist.add.GNU", "gnuzilla.gnu.org"); // Mozzarella - Hosts very outdated versions of extensions...

/// Prevent extensions from opening pop-ups to remote websites
// https://bugzilla.mozilla.org/show_bug.cgi?id=1760608
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/extensions/ExtensionActions.sys.mjs#286
pref("extensions.manifestV2.actionsPopupURLRestricted", true); // [DEFAULT - Android]

/// Prevent extensions from opening pop-ups without user interaction
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/extensions/parent/ext-browserAction.js#1071
// https://searchfox.org/firefox-main/rev/82e2435f/mobile/shared/components/extensions/ext-browserAction.js#184
pref("extensions.openPopupWithoutUserGesture.enabled", false); // [DEFAULT - non-Nightly]

/// Prevent extensions from using the Gecko Profiler
// Includes certain Mozilla extensions by default
// https://firefox-source-docs.mozilla.org/tools/profiler/index.html
pref("extensions.geckoProfiler.acceptedExtensionIds", ""); // [HIDDEN - Android] [DEFAULT - Android]

/// Prevent recommending search extensions [NO-ANDROID] [NO-MAIL]
// This is the "Find more search engines" link at `about:preferences#search` [NO-ANDROID] [NO-MAIL]
// If users want to add more search engines, they should add them manually using the `Add` button - or directly from the URL bar on the desired search engine. Let's not encourage them to install add-ons that are both unnecessary, and will directly compromise their privacy and security in most cases. [NO-ANDROID] [NO-MAIL]
pref("browser.search.searchEnginesURL", ""); // [NO-ANDROID] [NO-MAIL]

/// Prevent unprivileged extensions from accessing experimental APIs by default
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", false); // [DEFAULT - non-Thunderbird]

/// Prevent hiding extensions [NO-ANDROID]
pref("devtools.aboutdebugging.showHiddenAddons", true, locked); // [NO-ANDROID]

/// Require resources loaded by MV2 extensions to be specified under web_accessible_resources in the extension's manifest
// (This is the default for MV3)
// https://developer.chrome.com/docs/extensions/reference/manifest/web-accessible-resources
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#6013
// https://searchfox.org/firefox-main/rev/82e2435f/caps/nsScriptSecurityManager.cpp#723
pref("extensions.content_web_accessible.enabled", true);

/// Require secure origins to install add-ons
pref("extensions.install.requireSecureOrigin", true); // [HIDDEN]

pref("browser.phoenix.status", "016");

/*** 017 AI ***/

/// Allow managing models from `about:addons`
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/ModelHubProvider.sys.mjs#18
pref("extensions.htmlaboutaddons.local_model_management", true); // [DEFAULT]

/// Allow typing a custom AI chat prompt based on your selection (if pop-up when highlighting text is enabled) [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.shortcuts.custom", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Control the Firefox "AI" (Local machine learning) Runtime
// https://firefox-source-docs.mozilla.org/toolkit/components/ml/index.html
// On desktop, we need to keep this enabled, as it's required for certain legitimate functionality,
// such as PDF.js alt text image generation
// On Android and Thunderbird, the legitimate features aren't implemented, so we can disable it entirely
// Note that, even when this is enabled,
// we don't actually enable/install any AI models/functionality by default
pref("browser.ml.enable", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable AI Chat [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/ai-chatbot [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.menu", false); // [NO-ANDROID] [NO-MAIL] Same issue as `browser.ml.chat.page`, this also doesn't seem to be covered by `browser.ml.chat.enabled` :/ https://github.com/mozilla/policy-templates/issues/1230#issuecomment-3412973906
pref("browser.ml.chat.page", false); // [NO-ANDROID] [NO-MAIL] This disables the "Ask AI Chatbot" context menu item - for some reason this isn't covered by `browser.ml.chat.enabled`, and I'm only seeing it on my YouTube specialized config profile? https://bugzilla.mozilla.org/show_bug.cgi?id=1994785
pref("browser.ml.chat.sidebar", false); // [NO-ANDROID] [NO-MAIL]

/// Disable AI/ML Autofill [NO-ANDROID]
// https://searchfox.org/firefox-esr140/source/toolkit/components/formautofill/MLAutofill.sys.mjs [NO-ANDROID]
pref("extensions.formautofill.ml.experiment.enabled", false); // [NO-ANDROID] [ESR]

/// Disable AI windows [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/aiwindow/ui/modules/AIWindow.sys.mjs [NO-ANDROID] [NO-MAIL]
// Appears to be similar to "Smart Assist" below, relies on OpenAI/ChatGPT [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/28d9e40f/browser/components/aiwindow/models/Utils.sys.mjs#32 [NO-ANDROID] [NO-MAIL]
pref("browser.aiwindow.apiKey", ''); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.aiwindow.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.aiwindow.endpoint", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.aiwindow.insights", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.aiwindow.model", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable Link Preview "Key Points" [NO-ANDROID] [NO-MAIL]
// Currently no-op anyways - requires `dom.postMessage.sharedArrayBuffer.withCOOP_COEP` set to `true`: https://codeberg.org/celenity/Phoenix/issues/151 [NO-ANDROID] [NO-MAIL]
// https://blog.mozilla.org/mozilla/ai/ai-tech/ai-link-previews-firefox/ [NO-ANDROID] [NO-MAIL]
pref("browser.ml.linkPreview.collapsed", true); // [NO-ANDROID] [NO-MAIL] Ensure we don't prompt users to enable AI "key points" - https://codeberg.org/librewolf/settings/pulls/98#issuecomment-9002205
pref("browser.ml.linkPreview.enabled", false); // [NO-ANDROID] [NO-MAIL] This disables Link Preview itself by default - if this alone is re-enabled, it'll still provide basic previews without AI
pref("browser.ml.linkPreview.longPress", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.ml.linkPreview.optin", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ml.linkPreview.supportedLocales", "null"); // [NO-ANDROID] [NO-MAIL] This hides the UI toggle at `about:preferences#general`

/// Disable Page Assist [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/genai/PageAssist.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.ml.pageAssist.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable Perplexity URL bar promotion [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/urlbar/UrlbarPrefs.sys.mjs#229 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.perplexity.hasBeenInSearchMode", true); // [NO-ANDROID] [NO-MAIL]

/// Disable semantic history
// https://searchfox.org/firefox-main/source/toolkit/components/places/PlacesSemanticHistoryManager.sys.mjs
pref("places.semanticHistory.featureGate", false); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Nightly/Dev Firefox Desktop]

/// Disable "Smart Assist" [NO-ANDROID] [NO-MAIL]
// Currently relies on OpenAI/ChatGPT... so I'm going to be aggressive here, because I don't really want to deal with this :/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/genai/SmartAssistEngine.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.ml.smartAssist.apiKey", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ml.smartAssist.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ml.smartAssist.endpoint", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ml.smartAssist.model", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.ml.smartAssist.overrideNewTab", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable the WebExtensions AI API
// https://firefox-source-docs.mozilla.org/toolkit/components/ml/extensions.html#webextensions-ai-api
pref("extensions.ml.enabled", false);

/// Do not use AI to "suggest tabs and a name for tab groups" by default [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.groups.smart.enabled", false); // [NO-ANDROID] [NO-MAIL] UI
pref("browser.tabs.groups.smart.optin", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.tabs.groups.smart.userEnabled", false); // [NO-ANDROID] [NO-MAIL]

/// If Link Preview is enabled, do not censor results [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/genai/LinkPreviewModel.sys.mjs#529 [NO-ANDROID] [NO-MAIL]
pref("browser.ml.linkPreview.blockListEnabled", false); // [NO-ANDROID] [NO-MAIL]

/// Remove privacy-invasive AI Chatbot providers [NO-ANDROID] [NO-MAIL]
// (Anthropic Claude, ChatGPT, Google Gemini, Le Chat Mistral, and Microsoft Copilot) [NO-ANDROID] [NO-MAIL]
// Unfortunately, at the moment, this includes all of them... [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/genai/GenAI.sys.mjs#74 [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.providers", ""); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Set the default AI Chatbot (if enabled) to DuckDuckGo [NO-ANDROID] [NO-MAIL]
// Unfortunately this is not compatible with the pop-up when selecting text [NO-ANDROID] [NO-MAIL]
// Also AFAICT currently not possible to add this as a persistent option [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.provider", "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat"); // [NO-ANDROID] [NO-MAIL] 

pref("browser.phoenix.status", "017");

/*** 018 GEOLOCATION ***/

/// Block websites from prompting to access geolocation by default [NO-MAIL]
// `geo.prompt.testing.allow` is used when `geo.prompt.testing` is set to `true` - when `geo.prompt.testing` is set to false, the site permissions are followed like normal instead [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/base/nsContentPermissionHelper.h#144 [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/base/nsContentPermissionHelper.cpp#493 [NO-MAIL]
pref("permissions.default.geo", 2); // [NO-ANDROID] [NO-MAIL]

/// Disable logging network geolocation requests by default
// This is already Firefox's default setting - but setting it here exposes it in the `about:config` since it's hidden
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#18
pref("geo.provider.network.logging.enabled", false); // [HIDDEN] [DEFAULT] 


/// Disable Mozilla's GeoIP/Region Service
// Prevents Firefox from monitoring the user's region/general location
// Note: Firefox will still use different regional search engines based on the browser/system locale (ex. tested with Wikipedia), but this prevents using geolocation
// https://firefox-source-docs.mozilla.org/toolkit/modules/toolkit_modules/Region.html
// https://searchfox.org/firefox-main/source/toolkit/modules/Region.sys.mjs
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16254
pref("browser.region.local-geocoding", false); // [HIDDEN] [DEFAULT]
pref("browser.region.network.scan", false); // [DEFAULT] [DEFENSE IN DEPTH] Disable Wi-Fi scanning for these requests
pref("browser.region.network.url", "");
pref("browser.region.update.enabled", false);
pref("browser.search.region", "XX"); // [HIDDEN]
pref("doh-rollout.home-region", "XX"); // [HIDDEN]

/// Do not force the use of the network geolocation provider by default
// When either of these preferences are set to `true`, Firefox will ALWAYS use the network geolocation provider (BeaconDB in our case), instead of OS geolocation providers
// We're just setting these here to expose via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/dom/geolocation/Geolocation.cpp#774
// https://searchfox.org/firefox-main/rev/82e2435f/dom/geolocation/Geolocation.cpp#778
pref("geo.provider.testing", false); // [HIDDEN] [DEFAULT]
pref("geo.provider.use_mls", false); // [HIDDEN] [DEFAULT]


/// Enable Geoclue for GNU/Linux distros by default [LINUX-ONLY] [NO-MAIL]
pref("geo.provider.use_geoclue", true); // [LINUX-ONLY] [NO-MAIL] [DEFAULT]

/// Enable network request cache for the network geolocation provider by default
// This is already Firefox's default setting - but setting it here exposes it in the `about:config` since it's hidden
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#69
pref("geo.provider.network.debug.requestCache.enabled", true); // [HIDDEN] [DEFAULT]

/// Prevent unconditionally providing high location accuracy [LINUX-ONLY]
// By default, Firefox provides all websites with high location accuracy, even if they don't request it... [LINUX-ONLY]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/linux/GeoclueLocationProvider.cpp#308 [LINUX-ONLY]
pref("geo.provider.geoclue.always_high_accuracy", false); // [LINUX-ONLY]

/// Set BeaconDB as the default network geolocation provider
// Default is Google :/
// https://searchfox.org/firefox-main/rev/82e2435f/dom/system/NetworkGeolocationProvider.sys.mjs#341
pref("geo.provider.network.url", "https://api.beacondb.net/v1/geolocate");

/// Update info URL to ours so that users receive accurate information [NO-ANDROID] [NO-MAIL]
pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo"); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "018");

/*** 019 PDF.js ***/

/// Disable Automatic Alt Text by default
// This is generated by a local machine learning model
// Setting these ensures that the inference model is only downloaded if the user opts in (by enabling the toggle to "Create alt text automatically" from "Image alt text settings" when viewing a PDF)
// https://support.mozilla.org/kb/pdf-alt-text#w_add-alt-text-automatically
// https://hacks.mozilla.org/2024/05/experimenting-with-local-alt-text-generation-in-firefox-nightly/
pref("pdfjs.enableAltTextModelDownload", false);
pref("pdfjs.enableGuessAltText", false);

/// Disable automatic hyperlinks
// By default, PDF.js automatically creates hyperlinks for URLs - and clicking on or attempting to select a Hyperlink immediately navigates the user to the link, without warning or prior indication
// So this prevents that - but users can still easily select and navigate to links if desired
pref("pdfjs.enableAutoLinking", false);

/// Disable JavaScript
pref("pdfjs.enableScripting", false);

/// Disable XFA
// Not even a standard...
// https://learn.microsoft.com/deployedge/microsoft-edge-policies#viewxfapdfiniemodeallowedorigins
// https://insert-script.blogspot.com/2019/01/adobe-reader-pdf-callback-via-xslt.html
// https://www.sentinelone.com/blog/malicious-pdfs-revealing-techniques-behind-attacks/
// https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=xfa
// https://wikipedia.org/wiki/XFA
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#security-considerations
pref("pdfjs.enableXfa", false);

/// Enable the ability to add signatures
pref("pdfjs.enableSignatureEditor", true);

/// Enable Alt Text creation
// This does NOT enable "Automatic Alt Text", we disable that separately above
// https://support.mozilla.org/kb/pdf-alt-text
pref("pdfjs.enableAltText", true);
pref("pdfjs.enableAltTextForEnglish", true);
pref("pdfjs.enableNewAltTextWhenAddingImage", true); // [DEFAULT] Enables the Alt Text Editor after adding an image
pref("pdfjs.enableUpdatedAddImage", true); // [DEFAULT]

/// Enable hardware acceleration by default
// This should help improve performance, which is especially notable for us since we disable JIT
pref("pdfjs.enableHWA", true);

/// Enable optimized partial rendering by default
// In my testing, this appears to make a *significant* performance improvement
// https://github.com/mozilla/pdf.js/blob/010e52e15db0cb534774cdf92e20c03bcd13d735/web/pdf_page_view.js#L93
pref("pdfjs.enableOptimizedPartialRendering", true);

/// Enforce using the internal font renderer
// This disable the CSS Font Loading API
// https://mozilla.github.io/pdf.js/api/draft/module-pdfjsLib.html
// https://developer.mozilla.org/docs/Web/API/CSS_Font_Loading_API
pref("pdfjs.disableFontFace", true);

/// Ensure users can select and interact with text
pref("pdfjs.textLayerMode", 1); // [DEFAULT]

/// Force PDFs to be downloaded/viewed locally, and prompt before opening the PDF Viewer
// So by default, if Firefox encounters a PDF file, it'll just automatically open it in most cases, and will load them from remote origins
// But thanks to the "Handlers" policy on Desktop (https://mozilla.github.io/policy-templates/#handlers), we force Firefox to prompt users before opening the file - and additionally, with the `browser.download.start_downloads_in_tmp_dir` & `browser.helperApps.deleteTempFileOnExit` prefs, when the users chooses to "Open" the PDF, it downloads the PDF to a temporary directory and loads it locally (from a `file://` URL), instead of from remote origins like the normal behavior
// This is also beneficial because it also allows users to effectively disable PDF.js (via the `browser.helperApps.showOpenOptionForPdfJS` pref), without being fingerprintable (like is the case with the standard `pdfjs.disabled` pref)
// The pref below are to further ensure we don't automatically open PDFs, and that we don't try to fetch anything remotely
// As a bonus, these likely also improve performance in many cases...
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#network-options
// https://deepwiki.com/mozilla/pdfjs-dist/6.2-advanced-configuration#performance-optimization-configurations
// (For testing: https://emk.name/test/bug1790641.html)
pref("browser.download.open_pdf_attachments_inline", false); // [DEFAULT - non-Android] https://bugzilla.mozilla.org/show_bug.cgi?id=1772569
pref("pdfjs.disableRange", true);
pref("pdfjs.disableStream", true);

/// Never allow documents to prevent copying text
pref("pdfjs.enablePermissions", false); // [DEFAULT]

/// Open external links in new tabs/windows
// https://github.com/mozilla/pdf.js/blob/master/extensions/chromium/preferences_schema.json
pref("pdfjs.externalLinkTarget", 2);

/// Prevent attempting to load/convert unknown binary files
// https://developer.mozilla.org/docs/Web/HTTP/Guides/MIME_types#applicationoctet-stream
pref("pdfjs.handleOctetStream", false);

/// Show sidebar by default when viewing PDFs
pref("pdfjs.sidebarViewOnLoad", 2);

/// Update URL when changing pages [NO-ANDROID]
// ex. Typically, if I load "https://example.invalid/example.pdf", and navigate to Page 27, the URL stays the same as "https://example.invalid/example.pdf" [NO-ANDROID]
// When this is set to "true", if I loaded "https://example.invalid/example.pdf", and navigated to Page 27, the URL would instead update to "https://example.invalid/example.pdf#page=27" [NO-ANDROID]
// So this is an incredibly useful feature that allows easy bookmarking/sharing of PDFs, keeping track of what you've read, etc. [NO-ANDROID]
// (We also still nuke browsing history by default on exit) [NO-ANDROID]
// This currently doesn't seem to work properly on Android [NO-ANDROID]
pref("pdfjs.historyUpdateUrl", true); // [NO-ANDROID]

pref("browser.phoenix.status", "019");

/*** 020 SAFE BROWSING ***/

/// By default, when you report a Safe Browsing false positive, it sends the URL to both Mozilla & Google (NOT PROXIED), as well as your locale to Mozilla
// Ex. https://en-us.phish-error.mozilla.com/?url=example.org - Which redirects you directly to https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=example.org 
// We can improve privacy and speed by sending the domain *only* to Google & without sending your locale to anyone
// We could also potentially strip tpl=mozilla which tells Google the request is from Firefox - though it looks like there is a different page for Firefox users with a better privacy policy, so we will leave it for now
// Unclear whether 'MalwareMistake' is used, but we can set it anyways
pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google5.reportMalwareMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");
pref("browser.safebrowsing.provider.google5.reportPhishMistakeURL", "https://safebrowsing.google.com/safebrowsing/report_error/?tpl=mozilla&url=");

//// Similar behavior also appears to happen when you report a URL to Safe Browsing
pref("browser.safebrowsing.reportPhishURL", "https://safebrowsing.google.com/safebrowsing/report_phish/?tpl=mozilla&url=");

/// Disable the legacy (v2.2) Safe Browsing API
// https://code.google.com/archive/p/google-safe-browsing/wikis/Protocolv2Spec.wiki
// Has been nonfunctional since October 2018
// https://security.googleblog.com/2018/01/announcing-turndown-of-deprecated.html
// Let's make sure it's not used for defense in depth (and attack surface reduction...)
pref("browser.safebrowsing.provider.google.advisoryName", "Google Safe Browsing (Legacy)"); // Label it so it's clearly distinguishable if it is ever enabled for whatever reason...
pref("browser.safebrowsing.provider.google.lists", "disabled");
pref("browser.safebrowsing.provider.google.lists.default", "goog-badbinurl-shavar,goog-downloadwhite-digest256,goog-phish-shavar,googpub-phish-shavar,goog-malware-shavar,goog-unwanted-shavar"); // [HIDDEN] This pref does nothing, just makes it easier for users to re-enable this Safe Browsing provider if desired by copying and pasting the value of this pref as the value for `browser.safebrowsing.provider.google.lists`

/// Enable an additional plug-in blocklist from Mozilla
pref("urlclassifier.blockedTable", "moztest-block-simple,mozplugin-block-digest256"); // [DEFAULT - Nightly]

/// Enable the Potentially Harmful Application list (when Safe Browsing is enabled)
// This contains threats that are specific to Mobile/Android (of the `POTENTIALLY_HARMFUL_APPLICATION` type)
// Firefox on non-Android devices will just silently ignore/disregard this list
// https://bugzilla.mozilla.org/show_bug.cgi?id=1980046
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/nsUrlClassifierUtils.cpp#176
// https://developers.google.com/safe-browsing/reference/Local.Database
pref("urlclassifier.malwareTable", "goog-malware-proto,goog-unwanted-proto,moztest-harmful-simple,moztest-malware-simple,moztest-unwanted-simple,goog-harmful-proto");

/// Enable Safe Browsing by default
// This won't do anything if you don't have an API key from Google, though doesn't hurt...
// Harmless from a privacy perspective due to the below changes, also effective at preventing real-time malicious domains and downloads.
// We will of course **ALWAYS** give users the ability to disable.
// https://searchfox.org/firefox-main/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.safebrowsing.blockedURIs.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.downloads.enabled", true); // [DEFAULT - non-Android]
pref("browser.safebrowsing.id", "navclient-auto-ffox"); // [DEFAULT - Official] Ensure we use Mozilla's ID
pref("browser.safebrowsing.malware.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.phishing.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.provider.google5.enabled", true); // [DEFAULT - Nightly]
pref("browser.safebrowsing.provider.mozilla.gethashURL", "https://shavar.services.mozilla.com/gethash?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2"); // Ensure we always use Mozilla's official ID
pref("browser.safebrowsing.update.enabled", true); // [HIDDEN] [DEFAULT] Also covers Mozilla's tracking protection lists
pref("urlclassifier.downloadAllowTable", "goog-downloadwhite-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.downloadBlockTable", "goog-badbinurl-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.enabled_mode", 3); // [DEFAULT] Ensure we enable classification for ETP and Safe Browsing https://searchfox.org/firefox-main/rev/4dad4a9a/netwerk/base/nsNetUtil.cpp#3332 https://searchfox.org/firefox-main/rev/ac83682a/modules/libpref/init/StaticPrefList.yaml#18483
pref("urlclassifier.phishTable", "goog-phish-proto,moztest-phish-simple"); // [DEFAULT - Official] Ensure we're using Google's full/private phishing list https://bugzilla.mozilla.org/show_bug.cgi?id=1288840

/// Ensure users can override Safe Browsing warnings by default
pref("browser.safebrowsing.allowOverride", true); // [DEFAULT]

/// Prevent sending metadata of downloaded files to Safe Browsing providers
// https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work#w_how-does-phishing-and-malware-protection-work-in-firefox
// https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
pref("browser.safebrowsing.downloads.remote.enabled", false);

/// Prevent sharing data/telemetry with Safe Browsing providers
// https://searchfox.org/mozilla-central/source/netwerk/url-classifier/nsChannelClassifier.cpp#364
// https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/nsUrlClassifierDBService.cpp#1964
// https://bugzilla.mozilla.org/show_bug.cgi?id=1351147
// (Known providers taken from here: https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/url-classifier/nsUrlClassifierUtils.cpp#444)
pref("browser.safebrowsing.provider.google.dataSharing.enabled", false, locked); // [HIDDEN - non-Android] [DEFAULT]
pref("browser.safebrowsing.provider.google.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false, locked); // [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharingURL", "", locked);
pref("browser.safebrowsing.provider.google5.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.google5.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.mozilla.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.mozilla.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.test.dataSharing.enabled", false, locked); // [HIDDEN] [DEFAULT]
pref("browser.safebrowsing.provider.test.dataSharingURL", "", locked); // [HIDDEN] [DEFAULT]

/// Proxy Safe Browsing
// This sets up a new Safe Browsing "provider", using the servers we've set up for IronFox, hosted on our Cloudflare storage bucket (in EU jurisdiction)
pref("browser.safebrowsing.provider.google4.advisoryName", "Google Safe Browsing (Proxied by IronFox) - v4");
pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google4.nextupdatetime", "1"); // [HIDDEN]
pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google5.advisoryName", "Google Safe Browsing (Proxied by IronFox) - v5");
pref("browser.safebrowsing.provider.google5.gethashURL", "https://safebrowsing.ironfoxoss.org/v5/hashes:search?key=%GOOGLE_SAFEBROWSING_API_KEY%");
pref("browser.safebrowsing.provider.google5.nextupdatetime", "1"); // [HIDDEN]
pref("browser.safebrowsing.provider.google5.updateURL", "https://safebrowsing.ironfoxoss.org/v5/hashLists:batchGet?key=%GOOGLE_SAFEBROWSING_API_KEY%");

/// Show advanced details on pages blocked by Safe Browsing by default [NO-ANDROID] [NO-MAIL]
pref("browser.xul.error_pages.show_safe_browsing_details_on_load", true); // [NO-ANDROID] [NO-MAIL]

/// Unbreak Google's download protection and legacy Safe Browsing provider (if enabled via the `browser.safebrowsing.downloads.remote.enabled` & `browser.safebrowsing.provider.google.lists` prefs)
//  Some (ex. LibreWolf) override these for no reason
pref("browser.safebrowsing.downloads.remote.url", "https://sb-ssl.google.com/safebrowsing/clientreport/download?key=%GOOGLE_SAFEBROWSING_API_KEY%"); // [DEFAULT]
pref("browser.safebrowsing.provider.google.gethashURL", "https://safebrowsing.google.com/safebrowsing/gethash?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2"); // [DEFAULT]
pref("browser.safebrowsing.provider.google.updateURL", "https://safebrowsing.google.com/safebrowsing/downloads?client=navclient-auto-ffox&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%"); // [DEFAULT]

/// Unclear whether these are actually used or not, but looks like Firefox has some kind of functionality to view a "report" from Safe Browsing about the safety, history, and general status of a site
// By default, it unnecessarily redirects from ex. https://safebrowsing.google.com/safebrowsing/diagnostic?site=example.org to https://transparencyreport.google.com/safe-browsing/search?url=example.org
// We can skip the redirect to improve performance
pref("browser.safebrowsing.provider.google.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google4.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google5.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");

pref("browser.phoenix.status", "020");

/*** 021 MISC. PRIVACY + SECURITY ***/

/// Disable Accessibility Services
// PRIVACY: Can be used to monitor users by design
// SECURITY: Can be easily abused by bad actors, Attack Surface Reduction
// "Firefox Accessibility Service is a technology built into Firefox that provides 3rd party applications running on the same device the ability to inspect, monitor, visualize, and alter web page content hosted within Firefox."
// We need to ensure we're still accomodating for impaired users, but I feel this is something that must be handled by the browser instead of external software
// https://web.archive.org/web/20240608190300/support.mozilla.org/en-US/kb/accessibility-services
pref("accessibility.force_disabled", 1);
pref("devtools.accessibility.enabled", false); // [NO-ANDROID] - Disables the Accessibility Inspector/context menu item by default - https://firefox-source-docs.mozilla.org/devtools-user/accessibility_inspector/

/// Disable automatic updates for OpenSearch engines
// PRIVACY: Unsolicited connections to search providers
// SECURITY: Could be abused to alter a user's search engine(s) without consent
// Doesn't appear to impact Mozilla's built-in search engines
// https://firefox-source-docs.mozilla.org/toolkit/search/Preferences.html#hidden
// https://developer.mozilla.org/docs/Web/XML/Guides/OpenSearch#supporting_automatic_updates_for_opensearch_plugins
pref("browser.search.update", false); // [DEFAULT - Android]

/// Disable Battery API (Navigator.getBattery)
// PRIVACY: Fingerprinting concerns, just plain creepy...
// SECURITY: Attack Surface Reduction
// NOTE: This only impacts chrome/certain privileged code; this is thankfully never exposed to websites
// I'm still not convinced that there's a legitimate use/need for this functionality though...
// https://developer.mozilla.org/docs/Web/API/Battery_Status_API
// https://developer.mozilla.org/docs/Web/API/Navigator/getBattery
// https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
pref("dom.battery.enabled", false);

/// Disable Beacon API (Navigator.sendBeacon)
// PRIVACY: Used for analytics/tracking by design, see explanation below
// SECURITY: Attack Surface Reduction
// I was originally against disabling this, but after careful consideration, I've changed my position.
// The explicit, stated purpose/use case of this API is for analytics/tracking.
// Websites *can* obtain the data shared from this API through other means; though the other ways to obtain it are more disruptive and less reliable.
// Analytics/tracking is also evidently not a use case that we, as the user agent, should support or assist with.
// I don't see a justification for adding APIs/features to support this hostile behavior. We are the user agent and must act in the best interest of users...
// Also disabled by ex. Cromite: https://github.com/uazo/cromite/blob/master/docs/FEATURES.md https://github.com/uazo/cromite/issues/1454
// https://developer.mozilla.org/docs/Web/API/Beacon_API
// https://developer.mozilla.org/docs/Web/API/Navigator/sendBeacon
// https://udn.realityripple.com/docs/Web/API/Navigator/sendBeacon
// https://w3c.github.io/beacon/#privacy-and-security
// https://bugzilla.mozilla.org/show_bug.cgi?id=1454252
pref("beacon.enabled", false);

/// Disable Clipboard API
// PRIVACY: Fingerprinting concerns, prevents monitoring users' clipboards without their consent
// SECURITY: Prevents leaking sensitive information (ex. passwords), Attack Surface Reduction
// NOTE: This only impacts extensions; this is thankfully never exposed to websites
// I'm still not convinced extensions need or should have access to this data though (While there are currently other ways for extensions to access clipboard data, those are deprecated and will presumably not be around for much longer)
// https://developer.mozilla.org/docs/Web/API/Clipboard
pref("dom.events.asyncClipboard.clipboardItem", false);
pref("dom.events.asyncClipboard.readText", false);
pref("dom.events.testing.asyncClipboard", false, locked); // [DEFAULT]

/// Disable Content Analysis SDK
// PRIVACY: Used for monitoring users by design
// SECURITY: Can be easily abused by bad actors, Attack Surface Reduction
// DESKTOP: We also set "ContentAnalysis" in policies
// https://mozilla.github.io/policy-templates/#contentanalysis
// https://github.com/chromium/content_analysis_sdk
pref("browser.contentanalysis.default_result", 0, locked); // [DEFAULT]
pref("browser.contentanalysis.enabled", false, locked); // [DEFAULT]
pref("browser.contentanalysis.interception_point.clipboard.enabled", false, locked);
pref("browser.contentanalysis.interception_point.drag_and_drop.enabled", false, locked);
pref("browser.contentanalysis.interception_point.file_upload.enabled", false, locked);
pref("browser.contentanalysis.interception_point.print.enabled", false, locked);
pref("browser.contentanalysis.max_connections", 0, locked); // Sets maximum number of allowed connections to 0
pref("browser.contentanalysis.show_blocked_result", true, locked); // [DEFAULT] - Always notify users when Content Analysis blocks access to something...
pref("browser.contentanalysis.silent_notifications", false, locked); // [DEFAULT] If Content Analysis is enabled, ensure notifications aren't silenced so that users are fully aware

/// Disable Federated Credential Management (FedCM) API
// PRIVACY: Provides support for "identity federation services"/third party sign-in - which can be used for tracking by design
// SECURITY: Attack Surface Reduction
// https://developer.mozilla.org/docs/Web/API/FedCM_API
// https://w3c-fedid.github.io/FedCM/
pref("dom.security.credentialmanagement.identity.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.security.credentialmanagement.identity.heavyweight.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.security.credentialmanagement.identity.lightweight.enabled", false); // [DEFAULT]


/// Disable Native Messaging
// This functionality is used to allow browser extensions to communicate with external apps/programs
// Naturally, this raises various privacy and security concerns
// https://developer.mozilla.org/docs/Mozilla/Add-ons/WebExtensions/Native_messaging
// https://developer.chrome.com/docs/extensions/develop/concepts/native-messaging
// https://searchfox.org/firefox-main/rev/af0f713f/toolkit/components/extensions/NativeMessaging.sys.mjs#12
pref("webextensions.native-messaging.max-input-message-bytes", 0); // [HIDDEN] [DEFAULT: 1048576]
pref("webextensions.native-messaging.max-output-message-bytes", 0); // [HIDDEN] [DEFAULT: -1, but, to override: set to 999999999]
pref("widget.use-xdg-desktop-portal.native-messaging", 0); // [LINUX-ONLY] [DEFAULT] For Flatpak/Snap https://searchfox.org/firefox-main/source/toolkit/components/extensions/docs/native-messaging-portal-design.rst

/// Disable Reporting API
// PRIVACY: Fingerprinting concerns, used for analytics by design
// SECURITY: Attack Surface Reduction
// https://w3c.github.io/reporting/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1492036
pref("dom.reporting.crash.enabled", false); // [DEFAULT]
pref("dom.reporting.enabled", false); // [DEFAULT]
pref("dom.reporting.featurePolicy.enabled", false); // [DEFAULT]
pref("dom.reporting.header.enabled", false); // [DEFAULT]
pref("dom.reporting.testing.enabled", false); // [DEFAULT]

/// Disable tab hover previews by default [NO-ANDROID] [NO-MAIL]
// PRIVACY: Reduces disk activity [NO-ANDROID] [NO-MAIL]
// SECURITY: Attack Surface Reduction [NO-ANDROID] [NO-MAIL]
// As a bonus, also boosts performance... [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.hoverPreview.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.hoverPreview.showThumbnails", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Web Share API
// This API allows websites to share data directly to system applications...
// PRIVACY: Could result in leakage/unexpected behavior
// SECURITY: "The data passed to {{Navigator/share()}} might be used to exploit buffer overflow or other remote code execution vulnerabilities in the [=share target=] that receive shares. There is no general way to guard against this, but implementors will want to be aware that it is a possibility (particularly when sharing files).", Attack Surface Reduction
// https://developer.mozilla.org/docs/Web/API/Web_Share_API
pref("dom.webshare.enabled", false); // [DEFAULT - non-Android/non-Nightly Windows]
pref("dom.webshare.requireinteraction", true); // [DEFAULT] If enabled, ensure we always require interaction...

/// Disable WebGPU
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://gpuweb.github.io/gpuweb/#privacy-considerations
// https://gpuweb.github.io/gpuweb/#security-considerations
// https://browserleaks.com/webgpu
pref("dom.webgpu.enabled", false); // [DEFAULT - non-Windows/non-Nightly]

/// Disable WebMIDI
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// See "Privacy Considerations" & "Security Considerations": https://webaudio.github.io/web-midi-api
// Toggling 'dom.webmidi.enabled' itself could be fingerprintable, but setting these instead just causes the permission to be automatically denied at a random interval
// https://searchfox.org/firefox-main/rev/82e2435f/dom/midi/MIDIPermissionRequest.cpp#120
// Test: https://permission.site/
pref("dom.sitepermsaddon-provider.enabled", false);
pref("dom.webmidi.gated", true); // [DEFAULT]
pref("permissions.default.midi", 2); // [HIDDEN]
pref("permissions.default.midi-sysex", 2); // [HIDDEN]

/// Disable the Windows UI Automation API
// Similar privacy and security concerns as with Accessibility Services (accessibility.force_disabled) above
// https://wikipedia.org/wiki/Microsoft_UI_Automation
// https://searchfox.org/firefox-main/rev/87a1e2a5/modules/libpref/init/StaticPrefList.yaml#298
pref("accessibility.uia.enable", 0);

/// Enable Local Network Access Restrictions
// https://wicg.github.io/local-network-access/
// https://searchfox.org/firefox-main/rev/7f33a0cc/netwerk/protocol/http/nsHttpTransaction.cpp#3735
pref("network.lna.block_trackers", true); // https://searchfox.org/firefox-main/rev/7f33a0cc/modules/libpref/init/StaticPrefList.yaml#14469
pref("network.lna.enabled", true); // [DEFAULT]
pref("network.lna.etp.enabled", false); // [DEFAULT] [NIGHTLY] Enable LNA, regardless of ETP/ETP Strict https://searchfox.org/firefox-main/rev/7f33a0cc/browser/components/protections/ContentBlockingPrefs.sys.mjs#265
pref("network.lna.websocket.enabled", true); // [NIGHTLY] Enforce LNA for WebSocket connections https://searchfox.org/firefox-main/rev/7f33a0cc/modules/libpref/init/StaticPrefList.yaml#14490
pref("permissions.default.local-network", 2); // [NO-ANDROID] [NIGHTLY] Blocks websites from prompting to access the local network by default; we won't set on Android for now since there's not a UI there to control this yet...
pref("permissions.default.localhost", 2); // [NO-ANDROID] [NIGHTLY] Blocks websites from prompting to access apps and services (outside of the browser) on your device

/// Enable Messaging Layer Security (MLS)
// PRIVACY: Ensures messages are only received by the intended recipient
// SECURITY: Protects the authenticity and integrity of messages
// Security layer for E2EE messaging
// https://wikipedia.org/wiki/Messaging_Layer_Security
// https://blog.mozilla.org/mozilla/messaging-layer-security-is-now-an-internet-standard/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876002
pref("dom.origin-trials.mls.state", 1);

/// Prevent exposing XPCOM Components.interfaces to websites
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// (For reference, this is also set by ex. Tor Browser)
// https://bugzilla.mozilla.org/show_bug.cgi?id=429070
// https://devdoc.net/web/developer.mozilla.org/en-US/docs/Components.interfaces.html
pref("dom.use_components_shim", false); // [DEFAULT - Nightly]


pref("browser.phoenix.status", "021");

/*** 022 MISC. PRIVACY ***/

/// Block ports currently known to be abused by Android apps for tracking/fingerprinting
// Previously blocked by default on Android - and assuming they don't cause issues, I'd also like to keep these blocked for other platforms (for defense in depth and in case this method of tracking is also being used elsewhere...)
// https://localmess.github.io/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1970141
pref("network.security.ports.banned", "29009, 29010, 30102, 30103, 12387, 12388, 12580, 12581, 12582, 12583, 12584, 12585, 12586, 12587, 12588, 12589, 12590, 12591");

/// Disable CSP reporting
// Fingerprinting concerns, Used for analytics by design
// Also reduces unsolicited network activity and bandwidth consumption
// Glad we managed to convince Mozilla to add this :)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
pref("security.csp.reporting.enabled", false);

/// Disable Hyperlink Auditing (Click Tracking)
// https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/
// https://searchfox.org/firefox-main/rev/82e2435f/docshell/base/nsPingListener.cpp#32
pref("browser.send_pings", false); // [DEFAULT]
pref("browser.send_pings.max_per_link", 1); // [DEFAULT] Ensure max number of pings are limited to 1 if Hyperlink Auditing is enabled
pref("browser.send_pings.require_same_host", true); // [DEFENSE IN DEPTH]

/// Disable Network Error Logging
// Fingerprinting concerns, Used for analytics by design
// https://developer.mozilla.org/docs/Web/HTTP/Network_Error_Logging
// https://w3c.github.io/network-error-logging/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1145235
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#13696
pref("network.http.network_error_logging.enabled", false); // [DEFAULT]

/// Disable online speech recognition
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/webspeech/recognition/OnlineSpeechRecognitionService.cpp#41
// https://searchfox.org/firefox-main/source/dom/media/webspeech/recognition/SpeechRecognition.cpp
pref("media.webspeech.service.endpoint", "data;"); // [HIDDEN]

/// Disable referers when leaving .onion domains
// NOTE: Please use TOR BROWSER for accessing .onion domains...
pref("network.http.referer.hideOnionSource", true); // [DEFAULT]

/// Disable storage access heuristics
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics
pref("dom.storage_access.auto_grants", false); // Automatic storage access grants
pref("privacy.restrict3rdpartystorage.heuristic.navigation", false); // [DEFAULT - non-desktop Nightly] 
pref("privacy.restrict3rdpartystorage.heuristic.opened_window_after_interaction", false);
pref("privacy.restrict3rdpartystorage.heuristic.recently_visited", false);
pref("privacy.restrict3rdpartystorage.heuristic.redirect", false); // [DEFAULT - Android]
pref("privacy.restrict3rdpartystorage.heuristic.window_open", false); // [DEFAULT - Android]

/// Disable TLS session identifiers
// Fingerprinting/tracking concerns
// Especially important for Android, where users likely leave the app open (and by extension: keep their browsing session active) for days at a time, much longer than on Desktop
// Even on Desktop, this can be used as a vector to detect whether Private Browsing is active: https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/44187
// For reference, this is also disabled by ex. Cromite
// https://arxiv.org/abs/1810.07304
pref("security.ssl.disable_session_identifiers", true);

/// Enable Containers
// https://support.mozilla.org/kb/how-use-firefox-containers
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/contextualidentity/ContextualIdentityService.sys.mjs#9
pref("privacy.userContext.enabled", true); // [HIDDEN - Android] [DEFAULT - Firefox Desktop Nightly]

/// Enable Cookie Banner Reduction
// https://support.mozilla.org/kb/cookie-banner-reduction
pref("cookiebanners.bannerClicking.enabled", true); // [DEFAULT]
pref("cookiebanners.cookieInjector.enabled", true); // [DEFAULT]
pref("cookiebanners.service.mode", 1);
pref("cookiebanners.service.mode.privateBrowsing", 1);
pref("cookiebanners.service.enableGlobalRules", true); // [DEFAULT]
pref("cookiebanners.service.enableGlobalRules.subFrames", true); // [DEFAULT]

/// Enable Cookies Having Independent Partitioned State (CHIPS)
// This allows websites to set cookies with a 'Partitioned' attribute, meaning they're limited in scope
// We still use ETP Strict for partioning anyways, so this could be useful as a defense in depth if a user decides to allow a specific domain (or domains) to access a third party cookie
// https://developer.mozilla.org/docs/Web/Privacy/Privacy_sandbox/Partitioned_cookies
// https://developer.mozilla.org/docs/Web/HTTP/Headers/Set-Cookie#partitioned
// https://github.com/privacycg/CHIPS
pref("network.cookie.CHIPS.enabled", true); // [DEFAULT - Nightly]
pref("network.cookie.chips.partitionLimitDryRun", false); // [DEFAULT]

/// Enable Do Not Track & Global Privacy Control
// Do Not Track is also covered by ETP Strict, pref to be removed soon...
pref("privacy.donottrackheader.enabled", true);
pref("privacy.globalprivacycontrol.enabled", true);
pref("privacy.globalprivacycontrol.functionality.enabled", true); // [DEFAULT - non-Thunderbird]
pref("privacy.globalprivacycontrol.pbmode.enabled", true); // [DEFAULT - non-Thunderbird]

/// Enable the (new) UI for browser profiles by default [NO-ANDROID] [NO-MAIL]
pref("browser.profiles.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]

/// Enable the UI for containers at `about:preferences#general` (`about:preferences#containers`) [NO-ANDROID] [NO-MAIL]
// We also include the Firefox Multi-Account Containers extension by default [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/how-use-firefox-containers [NO-ANDROID] [NO-MAIL]
pref("privacy.userContext.ui.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]

/// Enable the UI for Cookie Banner Reduction at `about:preferences#privacy` [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/cookie-banner-reduction [NO-ANDROID] [NO-MAIL]
pref("cookiebanners.ui.desktop.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Exclude third party trackers from storage access heuristics (if enabled)
// https://developer.mozilla.org/docs/Web/Privacy/State_Partitioning#storage_access_heuristics
pref("dom.storage_access.auto_grants.exclude_third_party_trackers", true); // [DEFAULT] Automatic storage access grants
pref("privacy.restrict3rdpartystorage.heuristic.exclude_third_party_trackers", true); // [DEFAULT]

/// Improve built-in query stripping to be on par with LibreWolf and Brave
// See Mozilla's defaults here: https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/query-stripping/changeset?_expected=0
// https://codeberg.org/librewolf/settings/src/commit/e93018221243f0af7cdbbf737b6af17d70cde8aa/librewolf.cfg#L103
// https://github.com/brave/brave-core/blob/master/components/query_filter/utils.cc
pref("privacy.query_stripping.strip_list", "__hsfp __hssc __hstc __s _bhlid _branch_match_id _branch_referrer _gl _hsenc _kx _openstat at_recipient_id at_recipient_list bbeml bsft_clkid bsft_uid dclid et_rid fb_action_ids fb_comment_id fbclid gbraid gclid guce_referrer guce_referrer_sig hsCtaTracking igshid irclickid mc_eid mkt_tok ml_subscriber ml_subscriber_hash msclkid mtm_cid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id pk_cid rb_clickid s_cid sc_customer sc_eh sc_uid srsltid ss_email_id twclid unicorn_click_id vero_conv vero_id vgo_ee wbraid wickedid yclid ymclid ysclid");

//// Unbreak urldefense.com redirects
/// (ex. https://urldefense.com/v3/__https://www.portainer.io/hs/preferences-center/en/direct?data=W2nXS-N30h-M1W45lXqV2nFX8ZW3SzKNq3gnnN0W4cQh6C1Bnn1kW1VjfB24fr2-BW4mm3dy3T2wkqW2MWfBj49z9PPW4mqs512qWTfrW4px5K71Nn7N2W32DKbz1V7s-qW21bSln2KWpS4W1SdHmq2YwgS9W3P8RNt2r6W8pW49QSSt1_tcPsW3GSrf749CfyJW2PPdX33JPrgmW4hcHf84hm-NmW2FS2pd2sMKL-W2YGYkz43RS-9W4pjpV52t0rxlW3SB_f94psLW2W3_Sm6w2FGVTjW3K2-cG4fzZLWW2qDSdB3bzPyBW3j8X_q2PMxWzW36CtK22MvcXrW4hNdFB3DLWP3W3VMWNy3SYMyvW1Vs-MC43NZJNW4hLsTd2B1T2JW2sB9wk3DMh2mW2D0QS-2t04tYW43Cpv42Tz6SwW32rgcB3_SfvDW4mq1yB36nnnkW3BNLQw2YfSH9W49sKsP3z4zKPW3zd1YL1Zm6S3W4kmj3Z2sQ7WVW36xkSD2RSm5hW1Q0SqC30sK9ZW2-kSbQ2nH5KcW36fNc_2RjGNjW36pblN43qsbhW2CCNvJ3_SL29W1_sQHx4fqK9NW3Sy1cb4mpD3h0&utm_campaign=XNF&utm_source=hs_automation&utm_medium=email&utm_content=264158909&_hsenc=p2ANqtz--9JvIgI266aB1UVizENwYNYREZSotsXOhWcMNeKjZLJO9ZwmR9xlyfsQN2orbT25IymZ_vKUNTANMKQMVQBnzowi2339ExVoOKMJaHx0t2yn5esgg&_hsmi=264158909__;!!MlclJBHn!0eDf-zTf69h-IhFT9WDu2GIXAtCy6RENwguPVpTF1k2K-Nbnzy1NXix2Gj7azc8yDFyI2z3Tz4nTFuGe2hlLzsBl$)
/// https://github.com/brave/brave-browser/issues/41134
pref("privacy.query_stripping.allow_list", "urldefense.com");

/// Isolate permissions per container (if containers are enabled)
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("permissions.isolateBy.userContext", true);

/// Isolate resources (ex. referrers & cookies) injected by extensions
// (ex. https://searchfox.org/mozilla-central/source/toolkit/components/extensions/test/xpcshell/test_ext_contentscript_antitracking.js)
pref("privacy.antitracking.isolateContentScriptResources", true); // [DEFAULT - Nightly]

/// Limit maximum cookie lifetime to 6 months/180 days (Like Brave)
// Firefox's default is currently 400 days (34560000)
// https://github.com/brave/brave-browser/issues/3443
// https://github.com/fmarier/brave-core/commit/4d222df50a8dfaaabb31e9f2c5070c4db5ba8fd5
// For testing: https://setcookie.net/
pref("network.cookie.maxageCap", 15552000);

/// Prevent Firefox from automatically guessing which container to open an external link in (if containers are enabled) [NO-ANDROID] [NO-MAIL]
// Instead, stick to the default [NO-ANDROID] [NO-MAIL]
// This can lead to cross contamination for those who keep separate containers exclusively for specific websites [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1874599#c8 [NO-ANDROID] [NO-MAIL]
pref("browser.link.force_default_user_context_id_for_external_opens", true); // [NO-ANDROID] [NO-MAIL]

/// Prevent sharing identifying information if a remote AutoConfig is being used
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/pref/autoconfig/src/nsAutoConfig.cpp#213
pref("autoadmin.append_emailaddr", false, locked); // [HIDDEN] [DEFAULT]

/// Prevent third parties from setting cookies unless the third party already has cookies as a first party (Like Safari)
// https://webkit.org/tracking-prevention/#the-default-cookie-policy
// https://bugzilla.mozilla.org/show_bug.cgi?id=1587182
pref("privacy.dynamic_firstparty.limitForeign", true);

/// Restrict tracking referers
pref("network.http.referer.defaultPolicy.trackers", 1);
pref("network.http.referer.defaultPolicy.trackers.pbmode", 1);

/// Strip tracking parameters from URLs when shared by default
pref("privacy.query_stripping.strip_on_share.enabled", true); // [DEFAULT - non-Android/Thunderbird]

/// Trim cross-origin referers (Like Safari)
// https://wiki.mozilla.org/Security/Referrer
pref("network.http.referer.XOriginTrimmingPolicy", 2);

pref("browser.phoenix.status", "022");

/*** 023 MISC. SECURITY ***/

/// Always prompt users for a certificate when websites request one, rather than automatically selecting one...
// https://www.stigviewer.com/stig/mozilla_firefox/2023-06-05/finding/V-251547
pref("security.default_personal_cert", "Ask Every Time", locked); // [DEFAULT]

/// Apply CSP to internal browser.xhtml
pref("security.browser_xhtml_csp.enabled", true); // [DEFAULT]
pref("security.browser_xhtml_csp.report-only", false); // [NO-ANDROID] [ESR]

/// Block privileged `about:` pages from loading remote scripts
// https://searchfox.org/firefox-main/rev/82e2435f/dom/security/nsContentSecurityManager.cpp#1102
pref("security.disallow_privilegedabout_remote_script_loads", true);

/// Configure protocol handling
// This can get very confusing, very fast - so here's a basic explanation:
// If a protocol is "exposed", it can be opened/used by the browser in all contexts
// If a protocol is "external", it can not be opened/used by the browser directly, and the protocol will instead open in an external application
// If a protocol is "external" and set to "warn-external", the user will be warned/prompted before the protocol is opened in an external application
// By default, Firefox on Desktop "exposes" ALL protocols (network.protocol-handler.expose-all), and allows ALL protocols to be opened externally (network.protocol-handler.external-default) - though it does require prompting before all of them (network.protocol-handler.warn-external-default), except for `mailto:` (network.protocol-handler.external.mailto), and it does manually block several protocols from being opened externally
// Android is similar, except, in addition to `mailto`, it also disables prompting before opening `sms`, `tel`, and YouTube
// https://bugzilla.mozilla.org/show_bug.cgi?id=819554
// https://bugzilla.mozilla.org/show_bug.cgi?id=589403
// https://bugzilla.mozilla.org/show_bug.cgi?id=630364
// Instead of "exposing" all protocols, we can reduce attack surface by limiting them to only the ones we actually need/use/want
// We can also ensure that the user is always warned before opening a protocol externally, and we can block protocols ourselves if desired
pref("network.protocol-handler.expose.about", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.blob", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.chrome", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.data", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.file", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.http", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.https", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.javascript", true); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.expose.moz-extension", true); // [DEFAULT - Thunderbird] [HIDDEN - non-Thunderbird]
pref("network.protocol-handler.expose.resource", true); // [HIDDEN]
pref("network.protocol-handler.expose.view-source", true); // [NO-ANDROID] [NO-MAIL]
pref("network.protocol-handler.expose-all", false); // [DEFAULT - Thunderbird]
pref("network.protocol-handler.external.about", false); // [HIDDEN]
pref("network.protocol-handler.external.afp", false); // [DEFAULT]
pref("network.protocol-handler.external.bankid", true); // [HIDDEN] Ensure we do not try to handle BankID authentication internally...
pref("network.protocol-handler.external.blob", false); // [HIDDEN]
pref("network.protocol-handler.external.chrome", false); // [HIDDEN]
pref("network.protocol-handler.external.data", false); // [DEFAULT]
pref("network.protocol-handler.external.disk", false); // [DEFAULT]
pref("network.protocol-handler.external.disks", false); // [DEFAULT]
pref("network.protocol-handler.external.hcp", false); // [DEFAULT]
pref("network.protocol-handler.external.help", false); // [HIDDEN - non-macOS] [DEFAULT - macOS]
pref("network.protocol-handler.external.htp", false); // [DEFAULT]
pref("network.protocol-handler.external.htps", false); // [DEFAULT]
pref("network.protocol-handler.external.http", false); // [NO-MAIL] [HIDDEN]
pref("network.protocol-handler.external.https", false); // [NO-MAIL] [HIDDEN]
pref("network.protocol-handler.external.ie.http", false); // [DEFAULT]
pref("network.protocol-handler.external.iehistory", false); // [DEFAULT]
pref("network.protocol-handler.external.ierss", false); // [DEFAULT]
pref("network.protocol-handler.external.ile", false); // [DEFAULT]
pref("network.protocol-handler.external.javascript", false); // [DEFAULT]
pref("network.protocol-handler.external.le", false); // [DEFAULT]
pref("network.protocol-handler.external.mk", false); // [DEFAULT]
pref("network.protocol-handler.external.moz", false); // [HIDDEN]
pref("network.protocol-handler.external.moz-extension", false); // [HIDDEN]
pref("network.protocol-handler.external.moz-icon", false); // [DEFAULT]
pref("network.protocol-handler.external.moz-sbrs", false); // [HIDDEN]
pref("network.protocol-handler.external.ms-cxh", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-cxh-full", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-help", false); // [DEFAULT]
pref("network.protocol-handler.external.ms-msdt", false); // [DEFAULT]
pref("network.protocol-handler.external.obtainium", true); // [HIDDEN] Ensure we do not try to handle Obtainium app installation internally...
pref("network.protocol-handler.external.ps", false); // [DEFAULT]
pref("network.protocol-handler.external.res", false); // [DEFAULT]
pref("network.protocol-handler.external.resource", false); // [HIDDEN]
pref("network.protocol-handler.external.search", false); // [DEFAULT]
pref("network.protocol-handler.external.search-ms", false); // [DEFAULT]
pref("network.protocol-handler.external.shell", false, locked); // [DEFAULT] Never expose shell access https://www.stigviewer.com/stig/mozilla_firefox/2019-12-12/finding/V-15771
pref("network.protocol-handler.external.tps", false); // [DEFAULT]
pref("network.protocol-handler.external.ttp", false); // [DEFAULT]
pref("network.protocol-handler.external.ttps", false); // [DEFAULT]
pref("network.protocol-handler.external.vbscript", false); // [DEFAULT]
pref("network.protocol-handler.external.view-source", false); // [HIDDEN]
pref("network.protocol-handler.external.vnd.ms.radio", false); // [DEFAULT]
pref("network.protocol-handler.warn-external.file", true); // [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.ftp", true); // [HIDDEN - non-Thunderbird] [DEFAULT - non-Thunderbird]
pref("network.protocol-handler.warn-external.mailto", true); // [HIDDEN - Thunderbird] [DEFAULT - non-Android/Firefox Desktop]
pref("network.protocol-handler.warn-external.shell", true, locked); // [HIDDEN] [DEFAULT]
pref("network.protocol-handler.warn-external.sms", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.tel", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external.vnd.youtube", true); // [HIDDEN - non-Android] [DEFAULT - non-Android]
pref("network.protocol-handler.warn-external-default", true); // [DEFAULT]

/// Decrease the lifetime of extension processes
// https://bugzilla.mozilla.org/show_bug.cgi?id=1847608
pref("dom.ipc.keepProcessesAlive.extension", 0); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Decrease the lifetime of privileged processes for `about:` pages
pref("dom.ipc.keepProcessesAlive.privilegedabout", 0);

/// Decrease the lifetime of web content processes
// https://bugzilla.mozilla.org/show_bug.cgi?id=1447393
pref("dom.ipc.keepProcessesAlive.web", 0); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Disable GNOME Integration [LINUX-ONLY]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/shell/nsGNOMEShellService.cpp#77 [LINUX-ONLY]
pref("browser.gnome-search-provider.enabled", false); // [LINUX-ONLY] [HIDDEN]

/// Disable Navigator Media Objects & getUserMedia Support in insecure contexts
// https://developer.mozilla.org/docs/Web/API/Navigator/mediaDevices
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#12475
pref("media.devices.insecure.enabled", false); // [DEFAULT]
pref("media.getusermedia.insecure.enabled", false); // [DEFAULT]


/// Do not allow additional ports by default
// This is just to expose the preference via the `about:config`
pref("network.security.ports.banned.override", ""); // [HIDDEN] [DEFAULT]



/// Enable content process sandboxing [NO-ANDROID]
// These are especially useful for ex. Thunderbird, which seems to disable sandboxing by default... [NO-ANDROID]
// Sandboxing is obviously critical from a security perspective as well, so doesn't hurt IMO to explicitly enable here [NO-ANDROID]
pref("security.sandbox.content.level", 6); // [LINUX-ONLY] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#1596

/// Enable the Cross-Origin-Embedder Policy Header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Cross-Origin-Embedder-Policy
pref("browser.tabs.remote.coep.credentialless", true); // [DEFAULT - non-Android stable] 'credentialless' 
pref("browser.tabs.remote.useCrossOriginEmbedderPolicy", true); // [DEFAULT]
pref("dom.origin-trials.coep-credentialless.state", 1); // 'credentialless' 

/// Enable the Cross-Origin-Opener Policy Header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Cross-Origin-Opener-Policy
pref("browser.tabs.remote.useCrossOriginOpenerPolicy", true); // [DEFAULT]

/// Enable Element.setHTML
// https://bugzilla.mozilla.org/show_bug.cgi?id=1805632
// https://webdocs.dev/en-us/docs/web/api/element/sethtml
pref("dom.security.setHTML.enabled", true);

/// Enable GPU Sandboxing
// https://www.ghacks.net/2023/01/17/firefox-110-will-launch-with-gpu-sandboxing-on-windows/
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/win/src/sandboxbroker/sandboxBroker.cpp#1293
// https://searchfox.org/firefox-main/rev/82e2435f/security/sandbox/chromium/sandbox/win/src/security_level.h#38
pref("security.sandbox.gpu.level", 2); // [1 = USER_RESTRICTED_NON_ADMIN (Default: Windows), 2 = USER_LIMITED (Stricter)]

/// Enable the Integrity-Policy header
// https://developer.mozilla.org/docs/Web/HTTP/Reference/Headers/Integrity-Policy
pref("security.integrity_policy.enabled", true); // [DEFAULT - Nightly]
pref("security.integrity_policy.stylesheet.enabled", true); // [NIGHTLY]

/// Enable Opaque Response Blocking
// https://github.com/annevk/orb
pref("browser.opaqueResponseBlocking", true); // [DEFAULT - non-Android]
pref("browser.opaqueResponseBlocking.javascriptValidator", true); // [DEFAULT]

/// Enable Origin-keyed agent clustering by default (Like Chromium)
// https://chromeenterprise.google/policies/#OriginAgentClusterDefaultEnabled
// https://developer.chrome.com/blog/immutable-document-domain/
pref("dom.origin_agent_cluster.default", true);
pref("dom.origin_agent_cluster.enabled", true); // [DEFAULT]

/// Enforce Per-site Process Isolation + isolate all websites
// https://wiki.mozilla.org/Project_Fission
pref("browser.sessionstore.disable_platform_collection", false); // [DEFAULT - non-Thunderbird]
pref("fission.autostart", true); // [DEFAULT - non-Android]
pref("fission.autostart.session", true); // [DEFAULT - non-Android]
pref("fission.disableSessionHistoryInParent", false); // [DEFAULT - non-Android] SHIP, required for Fission
pref("fission.highValue.login.monitor", true); // [DEFAULT - Android] Ensure that we are always marking log-in attempts as "high value", even if Fission is disabled - for if/when users decide to enable it later https://searchfox.org/firefox-main/rev/d88792ab/dom/ipc/LoginDetectionService.cpp#64
pref("fission.webContentIsolationStrategy", 1); // [DEFAULT - non-Android] Isolate everything https://searchfox.org/firefox-main/rev/d88792ab/dom/ipc/ProcessIsolation.cpp#50
pref("gfx.webrender.all", true);

/// Enable the Sanitizer API
// https://github.com/WICG/sanitizer-api
pref("dom.security.sanitizer.enabled", true);


/// Enable socket process sandboxing
// https://bugzilla.mozilla.org/show_bug.cgi?id=1608558
pref("security.sandbox.socket.process.level", 1); // [DEFAULT - Linux, non-Thunderbird]

/// Enable Spectre mitigations for isolated content
// Also enabled by ex. Tor Browser
pref("javascript.options.spectre.disable_for_isolated_content", false);

/// Enable Trusted Types
// https://developer.mozilla.org/docs/Web/API/Trusted_Types_API
pref("dom.security.trusted_types.enabled", true); // [DEFAULT - Nightly]

/// Enable WebAssembly Memory Control
// https://github.com/WebAssembly/memory-control/blob/main/proposals/memory-control/Overview.md
pref("javascript.options.wasm_memory_control", true);

/// Enforce strict file:// Origin Policy
// https://stuffandnonsense.co.uk/blog/firefoxs_file_uri_origin_policy_and_web_fonts
// https://stackoverflow.com/questions/2856502/css-font-face-not-working-with-firefox-but-working-with-chrome-and-ie
pref("security.fileuri.strict_origin_policy", true); // [DEFAULT]

/// Enforce various important security-related prefs
pref("dom.block_external_protocol_in_iframes", true); // [DEFAULT]
pref("dom.block_external_protocol_navigation_from_sandbox", true); // [DEFAULT]
pref("security.all_resource_uri_content_accessible", false); // [DEFAULT]
pref("security.allow_eval_in_parent_process", false); // [DEFAULT - non-Android/Thunderbird]
pref("security.allow_eval_with_system_principal", false); // [DEFAULT - non-Android]
pref("security.allow_parent_unrestricted_js_loads", false); // [DEFAULT - non-Android/Thunderbird]
pref("security.allow_unsafe_parent_loads", false); // [DEFAULT]
pref("security.data_uri.block_toplevel_data_uri_navigations", true); // [DEFAULT]

/// Ensure we block old/obsolete libavcodec libraries
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/platforms/ffmpeg/FFmpegLibWrapper.cpp#61
pref("media.libavcodec.allow-obsolete", false); // [DEFAULT]

/// If WebGL is enabled, force it to be loaded out of process
pref("webgl.out-of-process", true); // [DEFAULT]
pref("webgl.out-of-process.force", true);
pref("webgl.out-of-process.worker", true); // [DEFAULT]


/// Never skip the assertion that about:pages don't have content security policies (CSP)
// This is default on Standard Firefox releases, but not on ex. Thunderbird & other builds
pref("dom.security.skip_about_page_has_csp_assert", false); // [DEFAULT - non-Thunderbird]

/// Prefer to create new content processes, instead of re-using existing ones
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#2034
pref("browser.tabs.remote.subframesPreferUsed", false);

/// Prevent marking JIT code pages as both writable and executable, only one or the other...
// Might cause issues in certain specific set-ups
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876632
pref("javascript.options.content_process_write_protect_code", true); // [DEFAULT - OpenBSD?]

/// Prevent AutoConfig files (if being used) from gaining privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
// https://searchfox.org/firefox-main/rev/82e2435f/extensions/pref/autoconfig/src/nsReadConfig.cpp#148
pref("general.config.sandbox_enabled", true, locked); // [HIDDEN] [DEFAULT]

/// Prevent remoteTypes from triggering process switches they shouldn't be able to...
// https://searchfox.org/firefox-main/rev/82e2435f/dom/ipc/ContentParent.cpp#5535
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#1917
pref("browser.tabs.remote.enforceRemoteTypeRestrictions", true); // [DEFAULT - Nightly Desktop]

/// Protect against CSRF Attacks (Like Chromium)
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/6PZtLH7c6JQ
// https://hacks.mozilla.org/2020/08/changes-to-samesite-cookie-behavior/
// https://web.dev/articles/samesite-cookies-explained
// https://help.salesforce.com/s/articleView?id=000389944&type=1
// https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions
// https://web.dev/articles/schemeful-samesite
pref("network.cookie.sameSite.laxByDefault", true);
pref("network.cookie.sameSite.noneRequiresSecure", true); // [DEFAULT]
pref("network.cookie.sameSite.schemeful", true); // [DEFAULT - Nightly]

/// Protect against MIME Exploits
// https://www.pcmag.com/encyclopedia/term/mime-exploit
pref("dom.workers.importScripts.enforceStrictMimeType", true); // [DEFAULT]
pref("network.sniff.use_extension", true); // Sniff content types based on file extensions (Default only does this for `file://` URLs)
pref("security.block_fileuri_script_with_wrong_mime", true);
pref("security.block_Worker_with_wrong_mime", true); // [DEFAULT]

/// Sandbox AudioIPC (cubeb)
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#11215
pref("media.cubeb.sandbox", true); // [DEFAULT]

/// Use a separate content process for `file://` URLs
pref("browser.tabs.remote.separateFileUriProcess", true); // [DEFAULT - non-Android]

/// Warn on unprivileged namespaces [LINUX-ONLY]
pref("security.sandbox.warn_unprivileged_namespaces", true); // [LINUX-ONLY] [DEFAULT]

/// Yes, this is a real pref... 
// https://searchfox.org/firefox-main/rev/82e2435f/js/xpconnect/src/nsXPConnect.cpp#1167
pref("security.turn_off_all_security_so_that_viruses_can_take_over_this_computer", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "023");

/*** 024 MISC. ***/

/// Block pop-ups by default
pref("dom.disable_open_during_load", true); // [DEFAULT - non-Thunderbird]

/// Block websites from prompting to display notifications by default [NO-MAIL]
// I have yet to see a legitimate use-case for websites using push notifications... [NO-MAIL]
// but I see them constantly abused for malicious purposes & spam :/ [NO-MAIL]
// `notification.prompt.testing.allow` is used when `notification.prompt.testing` is set to `true` - when `notification.prompt.testing` is set to false, the site permissions are followed like normal instead [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/base/nsContentPermissionHelper.h#144 [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/dom/base/nsContentPermissionHelper.cpp#493 [NO-MAIL]
pref("permissions.default.desktop-notification", 2); // [NO-ANDROID] [NO-MAIL]

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
pref("network.trr.wait-for-portal", false); // [DEFAULT] Do not wait for captive portal to enable DoH https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#14839

/// Disable Firefox's "Reset/Refresh Profile" prompt [NO-ANDROID] [NO-MAIL]
// This could cause Phoenix users serious issues, especially those with custom configs/user.js files... [NO-ANDROID] [NO-MAIL]
// We also configure the "DisableProfileRefresh" policy [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/policy-templates/#disableprofilerefresh [NO-ANDROID] [NO-MAIL]
pref("browser.disableResetPrompt", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable network connectivity status monitoring
// (Ex. used for automatically switching between offline & online mode)
// https://bugzilla.mozilla.org/show_bug.cgi?id=620472
pref("network.manage-offline-status", false);
pref("network.offline-mirrors-connectivity", false); // [DEFAULT]
pref("offline.autoDetect", false); // [LINUX-ONLY] RedHat/Fedora-specific
pref("toolkit.networkmanager.disable", true); // [LINUX-ONLY] RedHat/Fedora-specific

/// Disable network requests to 0.0.0.0
// Appears to mitigate a (potentially severe?) privacy/security issue, but bug is confidential so I'm unable to find actual details...
// This is also being set by Tor Browser
// https://bugzilla.mozilla.org/show_bug.cgi?id=1889130
pref("network.socket.ip_addr_any.disabled", true); // [DEFAULT - Nightly]

/// Disable WebVTT Testing Events
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/webvtt/HTMLTrackElement.cpp#530
pref("media.webvtt.testing.events", false); // [DEFAULT]

/// Enable Firefox's newer 'Felt privacy' design for Certificate Errors
pref("security.certerrors.felt-privacy-v1", true); // [HIDDEN - Android/Thunderbird]

/// Enable Firefox's newer 'Felt privacy' design for Private Browsing [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.felt-privacy-v1", true); // [NO-ANDROID] [NO-MAIL]

/// Enable GREASE (Generate Random Extensions And Sustain Extensibility)
// This indirectly improves security for users, by ensuring that future TLS extensions/implementations are properly supported by websites
// For reference, this is enabled/always enforced by Chromium
// https://groups.google.com/a/chromium.org/g/security-dev/c/d_f6higCJzc
pref("security.tls.ech.disable_grease_on_fallback", false); // [DEFAULT]
pref("security.tls.ech.grease_http3", true); // [DEFAULT]
pref("security.tls.ech.grease_probability", 100); // [DEFAULT] Sets probability of using GREASE for ECH to 100%
pref("security.tls.grease_http3_enable", true);

/// Enable more detailed property error messages
pref("javascript.options.property_error_message_fix", true); // [DEFAULT - Nightly/Developer]

/// Ensure that holding shift bypasses context menu events
// (When holding shift, this prevents websites from hijacking the right click/context menu)
// https://developer.mozilla.org/docs/Web/API/Element/contextmenu_event
pref("dom.event.contextmenu.shift_suppresses_event", true); // [DEFAULT]

/// Force pop-up windows to open in new tabs instead
pref("browser.link.open_newwindow", 3); // [DEFAULT]
pref("browser.link.open_newwindow.restriction", 0); // [DEFAULT - Android/Thunderbird]

/// Limit what events can cause pop-ups
pref("dom.popup_allowed_events", "click dblclick");

/// Notify on Pop-up blocking by default [NO-ANDROID] [NO-MAIL]
pref("privacy.popups.showBrowserMessage", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Open links from external programs in new tabs by default [NO-ANDROID] [NO-MAIL]
pref("browser.link.open_newwindow.override.external", 3); // [NO-ANDROID] [NO-MAIL]

/// Prevent Safe Mode from automatically starting by default
// This causes ex. all extensions (such as uBlock Origin) to be disabled
// Users can still manually start Safe Mode from the command line if needed
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#2142
pref("toolkit.startup.max_resumed_crashes", -1); // [HIDDEN - non-Firefox Desktop]

/// Prevent scripts from moving, resizing, and messing with windows
pref("dom.allow_scripts_to_close_windows", false); // [DEFAULT]
pref("dom.disable_window_flip", true); // [DEFAULT - non-Android]
pref("dom.disable_window_move_resize", true); // [DEFAULT - Android]

/// Prevent websites from automatically refreshing
pref("accessibility.blockautorefresh", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.meta_refresh_when_inactive.disabled", true); // [DEFAULT - Android]

/// Reject invalid cookies
// https://searchfox.org/firefox-release/rev/9d94f5e3/modules/libpref/init/all.js#1791
pref("extensions.cookie.rejectWhenInvalid", true); // [NIGHTLY]

/// Show 'Always ask' for camera & microphone in the permissions drop-down (when that's what the user chose...) [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#933 [NO-ANDROID] [NO-MAIL]
pref("permissions.media.show_always_ask.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Show an error page/details instead of a blank page for HTTP responses with certain error codes (ex. 4xx, 5xx, & Content-Length: 0)
// ex. https://ozuma.sakura.ne.jp/httpstatus/400
pref("browser.http.blank_page_with_error_response.enabled", false); // [DEFAULT - non-Android]

/// Set certain default site permissions [NO-ANDROID] [NO-MAIL]
// These match Firefox's default settings, but, the prefs are hidden by default - so this exposes them at `about:config` [NO-ANDROID] [NO-MAIL]
pref("permissions.default.focus-tab-by-prompt", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Tab focus/switching - 0: Always ask, 1: Allow
pref("permissions.default.persistent-storage", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Persistent storage - 0: Always ask, 1: Allow, 2: Block
pref("permissions.default.screen", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Screensharing - 0: Always ask, 2: Block
pref("permissions.default.speaker", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Speaker Selection - 0: Always ask, 2: Block

pref("browser.phoenix.status", "024");

/*** 025 DEBUGGING ***/

/// Allow inspecting the browser chrome by default
pref("devtools.chrome.enabled", true); // [DEFAULT - Thunderbird]

/// Allow inspecting the DOM by default [NO-ANDROID]
pref("devtools.dom.enabled", true); // [NO-ANDROID]

/// Allow inspecting/debugging local tabs from `about:debugging` by default [NO-ANDROID]
// Useful, especially for Thunderbird, as it gives us a URL bar... [NO-ANDROID]
// On Thunderbird, you can use it by navigating to `Tools` -> `Developer Tools` -> `Debug Add-ons` (`about:debugging`), and choosing `Inspect` next to any tab... [NO-ANDROID]
pref("devtools.aboutdebugging.local-tab-debugging", true); // [NO-ANDROID] [DEFAULT - non-MOZILLA_OFFICIAL builds]

/// Allow inspecting/debugging processes from `about:debugging` by default [NO-ANDROID]
pref("devtools.aboutdebugging.process-debugging", true); // [NO-ANDROID] [DEFAULT]

/// Always prompt before connecting to Remote Debugging...
pref("devtools.debugger.prompt-connection", true, locked); // [DEFAULT - non-Nightly]

/// "Beautify" HTML content upon copy to the clipboard by default [NO-ANDROID]
pref("devtools.markup.beautifyOnCopy", true); // [NO-ANDROID]

/// Disable annoying "A simpler highlighter can be enabled in the settings..." banner when using developer tools [NO-ANDROID]
pref("devtools.inspector.simple-highlighters.message-dismissed", true); // [NO-ANDROID] [HIDDEN]

/// Disable annoying "Firefox Profiler is now integrated into Developer Tools" banner when opening the performance panel [NO-ANDROID]
pref("devtools.performance.new-panel-onboarding", false); // [NO-ANDROID] [HIDDEN]

/// Disable editor onboarding [NO-ANDROID]
pref("devtools.webconsole.input.editorOnboarding", false); // [NO-ANDROID]

/// Disable JS dump()
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/all.js#602
pref("browser.dom.window.dump.enabled", false); // [DEFAULT - non-Android, desktop `MOZILLA_OFFICIAL` builds]

/// Disable network monitoring by default [NO-ANDROID]
pref("devtools.browserconsole.enableNetworkMonitoring", false); // [NO-ANDROID] [DEFAULT]

/// Disable pausing on debugger statements by default [NO-ANDROID]
pref("devtools.debugger.pause-on-debugger-statement", false); // [NO-ANDROID]

/// Disable the performance panel intro [NO-ANDROID]
pref("devtools.performance.popup.intro-displayed", true); // [NO-ANDROID]

/// Disable Remote Debugging by default
// We also reset this per-session by setting it as a user pref in `phoenix-user-pref.cfg`
// https://firefox-source-docs.mozilla.org/devtools/backend/protocol.html
pref("devtools.debugger.remote-enabled", false); // [DEFAULT - non-Thunderbird]

/// Disable the Remote Debugging Web Socket
pref("devtools.debugger.remote-websocket", false, locked); // [DEFAULT]


/// Display content scripts injected by extensions when debugging by default [NO-ANDROID] [NO-MAIL]
pref("devtools.debugger.show-content-scripts", true); // [NO-ANDROID] [NO-MAIL]

/// Display Web Console timestamps by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/constants.js#81 [NO-ANDROID]
pref("devtools.webconsole.timestampMessages", true); // [NO-ANDROID]

/// Disable WebDriver BiDi experimental commands and events
// https://wiki.mozilla.org/WebDriver/RemoteProtocol/WebDriver_BiDi
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#25
pref("remote.experimental.enabled", false, locked); // [DEFAULT - non-Nightly]

/// Display responses in the "raw" format in the network monitor by default [NO-ANDROID]
pref("devtools.netmonitor.ui.default-raw-response", true); // [NO-ANDROID]

/// Enable the Anti tracking debug panel by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/644f0db1/devtools/client/definitions.js#485 [NO-ANDROID]
pref("devtools.anti-tracking.enabled", true); // [NO-ANDROID]

/// Enable automatic bracket/quote closing by default [NO-ANDROID]
pref("devtools.editor.autoclosebrackets", true); // [NO-ANDROID] [DEFAULT]

/// Enable DevTools buttons by default [NO-ANDROID]
pref("devtools.command-button-errorcount.enabled", true); // [NO-ANDROID] [DEFAULT] Error Count - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2209
pref("devtools.command-button-frames.enabled", true); // [NO-ANDROID] [DEFAULT] Frame Target - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2189
pref("devtools.command-button-measure.enabled", true); // [NO-ANDROID] Measure - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/themes/toolbox.css#541
pref("devtools.command-button-noautohide.enabled", true); // [NO-ANDROID] No Pop-up Autohide - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/framework/components/ToolboxToolbar.js#118
pref("devtools.command-button-pick.enabled", true); // [NO-ANDROID] [DEFAULT] Element picker https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/framework/toolbox.js#2333
pref("devtools.command-button-responsive.enabled", true); // [NO-ANDROID] [DEFAULT] Responsive - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#557
pref("devtools.command-button-rulers.enabled", true); // [NO-ANDROID] Ruler - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/themes/toolbox.css#537
pref("devtools.command-button-screenshot.enabled", true); // [NO-ANDROID] Screenshot - https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#588

/// Enable experimental DevTools preferences by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/definitions.js#550 [NO-ANDROID]
pref("devtools.command-button-experimental-prefs.enabled", true); // [NO-ANDROID] [HIDDEN - non-MOZILLA_OFFICIAL builds] [DEFAULT - non-MOZILLA_OFFICIAL builds]

/// Enable the Web Console sidebar toggle [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/webconsole-ui.js#46 [NO-ANDROID]
pref("devtools.webconsole.sidebarToggle", true); // [NO-ANDROID] [DEFAULT - Nightly]

/// Enforce local debugging only
pref("devtools.debugger.force-local", true, locked); // [DEFAULT]
pref("devtools.inspector.remote", false, locked); // [NO-ANDROID] [DEFAULT]

/// Enforce system access checks for WebDriver
// https://searchfox.org/firefox-esr140/rev/ba1d416c/remote/marionette/driver.sys.mjs#65
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#61
// https://bugzilla.mozilla.org/show_bug.cgi?id=1955007
pref("remote.system-access-check.enabled", true, locked); // [NO-ANDROID] [HIDDEN] [DEFAULT] [ESR]

/// Highlight syntax when viewing the source of webpages (via `view-source:`)
pref("view_source.syntax_highlight", true); // [DEFAULT - non-Thunderbird]


/// Pretty print code when debugging by default [NO-ANDROID]
pref("devtools.debugger.auto-pretty-print", true); // [NO-ANDROID]

/// Prevent automatically clearing log messages after page reloads/navigation [NO-ANDROID]
pref("devtools.netmonitor.persistlog", true); // [NO-ANDROID]
pref("devtools.webconsole.persistlog", true); // [NO-ANDROID]

/// Prevent console API from writing to `stdout` when used by chrome content
pref("devtools.console.stdout.chrome", false); // [DEFAULT - non-Android, `MOZILLA_OFFICIAL` builds]

/// Prevent filter queries/searches and recent selections from persisting across restarts [NO-ANDROID]
// (For this to be effective, these pref must be set as "user" prefs) [NO-ANDROID]
pref("devtools.debugger.pending-selected-location", "{}"); // [NO-ANDROID] [DEFAULT]
pref("devtools.netmonitor.requestfilter", ""); // [NO-ANDROID] [DEFAULT]

/// Prevent logging URLs in Reader errors
pref("reader.errors.includeURLs", false); // [DEFAULT - Android/Thunderbird]

/// Prevent WebDriver from overriding preferences by default
// https://searchfox.org/firefox-main/rev/82e2435f/remote/doc/Prefs.md#41
pref("remote.prefs.recommended", false);

/// Significantly reduce input history [NO-ANDROID]
pref("devtools.webconsole.inputHistoryCount", 10); // [NO-ANDROID] [DEFEAULT: 300]

/// Set Browser/Error Console scope to "Multiprocess" instead of "Parent process only" by default [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/devtools/client/webconsole/webconsole-ui.js#47 [NO-ANDROID]
pref("devtools.browsertoolbox.scope", "everything"); // [NO-ANDROID] [DEFAULT - Thunderbird] 

// Show default/browser styles in the Inspector by default [NO-ANDROID]
pref("devtools.inspector.showUserAgentStyles", true); // [NO-ANDROID]

/// Unbreak debugging if `localhost` can't be looked up via DNS [NO-ANDROID]
// (Ex. for Tor Browser) [NO-ANDROID]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16523 [NO-ANDROID]
pref("devtools.debugger.chrome-debugging-host", "127.0.0.1"); // [NO-ANDROID]

/// Wrap lines when debugging by default [NO-ANDROID]
// https://discourse.mozilla.org/t/long-line-wrapping-in-developer-tools-css-editor-and-debugger-code-views/47058 [NO-ANDROID]
pref("devtools.debugger.ui.editor-wrapping", true); // [NO-ANDROID]

/// Wrap lines when viewing the source of webpages (via `view-source:`)
pref("view_source.wrap_long_lines", true); // [DEFAULT - Android]

pref("browser.phoenix.status", "025");

/*** 026 PERFORMANCE ***/

// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

/// Compress cached JavaScript bytecode
// https://github.com/yokoffing/Betterfox/issues/247
// https://searchfox.org/firefox-main/rev/82e2435f/dom/script/ScriptCompression.cpp#99
// (Default = 0, which means it's off)
pref("browser.cache.jsbc_compression_level", 3);

/// Disable certain UI animations by default // [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/nsXPLookAndFeel.cpp#87 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/LookAndFeel.h#48 [NO-ANDROID]
pref("sidebar.animation.enabled", false); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/components/sidebar/browser-sidebar.js#2439
pref("ui.panelAnimations", 0); // [NO-ANDROID] [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [NO-ANDROID] [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [NO-ANDROID] [HIDDEN]

/// Disable CSS error reporting by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=831123
pref("layout.css.report_errors", false); // [DEFAULT - Android]

/// Disable extra extension logging by default
// https://searchfox.org/firefox-main/rev/82e2435f/browser/app/profile/firefox.js#29
pref("extensions.logging.enabled", false); // [DEFAULT]

/// Disable pacing requests
// https://codeberg.org/celenity/Phoenix/issues/84
pref("network.http.pacing.requests.enabled", false);

/// Display advanced performance settings at `about:preferences#general` [NO-ANDROID] [NO-MAIL]
// Despite what the name suggests, Firefox will remain at the default/recommended performance settings - all this does is expose the UI settings... [NO-ANDROID] [NO-MAIL]
pref("browser.preferences.defaultPerformanceSettings.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Enable Advanced Vector Extensions (AVX)
// https://wikipedia.org/wiki/Advanced_Vector_Extensions
// https://www.supportyourtech.com/articles/how-to-enable-avx-support-in-windows-11-a-step-by-step-guide/
pref("javascript.options.wasm_simd_avx", true);

/// Enable Branch Hinting
// https://github.com/WebAssembly/branch-hinting/blob/main/proposals/branch-hinting/Overview.md
pref("javascript.options.wasm_branch_hinting", true); // [DEFAULT - Nightly]

/// Enable Canvas2D acceleration (if supported)
// `gfx.canvas.accelerated.force-enabled` can be used to forcefully enable this acceleration, regardless of platform support
pref("gfx.canvas.accelerated", true); // [DEFAULT]
pref("gfx.canvas.accelerated.cache-items", 32768); // [Default = 8192, Chromium = 4096]
pref("gfx.canvas.accelerated.cache-size", 4096); // Increase cache size (Default = 256, Chromium = 512)

/// Enable CSS Masonry Layout
// https://www.smashingmagazine.com/native-css-masonry-layout-css-grid/
// (For testing: https://codepen.io/rachelandrew/pen/wvWmZWB)
pref("layout.css.grid-template-masonry-value.enabled", true); // [DEFAULT - Nightly/Thunderbird] 

/// Enable the "fetchpriority" attribute
// https://web.dev/articles/fetch-priority
pref("network.fetchpriority.enabled", true); // [DEFAULT]

/// Enable JS GC Parallel Marking
pref("javascript.options.mem.gc_parallel_marking", true); // [DEFAULT - non-Android]

/// Enable SIMD
// https://stackoverflow.blog/2020/07/08/improving-performance-with-simd-intrinsics-in-three-use-cases/
pref("javascript.options.wasm_relaxed_simd", true); // [DEFAULT - Nightly]

/// Enable VA-API by default [LINUX-ONLY] [NO-MAIL]
pref("media.ffmpeg.vaapi.enabled", true); // [LINUX-ONLY] [NO-MAIL]

/// Enable the WebRender native compositor (if supported)
// `gfx.webrender.compositor.force-enabled` can be used to forcefully enable this acceleration, regardless of platform support
pref("gfx.webrender.compositor", true); // [DEFAULT - macOS/Windows]


/// Increase buffering for video playback
// This doesn't apply to videos delivered via Media Source Extensions
// https://www.cloudflare.com/learning/video/what-is-buffering/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1540573
// https://searchfox.org/firefox-main/rev/82e2435f/dom/media/ChannelMediaDecoder.cpp#467
pref("media.cache_readahead_limit", 600); // (Default = 60)
pref("media.cache_readahead_limit.cellular", 600); // (Default = 30)
pref("media.cache_resume_threshold", 300); // (Default = 30)
pref("media.cache_resume_threshold.cellular", 300); // (Default = 10)
pref("media.throttle-cellular-regardless-of-download-rate", false); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Increase the chunk size for calls to image decoders
// (Default = 16384)
pref("image.mem.decode_bytes_at_a_time", 65536);

/// Increase DNS caching
pref("network.dnsCacheExpiration", 3600); // (Default = 60)
pref("network.dnsCacheExpirationGracePeriod", 120); // (Default = 60)
pref("network.dnsCacheEntries", 10000); // (Default = 800)

/// Increase the file-backed media cache size for cellular connections
// (Default = 32768)
// This is set to match the value of "media.cache_size"
pref("media.cache_size.cellular", 512000);

/// Increase the image cache size
// (Default = 5242880 - non-Android, 1048576 - Android)
pref("image.cache.size", 10485760);

/// Increase the memory-backed media cache size
pref("media.memory_cache_max_size", 262144); // (Default = 8192)
pref("media.memory_caches_combined_limit_kb", 1048576); // (Default = 524288)

/// Increase memory cache
pref("browser.cache.memory.capacity", 131072); // (Default = -1)
pref("browser.cache.memory.max_entry_size", 20480); // (Default = 5120)

/// Increase the skia font cache size (Similar to Chromium)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1239151#c2
// (Default = 5, Chromium = 20)
pref("gfx.content.skia-font-cache-size", 32);

/// Increase the maximum number of HTTP connections
pref("network.http.max-connections", 1800); // (Default = 128 for Android, 900 elsewhere)
pref("network.http.max-persistent-connections-per-proxy", 48); // (Default = 20 for Android, 32 elsewhere)
pref("network.http.max-persistent-connections-per-server", 10); // (Default = 6)
pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // (Default = 3)
pref("network.http.request.max-start-delay", 5); // (Default = 10)

/// Increase TLS token caching
// https://codeberg.org/celenity/Phoenix/issues/84
// https://searchfox.org/firefox-main/rev/82e2435f/netwerk/base/SSLTokensCache.cpp#491
// (Default = 2048)
pref("network.ssl_tokens_cache_capacity", 10240);

/// Use higher performance pinch-zoom
// https://searchfox.org/firefox-main/rev/82e2435f/modules/libpref/init/StaticPrefList.yaml#8039
pref("gfx.webrender.low-quality-pinch-zoom", true); // [DEFAULT - Android Nightly]

pref("browser.phoenix.status", "026");

/*** 027 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Allow downloading and switching locales [NO-ANDROID]
pref("app.update.langpack.enabled", true); // [NO-ANDROID] [DEFAULT]
pref("intl.multilingual.downloadEnabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]
pref("intl.multilingual.enabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]

/// Allow Picture-in-Picture on all websites, even if they try to block it...
pref("media.videocontrols.picture-in-picture.respect-disablePictureInPicture", false);

/// Allow zoom by default...
pref("apz.allow_zooming", true); // [DEFAULT]

/// Allow zoom on all websites, even if the website tries to block it...
// (This is the `Zoom on all websites` UI setting for Android)
pref("browser.ui.zoom.force-user-scalable", true);

/// Allow zooming out beyond the initial scale of websites by default
// https://searchfox.org/firefox-main/rev/82e2435f/gfx/layers/apz/src/AsyncPanZoomController.cpp#155
pref("apz.allow_zooming_out", true);

/// Allow the use of custom CSS by default [NO-ANDROID]
pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [NO-ANDROID]

/// Always display the Bookmarks toolbar by default [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/bookmarks-toolbar-display-favorite-websites [NO-ANDROID] [NO-MAIL]
pref("browser.toolbars.bookmarks.visibility", "always"); // [NO-ANDROID] [NO-MAIL]

/// Always load bookmarks in new tabs by default [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.loadBookmarksInTabs", true); // [NO-ANDROID] [NO-MAIL]

/// Clean-up default UI [NO-ANDROID] [NO-MAIL]
pref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","screenshot-button","back-button","forward-button","vertical-spacer","stop-reload-button","urlbar-container","_testpilot-containers-browser-action","fxa-toolbar-menu-button","reset-pbm-toolbar-button","developer-button","ublock0_raymondhill_net-browser-action","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","developer-button","_testpilot-containers-browser-action","ublock0_raymondhill_net-browser-action","screenshot-button"],"dirtyAreaCache":["nav-bar","vertical-tabs","PersonalToolbar","unified-extensions-area","TabsToolbar","toolbar-menubar"],"currentVersion":23,"newElementCount":8}'); // [NO-ANDROID] [NO-MAIL]

/// Disable annoying Web Speech API error pop-ups, especially relevant on Linux [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/actors/SpeechDispatcherParent.sys.mjs#7 [NO-ANDROID]
pref("media.webspeech.synth.dont_notify_on_error", true); // [NO-ANDROID] [HIDDEN]

/// Disable extra logging for policies by default [NO-MAIL] 
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in `about:config` [NO-MAIL] 
// https://searchfox.org/firefox-main/rev/16707ce1/browser/components/enterprisepolicies/Policies.sys.mjs#35 [NO-ANDROID] [NO-MAIL] 
pref("browser.policies.loglevel", "error"); // [NO-MAIL] [HIDDEN] [DEFAULT]

/// Disable fullscreen delay
pref("full-screen-api.transition-duration.enter", "0 0"); // [Default = 200 200]
pref("full-screen-api.transition-duration.leave", "0 0"); // [Default = 200 200]

/// Display "More settings" on print previews by default
// https://searchfox.org/firefox-main/rev/643d7328/modules/libpref/init/all.js#761
pref("print.more-settings.open", true);

/// Display the option to enable `Compact` mode at `Customize toolbar...` [NO-ANDROID] [NO-MAIL]
pref("browser.compactmode.show", true); // [NO-ANDROID] [NO-MAIL]

/// Display a spinning animation while websites are loading [NO-ANDROID] [NO-MAIL]
pref("browser.spin_cursor_while_busy", true); // [NO-ANDROID] [NO-MAIL]

/// Enable autoscrolling by default
pref("apz.autoscroll.enabled", true); // [DEFAULT]
pref("general.autoScroll", true); // [HIDDEN - Android] [DEFAULT - non-Android/Unix (excluding macOS, where it is on by default)]

/// Enable Backup settings (at `about:preferences#general`) by default [NO-ANDROID] [NO-MAIL]
pref("browser.backup.preferences.ui.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Enable + customize the new Sidebar by default [NO-ANDROID] [NO-MAIL]
pref("browser.toolbarbuttons.introduced.sidebar-button", false); // [NO-ANDROID] [NO-MAIL] Prevents Sidebar from automatically opening and closing on first launch - also needs `browser.uiCustomization.state`
pref("sidebar.backupState", '{"command":"","launcherWidth":0,"launcherExpanded":false,"launcherVisible":false}'); // [NO-ANDROID] [NO-MAIL] Hide by default
pref("sidebar.main.tools", "bookmarks,syncedtabs,history"); // [NO-ANDROID] [NO-MAIL] Removes AI Chat, adds Bookmarks
pref("sidebar.revamp", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]
pref("sidebar.visibility", "hide-sidebar"); // [NO-ANDROID] [NO-MAIL] Hide by default

/// Enable developer options for `about:profiling`
pref("devtools.performance.aboutprofiling.has-developer-options", true);

/// Enable display of in-process subframes at `about:processes` by default
pref("toolkit.aboutProcesses.showAllSubframes", true);

/// Enable display of thread information at `about:processes` by default
pref("toolkit.aboutProcesses.showThreads", true); // [DEFAULT - Nightly]

/// Enable Firefox Translations (+ the pop-up) by default [NO-MAIL]
// Translations are done locally - very nice to have [NO-MAIL]
// https://support.mozilla.org/kb/website-translation [NO-MAIL]
// Currently broken on Thunderbird :( [NO-MAIL]
pref("browser.translations.automaticallyPopup", true); // [NO-MAIL] [DEFAULT]
pref("browser.translations.enable", true); // [NO-MAIL] [DEFAULT - non-Thunderbird]
pref("browser.translations.select.enable", true); // [NO-MAIL] [DEFAULT - non-Android/Thunderbird]
pref("browser.translations.newSettingsUI.enable", true); // [NO-ANDROID] [NO-MAIL] Enables the new UI at `about:preferences#general`
pref("browser.translations.simulateUnsupportedEngine", false); // [NO-MAIL] [DEFAULT]
pref("extensions.translations.disabled", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Enables `Exceptions` UI at `about:preferences#general`

/// Enable IPv6
// Important, nice to have
pref("network.dns.disableIPv6", false); // [DEFAULT]

/// Enable overscrolling by default
// https://www.omgubuntu.co.uk/2024/09/mozilla-firefox-130-new-features
pref("apz.overscroll.enabled", true); // [DEFAULT]

/// Enable the "Page Setup.." menu by default (under `File` - ex. on the menu bar)
// https://searchfox.org/firefox-main/rev/643d7328/modules/libpref/init/all.js#729
// https://searchfox.org/firefox-main/rev/643d7328/toolkit/components/printing/content/printUtils.js#82
pref("print.show_page_setup_menu", true);

/// Enable smooth scrolling by default
// This currently appears to be overriden by `ui.prefersReducedMotion` on Desktop
pref("general.smoothScroll", true); // [DEFAULT]

/// Enable Spellcheck for both multi-line and single-line boxes [NO-ANDROID]
// [Default = 1, only checks multi-line boxes] [NO-ANDROID]
// https://codeberg.org/celenity/Phoenix/issues/33 [NO-ANDROID]
pref("layout.spellcheckDefault", 2); // [NO-ANDROID]

/// Enable support for web applications manifests [NO-MAIL]
// Ex. required for PWAs (& PWA inspection on desktop) [NO-MAIL]
// https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1603673 [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1647858 [NO-MAIL]
pref("dom.manifest.enabled", true); // [NO-MAIL] [DEFAULT]

/// Enable Tab Groups [NO-ANDROID] [NO-MAIL]
// https://www.ghacks.net/2024/12/03/how-to-enable-tab-groups-in-firefox/ [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.groups.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]

/// Enable Taskbar Tabs (PWAs) by default [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1915736 [NO-ANDROID] [NO-MAIL]
// https://windowsreport.com/firefox-is-bringing-web-apps-to-windows-11-with-taskbar-tabs-first-look/ [NO-ANDROID] [NO-MAIL]
pref("browser.taskbarTabs.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Enable the `Unload Tab` context menu item by default [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.unloadTabInContextMenu", true); // [NO-ANDROID] [NO-MAIL]

/// Enable the `View Image Info` context menu item by default [NO-ANDROID] [NO-MAIL]
pref("browser.menu.showViewImageInfo", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Developer Edition]


/// Ensure users can always control Nimbus recipes
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#692
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#952
pref("nimbus.debug", true); // [HIDDEN - non-Firefox Desktop]
pref("nimbus.validation.enabled", false); // [HIDDEN - non-Firefox Desktop]

/// Export bookmarks to a `bookmarks.html` file by default [NO-ANDROID] [NO-MAIL]
pref("browser.bookmarks.autoExportHTML", true); // [NO-ANDROID] [NO-MAIL]

/// Expose hidden UI preferences at about:config [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/nsXPLookAndFeel.cpp#87 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/82e2435f/widget/LookAndFeel.h#48 [NO-ANDROID]
pref("ui.hideCursorWhileTyping", 1); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.prefersReducedTransparency", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.scrollToClick", 1); // [NO-ANDROID] [HIDDEN]
pref("ui.useAccessibilityTheme", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]

/// Fade out unloaded tabs in the tab bar [NO-ANDROID] [NO-MAIL]
// By default, Firefox only fades tabs unloaded explicitly (`browser.tabs.fadeOutExplicitlyUnloadedTabs`), but, with `browser.tabs.fadeOutUnloadedTabs`, we can fade all unloaded tabs, regardless of the reason they're unloaded [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/1a8c62b8/browser/app/profile/firefox.js#2650 [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.fadeOutExplicitlyUnloadedTabs", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.tabs.fadeOutUnloadedTabs", true); // [NO-ANDROID] [NO-MAIL]

/// Hide the Title Bar by default
pref("browser.tabs.inTitlebar", 1);

/// Highlight all Findbar (Ctrl + F) results by default
pref("findbar.highlightAll", true);

/// Prevent the alt key from toggling menu bar by default
pref("ui.key.menuAccessKeyFocuses", false); // [DEFAULT - non-Windows/Linux]

/// Prevent displaying Private Browsing windows as separate icons on the Windows Taskbar by default [NO-ANDROID] [NO-MAIL]
pref("browser.privateWindowSeparation.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Prevent including the space next to words when double-clicking/selecting text
// https://codeberg.org/celenity/Phoenix/issues/84#issuecomment-3097957
pref("layout.word_select.eat_space_to_next_word", false); // [DEFAULT - non-Windows]

/// Set the default log level for Background Tasks
// This is the default value - this just exposes the pref via the `about:config`
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/backgroundtasks/BackgroundTasksManager.sys.mjs#18
pref("toolkit.backgroundtasks.loglevel", "error"); // [HIDDEN] [DEFAULT]

/// Set the default log level for Remote Settings
// This is the default value - this just exposes the pref via the `about:config`
pref("services.settings.loglevel", "warn"); // [HIDDEN] [DEFAULT]

/// Set default URL to load when navigating to `moz://a`
// Default is https://www.mozilla.org/about/manifesto/
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/mozprotocol/MozProtocolHandler.sys.mjs#10
pref("toolkit.mozprotocol.url", "about:mozilla"); // [HIDDEN]

/// Prevent automatically closing the Bookmarks menu after selecting a bookmark [NO-ANDROID] [NO-MAIL]
pref("browser.bookmarks.openInTabClosesMenu", false); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "027");

/*** 028 UPDATES ***/

// Ensure the browser's binary is always old enough to check for browser updates [NO-ANDROID]
pref("app.update.checkInstallTime.days", 0); // [NO-ANDROID]

/// Alert users of browser updates ASAP [NO-ANDROID]
pref("app.update.badgeWaitTime", 0); // [NO-ANDROID] Immediately show badge on hamburger menu when an update is available
pref("app.update.notifyDuringDownload", true); // [NO-ANDROID] Ensure that users are notified when an update is downloaded
pref("app.update.promptWaitTime", 0); // [NO-ANDROID] Immediately prompt users to update when an update is ready

/// Automatically update extensions by default
pref("extensions.systemAddon.update.enabled", true); // [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#1317
pref("extensions.systemAddon.update.url", "https://aus5.mozilla.org/update/3/SystemAddons/%VERSION%/%BUILD_ID%/%BUILD_TARGET%/%LOCALE%/%CHANNEL%/%OS_VERSION%/%DISTRIBUTION%/%DISTRIBUTION_VERSION%/update.xml"); // [HIDDEN - Thunderbird] [DEFAULT - non-Thunderbird]
pref("extensions.update.autoUpdateDefault", true); // [HIDDEN - ANDROID] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#4580
pref("extensions.update.enabled", true); // [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/AddonManager.sys.mjs#1348

/// Check for browser updates hourly [NO-ANDROID]
pref("app.update.background.interval", 3600); // [NO-ANDROID] (Default: 25200 (7 hours))
pref("app.update.interval", 3600); // [NO-ANDROID] (Default: 21600 (6 hours))

/// Check for extension/theme updates hourly
// Default is once every 24 hours
pref("extensions.update.interval", 3600);

/// Disable insecure extension updates
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/AddonUpdateChecker.sys.mjs#66
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#2707
pref("extensions.checkUpdateSecurity", true); // [HIDDEN] [DEFAULT]

/// Sync with Remote Settings hourly, rather than the default of only once a day
// This is used for delivering lots of security-critical databases (Ex. CRLite/revocation checks, malicious add-on blocklists, etc...)
// So let's make sure our users are up to date as quick as possible
pref("services.settings.poll_interval", 3600);

pref("browser.phoenix.status", "028");

/*** 029 FIREFOX HOME ***/

/// Disable AccuWeather by default, but allow users to enable it if desired [NO-ANDROID] [NO-MAIL]
// NOTE: This depends on Merino: `browser.urlbar.merino.endpointURL`, and the AccuWeather provider must be allowed: `browser.urlbar.merino.providers`) [NO-ANDROID] [NO-MAIL]
// NOTE: We also warn users before navigating to AccuWeather if they select the widget, via uBlock Origin, so that this feature can be used safely without directly navigating to AccuWeather's website (which includes ads/tracking/etc.) [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showWeather", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.system.showWeather", true); // [NO-ANDROID] [NO-MAIL] UI

/// Disable adult content filtering by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/modules/FilterAdult.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.filterAdult", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable Contile (Sponsored tiles) [NO-ANDROID] [NO-MAIL]
// https://mozilla-services.github.io/contile/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/TopSitesFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.contile.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#993
pref("browser.topsites.contile.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.contile.sov.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-release/rev/9d94f5e3/toolkit/components/nimbus/FeatureManifest.yaml#2007

/// Disable Fakespot [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.fakespot.enabled", false); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-release/rev/9d94f5e3/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1338
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.feeds", "need_to_know"); // [NO-ANDROID] [NO-MAIL] [DEFAULT = "need_to_know, fakespot"] https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#1094

/// Disable fetching favicons remotely from Mozila's remote Tippy Top service [NO-ANDROID] [NO-MAIL]
// https://superuser.com/questions/1358289/how-are-the-icons-for-top-sites-in-the-firefox-new-tab-rendered/1495054#1495054 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1507 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.favicon", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable fetching locale/fluent files remotely [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/asrouter/docs/remote_cfr.md#60 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/asrouter/modules/RemoteL10n.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.useRemoteL10n", false); // [NO-ANDROID] [NO-MAIL]

/// Disable fetching top sites remotely [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/components/topsites/TopSites.sys.mjs#359 [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.useRemoteSetting", false); // [NO-ANDROID] [NO-MAIL]

/// Disable hiding URLs with certain parameters from Top Sites by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/modules/NewTabUtils.sys.mjs#1001 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.hideTopSitesWithSearchParam", ""); // [NO-ANDROID] [NO-MAIL] [Default: mfadid=adm]

/// Disable Firefox Sync first run/promotion and metrics [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/PrefsFeed.sys.mjs#268 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.fxaccounts.endpoint", ""); // [NO-ANDROID] [NO-MAIL]

/// Disable impression stats [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/ImpressionCaps.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.impressionCaps.nonSponsoredEnabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.quicksuggest.impressionCaps.sponsoredEnabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable MARS (Mozilla Ad Routing Service) [NO-ANDROID] [NO-MAIL]
// https://ads.mozilla.org/assets/docs/openapi/mars-api.html [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/AdsFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.reportAds.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.discoverystream.sections.contextualAds.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.contextualAds.locale-config", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.contextualAds.region-config", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.adsfeed", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.spocs.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.tiles.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.spocs.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.tiles.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable mobile promotions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#271 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-a", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-b", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-c", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable new tab attribution [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#781 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1563 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/NewTabAttributionFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.attribution.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.newtabattributionfeed", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable onboarding [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/7d68baf8/browser/app/profile/firefox.js#1972 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.dismissed", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.maybeDisplay", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Pocket [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showRecentSaves", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Pocket sponsored stories [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/pocket-sponsored-stories-new-tabs [NO-ANDROID] [NO-MAIL]
// https://github.com/Pocket/proxy-server [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/lib/AboutPreferences.sys.mjs#135 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/16a9e4fb/browser/app/profile/firefox.js#1864 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/16a9e4fb/toolkit/components/nimbus/FeatureManifest.yaml#1115 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.ctaButtonSponsors", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.placements.spocs", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.placements.spocs.counts", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint", "data;", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint-query", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocAdTypes", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocMessageVariant", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocSiteId", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "", locked); // [NO-ANDROID] [NO-MAIL] Ensure we don't try to send a deletion request, as there's no data to delete... and we block the endpoint anyways https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/docs/v2-system-addon/preferences.md#128
pref("browser.newtabpage.activity-stream.discoverystream.region-spocs-config", "", locked); // [NO-ANDROID] [NO-MAIL] Don't show sponsored content to any region by default... https://searchfox.org/mozilla-central/rev/96296f9d/toolkit/components/nimbus/FeatureManifest.yaml#1769
pref("browser.newtabpage.activity-stream.discoverystream.spoc-positions", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showSponsored", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.system.showSponsored", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable the promotion card [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#685 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.promoCard.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.promoCard.visible", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable recent activity by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.section.highlights", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false); // [NO-ANDROID] [NO-MAIL] Bookmarks
pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false); // [NO-ANDROID] [NO-MAIL] Downloads
pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false); // [NO-ANDROID] [NO-MAIL] Visited websites

/// Disable sponsored shortcuts [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/sponsor-privacy [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spoc-topsites-positions", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesAdTypes", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesPlacement.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesZoneIds", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocZoneIds", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/AboutPreferences.sys.mjs#69

/// Disable stories [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.system.topstories", false); // [NO-ANDROID] [NO-MAIL] Hides the UI setting

/// Disable telemetry [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/newtab/pings.yaml [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/TelemetryFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.contextual-services.contextId", "{foo-123-foo}", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/source/browser/modules/ContextId.sys.mjs
pref("browser.newtabpage.activity-stream.feeds.telemetry", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1501
pref("browser.newtabpage.activity-stream.telemetry", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#494
pref("browser.newtabpage.activity-stream.telemetry.privatePing.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#517
pref("browser.newtabpage.activity-stream.telemetry.privatePing.inferredInterests.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] Ensure we never submit "inferred" New Tab interests with new tab pings https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#537
pref("browser.newtabpage.activity-stream.telemetry.privatePing.redactNewtabPing.enabled", true, locked); // [NO-ANDROID] [NO-MAIL] Redact information from new tab pings https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#530 https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/TelemetryFeed.sys.mjs#386
pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#510
pref("browser.newtabpage.activity-stream.telemetry.surfaceId", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#524
pref("browser.newtabpage.activity-stream.telemetry.ut.events", false, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#502
pref("browser.newtabpage.ping.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/TelemetryFeed.sys.mjs#501 https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/TelemetryFeed.sys.mjs#1254
pref("browser.places.interactions.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] Disable interaction measurements https://searchfox.org/firefox-main/source/browser/components/places/Interactions.sys.mjs
pref("browser.places.interactions.log", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Disable logging https://searchfox.org/firefox-main/rev/82e2435f/browser/components/places/Interactions.sys.mjs#20
pref("browser.privacySegmentation.preferences.show", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.search.serpEventTelemetryCategorization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.search.serpMetricsRecordedCounter", 0, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] Ensure we never try to submit SERP categorization event metrics https://searchfox.org/firefox-main/rev/82e2435f/browser/components/search/SERPCategorization.sys.mjs#546

/// Disable trending searches by default [NO-ANDROID] [NO-MAIL]
// Currently appears to be no-op, so we can also ensure the UI is hidden [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/TrendingSearchFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.system.trendingSearch.enabled", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.newtabpage.activity-stream.trendingSearch.enabled", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable wallpaper promotions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#910 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightDismissed", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable Firefox Home [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.testing.shouldInitializeFeeds", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#150
pref("browser.newtabpage.disableNewTabAsAddon", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [HIDDEN] https://searchfox.org/firefox-main/rev/82e2435f/browser/components/newtab/AboutNewTabResourceMapping.sys.mjs#186
pref("browser.newtabpage.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable the new shortcuts UI refresh by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabShortcuts.refresh", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable publisher favicons (if stories are enabled) by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.publisherFavicon.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Enable shortcuts by default [NO-ANDROID] [NO-MAIL] [DEFAULT]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/UrlbarProviderTopSites.sys.mjs [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.places", true);// [NO-ANDROID] [NO-MAIL] [DEFAULT] Required to click shortcuts...
pref("browser.newtabpage.activity-stream.feeds.system.topsites", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.topsites", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable wallpapers, but disable fetching them remotely by default [NO-ANDROID] [NO-MAIL]
// By default, Firefox to connect to ex. `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/newtab-wallpapers-v2/...` on every browser launch after the user navigates to `about:home` :/ [NO-ANDROID] [NO-MAIL]
// This is a work-around that enables *partial* support for custom wallpapers, but without hitting the network [NO-ANDROID] [NO-MAIL]
// Currently, only colors are supported, no built-in wallpapers or custom files work yet sadly [NO-ANDROID] [NO-MAIL]
// To apply a color wallpaper, set the value of `browser.newtabpage.activity-stream.newtabWallpapers.wallpaper` to `solid-color-picker-`, followed by your desired color hex (ex: `solid-color-picker-#ffffff` for white) [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/data/content/activity-stream.bundle.js#14257 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/extensions/newtab/lib/Wallpapers/WallpaperFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1972944 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.wallpaperfeed", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customColor.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.uploadedPreviously", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.uuid", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.wallpaper", "solid-color-picker-#f4dbe9"); // [NO-ANDROID] [NO-MAIL]

/// Ensure collections can always be dismissed [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.isCollectionDismissible", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Ensure default homepage is `about:home` [NO-ANDROID] [NO-MAIL]
// This is typically the default, but overriden by some distro-packaged versions of Firefox (ex. Fedora) [NO-ANDROID] [NO-MAIL]
pref("browser.startup.homepage", "about:home"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.startup.page", 1); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Ensure we isolate content with containers [NO-ANDROID] [NO-MAIL]
pref("browser.discovery.containers.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Expose debug prefs to the `about:config` [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.debugLogLevel", "error"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] To expose via the `about:config` - https://searchfox.org/firefox-main/rev/82e2435f/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs#95
pref("browser.newtabpage.activity-stream.debug", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN - non-Nightly] [DEFAULT] To expose via the `about:config`

/// Hide checkboxes to enable sponsored shortcuts and Pocket sponsored stories [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1386 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.newtabpage.activity-stream.system.showSponsoredCheckboxes", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Hide the Firefox logo [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", false); // [NO-ANDROID] [NO-MAIL]

/// If ads are somehow enabled, use OHTTP for superior privacy [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#1158 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/AdsFeed.sys.mjs#366 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.ohttp.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFENSE IN DEPTH]

/// If Merino is enabled, disable experimentation [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/DiscoveryStreamFeed.sys.mjs#1924 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-feed-experiment", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// If Merino is enabled, use OHTTP for superior privacy [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/toolkit/components/nimbus/FeatureManifest.yaml#1171 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/DiscoveryStreamFeed.sys.mjs#1727 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/c2646728/browser/components/urlbar/MerinoClient.sys.mjs#75 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.ohttp.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.configURL", "https://prod.ohttp-gateway.prod.webservices.mozgcp.net/ohttp-configs"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.relayURL", "https://mozilla-ohttp.fastly-edge.com/"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.merino.ohttpConfigURL", "https://prod.merino.prod.webservices.mozgcp.net/ohttp-configs"); // [NO-ANDROID] [NO-MAIL] https://github.com/mozilla/application-services/blob/1db4410891aa5eac49419100807c9522c4a3a89d/components/viaduct/src/ohttp.rs#L93
pref("browser.urlbar.merino.ohttpRelayURL", "https://ohttp-relay-merino-prod.edgecompute.app/"); // [NO-ANDROID] [NO-MAIL] https://github.com/mozilla/application-services/blob/1db4410891aa5eac49419100807c9522c4a3a89d/components/viaduct/src/ohttp.rs#L92

/// If sponsored content is somehow enabled, ensure that privacy protections are enabled [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.sponsor-protection.debug", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.newtabpage.sponsor-protection.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// If stories are enabled, allow customization and following/unfollowing interests/topics [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.customizeMenuPanel.enabled", true); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#714
pref("browser.newtabpage.activity-stream.discoverystream.sections.interestPicker.enabled", true); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#831
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.enabled", true); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#706
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.enabled", true); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/82e2435f/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1236

/// If stories are enabled, disable "personalization" [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/RecommendationProvider.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/7d68baf8/browser/app/profile/firefox.js#1967 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/InferredPersonalizationFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.personalization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.recs.personalized", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.locale-config", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.region-config", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.user.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.shortcuts.personalization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.inferredpersonalizationfeed", false, locked); // [NO-ANDROID] [NO-MAIL]

/// If stories are enabled, disable impression tracking [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.impressionId", "{some-fake-impression-ID}", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/test/xpcshell/test_TelemetryFeed.js
pref("browser.newtabpage.activity-stream.discoverystream.rec.impressions", "{}", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/mozilla-central/rev/cc4985b7/browser/extensions/newtab/lib/ActivityStream.sys.mjs#978
pref("browser.newtabpage.activity-stream.discoverystream.spoc.impressions", "{}", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/mozilla-central/rev/cc4985b7/browser/extensions/newtab/lib/ActivityStream.sys.mjs#962
pref("browser.newtabpage.activity-stream.feeds.section.topstories.rec.impressions", "{}", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] https://searchfox.org/mozilla-central/rev/cc4985b7/browser/extensions/newtab/lib/TopStoriesFeed.sys.mjs#33
pref("browser.newtabpage.activity-stream.feeds.section.topstories.spoc.impressions", "{}", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] https://searchfox.org/mozilla-central/rev/cc4985b7/browser/extensions/newtab/lib/TopStoriesFeed.sys.mjs#27

/// If stories are enabled, enable the new sections UI by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.cards.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// If stories are enabled, fetch content from Merino (instead of Pocket and friends) [NO-ANDROID] [NO-MAIL]
// Newer, more private (ex. OHTTP), etc. [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.config", '{"collapsible":true,"enabled":true}'); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/lib/ActivityStream.sys.mjs#886
pref("browser.newtabpage.activity-stream.discoverystream.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "https://merino.services.mozilla.com/"); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.endpoint", "merino.services.mozilla.com"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.recommendationprovider", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", '{"hidden":true,"show_spocs":false}'); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/lib/ActivityStream.sys.mjs#190 (Hides the toggle at `about:preferences#home`)

/// Prevent adding random recently visited sites to shortcuts/pins by default
// https://searchfox.org/mozilla-central/rev/73bd66f4/toolkit/components/places/nsNavHistory.cpp#62
pref("places.frecency.bookmarkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 75]
pref("places.frecency.defaultVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.downloadVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.embedVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.framedLinkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.linkVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 100]
pref("places.frecency.permRedirectVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Firefox Desktop] [Default on Firefox Desktop: 50]
pref("places.frecency.redirectSourceVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("places.frecency.reloadVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default on Firefox Desktop: 0]
pref("places.frecency.tempRedirectVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [DEFAULT - non-Firefox Desktop] [Default on Firefox Desktop: 40]
pref("places.frecency.typedVisitBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 2000]
pref("places.frecency.unvisitedBookmarkBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 140]
pref("places.frecency.unvisitedTypedBonus", 0); // [HIDDEN - Android/Thunderbird] [Default: 200]

/// Prevent searches from jumping to the URL bar [NO-ANDROID] [NO-MAIL]
// https://www.reddit.com/r/firefox/comments/oxwvbo/firefox_start_page_search_options/ [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false); // [NO-ANDROID] [NO-MAIL]

/// Remove default shortcuts [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.default.sites", ""); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/lib/ActivityStream.sys.mjs#181
pref("browser.newtabpage.activity-stream.improvesearch.noDefaultSearchTile", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/mozilla-central/rev/7d68baf8/browser/extensions/newtab/lib/ActivityStream.sys.mjs#831
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.pinned", '[{"url":"","label":"! Placeholder"}]'); // [NO-ANDROID] [NO-MAIL] [HIDDEN] https://searchfox.org/mozilla-central/rev/7d68baf8/toolkit/modules/NewTabUtils.sys.mjs#147 - Set as a placeholder to allow easily adding custom shortcuts/pins

pref("browser.phoenix.status", "029");

/*** 030 FIREFOX SUGGEST ***/ // [NO-ANDROID] [NO-MAIL]

/// Disable AccuWeather suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// NOTE: This requires `browser.urlbar.suggest.quicksuggest.sponsored` set to `true` (when that pref is true, we still prevent the standard sponsored content from showing and disable the standard ad providers, thanks to `browser.urlbar.merino.providers`) [NO-ANDROID] [NO-MAIL]
// NOTE: We also warn users before navigating to AccuWeather if they select a result, via uBlock Origin, so that this feature can be used safely without directly navigating to AccuWeather's website (which includes ads/tracking/etc.) [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.weather", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.weather.featureGate", true); // [NO-ANDROID] [NO-MAIL]

/// Disable adMarketplace (AMP) suggestions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/AmpSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.amp.featureGate", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.amp", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable AMO suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/AddonSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.addons.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.addons", false); // [NO-ANDROID] [NO-MAIL]

/// Disable "Exposure" telemetry [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/cc4985b7/toolkit/components/nimbus/FeatureManifest.yaml#281 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/cc4985b7/toolkit/components/nimbus/FeatureManifest.yaml#326 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.exposureResults", "", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.urlbar.keywordExposureResults", "", locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.urlbar.showExposureResults", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable Fakespot suggestions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/FakespotSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.fakespot.featureGate", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.fakespot", false); // [NO-ANDROID] [NO-MAIL]

/// Disable fetching minimum keyword lengths from Nimbus and/or Remote Settings [NO-ANDROID] [NO-MAIL]
// We also set these as user prefs in `phoenix-user-pref.cfg`, to ensure that Firefox properly uses/recognizes them [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.addons.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#736
pref("browser.urlbar.flightStatus.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] [HIDDEN] https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#143
pref("browser.urlbar.market.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#181
pref("browser.urlbar.weather.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#627
pref("browser.urlbar.yelp.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#642
pref("browser.urlbar.yelpRealtime.minKeywordLength", 4); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#666

/// Disable Firefox Suggest by default [NO-ANDROID] [NO-MAIL]
/// I'd rather not set this, but unfortunately, when it's on, it causes Firefox to connect to `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/quicksuggest-amp/changeset?_expected=*` and `https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/quicksuggest-other/changeset?_expected=*` on every launch, EVEN IF no suggestions are enabled :/ [NO-ANDROID] [NO-MAIL]
// This also gives us a cleaner UI, and I highly doubt that this is something most of our users want anyways [NO-ANDROID] [NO-MAIL]
// NOTE: This usually gets ignored and set to `true` anyways (unless we lock it), but we also set the region to a dummy one ("XX"), which prevents that from happening - https://searchfox.org/firefox-main/source/browser/components/urlbar/QuickSuggest.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Disable FlightAware (flight status) suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/FlightStatusSuggestions.sys.mjs[NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#788 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#489 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.flightStatus.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.flightStatus", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable machine learning [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/MLSuggest.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.mlEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.yelp.mlEnabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable MDN suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/MDNSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.mdn.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.mdn", false); // [NO-ANDROID] [NO-MAIL]

/// Disable nags to opt-in to "real-time suggestions" [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/components/urlbar/UrlbarPrefs.sys.mjs#489 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/app/profile/firefox.js#758 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.realtimeOptIn", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable online suggestions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#470 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#492 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#499 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.online.available", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] Hides UI at `about:preferences#search`
pref("browser.urlbar.quicksuggest.online.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.settingsUi", 2); // [NO-ANDROID] [NO-MAIL] Hides UI at `about:preferences#search`
pref("browser.urlbar.suggest.quicksuggest.all", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false); // [NO-ANDROID] [NO-MAIL]

/// Disable partner links/attribution [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/modules/PartnerLinkAttribution.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/7d68baf8/browser/app/profile/firefox.js#1745 [NO-ANDROID] [NO-MAIL]
pref("browser.partnerlink.attributionURL", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.partnerlink.campaign.topsites", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Polygon (stock market) suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/MarketSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/app/profile/firefox.js#761 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/4258ca07/browser/components/urlbar/UrlbarPrefs.sys.mjs#470 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.market.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.market", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable row labels by default [NO-ANDROID] [NO-MAIL]
// Provides a cleaner UI, and removes Firefox Suggest branding from results [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/components/urlbar/UrlbarPrefs.sys.mjs#159 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.groupLabels.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Disable sponsored suggestions [NO-ANDROID] [NO-MAIL]
// NOTE: `browser.urlbar.suggest.quicksuggest.sponsored` is required for weather suggestions; due to `browser.urlbar.merino.providers` though, when `browser.urlbar.suggest.quicksuggest.sponsored` is on, the only thing it does is allow weather suggestions - so we won't lock this [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/7d68baf8/browser/components/urlbar/UrlbarPrefs.sys.mjs#415 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/10ecded0/browser/app/profile/firefox.js#495 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.sponsoredTopSites", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // [NO-ANDROID] [NO-MAIL]

/// Disable sports suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/SportsSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/70425199/browser/app/profile/firefox.js#795 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/70425199/browser/components/urlbar/UrlbarPrefs.sys.mjs#532 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.sports.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.sports", false); // [NO-ANDROID] [NO-MAIL]

/// Disable telemetry [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.contextualOptIn", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable Wikipedia suggestions by default, but allow users to enable them if desired [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/private/WikipediaSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.wikipedia", false); // [NO-ANDROID] [NO-MAIL] [NIGHTLY]
pref("browser.urlbar.wikipedia.featureGate", true); // [NO-ANDROID] [NO-MAIL] [NIGHTLY]

/// Disable Yelp suggestions [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/YelpSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/YelpRealtimeSuggestions.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.yelp", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.yelpRealtime", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.yelp.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.yelpRealtime.featureGate", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable important date suggestions by default [NO-ANDROID] [NO-MAIL]
// (If these are set and Firefox Suggest (browser.urlbar.quicksuggest.enabled) is enabled, ex. searching "Christmas" shows "Thursday, December 25, 2025") [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/source/browser/components/urlbar/private/ImportantDatesSuggestions.sys.mjs[NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#769 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/firefox-main/rev/16707ce1/browser/app/profile/firefox.js#772 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.importantDates.featureGate", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.importantDates", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Ensure that we're using the newer Rust backend [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/cc4985b7/browser/components/urlbar/UrlbarPrefs.sys.mjs#317 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.rustEnabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// If Merino is enabled, only allow fetching content from AccuWeather, AMO, MDN, Polygon (stock market), and Wikipedia (if the corresponding prefs are enabled) [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/cc4985b7/browser/components/urlbar/MerinoClient.sys.mjs#123 [NO-ANDROID] [NO-MAIL]
// NOTE: These are also required for displaying Weather on Firefox Home (`about:home`) [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.merino.endpointURL", "https://merino.services.mozilla.com/api/v1/suggest"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.merino.providers", "accuweather,amo,flightaware,market,mdn,sports,wikipedia"); // [NO-ANDROID] [NO-MAIL]

/// If Yelp suggestions are enabled, show subject/title for results [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/cc4985b7/browser/app/profile/firefox.js#706 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.yelp.serviceResultDistinction", true); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "030"); // [NO-ANDROID] [NO-MAIL]

/*** 031 SYNC ***/ // [NO-ANDROID]

/// Disable Firefox Sync by default [NO-ANDROID]
// When signing in to Firefox Sync, this controls the items (checkboxes) that are set to sync (under `about:preferences#sync`). [NO-ANDROID]
// This allows the user to control and choose for themselves what they'd like to sync, rather than automatically syncing everything (like the default) [NO-ANDROID]
pref("services.sync.engine.addons", false); // [NO-ANDROID]
pref("services.sync.engine.addresses", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.bookmarks", false); // [NO-ANDROID]
pref("services.sync.engine.creditcards", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.history", false); // [NO-ANDROID]
pref("services.sync.engine.passwords", false); // [NO-ANDROID]
pref("services.sync.engine.prefs", false); // [NO-ANDROID]
pref("services.sync.engine.tabs", false); // [NO-ANDROID]

/// Disable promotions [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.monitorEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.relayEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.vpnEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.mobilepromo.android", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.mobilepromo.ios", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.sendtabpromo.url", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable sending the user agent with Firefox Sync requests [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/af0f713f/services/sync/modules/resource.sys.mjs#38 [NO-ANDROID]
// https://searchfox.org/firefox-main/rev/af0f713f/services/sync/modules/resource.sys.mjs#99 [NO-ANDROID]
pref("services.sync.sendVersionInfo", false); // [NO-ANDROID]

/// Disable set-up/feature recommendation [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/base/content/browser-sync.js [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.syncSetup.panelAccessed", true, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable telemetry [NO-ANDROID]
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked); // [NO-ANDROID]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked); // [NO-ANDROID]
pref("services.sync.log.logger.telemetry", "Fatal"); // [NO-ANDROID] [HIDDEN]
pref("services.sync.telemetry.maxEventsCount", 0, locked); // [NO-ANDROID] [HIDDEN] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.maxPayloadCount", 0, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.submissionInterval", 999999999, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst

/// If Firefox sync is enabled, disable avatar fetching [NO-ANDROID]
// See "network.dns.localDomains" above, we need to block "profile.accounts.firefox.com" [NO-ANDROID]
// The pref below just prevents Firefox from complaining and generating log files/errors when that domain can't be reached (even though it's unnecessary for Sync to function AFAICT...) [NO-ANDROID]
pref("services.sync.log.appender.file.level", "Fatal"); // [NO-ANDROID]

/// Improve the reliability of extension storage sync [NO-ANDROID]
pref("services.sync.extension-storage.skipPercentageChance", 0); // [NO-ANDROID]

/// Prevent automatically sharing Firefox Sync accounts [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.migrateToDevEdition", false); // [NO-ANDROID] [NO-MAIL]

/// Sync additional preferences... [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.bookmarks.autoExportHTML", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.bookmarks.openInTabClosesMenu", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.compactmode.show", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.download.open_pdf_attachments_inline", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showRecentSaves", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showWeather", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.preferences.experimental", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.privatebrowsing.resetPBM.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.privateWindowSeparation.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.search.openintab", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.search.separatePrivateDefault.urlbarResult.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.spin_cursor_while_busy", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.tabs.groups.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.tabs.loadBookmarksInTabs", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.toolbars.bookmarks.visibility", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.urlbar.openintab", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.urlbar.suggest.calculator", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.urlbar.suggest.clipboard", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.urlbar.unitConversion.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.urlbar.update2.engineAliasRefresh", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.xul.error_pages.expert_bad_cert", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.xul.error_pages.show_safe_browsing_details_on_load", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.chrome.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.command-button-measure.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.command-button-rulers.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.command-button-screenshot.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.dom.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.devtools.debugger.ui.editor-wrapping", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.dom.security.https_only_mode_error_page_user_suggestions", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.dom.security.https_only_mode_send_http_background_request", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.findbar.highlightAll", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.layout.forms.reveal-password-button.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.media.autoplay.blocking_policy", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.media.ffmpeg.vaapi.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.middlemouse.paste", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.network.IDN_show_punycode", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.pdfjs.sidebarViewOnLoad", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.privacy.webrtc.globalMuteToggles", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.sidebar.main.tools", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.sidebar.revamp", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.startup.homepage_override_nimbus_disable_wnp", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.view_source.wrap_long_lines", true); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "031"); // [NO-ANDROID]

/*** 032 LIBREWOLF ***/ // [NO-ANDROID] [NO-MAIL]

/// The following prefs are specific to LibreWolf and its derivatives, you can safely ignore them if you're not using LibreWolf [NO-ANDROID] [NO-MAIL]
// While we don't officially support LibreWolf, I am aware of people using Phoenix with LibreWolf - and these are nice to have anyways, especially if we do support them in the future [NO-ANDROID] [NO-MAIL]
// https://codeberg.org/librewolf/settings/src/branch/master/librewolf.cfg [NO-ANDROID] [NO-MAIL]

/// Enable update checks when navigating to `About LibreWolf` [NO-ANDROID] [NO-MAIL]
pref("librewolf.aboutMenu.checkVersion", true); // [NO-ANDROID] [NO-MAIL]

/// Set the uBlock Origin config to our own by default [NO-ANDROID] [NO-MAIL]
// https://phoenix.celenity.dev/content-blocking [NO-ANDROID] [NO-MAIL]
pref("librewolf.uBO.assetsBootstrapLocation", "https://gitlab.com/celenityy/Phoenix/-/raw/pages/uBlock/assets.json"); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "032"); // [NO-ANDROID] [NO-MAIL]

/*** 033 SPECIALIZED/CUSTOM CONFIGS ***/ // [NO-ANDROID]

/// Configure remote AutoConfig files (if active) [NO-ANDROID]
pref("autoadmin.failover_to_cached", true); // [NO-ANDROID]
pref("autoadmin.offline_failover", true); // [NO-ANDROID]
pref("autoadmin.refresh_interval", 60); // [NO-ANDROID]

/// Enable support for custom/specialized configs... [NO-ANDROID] [NO-OSX] [NO-WINDOWS]
pref("general.config.filename", "phoenix.cfg"); // [NO-ANDROID] [NO-MAIL] [NO-OSX] [NO-WINDOWS]
pref("general.config.obscure_value", 0); // [NO-ANDROID] [NO-OSX] [NO-WINDOWS]
pref("general.config.vendor", "phoenix"); // [NO-ANDROID] [NO-MAIL] [NO-OSX] [NO-WINDOWS]

pref("browser.phoenix.status", "033"); // [NO-ANDROID]

pref("browser.phoenix.status", "successfully applied :D", locked);
