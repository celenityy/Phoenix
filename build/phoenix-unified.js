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

pref("browser.phoenix.version", "2025.05.11.1", locked);

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
029: SYNC (DESKTOP ONLY)
030: SPECIALIZED/CUSTOM CONFIGS (DESKTOP ONLY)

*/

/* KEY

Unspecified = This preference should be set EVERYWHERE

[ANDROID-ONLY] = This preference should ONLY be set for Android
[LINUX-ONLY] = This preference should ONLY be set for GNU/Linux
[OSX-ONLY] = This preference should ONLY be set for macOS
[WINDOWS-ONLY] = This preference should ONLY be set for Windows

[NO-ANDROID] = This preference should be set everywhere, EXCEPT for Android
[NO-LINUX] = This preference should be set everywhere, EXCEPT for GNU/Linux
[NO-MAIL] = This preference should be set everywhere, EXCEPT for Thunderbird (Useful for ex. Dove)
[NO-OSX] = This preference should be set everywhere, EXCEPT for macOS
[NO-WINDOWS] = This preference should be set everywhere, EXCEPT for Windows

*/

/// Add custom branding under `Firefox Updates` at `about:preferences#general` [NO-ANDROID] [NO-MAIL]
// This will unfortunately only display if the version of Firefox you're using is repackaged (ex. Flatpaks/Linux distros) [NO-ANDROID] [NO-MAIL]
pref("distribution.about", "Phoenix for Mozilla Firefox - 2025.05.11.1 💜", locked); // [NO-ANDROID] [NO-MAIL]

/*** 000 ABOUT:CONFIG ***/

/// Disable annoying warnings when attempting to access the `about:config`
pref("browser.aboutConfig.showWarning", false); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - Thunderbird]
pref("general.warnOnAboutConfig", false);

/// Ensure that the `about:config` is always enabled
pref("general.aboutConfig.enable", true, locked); // [DEFAULT - non-Android]

/// Ensure our policies aren't overriden...
// https://searchfox.org/mozilla-central/source/toolkit/components/enterprisepolicies/EnterprisePoliciesParent.sys.mjs
pref("browser.policies.perUserDir", false, locked); // [LINUX-ONLY] [NO-MAIL] RedHat/Fedora-specific
pref("toolkit.policies.perUserDir", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "000");

/*** 001 DATA COLLECTION ***/

// A lot of defense in depth...
// These also provide Attack Surface Reduction

/// Block domains
// Any domains listed here are redirected to `127.0.0.1`
// We'll use this primarily for Mozilla ad/telemetry domains, but we'll also use it for ads & trackers that appear on Mozilla properties and services, as well as ad/tracking/telemetry domains that appear on other default connections/services
// Ex. We use DuckDuckGo as our default search engine, so we'll nclude their analytics domains
// On IronFox, we link to our GitLab releases via the `What's New` alert, so we'll also cover their analytics domains, etc...
// But generally we'll want to keep this limited in favor of ex. uBlock Origin & other mechanisms.
pref("network.dns.localDomains", "250analytics.com,a.omappapi.com,ads.allizom.org,ads.mozilla.org,ads.nonprod.webservices.mozgcp.net,ads.prod.webservices.mozgcp.net,analytics.getpocket.com,analytics.google.com,analytics.withgoogle.com,anf1.fuzzing.mozilla.org,anonymco.com,api.divviup.org,asan-nightly-frontend-elb-1348905149.us-east-2.elb.amazonaws.com,braze.com,contile.services.mozilla.com,contile-images.services.mozilla.com,classify-client.nonprod.webservices.mozgcp.net,classify-client.prod.webservices.mozgcp.net,classify-client.services.mozilla.com,crash-reports.allizom.org,crash-reports.mozilla.com,crash-reports-xpsp2.mozilla.com,crash-stacks.mozilla.com,crash-stats.allizom.org,crash-stats.mozilla.com,crash-stats.mozilla.org,dap.services.mozilla.com,dap.nonprod.webservices.mozgcp.net,dap.prod.webservices.mozgcp.net,dap-09-3.api.divviup.org,data.mozilla.com,data-ingestion.prod.dataops.mozgcp.net,dataops.mozgcp.net,dataservices.mozgcp.net,discovery.addons.allizom.org,discovery.addons.mozilla.org,discovery.addons-dev.allizom.org,divviup.org,download-stats.mozilla.org,download-stats.r53-2.services.mozilla.com,experimenter.services.mozilla.com,experimenter.nonprod.webservices.mozgcp.net,experimenter.prod.webservices.mozgcp.net,fhr.data.mozilla.com,fhr.r53-2.services.mozilla.com,firefox-android-home-recommendations.getpocket.com,fuzzing.mozilla.org,google-analytics.com,google-analytics-cn.com,googleanalytics.com,googlesyndication.com,googlesyndication-cn.com,googletagmanager.com,googletagmanager-cn.com,googletagservices.com,googletagservices-cn.com,improving.duckduckgo.com,incoming.telemetry.mozilla.org,incoming.thunderbird.net,incoming-telemetry.thunderbird.net,ingestion-edge.prod.dataops.mozgcp.net,location.services.mozilla.com,locprod1-elb-eu-west-1.prod.mozaws.net,locprod2-elb-us-west-2.prod.mozaws.net,merino.nonprod.cloudops.mozgcp.net,merino.prod.cloudops.mozgcp.net,merino.services.mozilla.com,metrics-content.duckduckgo.com,mozilla-ohttp.fastly-edge.com,new-sentry.gitlab.net,nonprod.classify-client.nonprod.webservices.mozgcp.net,normandy.cdn.mozilla.net,normandy.nonprod.cloudops.mozgcp.net,normandy.prod.cloudops.mozgcp.net,normandy-cdn.services.mozilla.com,ohttp-gateway.prod.webservices.mozgcp.net,omappapi.com,pagead2.googlesyndication.com,pipeline-incoming-prod-elb-149169523.us-west-2.elb.amazonaws.com,prod.ads.prod.webservices.mozgcp.net,prod.classify-client.prod.webservices.mozgcp.net,prod.dap.prod.webservices.mozgcp.net,prod.data-ingestion.prod.dataops.mozgcp.net,prod.dataops.mozgcp.net,prod.experimenter.prod.webservices.mozgcp.net,prod.ingestion-edge.prod.dataops.mozgcp.net,prod.ohttp-gateway.prod.webservices.mozgcp.net,prod.sentry.prod.cloudops.mozgcp.net,prod-classifyclient.normandy.prod.cloudops.mozgcp.net,sdk.iad-05.braze.com,search.r53-2.services.mozilla.com,search.services.mozilla.com,self-repair.mozilla.org,self-repair.r53-2.services.mozilla.com,sentry.gitlab.net,sentry.io,sentry.nonprod.cloudops.mozgcp.net,sentry.prod.cloudops.mozgcp.net,sentry.prod.mozaws.net,sitereview.zscaler.com,snippets.allizom.org,snippets.cdn.mozilla.net,snippets.mozilla.com,snippets-prod.frankfurt.moz.works,snippets-prod.moz.works,snippets-prod.oregon-b.moz.works,snippets-stage.moz.works,snippets-stage.oregon-b.moz.works,snowplow.trx.gitlab.net,snowplowalb-1011729428.us-east-1.elb.amazonaws.com,snowplowprd.trx.gitlab.net,snowplowprdnlb-1490493263.us-east-2.elb.amazonaws.com,socorro.nonprod.webservices.mozgcp.net,socorro.prod.webservices.mozgcp.net,socorro-collector.services.mozilla.com,socorro-webapp-allizom.stage.mozaws.net,socorro-webapp.services.mozilla.com,spocs.getpocket.com,spocs.getpocket.dev,spocs.mozilla.net,ssl.google-analytics.com,ssl-google-analytics.l.google.com,stage.sentry.nonprod.cloudops.mozgcp.net,start.fedoraproject.org,start.thunderbird.net,start.ubuntu.com,start-stage.thunderbird.net,survey.mozilla.com,tagmanager.google.com,talkback.mozilla.org,talkback-public.mozilla.org,talkback-reports.mozilla.org,telemetry-coverage.mozilla.org,telemetry-coverage.r53-2.services.mozilla.com,telemetry-experiment.cdn.mozilla.net,telemetry-incoming.r53-2.services.mozilla.com,telemetry-incoming-a.r53-2.services.mozilla.com,telemetry-incoming-b.r53-2.services.mozilla.com,telemetry-prod-1054754349.us-east-1.elb.amazonaws.com,tiles-cdn.prod.ads.prod.webservices.mozgcp.net,updates.thunderbird.net,updates-stage.thunderbird.net,use-application-dns.net,vf.startpage.com,widgets.getpocket.com,www.250analytics.com,www.anonymco.com,www.google-analytics.com,www.google-analytics-cn.com,www.googleanalytics.com,www.googlesyndication.com,www.googlesyndication-cn.com,www.googletagmanager.com,www.googletagmanager-cn.com,www.googletagservices.com,www.googletagservices-cn.com,www.sentry.io,www-google-analytics.l.google.com,www-googletagmanager.l.google.com");

/// Disable Browser Usage Telemetry metrics
// https://searchfox.org/mozilla-central/source/browser/docs/BrowserUsageTelemetry.rst
// https://searchfox.org/mozilla-central/source/browser/modules/BrowserUsageTelemetry.sys.mjs
// https://searchfox.org/mozilla-central/source/toolkit/content/widgets/tabbox.js
pref("browser.engagement.ctrlTab.has-used", true, locked); // [HIDDEN - Android/Thunderbird]
pref("browser.engagement.downloads-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.fxa-toolbar-menu-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.home-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.library-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.sidebar-button.has-used", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.engagement.total_uri_count.pbm", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Disable Coverage
// https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/
// https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/pings/CoveragePing.sys.mjs
// https://bugzilla.mozilla.org/show_bug.cgi?id=1487578
pref("toolkit.coverage.enabled", false, locked); // [DEFAULT]
pref("toolkit.coverage.endpoint.base", "", locked);
pref("toolkit.coverage.log-level", 70); // Limits logging to fatal only
pref("toolkit.coverage.opt-out", true, locked); // [HIDDEN]
pref("toolkit.telemetry.coverage.opt-out", true, locked); // [HIDDEN]

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
// https://firefox-source-docs.mozilla.org/tools/sanitizer/asan_nightly.html
// https://github.com/choller/firefox-asan-reporter
pref("asanreporter.apiurl", "", locked);
pref("asanreporter.clientid", "unknown", locked);
pref("asanreporter.loglevel", 70);
pref("breakpad.reportURL", "", locked);
pref("browser.crashReports.crashPull", false, locked); // [DEFAULT] Do not request crash reports for background processes from users https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/crash-reports-ondemand/changeset?_expected=0
pref("browser.crashReports.requestedNeverShowAgain", true, locked); // Do not request crash reports for background processes from users https://searchfox.org/mozilla-central/source/toolkit/components/crashes/RemoteSettingsCrashPull.sys.mjs
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird] [DEFAULT - non-Nightly]
pref("browser.tabs.crashReporting.includeURL", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [DEFENSE IN DEPTH] (This is for `about:tabcrashed`)
pref("browser.tabs.crashReporting.sendReport", false, locked); // [NO-ANDROID] [NO-MAIL] (This is for `about:tabcrashed`)
pref("toolkit.crashreporter.include_context_heap", false, locked);

/// Disable Data Reporting & Telemetry
/// We also configure "DisableTelemetry" & "ImproveSuggest" in policies on Desktop
// https://mozilla.github.io/policy-templates/#disabletelemetry 
// https://mozilla.github.io/policy-templates/#firefoxsuggest
// https://wiki.mozilla.org/QA/Telemetry
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/internals/preferences.html
// https://searchfox.org/mozilla-release/source/toolkit/components/glean/xpcom/FOG.cpp
// https://searchfox.org/mozilla-release/source/toolkit/components/telemetry/app/TelemetryUtils.sys.mjs
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("browser.safebrowsing.features.emailtracking.datacollection.update", false, locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("browser.urlbar.quicksuggest.onboardingDialogChoice", "reject_2", locked); // [NO-ANDROID] [NO-MAIL] [ESR] [HIDDEN] https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst
pref("captchadetection.actor.enabled", false, locked); // Disable CAPTCHA Detection Pings https://searchfox.org/mozilla-central/source/toolkit/components/captchadetection
pref("captchadetection.loglevel", "Off");
pref("datareporting.dau.cachedUsageProfileID", "beefbeef-beef-beef-beef-beeefbeefbee", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/app/ClientID.sys.mjs#44
pref("datareporting.dau.cachedUsageProfileGroupID", "b0bacafe-b0ba-cafe-b0ba-cafeb0bacafe", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/app/ClientID.sys.mjs#44
pref("datareporting.healthreport.uploadEnabled", false, locked); // [DEFAULT - Android]
pref("datareporting.policy.dataSubmissionEnabled", false, locked);
pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true, locked);
pref("datareporting.policy.firstRunURL", "", locked);
pref("datareporting.usage.uploadEnabled", false, locked); // [HIDDEN - ANDROID] [DEFAULT - Android] Disables "daily usage pings" https://support.mozilla.org/kb/usage-ping-settings
pref("dom.security.unexpected_system_load_telemetry_enabled", false, locked); // [DEFAULT - non-Nightly]
pref("extensions.dataCollectionPermissions.enabled", false, locked); // [NIGHTLY] [DEFAULT] https://searchfox.org/mozilla-central/source/toolkit/locales-preview/dataCollectionPermissions.ftl
pref("network.jar.record_failure_reason", false, locked); // [DEFAULT - non-Nightly] https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#14397
pref("network.traffic_analyzer.enabled", false, locked); // https://searchfox.org/mozilla-release/source/modules/libpref/init/StaticPrefList.yaml#13191
pref("network.trr.confirmation_telemetry_enabled", false, locked);
pref("nimbus.telemetry.targetingContextEnabled", false, locked); // [HIDDEN - ANDROID/THUNDERBIRD] [DEFAULT - Artifact builds] Targeting context telemetry - https://searchfox.org/mozilla-central/rev/f1e32fa7/browser/app/profile/firefox.js#2040
pref("privacy.imageInputTelemetry.enableTestMode", false, locked); // [HIDDEN] "Event Telemetry" https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#15549
pref("privacy.trackingprotection.emailtracking.data_collection.enabled", false, locked);
pref("services.sync.log.logger.telemetry", "Fatal"); // [NO-ANDROID] [HIDDEN]
pref("services.sync.telemetry.maxEventsCount", 0, locked); // [NO-ANDROID] [HIDDEN] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.maxPayloadCount", 0, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.submissionInterval", 999999999, locked); // [NO-ANDROID] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("telemetry.fog.test.activity_limit", -1, locked); // Disable activity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.test.inactivity_limit", -1, locked); // Disable inactivity-based ping submission - ex. https://mozilla.github.io/glean/book/user/pings/baseline.html#scheduling
pref("telemetry.fog.init_on_shutdown", false, locked); // Prevent Glean from initializing on shutdown https://searchfox.org/mozilla-central/source/toolkit/components/glean/docs/dev/preferences.md#49
pref("telemetry.fog.test.localhost_port", 70000, locked); // Force telemetry pings to be sent to localhost instead of Mozilla's servers, if they're somehow enabled... (port just has to be higher than 0, I chose 70000 as its invalid) - https://searchfox.org/mozilla-central/source/toolkit/components/glean/docs/dev/preferences.md#15
pref("telemetry.glean.internal.finalInactive", false, locked); // [DEFAULT] [HIDDEN] Disable early shutdown pings https://searchfox.org/mozilla-central/source/toolkit/components/glean/xpcom/FOG.cpp
pref("telemetry.glean.internal.maxPingsPerMinute", 0, locked); // [HIDDEN] Prevent Glean from sending pings https://searchfox.org/mozilla-central/source/toolkit/components/glean/xpcom/FOG.cpp
pref("telemetry.number_of_site_origin.min_interval", 999999999, locked);
pref("toolkit.content-background-hang-monitor.disabled", true, locked); // BHR https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#16720
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
pref("toolkit.telemetry.dap_helper", "", locked); // [NO-ANDROID] [ESR]
pref("toolkit.telemetry.dap_helper_owner", "", locked); // [NO-ANDROID] [ESR]
pref("toolkit.telemetry.dap_leader", "", locked); // [NO-ANDROID] [ESR]
pref("toolkit.telemetry.dap_leader_owner", "", locked); // [NO-ANDROID] [ESR]
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
pref("toolkit.telemetry.eventping.maximumFrequency", 999999999, locked); // [HIDDEN]
pref("toolkit.telemetry.eventping.minimumFrequency", 999999999, locked); // [HIDDEN]
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
pref("toolkit.telemetry.testing.disableFuzzingDelay", false, locked); // [DEFAULT] [HIDDEN] [DEFENSE IN DEPTH] Always delay sending pings between 0-1 AM
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
pref("urlclassifier.features.emailtracking.datacollection.allowlistTables", "", locked); // https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs
pref("urlclassifier.features.emailtracking.datacollection.blocklistTables", "", locked); // https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/SafeBrowsing.sys.mjs

/// Disable Default Browser Agent [WINDOWS-ONLY]
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html [WINDOWS-ONLY]
pref("default-browser-agent.enabled", false, locked); // [WINDOWS-ONLY]

/// Disable Experiments/Studies
// (Shield/Nimbus/Normandy)
// https://support.mozilla.org/kb/shield
// https://support.mozilla.org/kb/how-stop-firefox-making-automatic-connections#w_experiments-or-studies
// https://experimenter.info/
// https://wiki.mozilla.org/Firefox/Shield/Shield_Studies
// https://mozilla.github.io/normandy/
// https://wiki.mozilla.org/Advocacy/heartbeat
// resource://nimbus/ExperimentAPI.sys.mjs
// https://searchfox.org/mozilla-central/source/toolkit/components/backgroundtasks/defaults/backgroundtasks_browser.js
pref("app.normandy.run_interval_seconds", 0, locked); // [HIDDEN - Android/Thunderbird] Prevent fetching experiments - This pref is also used by Nimbus
pref("app.normandy.api_url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.experiments.lazy_classify", true, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFENSE IN DEPTH] Prevent making client classification requests on every startup https://mozilla.github.io/normandy/dev/feature-experiments.html
pref("app.normandy.first_run", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.last_seen_buildid", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.normandy.logging.level", 70); // [NO-ANDROID] [NO-MAIL] Limit logging to fatal only
pref("app.normandy.user_id", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.shield.optoutstudies.enabled", false, locked); // [HIDDEN - Android/Thunderbird]
pref("messaging-system.log", "off"); // [NO-ANDROID] [NO-MAIL] Disables logging
pref("messaging-system.rsexperimentloader.collection_id", "", locked);
pref("messaging-system.rsexperimentloader.enabled", false, locked); // [NO-ANDROID] [ESR]
pref("nimbus.appId", "", locked);

/// Disable Firefox Home Telemetry [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-release/source/browser/components/newtab/pings.yaml [NO-ANDROID] [NO-MAIL]
pref("browser.aboutwelcome.log", "off"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Disable logging
pref("browser.contextual-services.contextId", "{foo-123-foo}", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/test/xpcshell/test_TelemetryFeed.js
pref("browser.engagement.search_counts.pbm", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] Disable recording search telemetry (in private windows) https://searchfox.org/mozilla-central/source/browser/components/search/BrowserSearchTelemetry.sys.mjs
pref("browser.newtabpage.activity-stream.feeds.telemetry", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.impressionId", "{some-fake-impression-ID}", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/source/browser/extensions/newtab/test/xpcshell/test_TelemetryFeed.js
pref("browser.newtabpage.activity-stream.telemetry", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.telemetry.privatePing.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.telemetry.privatePing.inferredInterests.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY] Ensure we never submit "inferred" New Tab interests with new tab pings
pref("browser.newtabpage.activity-stream.telemetry.privatePing.redactNewtabPing.enabled", true, locked); // [NO-ANDROID] [NO-MAIL] [NIGHTLY] Redact information from new tab pings https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/TelemetryFeed.sys.mjs#354
pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.telemetry.surfaceId", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.telemetry.ut.events", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.ping.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.places.interactions.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] Disable interaction measurements https://searchfox.org/mozilla-central/source/browser/components/places/Interactions.sys.mjs
pref("browser.places.interactions.log", false); // [DEFAULT] [HIDDEN] Disable logging https://searchfox.org/mozilla-central/source/browser/components/places/Interactions.sys.mjs
pref("browser.privacySegmentation.preferences.show", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.search.serpEventTelemetryCategorization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.account.telemetry.sanitized_uid", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable OHTTP Telemetry [ANDROID-ONLY]
// https://searchfox.org/mozilla-central/source/widget/android/OhttpHelper.cpp [ANDROID-ONLY]
pref("network.ohttp.configURL", "", locked); // [ANDROID-ONLY] [NIGHTLY]
pref("network.ohttp.relayURL", "", locked); // [ANDROID-ONLY] [NIGHTLY]

/// Disable Origin Trials
// https://wiki.mozilla.org/Origin_Trials
pref("dom.origin-trials.enabled", false, locked);

/// Disable X-Frame Options Error Reporting
// https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/data/xfocsp-error-report-ping.html
pref("security.xfocsp.errorReporting.automatic", false, locked); // [DEFAULT]
pref("security.xfocsp.errorReporting.enabled", false, locked);

/// Prevent automatically uploading profiler data (from `about:logging`) to Mozilla
pref("toolkit.aboutLogging.uploadProfileToCloud", false); // [DEFAULT - non-Android]

/// Remove partner attribution
// These are *only* used for telemetry, and could potentially be used for fingerprinting
pref("app.distributor", "", locked); // [DEFAULT] [HIDDEN]
pref("app.distributor.channel", "", locked); // [DEFAULT] [HIDDEN]
pref("mozilla.partner.id", "", locked); // [DEFAULT] [HIDDEN]

pref("browser.phoenix.status", "001");

/*** 002 MOZILLA CRAP™ ***/

// Some of these also provide Attack Surface Reduction

/// Clean-up Firefox Home [NO-ANDROID] [NO-MAIL]
// We also configure the "FirefoxHome" policy [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/policy-templates/#firefoxhome [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.debugLogLevel", "error"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT] To expose via the `about:config` - https://searchfox.org/mozilla-central/source/browser/components/asrouter/modules/ASRouterPreferences.sys.mjs
pref("browser.newtabpage.activity-stream.asrouter.providers.message-groups", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.messaging-experiments", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.useRemoteL10n", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.debug", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN - non-Nightly] [DEFAULT] To expose via the `about:config`
pref("browser.newtabpage.activity-stream.discoverystream.config", "[]", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.feeds", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.configURL", "", locked); // [NO-ANDROID] [NO-MAIL] [NIGHTLY]
pref("browser.newtabpage.activity-stream.discoverystream.ohttp.relayURL", "", locked); // [NO-ANDROID] [NO-MAIL] [NIGHTLY]
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.dismissed", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.onboardingExperience.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.personalization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.recs.personalized", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.user.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.spocs-endpoint-query", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.discoverystream.topicSelection.onboarding.maybeDisplay", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.recommendationprovider", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.snippets", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showSponsored", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.system.showSponsored", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("messaging-system.askForFeedback", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Clear unnecessary/undesired Mozilla URLs
pref("app.feedback.baseURL", ""); // [NO-ANDROID]
pref("app.normandy.shieldLearnMoreUrl", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.support.url", ""); // [NO-ANDROID] [NO-MAIL]
pref("datareporting.healthreport.infoURL", ""); // [HIDDEN - Android]
pref("extensions.getAddons.langpacks.url", ""); // [ANDROID-ONLY] Functionality isn't supported on Android, so no need to connect there - ex. https://services.addons.mozilla.org/api/v4/addons/language-tools/?app=android&type=language&appversion=138.0.1
pref("extensions.recommendations.privacyPolicyUrl", "");
pref("toolkit.crashreporter.infoURL", "");
pref("toolkit.datacollection.infoURL", "");

/// Disable `about:welcome`/onboarding [NO-ANDROID] [NO-MAIL]
// Privacy concerns - unsolicited connections [NO-ANDROID] [NO-MAIL]
// Also just annoying and undesired for our use case :/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/BrowserContentHandler.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.aboutwelcome.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.rights.3.shown", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.startup.homepage_override.buildID", "20100101", locked); // [NO-ANDROID] [NO-MAIL] Ex. matches what Tor Browser uses
pref("browser.startup.homepage_override.mstone", "ignore", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.startup.upgradeDialog.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] https://searchfox.org/mozilla-central/rev/f1e32fa7/browser/components/asrouter/docs/first-run.md#69
pref("browser.suppress_first_window_animation", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("startup.homepage_override_nimbus_disable_wnp", true); // [NO-ANDROID] [NO-MAIL] "What's New" Pages
pref("startup.homepage_override_url", ""); // [NO-ANDROID] [NO-MAIL]
pref("startup.homepage_override_url_nimbus", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("startup.homepage_welcome_url", ""); // [NO-ANDROID] [NO-MAIL]
pref("startup.homepage_welcome_url.additional", ""); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable add-on/feature recommendations
// https://support.mozilla.org/kb/recommendations-firefox
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/content/aboutaddons.js
// https://searchfox.org/mozilla-central/source/browser/components/enterprisepolicies/Policies.sys.mjs
pref("browser.dataFeatureRecommendations.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.discovery.enabled", false, locked); // [HIDDEN - non-Desktop Firefox]
pref("browser.discovery.sites", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "null", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.translations.panelShown", true, locked); // [HIDDEN]
pref("extensions.getAddons.browseAddons", "", locked); // [HIDDEN - non-Android]
pref("extensions.getAddons.discovery.api_url", "data;", locked);
pref("extensions.getAddons.showPane", false, locked);
pref("extensions.htmlaboutaddons.recommendations.enabled", false, locked);
pref("extensions.recommendations.hideNotice", true, locked); // [HIDDEN] "Some of these recommendations are personalized..." banner
pref("extensions.recommendations.themeRecommendationUrl", "", locked);
pref("extensions.ui.lastCategory", "addons://list/extension"); // [HIDDEN] Ensure default view of `about:addons` is always local/installed extensions
pref("extensions.webservice.discoverURL", "", locked); // [HIDDEN - non-Thunderbird]
pref("identity.fxaccounts.toolbar.syncSetup.panelAccessed", true, locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/mozilla-central/source/browser/base/content/browser-sync.js

/// Disable DoH Rollout/heuristics/steering
// This helps ensure Firefox doesn't override our/the user's DoH settings...
// https://searchfox.org/mozilla-central/source/toolkit/components/doh/DoHConfig.sys.mjs
// https://searchfox.org/mozilla-central/source/toolkit/components/doh/DoHController.sys.mjs
// https://searchfox.org/mozilla-central/source/toolkit/components/doh/DoHHeuristics.sys.mjs
// https://searchfox.org/mozilla-central/source/netwerk/docs/dns/dns-over-https-trr.md
// https://searchfox.org/mozilla-central/rev/f1e32fa7/mobile/android/geckoview/src/main/java/org/mozilla/geckoview/GeckoRuntimeSettings.java#1625
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
pref("network.android_doh.autoselect_enabled", false, locked); // [DEFAULT] https://searchfox.org/mozilla-central/rev/f1e32fa7/modules/libpref/init/StaticPrefList.yaml#14585

/// Disable 'Essential Domains Fallback'
// My concern here is the fact that this is fetched from Remote Settings - this could potentially be used to bypass our internal domain blocklist above + the firewall of users if they themselves choose to block specific domains for whatever reason
// I don't have a problem with this being a local dump though, as I can understand the usefulness of this (and being local would mitigate my concerns here) - but I'm not comfortable with the remote part
// This is currently unused anyways...
// https://searchfox.org/mozilla-central/source/netwerk/base/EssentialDomainsRemoteSettings.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/moz-essential-domain-fallbacks/changeset?_expected=0
pref("network.essential_domains_fallback", false); // [DEFAULT]

/// Disable Fakespot
pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.fakespot.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.active", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.ads.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.shopping.experience2023.ads.exposure", false, locked); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.shopping.experience2023.ads.userEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.autoOpen.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.shopping.experience2023.autoOpen.userEnabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.control", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.shopping.experience2023.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.shopping.experience2023.integratedSidebar", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.shopping.experience2023.newPositionCard.hasSeen", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.optedIn", 2); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.shoppingSidebar", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.survey.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shopping.experience2023.survey.hasSeen", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.fakespot.featureGate", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.fakespot", false); // [NO-ANDROID] [NO-MAIL]
pref("toolkit.shopping.ohttpConfigURL", "");
pref("toolkit.shopping.ohttpRelayURL", "");

/// Disable "Feature Tours" [NO-ANDROID] [NO-MAIL]
pref("browser.firefox-view.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtab.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.pdfjs.feature-tour", '{"screen":"","complete":true}'); // [NO-ANDROID] [NO-MAIL]

/// Disable fetching favicons for `about:home` from Mozila's remote Tippy Top service [NO-ANDROID] [NO-MAIL]
// https://superuser.com/questions/1358289/how-are-the-icons-for-top-sites-in-the-firefox-new-tab-rendered/1495054#1495054 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/ActivityStream.sys.mjs#1151 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.favicon", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Firefox Relay by default
pref("signon.firefoxRelay.feature", "disabled"); // [HIDDEN - Thunderbird]

/// Disable Firefox Suggest [NO-ANDROID] [NO-MAIL]
// We also configure "FirefoxSuggest" & "UrlbarInterventions" in policies [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/policy-templates/#firefoxsuggest [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/policy-templates/#usermessaging [NO-ANDROID] [NO-MAIL]
// https://mozilla-services.github.io/merino/firefox.html [NO-ANDROID] [NO-MAIL]
// https://github.com/mozilla-services/merino-py [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-feed-experiment", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.endpoint", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.ohttp.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.urlbar.addons.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.groupLabels.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.mdn.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.merino.endpointURL", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.merino.providers", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.contextualOptIn", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] Firefox only seems to set this for new profiles if it's locked...
pref("browser.urlbar.quicksuggest.hideSettingsUI", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.scenario", "offline"); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.shouldShowOnboardingDialog", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.showedOnboardingDialog", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.quicksuggest.sponsoredPriority", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.addons", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.mdn", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false, locked); // [NO-ANDROID] [NO-MAIL] Firefox only seems to set this for new profiles if it's locked...
pref("browser.urlbar.suggest.quicksuggest.sponsored", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.trending", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.weather", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.yelp", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trending.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.weather.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.yelp.featureGate", false); // [NO-ANDROID] [NO-MAIL]

/// Disable "Interest-based Content Relevance Ranking and Personalization"
// https://bugzilla.mozilla.org/show_bug.cgi?id=1886207
pref("toolkit.contentRelevancy.enabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.ingestEnabled", false, locked); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("toolkit.contentRelevancy.log", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Disable mozAddonManager
// mozAddonManager prevents extensions from working on `addons.mozilla.org`/the specified domains
// This API also exposes a list of the user's installed add-ons to `addons.mozilla.org`/the specified domains...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
pref("extensions.webapi.testing", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains
pref("extensions.webapi.testing.http", false); // [DEFAULT] Disables mozAddonManager on Mozilla testing domains using insecure protocols

/// Disable the Mozilla Ad Routing Service (MARS) :/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/ActivityStream.sys.mjs#221 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.adsfeed", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.reportAds.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.spocs.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.tiles.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.unifiedAds.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.ohttp.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.unifiedAds.spocs.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.unifiedAds.tiles.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Mozilla promotions [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.hide_vpn_banner", true, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.lockwise.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.mobile-android.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.mobile-ios.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.monitor.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.contentblocking.report.proxy.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.contentblocking.report.proxy_extension.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.show_mobile_app", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-android.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-ios.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.report.vpn-promo.url", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-a", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-b", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.mobileDownloadModal.variant-c", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [NIGHTLY]
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightDismissed", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.highlightEnabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.preferences.moreFromMozilla", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.vpnpromourl", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.promo.cookiebanners.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.promo.focus.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.promo.pin.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.protections_panel.infoMessage.seen", true); // [NO-ANDROID] [NO-MAIL] Disables ETP Banner
pref("browser.vpn_promo.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("cookiebanners.ui.desktop.showCallout", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.monitorEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.relayEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.toolbar.pxiToolbarEnabled.vpnEnabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.mobilepromo.android", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.mobilepromo.ios", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("identity.sendtabpromo.url", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Mozilla.UITour [NO-ANDROID] [NO-MAIL]
// https://mozilla.github.io/bedrock/uitour/#ui-tour [NO-ANDROID] [NO-MAIL]
// https://firefox-source-docs.mozilla.org/browser/components/uitour/docs/index.html [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/uitour/UITourUtils.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.loglevel", "Off"); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.requireSecure", true, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.uitour.surveyDuration", 0, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.uitour.testingOrigins", "", locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT] [HIDDEN]
pref("browser.uitour.url", "", locked); // [NO-ANDROID] [NO-MAIL]

/// Disable Pocket [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.sections.cards.enabled", false); // [NO-ANDROID] [NO-MAIL] "Revised Pocket Story Card UI" https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml
pref("browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showRecentSaves", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.pocket.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.pocket", false); // [NO-ANDROID] [NO-MAIL]
pref("extensions.pocket.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Disable "Privacy-Preserving Attribution"
// https://support.mozilla.org/kb/privacy-preserving-attribution
pref("dom.origin-trials.private-attribution.state", 2, locked); // [DEFAULT]
pref("dom.private-attribution.submission.enabled", false, locked); // [DEFAULT]

/// Disable Remote Permissions
// This currently only allows overriding behavior for HTTPS-First (and only makes an exception for a testing domain...)
// We enforce HTTPS-Only Mode anyways, so this isn't relevant to us - and regardless, I don't think there should be remote/default overrides for a feature like this (or permissions in general...), best left up to the user.
// https://searchfox.org/mozilla-central/source/extensions/permissions/docs/remote.rst
// https://searchfox.org/mozilla-central/source/extensions/permissions/RemotePermissionService.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/remote-permissions/changeset?_expected=0
// https://support.mozilla.org/kb/https-first
pref("permissions.manager.remote.enabled", false);

/// Disable Remote Settings 'Preview' Buckets
// Nice to expose via about:config
pref("services.settings.preview_enabled", false); // [HIDDEN, DEFAULT]

/// Disable "Top Sites"/Sponsored content/etc. [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.default.sites", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesPlacement.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.noDefaultSearchTile", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.section.topstories", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", '{"hidden":true}', locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.system.topstories", false, locked); // [NO-ANDROID] [NO-MAIL] Controls the visibility of the `about:home` setting
pref("browser.newtabpage.pinned", '[]'); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.partnerlink.attributionURL", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.partnerlink.campaign.topsites", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.search.param.search_rich_suggestions", "", locked); // [NO-ANDROID] [NO-MAIL] https://searchfox.org/comm-central/source/mozilla/toolkit/components/search/AppProvidedSearchEngine.sys.mjs
pref("browser.topsites.component.enabled", false, locked); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.topsites.contile.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.contile.endpoint", "", locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.contile.sov.enabled", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.topsites.useRemoteSetting", false, locked); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.sponsoredTopSites", false, locked); // [NO-ANDROID] [NO-MAIL]

/// Disable the "updated wallpaper experience" (V2) [NO-ANDROID] [NO-MAIL]
// This causes Firefox to connect to `https://firefox-settings-attachments.cdn.mozilla.net/main-workspace/newtab-wallpapers-v2/...` on every browser launch after the user navigates to `about:home` :/ [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#1422 [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs#22 [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Disable the Web Compatibility Reporter
// Harmless - We just don't want to waste Mozilla's time due to our custom set-up...
// Also acts as a potential performance improvement
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#3604
pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT - non-Release/ESR]
pref("extensions.webcompat-reporter.newIssueEndpoint", "https://phoenix.celenity.dev/issues"); // Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764
pref("ui.new-webcompat-reporter.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("ui.new-webcompat-reporter.new-report-endpoint", "https://phoenix.celenity.dev/issues"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] Temporarily override to our URL instead of Mozilla's to work-around upstream bug - https://bugzilla.mozilla.org/show_bug.cgi?id=1963764

/// Opt out of add-on metadata updates
// Note: This prevents themes from displaying previews in `about:addons`
// https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/
pref("extensions.getAddons.cache.enabled", false);

/// Prevent checking if Firefox is the default browser [NO-ANDROID] [NO-MAIL]
pref("browser.shell.checkDefaultBrowser", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.shell.skipDefaultBrowserCheckOnFirstRun", true); // [NO-ANDROID] [NO-MAIL]

/// Prevent checking if Firefox is the default `mailto:` handler [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1864216 [NO-ANDROID] [NO-MAIL]
pref("browser.mailto.dualPrompt", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Prevent checking if Firefox is the default PDF viewer [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js [NO-ANDROID] [NO-MAIL]
pref("browser.shell.checkDefaultPDF", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.shell.checkDefaultPDF.silencedByUser", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Remove special privileges from Mozilla domains
// https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#privileged-mozilla-content
pref("browser.tabs.remote.separatePrivilegedMozillaWebContentProcess", false, locked); // [DEFAULT on Firefox Desktop]
pref("browser.tabs.remote.separatedMozillaDomains", "", locked);
pref("dom.ipc.processCount.privilegedmozilla", 0, locked);
pref("extensions.webextensions.restrictedDomains", "");
pref("permissions.manager.defaultsUrl", "", locked); // [HIDDEN - Android] [DEFAULT - Android]
pref("svg.context-properties.content.allowed-domains", "", locked); // [DEFAULT - Android/Thunderbird]

/// Remove tracking parameters from Mozilla URLs + prevent exposing locale & unnecessary information
// For info on the extension update (`extensions.update.`) URL parameters, see https://devdoc.net/web/developer.mozilla.org/en-US/docs/Install_Manifests.html & https://mozilla-balrog.readthedocs.io/en/latest/database.html
pref("app.releaseNotesURL", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.releaseNotesURL.aboutDialog", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.releaseNotesURL.prompt", "https://www.mozilla.org/firefox/%VERSION%/releasenotes", locked); // [NO-ANDROID] [NO-MAIL]
pref("app.support.baseURL", "https://support.mozilla.org/kb/");
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
pref("browser.search.searchEnginesURL", "https://addons.mozilla.org/firefox/search-engines/"); // [NO-ANDROID] [NO-MAIL]
pref("browser.xr.warning.infoURL", "https://support.mozilla.org/kb/webxr-permission-info-page"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.abuseReport.amoFormURL", "https://addons.mozilla.org/feedback/addon/%addonID%/");
pref("extensions.blocklist.addonItemURL", "https://addons.mozilla.org/blocked-addon/%addonID%/%addonVersion%/");
pref("extensions.getAddons.link.url", "https://addons.mozilla.org/"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/search?q=%TERMS%"); // [NO-ANDROID] [NO-MAIL]
pref("extensions.getAddons.search.browseURL", "https://addons.mozilla.org/android/search?q=%TERMS%"); // [ANDROID-ONLY]
pref("extensions.update.background.url", "https://versioncheck-bg.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // [NO-MAIL] Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("extensions.update.url", "https://versioncheck.addons.mozilla.org/update/VersionCheck.php?reqVersion=%REQ_VERSION%&id=%ITEM_ID%&version=%ITEM_VERSION%&status=%ITEM_STATUS%&appID=%APP_ID%&appVersion=%APP_VERSION%&currentAppVersion=%CURRENT_APP_VERSION%&updateType=%UPDATE_TYPE%"); // [NO-MAIL] Removes maximum app/browser version (maxAppVersion), operating system (appOS), ABI (appABI), locale (locale), and compatibility mode (compatMode)
pref("lightweightThemes.getMoreURL", "https://addons.mozilla.org/themes/"); // [NO-ANDROID] [NO-MAIL]
pref("pdfjs.altTextLearnMoreUrl", "https://support.mozilla.org/kb/pdf-alt-text"); // [NO-MAIL]
pref("signon.firefoxRelay.learn_more_url", "https://support.mozilla.org/kb/relay-integration#w_frequently-asked-questions");
pref("signon.firefoxRelay.manage_url", "https://relay.firefox.com/accounts/profile/");
pref("signon.firefoxRelay.privacy_policy_url", "https://www.mozilla.org/privacy/subscription-services/");
pref("signon.firefoxRelay.terms_of_service_url", "https://www.mozilla.org/about/legal/terms/subscription-services/");

/// Skip Mozilla's `Privacy Notice` & `Terms of Use`
// https://github.com/mozilla/policy-templates/pull/1212
// https://searchfox.org/mozilla-central/source/browser/components/enterprisepolicies/Policies.sys.mjs
pref("datareporting.policy.dataSubmissionPolicyAcceptedVersion", 999, locked);
pref("datareporting.policy.dataSubmissionPolicyNotifiedTime", "999999999", locked);

pref("browser.phoenix.status", "002");

/*** 003 TRACKING PROTECTION ***/

/// Enable ETP Strict
// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop?as=u#w_strict-enhanced-tracking-protection
pref("browser.contentblocking.category", "strict", locked); // [HIDDEN]

/// Manually enable ETP/Strict protections...
// These are typically configured by ETP Strict - but unfortunately Firefox doesn't set ETP Strict on the browser's first run :/
// So we need to also manually configure them. We still also use ETP Strict (not 'Custom') due to our enforcement of it, so we should be covered by Mozilla changes/updates for protections.
// Manually specifying these is also useful for cases like Android: where all protections aren't enabled with ETP Strict, and on Thunderbird: where ETP Strict doesn't exist at all...
// We're also configuring the 'CookieBehavior' & 'EnableTrackingProtection' policies on desktop.

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
pref("privacy.trackingprotection.fingerprinting.enabled", true); // [DEFAULT - non-Thunderbird]

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
pref("privacy.trackingprotection.annotate_channels", true); // [DEFAULT]
pref("privacy.trackingprotection.enabled", true);
pref("privacy.trackingprotection.pbmode.enabled", true); // [DEFAULT - non-Android]

//// Block known trackers using the `strict` (Level 2) list
/// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#15192
/// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#2804
pref("privacy.annotate_channels.strict_list.enabled", true); // [DEFAULT - Android]
pref("privacy.annotate_channels.strict_list.pbmode.enabled", true); // [DEFAULT]

//// Block known tracking cookies
pref("network.cookie.cookieBehavior.trackerCookieBlocking", true); // [DEFAULT - Desktop] [HIDDEN - Android/Thunderbird]
pref("privacy.socialtracking.block_cookies.enabled", true); // [DEFAULT]

//// Enable Bounce Tracking Protection
/// https://support.mozilla.org/kb/enhanced-tracking-protection-firefox-desktop#w_bounce-tracking-protection
/// https://searchfox.org/mozilla-central/source/toolkit/components/antitracking/bouncetrackingprotection/nsIBounceTrackingProtection.idl#11
pref("privacy.bounceTrackingProtection.enabled", true); // [DEFAULT] [HIDDEN - Desktop]
pref("privacy.bounceTrackingProtection.enableDryRunMode", false); // [HIDDEN - Desktop]
pref("privacy.bounceTrackingProtection.mode", 1); // [HIDDEN - Android/Thunderbird]

//// Enable Query Parameter Stripping
/// https://firefox-source-docs.mozilla.org/toolkit/components/antitracking/anti-tracking/query-stripping/index.html
pref("privacy.query_stripping.enabled", true);
pref("privacy.query_stripping.enabled.pbmode", true);
pref("privacy.query_stripping.redirect", true); // [DEFAULT]

//// Enable SmartBlock & UA overrides/injections
pref("extensions.webcompat.enable_shims", true); // [DEFAULT - non-Thunderbird] [HIDDEN]
pref("extensions.webcompat.perform_injections", true); // [DEFAULT - non-Thunderbird] [HIDDEN]
pref("extensions.webcompat.perform_ua_overrides", true); // [DEFAULT - non-Thunderbird] [HIDDEN]
pref("extensions.webcompat.smartblockEmbeds.enabled", true); // [DEFAULT - Desktop] [HIDDEN - Android/Thunderbird] - Enables Embeds/Placeholders to make certain resources click to load

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
pref("privacy.fingerprintingProtection.pbmode", true); // [DEFAULT - non-Thunderbird]
pref("privacy.reduceTimerPrecision", true); // [DEFAULT]

//// Enable TCP/dFPI
/// https://support.mozilla.org/kb/introducing-total-cookie-protection-standard-mode
/// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml#2828
pref("network.cookie.cookieBehavior", 5); // [DEFAULT - non-Thunderbird]
pref("network.cookie.cookieBehavior.optInPartitioning", true);
pref("network.cookie.cookieBehavior.optInPartitioning.pbmode", true);
pref("network.cookie.cookieBehavior.pbmode", 5); // [DEFAULT - non-Thunderbird]

//// Ignore less restricted referer policies (than the default)
/// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#12979
pref("network.http.referer.disallowCrossSiteRelaxingDefault", true); // [DEFAULT] - for cross-site requests
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode", true); // [DEFAULT] - for cross-site requests in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode.top_navigation", true); // [DEFAULT] - for top navigations in Private Browsing
pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true); // for top navigations

//// Lower the network priority of known trackers (if not blocked for whatever reason...)
pref("privacy.trackingprotection.lower_network_priority", true);

pref("browser.phoenix.status", "003");

/*** 004 FINGERPRINTING PROTECTION ***/

/// Always load fonts bundled with Firefox
// The default is -1 - which loads bundled fonts, EXCEPT on "low-memory" devices
// Hence, this could add extra entropy/add an extra fingerprinting vector for users on "low-memory" devices
// In general, this will ensure all users have the same standard behavior here
// https://bugzilla.mozilla.org/show_bug.cgi?id=1686274
// https://searchfox.org/mozilla-central/rev/20fc11f1/gfx/thebes/gfxFT2FontList.cpp#1615
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

/// Disable Mozilla's remote fingerprinting protection overrides
// Unnecessary/undesired for our use case...
// Currently this is only used to disable canvas randomization for Google domains (to fix a certain display issue in Google Maps)
// This unfortunately impacts all Google domains (can't just be limited to Maps), and due to the importance of the this fingerprinting protection (especially for Android), as well as Google's questionable privacy practices... I feel that this is best left up to the user.
// I'd rather leave this on though, so I hope we can re-assess and re-enable this in the future.
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fingerprinting-protection-overrides/changeset?_expected=0
pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);

/// Disable VP9 Benchmark
// This means that VP9 will always be enabled regardless of performance benchmarks (unless on a plaform where this isn't supported)
// This likely also results in a performance improvement, so that's nice
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/22548
pref("media.benchmark.vp9.threshold", 0);

/// Enable canvas randomization for the browser chrome
pref("privacy.resistFingerprinting.randomization.canvas.disable_for_chrome", false); // [DEFAULT]

/// Enable fdlibm for Math.sin, Math.cos, and Math.tan
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#8720
// https://groups.google.com/a/mozilla.org/g/dev-platform/c/0dxAO-JsoXI/m/eEhjM9VsAgAJ
pref("javascript.options.use_fdlibm_for_sin_cos_tan", true); // [DEFAULT - non-Windows]

/// Enable light mode by default
// Matches with RFP & prevents exposing system theme
pref("layout.css.prefers-color-scheme.content-override", 1);

/// Ensure we use the standard Noto Color Emoji font by default (instead of ex. Samsung's if available) [ANDROID-ONLY]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/43023 [ANDROID-ONLY]
pref("font.name-list.emoji", "Noto Color Emoji"); // [ANDROID-ONLY]

/// Expose dynamic rounding of content dimensions (`privacy.resistFingerprinting.letterboxing`) in the `about:config`, but do not enable by default [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1407366 [NO-ANDROID] [NO-MAIL]
pref("privacy.resistFingerprinting.letterboxing", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Harden FPP (which we enable at `003` in `Phoenix-Core`) to match RFP with a few exceptions...
// As explained here: https://codeberg.org/celenity/Phoenix/wiki/Android#fingerprinting [ANDROID-ONLY]
// This also improves security - Attack Surface Reduction, reduced timer precision
// List of targets: https://searchfox.org/mozilla-central/source/toolkit/components/resistfingerprinting/RFPTargets.inc
// Easily build your own (global) override list: https://raw.githack.com/rindeal/Firefox-FPP-Override-List-Editor/master/FirefoxFPPOverrideListEditor.html
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC"); // [NO-ANDROID] [NO-MAIL]
pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,-CSSPrefersColorScheme,-FrameRate,-JSDateTimeUTC"); // [ANDROID-ONLY]
pref("privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts", false); // [NO-ANDROID] [ESR] (This is the equivalent of the `-CanvasExtractionBeforeUserInputIsBlocked` target)
pref("privacy.resistFingerprinting.randomDataOnCanvasExtract", true); // [NO-ANDROID] [ESR] (This is the equivalent of the `+CanvasRandomization` target)

/// Prevent enumeration of media devices
// Exceptions can be set via the `media.devices.enumerate.legacy.allowlist` pref
// https://bugzilla.mozilla.org/show_bug.cgi?id=1528042
pref("media.devices.enumerate.legacy.enabled", false); // [DEFAULT]

/// Prevent exposing WebGL Renderer Info
// So this is typically covered by RFP/FPP's 'WebGLRenderInfo' target, but some websites (ex. moviezapiya.fun) break when that target is set, due to the target disabling the debug renderer info (while spoofing the renderer query info to "Mozilla" for the vendor and renderer)
// So for cases like that, when the `WebGLRenderInfo` target is disabled, this will ensure the real vendor/renderer info is still not exposed (RFP/FPP's target here should still take precedent)
// Looks like this is fixed for 140, so we won't need these for long... - https://bugzilla.mozilla.org/show_bug.cgi?id=1966860
// https://searchfox.org/mozilla-central/source/dom/canvas/SanitizeRenderer.cpp
pref("webgl.enable-renderer-query", false); // Spoofs "Vendor" and "Renderer" to "Mozilla" (Like the `WebGLRenderInfo` target does)
pref("webgl.sanitize-unmasked-renderer", true); // [DEFAULT] [DEFENSE IN DEPTH]
pref("webgl.override-unmasked-renderer", "Mozilla"); // Attempts to spoof "Unmasked Renderer" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query), but Firefox seems to override to "Generic Renderer" anyways
pref("webgl.override-unmasked-vendor", "Mozilla"); // Spoofs "Unmasked Vendor" Debug info to "Mozilla" (like FPP/RFP does for the WebGL renderer query)

/// Prevent using system accent colors
pref("widget.non-native-theme.use-theme-accent", false); // [DEFAULT - non-Thunderbird Windows]

/// Prevent using system colors
// The `ui.use_standins_for_native_colors` pref does the same thing as the 'UseStandinsForNativeColors' RFP/FPP target (so it shouldn't interfere with FPP/RFP)
// But I also want to set this here to ensure users are protected if they disable FPP for whatever reason, or if they disable ETP/Strict for a specific site/add an exception
// https://searchfox.org/mozilla-central/rev/a589ce1e/layout/style/PreferenceSheet.cpp#69
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
pref("privacy.window.maxInnerHeight", 900); // [DEFAULT - non-Android/Thunderbird]
pref("privacy.window.maxInnerWidth", 1600);

/// Set a fixed temporary storage limit
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41065
// https://bugzilla.mozilla.org/show_bug.cgi?id=1781277
pref("dom.quotaManager.temporaryStorage.fixedLimit", 52428800); // Ex. matches what Tor Browser uses & what Firefox uses by default in most cases

/// Set target video resolution to 1080p
// Default on ESR is still 480p...
pref("privacy.resistFingerprinting.target_video_res", 1080); // [DEFAULT - non-ESR]

/// Set zoom levels on a per-site basis
// Changing the zoom level globally can be fingerprintable
// Note: We also set the "SiteSpecificZoom" FPP/RFP target
pref("browser.zoom.siteSpecific", true); // [DEFAULT - non-Android]

/// So people don't freak out when they see RFP isn't enabled...
pref("privacy.resistFingerprinting.0.note", "RFP is disabled on purpose.");
pref("privacy.resistFingerprinting.1.note", "We use a hardened configuration of FPP instead.");
pref("privacy.resistFingerprinting.2.note", "Using RFP is not recommended or supported.");

/// Set FPP granular overrides (if the related target is enabled...)
// See here for details: https://codeberg.org/celenity/Phoenix/wiki/FPP-Overrides
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"aa.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.ae","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.ca","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.uk","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.co.za","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.br","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.mx","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.com.tr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.de","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.eg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.es","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.fr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.ie","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.it","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.nl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.pl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.se","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"amazon.sg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.com.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"apple.news","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"barnesandnoble.com","overrides":"-ScreenRect"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cloudflare.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+JSDateTimeUTC"},{"firstPartyDomain":"cvs.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"discord.gg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"epicgames.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"goo.gl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"kroger.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"medium.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"moviezapiya.fun","overrides":"-WebGLRenderInfo"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pogo.com","thirdPartyDomain":"pogospike.com","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"reddit.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"redditmedia.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"rezka-ua.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"riverside.fm","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"southwest.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"stacksocial.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"t.co","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"tiktok.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"tileman.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+JSDateTimeUTC"},{"firstPartyDomain":"transfem.dev","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"usps.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"yahoo.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"youtu.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"zoho.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.eu","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"zoho.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.news","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"bsky.app","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdn-apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdninstagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cloudflare.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"discord.gg","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"goo.gl","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"googlevideo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"gravatar.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"instagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"licdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"linkedin.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"loginwithamazon.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.store","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"moviezapiya.fun","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinimg.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinterest.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pornhub.com","overrides":"-CanvasExtractionFromThirdPartiesIsBlocked"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net.cn","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha-cn.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redd.it","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"reddit.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditmedia.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditstatic.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"t.co","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"tiktok.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"tileman.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twitter.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twimg.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeocdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"x.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtu.be","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"}]'); // [NO-ANDROID] [NO-MAIL]
pref("privacy.fingerprintingProtection.granularOverrides", '[{"firstPartyDomain":"aa.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.ae","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.ca","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.uk","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.co.za","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.br","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.mx","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.com.tr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.de","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.eg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.es","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.fr","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.ie","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.it","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.nl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.pl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.se","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"amazon.sg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"apple.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"apple.com.cn","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"apple.news","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"arcticfoxes.net","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"aria.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"bitcoinist.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"brave.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"bsky.app","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"chatwave.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"chipotle.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cinny.in","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"citybbq.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"cloudflare.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"cvs.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"discord.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"discord.gg","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"doordash.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"duesen.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"element.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"epicgames.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"favicon.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"flieger.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"g24.at","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gemeinsam.jetzt","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"gitlab.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"gnulinux.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"goo.gl","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"gsi.go.jp","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"harkins.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"hot-chilli.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"icloud.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"icloud.com.cn","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"jerseymikes.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"kosmikdog.eu","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"kroger.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"letterboxd.com","overrides":"-ScreenRect"},{"firstPartyDomain":"medium.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"megacloud.store","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"moviezapiya.fun","overrides":"-WebGLRenderInfo,+JSDateTimeUTC"},{"firstPartyDomain":"mtrx.nz","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"neat.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nitro.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nope.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"nperf.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"oblak.be","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pcriot.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pendora.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"pogo.com","thirdPartyDomain":"pogospike.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"photopea.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pogospike.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"pornhub.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"proton.me","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"reddit.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"redditmedia.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"rezka-ua.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"riverside.fm","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"rollenspiel.chat","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"socialnetwork24.com","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"southwest.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"stacksocial.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"studichat.de","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"synod.im","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"t.co","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"the-apothecary.club","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"tiktok.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"tileman.io","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+JSDateTimeUTC"},{"firstPartyDomain":"transfem.dev","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"unredacted.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"usps.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"utwente.io","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"viliusle.github.io","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"watchduty.org","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"we2.ee","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"x.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"yahoo.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"yatrix.org","overrides":"-JSDateTimeUTC"},{"firstPartyDomain":"youtu.be","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt,+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"zoho.com","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"}{"firstPartyDomain":"zoho.com.au","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.eu","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.in","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.jp","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"zoho.sa","overrides":"+CanvasExtractionBeforeUserInputIsBlocked,+CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"apple.news","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"bsky.app","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdn-apple.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cdninstagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"cloudflare.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"discord.gg","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"favicon.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"goo.gl","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"googlevideo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"gravatar.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"instagram.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"licdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"linkedin.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"loginwithamazon.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.blog","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"megacloud.store","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"moviezapiya.fun","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinimg.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pinterest.com","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"pornhub.com","overrides":"-CanvasExtractionBeforeUserInputIsBlocked,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasImageExtractionPrompt"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha.net.cn","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"recaptcha-cn.net","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redd.it","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"reddit.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditmedia.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"redditstatic.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"t.co","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"tileman.io","overrides":"+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"tiktok.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twitter.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"twimg.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeo.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"vimeocdn.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"x.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtu.be","overrides":"+CSSPrefersColorScheme,+FrameRate,+JSDateTimeUTC,+JSLocale"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"},{"firstPartyDomain":"*","thirdPartyDomain":"youtube-nocookie.com","overrides":"+CSSPrefersColorScheme,+JSDateTimeUTC"}]'); // [ANDROID-ONLY]

pref("browser.phoenix.status", "004");

/*** 005 DISK AVOIDANCE ***/

/// Allow permission manager to write to disk
// This is already Firefox's default - but it's hidden, so this exposes it via the `about:config`
// https://searchfox.org/mozilla-central/source/extensions/permissions/PermissionManager.cpp#758
pref("permissions.memory_only", false); // [HIDDEN] [DEFAULT]

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

/// Decrease the number of pages allowed in back/forward cache
// Also improves performance
// (Default = -1 (Automatic) - which is 8 unless you're using a device with under 1GB of RAM)
// https://kb.mozillazine.org/Browser.sessionhistory.max_total_viewers#Possible_values_and_their_effects
pref("browser.sessionhistory.max_total_viewers", 7);

/// Decrease the number of tabs saved in Session Store [NO-MAIL]
// Also improves performance [NO-MAIL]
// (Default = 10 for Android, 25 elsewhere) [NO-MAIL]
pref("browser.sessionstore.max_tabs_undo", 7); // [NO-MAIL]

/// Disable collection/generation of background thumbnails
// https://searchfox.org/mozilla-central/source/toolkit/components/thumbnails/PageThumbs.sys.mjs#629
pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN]

/// Disable collection/generation of wireframes
// https://searchfox.org/mozilla-central/source/browser/components/sessionstore/PageWireframes.sys.mjs
pref("browser.history.collectWireframes", false); // [DEFAULT]

/// Disable coloring visited links
pref("layout.css.visited_links_enabled", false);

/// Disable favicons in shortcuts [NO-ANDROID]
// Prevents .ico files from persisting, even after deletion [NO-ANDROID]
pref("browser.shell.shortcutFavicons", false); // [NO-ANDROID] [HIDDEN - Thunderbird]

/// Disable LaterRun [NO-ANDROID] [NO-MAIL]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/41568 [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1200639 [NO-ANDROID] [NO-MAIL]
pref("browser.laterrun.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable logging blocked domains to `about:protections` [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.cfr-milestone.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.contentblocking.cfr-milestone.milestone-shown-time", "999999999"); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.contentblocking.cfr-milestone.update-interval", 0); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable Search & Form History
// Can be leaked to sites...
// https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
pref("browser.formfill.enable", false);

/// Disable disk caching
pref("browser.cache.disk.enable", false);
pref("browser.cache.disk_cache_ssl", false);

/// Disable logging blocked domains to `about:protections`
pref("browser.contentblocking.database.enabled", false); // [DEFAULT - Android/Thunderbird]

/// Disable WebRTC history
// History will still gather when `about:webrtc` is open
// Also likely improves performance...
pref("media.aboutwebrtc.hist.enabled", false); // [DEFAULT - non-Nightly]

/// Enable a fire button in Private Browsing Windows to reset the session [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.resetPBM.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly]

/// Increase the interval between between Session Store save operations
// Also improves performance
// (Default = 10000 (10 secs) for Android, 15000 (15 secs) elsewhere)
// https://searchfox.org/mozilla-central/source/toolkit/components/sessionstore/docs/utils.rst
pref("browser.sessionstore.interval", 60000); // 1 minute

// Prevent automatically sharing Firefox Sync accounts [NO-ANDROID] [NO-MAIL]
pref("identity.fxaccounts.migrateToDevEdition", false); // [NO-ANDROID] [NO-MAIL]

/// Prevent automatically starting Firefox and restoring session after reboot [WINDOWS-ONLY]
pref("toolkit.winRegisterApplicationRestart", false); // [WINDOWS-ONLY] [HIDDEN - Thunderbird]

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
// https://searchfox.org/mozilla-central/rev/06e32c3e/browser/app/profile/firefox.js#2511 [NO-ANDROID] [NO-MAIL]
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
// https://searchfox.org/mozilla-central/rev/06e32c3e/browser/app/profile/firefox.js#782 [NO-ANDROID] [NO-MAIL]
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
pref("security.certerror.hideAddException", false); // [DEFAULT] [HIDDEN]

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

/// Disable Parental Controls
// https://searchfox.org/mozilla-central/source/toolkit/components/parentalcontrols/nsIParentalControlsService.idl
// https://searchfox.org/mozilla-central/source/netwerk/protocol/http/nsHttpHandler.cpp#547
pref("network.parental_controls_cached_state", false, locked); // [DEFAULT]

/// Disable sending background HTTP requests to websites that do not respond quickly to check if they support HTTPS
pref("dom.security.https_only_mode_send_http_background_request", false);

/// Disable third-party/OS-level root certificates
// I've been torn on how to handle this, but IMO the safest way forward is disabling this functionality in Firefox.
// This is commonly abused by malware/etc. and it's even overriden by certain software/garbage AV's...
// Ex. https://support.kaspersky.com/common/compatibility/14620#block3
// Since this is something programs actively try to override, I don't see a safe way to support this, so we'll lock it.
// We still allow users to manually import certificates into Firefox... 
// So we can ensure users are aware of certificates they add and are making this decision consciously.
// We also set "ImportEnterpriseRoots" in policies [NO-ANDROID]
// https://mozilla.github.io/policy-templates/#certificates--importenterpriseroots [NO-ANDROID]
pref("security.certerrors.mitm.auto_enable_enterprise_roots", false); // [ANDROID-ONLY] [DEFAULT]
pref("security.certerrors.mitm.auto_enable_enterprise_roots", false, locked); // [NO-ANDROID] [HIDDEN - Thunderbird]
pref("security.enterprise_roots.enabled", false); // [ANDROID-ONLY] [DEFAULT]
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
pref("security.pki.certificate_transparency.mode", 2); // [DEFAULT - Nightly Desktop]
pref("security.pki.certificate_transparency.disable_for_hosts", ""); // [DEFAULT]
pref("security.pki.certificate_transparency.disable_for_spki_hashes", ""); // [DEFAULT]

/// Enable CRLite revocation checks & prioritize over OCSP
// https://blog.mozilla.org/security/2020/01/09/crlite-part-1-all-web-pki-revocations-compressed/
pref("security.pki.crlite_mode", 2); // [DEFAULT - Nightly]
pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT - non-Android]

/// Enable Delegated Credentials
// https://wikipedia.org/wiki/Delegated_credential
pref("security.tls.enable_delegated_credentials", true); // [DEFAULT]

/// Enable MITM Detection
// https://github.com/arkenfox/user.js/issues/740
// https://bugzilla.mozilla.org/show_bug.cgi?id=1529643
pref("security.certerrors.mitm.priming.enabled", true); //[HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]
pref("security.certerrors.mitm.priming.endpoint", "https://mitmdetection.services.mozilla.com/"); //[HIDDEN - Android/Thunderbird] [DEFAULT - non-Android/Thunderbird]

/// Enable OCSP revocation checks + stapling
// (https://wikipedia.org/wiki/Online_Certificate_Status_Protocol
// https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
// https://blog.cloudflare.com/high-reliability-ocsp-stapling/#ocsp-must-staple
pref("security.OCSP.enabled", 1); // [DEFAULT - non-Android]
pref("security.ssl.enable_ocsp_must_staple", true); // [DEFAULT]
pref("security.ssl.enable_ocsp_stapling", true); // [DEFAULT]

/// Enable Post Quantum Key Agreement (Kyber)
pref("media.webrtc.enable_pq_dtls", true); // [DEFAULT]
pref("network.http.http3.enable_kyber", true); // [DEFAULT - non-Android]
pref("security.tls.client_hello.send_p256_keyshare", true); // [DEFAULT]
pref("security.tls.enable_kyber", true); // [DEFAULT - non-Android]

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning
pref("security.cert_pinning.enforcement_level", 2);

/// Enforce TLS 1.3 downgrade protection
// https://bugzilla.mozilla.org/show_bug.cgi?id=1576790
pref("security.tls.hello_downgrade_check", true); // [DEFAULT]

/// Enforce using HTTPS as much as possible
pref("dom.securecontext.allowlist", ""); // [HIDDEN] [DEFAULT] https://searchfox.org/mozilla-central/rev/a589ce1e/dom/security/nsMixedContentBlocker.cpp#270
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

/// Ensure we use the HSTS preload list
// https://searchfox.org/mozilla-central/source/remote/cdp/domains/parent/Security.sys.mjs
pref("network.stricttransportsecurity.preloadlist", true); // [DEFAULT]

/// Hard-fail OCSP revocation checks by default
// Significant security improvement
// https://github.com/arkenfox/user.js/issues/1576
pref("security.OCSP.require", true);

/// If HTTPS-Only Mode is disabled in favor of HTTPS-First, prevent automatically exempting domains (to ensure we always try HTTPS first...)
pref("dom.security.https_first_add_exception_on_failure", false);
pref("dom.security.https_first_add_exception_on_failiure", false); // [NO-ANDROID] [ESR]

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

/// Allow using a different search engine in normal vs. private Windows
pref("browser.search.separatePrivateDefault.ui.enabled", true);

/// Always show Punycode
// Protects against phishing & IDN Homograph Attacks
// https://wikipedia.org/wiki/IDN_homograph_attack
pref("network.IDN_show_punycode", true);

/// Disable autofill/autocompletion of URLs by default [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.autoFill", false); // [NO-ANDROID] [NO-MAIL]

/// Disable Search Suggestions
// `browser.search.suggest.enabled` & `browser.search.suggest.enabled.private` appear to have no impact on Android & Thunderbird, but they're still defined there anyways.. so we can set them anyways
pref("browser.search.suggest.enabled", false); // [DEFAULT - Android]
pref("browser.search.suggest.enabled.private", false); // [DEFAULT]
pref("browser.urlbar.showSearchSuggestionsFirst", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.searches", false); // [NO-ANDROID] [NO-MAIL]

/// Disable suggestions for "Recent Searches" [NO-ANDROID] [NO-MAIL]
// We disable search and form history anyways [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.recentsearches.featureGate", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.recentsearches", false); // [NO-ANDROID] [NO-MAIL]

/// Disable URL trimming [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trimHttps", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.trimURLs", false); // [NO-ANDROID] [NO-MAIL]

/// Enable the UI to add custom search engines at `about:preferences#search` [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.update2.engineAliasRefresh", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Exclude JavaScript URLS from results [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.filter.javascript", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Highlight domains and other styling [NO-ANDROID] [NO-MAIL]
// Protects against phishing [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/preferences.rst [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.formatting.enabled", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Nice to have [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.scotchBonnet.enableOverride", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT - Nightly] Adds Unified Search button to easily switch search engines in URL Bar - https://windowsreport.com/firefox-tests-dedicated-address-bar-button-for-easier-search-engine-switching/ + other tweaks
pref("browser.urlbar.shortcuts.actions", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN]
pref("browser.urlbar.suggest.bookmark", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.calculator", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.clipboard", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.engines", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.history", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.suggest.openpage", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.urlbar.suggest.quickactions", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.unitConversion.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Prompt to use Private Browsing [NO-ANDROID] [NO-MAIL]
pref("browser.search.separatePrivateDefault.urlbarResult.enabled", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Remove default Search Engine Placeholders [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.placeholderName", ""); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.placeholderName.private", ""); // [NO-ANDROID] [NO-MAIL]

/// Show full URLs instead of search terms [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.restyleSearches", false); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]
pref("browser.urlbar.showSearchTerms.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.showSearchTerms.featureGate", false); // [NO-ANDROID] [NO-MAIL]

/// Use same search engine in both normal & private browsing windows by default
// Otherwise, Firefox's default private search engine will set itself as Google, regardless of our default... :/
pref("browser.search.separatePrivateDefault", false);

pref("browser.phoenix.status", "009");

/*** 010 DNS ***/

/// Always warn before falling back from DoH to system DNS
pref("network.trr.display_fallback_warning", true);
pref("network.trr_ui.show_fallback_warning_option", true);

/// Customize list of built-in DoH resolvers [NO-ANDROID] [NO-MAIL]
pref("doh-rollout.provider-list", '[{"uri":"https://dns.quad9.net/dns-query","UIName":"Quad9 - Real-time Malware Protection","autoDefault":true},{"uri":"https://zero.dns0.eu","UIName":"DNS0 (ZERO) - Hardened Real-time Malware Protection","autoDefault":false},{"uri":"https://dns0.eu","UIName":"DNS0 - Real-time Malware Protection","autoDefault":false},{"uri":"https://base.dns.mullvad.net/dns-query","UIName":"Mullvad (Base) - Ad/Tracking/Limited Malware Protection","autoDefault":false},{"uri":"https://dns.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Ad/Tracking Protection","autoDefault":false},{"uri":"https://dns.mullvad.net/dns-query","UIName":"Mullvad - Unfiltered","autoDefault":false},{"uri":"https://wikimedia-dns.org/dns-query","UIName":"Wikimedia - Unfiltered","autoDefault":false},{"uri":"https://firefox.dns.nextdns.io/","UIName":"NextDNS (Public) - Unfiltered","autoDefault":false},{"uri":"https://unfiltered.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Unfiltered","autoDefault":false},{"uri":"https://kids.dns0.eu","UIName":"DNS0 - Kids","autoDefault":false},{"uri":"https://family.dns.mullvad.net/dns-query","UIName":"Mullvad (Family)","autoDefault":false},{"uri":"https://family.adguard-dns.com/dns-query","UIName":"AdGuard (Public) - Family Protection","autoDefault":false},{"uri":"https://extended.dns.mullvad.net/dns-query","UIName":"Mullvad (Extended) - Ad/Tracking/Limited Malware/Social Media Protection","autoDefault":false},{"uri":"https://all.dns.mullvad.net/dns-query","UIName":"Mullvad (All) - Ad/Tracking/Limited Malware/Social Media/Adult/Gambling Protection","autoDefault":false},{"uri":"https://security.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Malware Protection","autoDefault":false},{"uri":"https://mozilla.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Unfiltered (Stricter privacy policy)","autoDefault":false},{"uri":"https://family.cloudflare-dns.com/dns-query","UIName":"Cloudflare - Adult Content/Malware Protection","autoDefault":false}]'); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

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
pref("network.trr.bootstrapAddr", ""); // [HIDDEN] [DEFAULT]

/// Fix IPv6 connectivity when DoH is enabled
// https://codeberg.org/divested/brace/pulls/5
pref("network.dns.preferIPv6", true);

/// Prevent bypassing DoH for /etc/HOSTS entries by default
// Protects against HOSTS file hijacking
// https://www.malwarebytes.com/blog/news/2016/09/hosts-file-hijacks
// https://www.microsoft.com/wdsi/threats/malware-encyclopedia-description?Name=SettingsModifier:Win32/HostsFileHijack
// https://www.microcenter.com/tech_center/article/6472/how-to-clean-the-windows-hosts-file-if-malware-has-tampered-with-it
pref("network.trr.exclude-etc-hosts", false);

/// Prevent disabling DoH from registry checks
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("network.notify.checkForNRPT", false);
pref("network.notify.checkForProxies", false);

/// Prevent sending headers for DoH requests
pref("network.trr.send_accept-language_headers", false); // [DEFAULT]
pref("network.trr.send_empty_accept-encoding_headers", true); // [DEFAULT]
pref("network.trr.send_user-agent_headers", false); // [DEFAULT]

/// Temporarily exclude certain captive portal domains from DNS over HTTPS by default [ANDROID-ONLY]
// Android unfortunately doesn't currently prompt users to fallback from DNS over HTTPS when a site can't be found (like desktop does), which causes unexpected breakage for users, as it leaves them without a clear explanation of the issue and a way to add the exceptions [ANDROID-ONLY]
// I don't love the idea of doing this... so again, to clarify: these are temporary will be removed once Firefox adds the fallback UI [ANDROID-ONLY]
// Domains taken from: https://badblock.celenity.dev/#captive-whitelist [ANDROID-ONLY]
pref("network.trr.builtin-excluded-domains", "localhost,local,aainflight.com,acwifi.com,aircanadawifi.com,airtime.geemedia.com,alaskawifi.com,amtrakconnect.com,amtrakwifi.com,ana-inflight-wifi.com,app-yoda.arubathena.com,aruba.odyssys.net,arubanetworks.com,arubanetworks.com.cn,asset-acms.anuvu.cloud,auth.hpe.com,bap.aws.opennetworkexchange.net,btwifi.com,captive.o2wifi.co.uk,captive-2020.aio.cloudauth.net,captive-2022.aio.cloudauth.net,captivemgr.o2wifi.net.uk,captiveportal-login.belex.com,carnivalwifi.com,cbp-guest.cbp.dhs.gov,cdnhotspot.afd.azureedge.net,cdnhotspot.azureedge.net,central.access.network,cfr-mprtuam-01.cops.us1.pr.anuvu.cloud,checkout.aa.com,cloud.imedia.ie,connect.edge.ihg.com,connect-edge.ihg.com,connected.xfinity.com,controller.access.network,cust.blueprintrf.com,deltawifi.com,device-yoda2.arubadev.cloud.hpe.com,dlrguest-captive.disney.com,ee-wifi.ee.co.uk,etihadwi-fly.com,fedsso.yum.com,flyfi.com,freewlan.sbb.ch,gogoinair.com,gogoinflight.com,gp1.wendys.com,guestinternet.com,guestinternet.com.s3-website-us-east-1.amazonaws.com,hiltonwifi.com,hotspotportals.com,hs.imedia.ie,httpforever.com,iceportal.de,inflight.pacwisp.net,inflight-wifi.com,inflightinternet.com,internal2-public-device-nc-nlb-b71ba3c951b09682.elb.us-west-2.amazonaws.com,internal2-public-device-nlb-2e2273d4267c0682.elb.us-west-2.amazonaws.com,internetupgrade.marriott.com,kong-gtw-portal-apse2prod5-lb-1386339370.ap-southeast-2.elb.amazonaws.com,kong-gtw-portal-eu-lb-1104785228.eu-central-1.elb.amazonaws.com,kong-gtw-portal-mec1prod6-lb-2104849938.me-central-1.elb.amazonaws.com,kong-gtw-portal-production-lb-686216184.us-west-1.elb.amazonaws.com,kong-gtw-portal-use1prod2-lb-291057632.us-east-1.elb.amazonaws.com,krisworld.singaporeair.com,kw.sq.com,landing.sbb.ch,loggedin.wifigem.it,login.attwifi.com,login.cloud5.com,login.cloudi-fi.net,login.innflux.com,login.wifigem.com,login.windstream.com,login-awe-cluster.attwifi.com,login-federated.windstream.com,lounge.aa.com,lpv.attwifi.com,lufthansa-flynet.com,managedwifi.xfinity.com,massportwifi.com,marriottwifi.com,medallionclass.com,mscwifi.com,msftguest-virtual.partners.extranet.microsoft.com,mt1.datavalet.io,network-auth.com,neverssl.com,nossl.com,ofc-yoda2.arubadev.cloud.hpe.com,onboard.eurostar.com,onboard.sbb.ch,onboardicafe.com,portal.ac2.mist.com,portal.ac5.mist.com,portal.ac6.mist.com,portal.eu.mist.com,portal.gc1.mist.com,portal.gc2.mist.com,portal.gc3.mist.com,portal.mist.com,portal.moovmanage.com,qa-connect-edge.ihg.com,rcs.arubathena.com,rcs-m.arubathena.com,rcs-ng-yoda2.arubadev.cloud.hpe.com,regio-guide.de,rsc.att.com,rsc.wayport.net,rougewifi.com,sbux-j3.datavalet.io,sbux-portal.globalreachtech.com,sbux-portal.odyssys.net,secure.11os.com,secure.datavalet.io,secure.wayport.net,secure-login.attwifi.com,service.thecloud.net,shop.ba.com,singaporeair-krisworld.com,sso.wendys.com,stage.connect.edge.ihg.com,starbucks-east.datavalet.io,stay.marriottbonvoy.com,southwestwifi.com,thalysnet.com,thd.cloudauth.net,timhortonswifi.com,tvgreyhound.com,unitedprivatescreening.com,unitedwifi.com,universal-orlando.ampthink.com,viasat.com,virginwifi.com,wanderingwifi.com,we.windstream.com,weconnect.wendys.com,wifi.airasia.com,wifi.bahn.de,wifi.cathaypacific.com,wifi.delta.com,wifi.esa.com,wifi.kfc.com,wifi1.kfc.com,wifi2.kfc.com,wifi.panerabread.com,wifi.singaporeair.com,wifi.sncf,wifi.starbucks.com,wifi.tgv-lyria.com,wifi.tgvlyria.com,wifi.united.com,wifi.united.com.edgekey.net,wifi.we.co,wifi.xfinity.com,wifi-viarail.ca,wifi-xdb.boingohotspot.net,wifihotspot.io,wifilauncher.com,wifilauncher.com.s3-website.us-east-1.amazonaws.com,wifilrn-ch2-1p.xfinity.com,wifionboard.com,wirelessportal.americanexpress.com,wirelessportal.americanexpress.com.akadns.net,wirelessportal2.americanexpress.com.akadns.net,wlb1-1579773356.us-east-1.elb.amazonaws.com,yoda-cgqa.arubathena.com,yoda-cgqa-elb.arubathena.com,yoda2-ofc-nlb-f4f923213a2189c7.elb.us-west-2.amazonaws.com,yoda2-public-device-nlb-8343995ce4714f6f.elb.us-west-2.amazonaws.com,yoda2-rcs-nlb-0c9df3882f3f7416.elb.us-west-2.amazonaws.com,zugportal.de"); // [ANDROID-ONLY]

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

/// Disable GIO
// https://bugzilla.mozilla.org/1433507
pref("network.gio.supported-protocols", ""); // [HIDDEN]

/// Disable Uniform Naming Convention (UNC) file paths
// https://bugzilla.mozilla.org/1413868
pref("network.file.disable_unc_paths", true); // [HIDDEN]

/// Disable file:///net
// https://bugzilla.mozilla.org/show_bug.cgi?id=1412081
pref("network.file.path_blacklist", "/net"); // [HIDDEN]

/// Disable Wi-Fi Tickler
// Ex. disabled by the Proxy Bypass Protection build argument
// https://searchfox.org/mozilla-central/source/netwerk/base/Tickler.h
// https://searchfox.org/mozilla-central/source/netwerk/base/Tickler.cpp
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
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2452
pref("privacy.webrtc.allowSilencingNotifications", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]
pref("privacy.webrtc.hideGlobalIndicator", false); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Always sandbox Media Transport
// https://searchfox.org/mozilla-central/source/security/sandbox/common/SandboxSettings.cpp
pref("media.peerconnection.mtransport_process", true); // [HIDDEN - Android/Thunderbird] [DEFAULT]

/// Enable global toggles for muting the camera/microphone
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2452
pref("privacy.webrtc.globalMuteToggles", true); // [HIDDEN - Android]

/// Enable mDNS Host Obfuscation to prevent leaking local IP addresses
// https://bugzilla.mozilla.org/show_bug.cgi?id=1588817
pref("media.peerconnection.ice.obfuscate_host_addresses", true); // [DEFAULT - non-Android]

/// Prevent WebRTC from bypassing the proxy (if configured)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1790270
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/// Warn users when attempting to switch tabs in a window being shared over WebRTC
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#2459
pref("privacy.webrtc.sharedTabWarning", true); // [HIDDEN - Android/Thunderbird]

pref("browser.phoenix.status", "012");

/*** 013 MEDIA ***/

/// Add DRM notes
pref("media.eme.enabled.3.note", "You will also need to enable GMP and a CDM."); // [NO-ANDROID] [NO-MAIL]
pref("media.eme.enabled.3.note", "You will also need to enable the CDM."); // [ANDROID-ONLY]
pref("media.eme.enabled.4.note", "See media.gmp-provider.enabled, media.gmp-widevinecdm.enabled, & media.media.gmp-widevinecdm.visible"); // [NO-ANDROID] [NO-MAIL]
pref("media.eme.enabled.4.note", "See media.mediadrm-widevinecdm.visible"); // [ANDROID-ONLY]
pref("media.eme.enabled.5.note", "WINDOWS USERS: Also see media.eme.playready.enabled, media.gmp-widevinecdm-l1.enabled, & media.gmp-widevinecdm-l1.visible"); // [WINDOWS-ONLY] [NO-MAIL]
pref("media.gmp-widevinecdm.0.note", "See media.mediadrm-widevinecdm.visible"); // [ANDROID-ONLY]
pref("media.gmp-widevinecdm-l1.0.note", "See media.mediadrm-widevinecdm.visible"); // [ANDROID-ONLY]

/// Block media autoplay by default
// https://support.mozilla.org/kb/block-autoplay
pref("media.autoplay.default", 5);

/// Disable DRM
// Garbage technology with freedom, privacy, & security concerns
// https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next
pref("media.clearkey.persistent-license.enabled", false); // [DEFAULT]
pref("media.clearkey.test-key-systems.enabled", false); // [DEFAULT]
pref("media.eme.enabled", false);
pref("media.eme.enabled.0.note", "DRM/EME is not recommended or supported.");
pref("media.eme.enabled.1.note", "Enabling it WILL compromise your privacy/security.");
pref("media.eme.enabled.2.note", "Proceed at your own caution.");
pref("media.eme.playready.enabled", false); // [WINDOWS-ONLY] Microsoft PlayReady
pref("media.eme.require-app-approval", true); // [ANDROID-ONLY] [DEFAULT] Ensure EME always requires permission (if enabled) - https://bugzilla.mozilla.org/show_bug.cgi?id=1620102 https://searchfox.org/mozilla-central/source/dom/media/eme/MediaKeySystemAccessPermissionRequest.h
pref("media.eme.wmf.clearkey.enabled", false); // [WINDOWS-ONLY] Windows Media Foundation Clearkey [DEFAULT]
pref("media.gmp-widevinecdm.enabled", false); // [NO-ANDROID] [HIDDEN - non-Firefox Desktop] Widevine
pref("media.gmp-widevinecdm.enabled", false, locked); // [ANDROID-ONLY] media.mediadrm-widevinecdm.visible should be used instead - this is very broken, let's lock to avoid issues...
pref("media.gmp-widevinecdm.visible", false); // [NO-ANDROID] [HIDDEN - non-Firefox Desktop] Widevine
pref("media.gmp-widevinecdm.visible", false, locked); // [ANDROID-ONLY] media.mediadrm-widevinecdm.visible should be used instead - this is very broken, let's lock to avoid issues...
pref("media.gmp-widevinecdm-l1.enabled", false); // [NO-ANDROID] [DEFAULT - non-Nightly] [HIDDEN - non-Firefox Desktop] Widevine
pref("media.gmp-widevinecdm-l1.enabled", false, locked); // [ANDROID-ONLY] media.mediadrm-widevinecdm.visible should be used instead - this is very broken, let's lock to avoid issues...
pref("media.gmp-widevinecdm-l1.visible", false); // [NO-ANDROID] [DEFAULT - non-Nightly] [HIDDEN - non-Firefox Desktop] Widevine
pref("media.gmp-widevinecdm-l1.visible", false, locked); // [ANDROID-ONLY] media.mediadrm-widevinecdm.visible should be used instead - this is very broken, let's lock to avoid issues...
pref("media.mediadrm-widevinecdm.visible", false); // [ANDROID-ONLY] Widevine MediaDrm/MediaKeySystem - https://developer.android.com/reference/android/media/MediaDrm https://bugzilla.mozilla.org/show_bug.cgi?id=1306219

/// Disable Gecko Media Plugins (GMP)
// This is currently only used for DRM & OpenH264 (both of which we disable)
// In general, I feel that these are unnecessary and best left to the operating system to support. They do also pose privacy & security concerns, so I don't see a reason to keep these enabled.
// https://wiki.mozilla.org/GeckoMediaPlugins
pref("media.gmp-provider.enabled", false);

/// Disable GMP local sources
// https://searchfox.org/mozilla-central/source/toolkit/modules/GMPUtils.sys.mjs
pref("media.gmp-manager.allowLocalSources", false);

/// Disable GMP logging by default (to expose via the `about:config`)
pref("media.gmp.log.dump", false); // [DEFAULT] [HIDDEN]
pref("media.gmp.log.level", 70); // [HIDDEN] Limits logging to fatal only

/// Disable HLS [ANDROID-ONLY]
// This uses an additional external library (ExoPlayer), and poses privacy & security concerns [ANDROID-ONLY]
// This is already the default for all platforms except Android [ANDROID-ONLY]
// https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/29859 [ANDROID-ONLY]
pref("media.hls.enabled", false); // [ANDROID-ONLY]

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

/// Enable click to play UI for certain CSS skins by default [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/blob/master/css/leptonContent.css#L223 [NO-ANDROID]
// https://github.com/black7375/Firefox-UI-Fix/wiki/Options#defaults-6 [NO-ANDROID]
pref("userContent.player.click_to_play", true); // [NO-ANDROID] [HIDDEN]

/// Hide the DRM toggle from `about:preferences#general` [NO-ANDROID] [NO-MAIL]
pref("browser.eme.ui.enabled", false); // [NO-ANDROID] [NO-MAIL]

/// Sandbox GMP [LINUX-ONLY]
// https://searchfox.org/mozilla-central/source/dom/media/gmp/GMPServiceParent.cpp#1023 [LINUX-ONLY]
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml [LINUX-ONLY]
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
// https://codeberg.org/rusty-snake/firefox-config/src/branch/main/assets/user-overrides.js#L60
// https://codeberg.org/celenity/Phoenix/issues/93
pref("javascript.options.baselinejit", false); // Baseline Compiler
pref("javascript.options.ion", false); // WarpMonkey
pref("javascript.options.jithints", false); // Eager baseline hints https://bugzilla.mozilla.org/show_bug.cgi?id=1831572
pref("javascript.options.main_process_disable_jit", true); // [DEFAULT - iOS?] The JIT backend https://searchfox.org/mozilla-central/source/js/src/jit/JitOptions.cpp
pref("javascript.options.native_regexp", false); // irregexp https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/21865
pref("javascript.options.wasm_baselinejit", false); // WASM Baseline Compiler

/// Disable JPEG-XL
// https://github.com/mozilla/standards-positions/pull/1064
pref("image.jxl.enabled", false); // [DEFAULT]

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
pref("dom.postMessage.sharedArrayBuffer.withCOOP_COEP", false); // [NO-MAIL]

/// Disable WebVR/WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API
pref("permissions.default.xr", 2); // [HIDDEN - Android/Thunderbird]

/// If JIT (Ion/WarpMonkey) is disabled, also disable it for extensions
// This is the default, but it's hidden - so setting it here lets us expose it...
// https://bugzilla.mozilla.org/show_bug.cgi?id=1599226
pref("javascript.options.jit_trustedprincipals", false);

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
// https://gitlab.com/ironfox-oss/IronFox/-/issues/11 [ANDROID-ONLY]
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
pref("extensions.formautofill.addresses.enabled", false);
pref("extensions.formautofill.creditCards.enabled", false);
pref("signon.rememberSignons", false);

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
// https://support.mozilla.org/kb/mozilla-monitor-faq#w_does-mozilla-monitor-know-my-passwords [NO-ANDROID] [NO-MAIL]
// https://blog.mozilla.org/security/2018/06/25/scanning-breached-accounts-k-anonymity/ [NO-ANDROID] [NO-MAIL]
pref("signon.management.page.breach-alerts.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("signon.management.page.vulnerable-passwords.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable anti-spoof confirmation prompts
pref("network.auth.confirmAuth.enabled", true);

/// Enable strong password generation (if the Password Manager is enabled) by default
pref("signon.generation.enabled", true); // [DEFAULT]

/// Prevent cross-origin sub-resources from opening HTTP authentication dialogs to protect against phishing
// (Meaning dialogs for embedded items are only presented when originating from the same site)
// https://support.mozilla.org/questions/1245144
pref("network.auth.non-web-content-triggered-resources-http-auth-allow", false); // [DEFAULT - non-Thunderbird]
pref("network.auth.subresource-http-auth-allow", 1);
pref("network.auth.subresource-img-cross-origin-http-auth-allow", false); // [DEFAULT - non-Thunderbird]

/// Protect against password spoofing for cross-domain auth requests [NO-ANDROID] [NO-MAIL]
// https://bugzilla.mozilla.org/show_bug.cgi?id=791594 [NO-ANDROID] [NO-MAIL]
pref("privacy.authPromptSpoofingProtection", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

pref("browser.phoenix.status", "015");

/*** 016 EXTENSIONS ***/

/// Allow LocalCDN (if installed) to work on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.{b86e4813-687a-43e6-ab65-0bde4ab75758}", true);

/// Allow Mullvad's extension (if installed) to work on restricted/quarantined domains by default
pref("extensions.quarantineIgnoredByUser.{d19a89b9-76c1-4a61-bcd4-49e8de916403}", true);

/// Allow uBlock Origin (if installed) to work on restricted/quarantined domains by default
// This isn't necessary ATM (since uBlock Origin is 'recommended' by Mozilla - so it can already access quarantined domains), but we can still set this anyways for redundancy/to ensure we're always covered if anything changes in the future
// This is especially important for Thunderbird though - since uBlock Origin isn't 'recommended' there like it is on Firefox...
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantineIgnoredByUser.uBlock0@raymondhill.net", true); // [HIDDEN]

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

/// Disable add-on sideloading
// Only allows installing extensions from profile & application directories (Prevents extensions being installed from the system/via other software)
// https://archive.is/DYjAM
// https://support.mozilla.org/kb/deploying-firefox-with-extensions
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/internal/AddonSettings.sys.mjs#125
pref("extensions.autoDisableScopes", 15, locked); // [DEFAULT - non-Thunderbird] Defense in depth, ensures sideloaded extensions are always disabled by default...
pref("extensions.enabledScopes", 5); // [HIDDEN]
pref("extensions.installDistroAddons", false); // [DEFAULT - Android] [HIDDEN - non-Android]
pref("extensions.sideloadScopes", 0); // [HIDDEN]
pref("extensions.startupScanScopes", 0); // [DEFAULT - non-Thunderbird] [HIDDEN - Android]

/// Disable installation of add-ons + only allow enabling it per-session [DESKTOP]
// Includes extensions & themes
// Does NOT apply to Android's `Recommended` extensions (collections) found at `Settings` -> `Advanced` -> `Extensions`
// This doesn't impact already installed add-ons & add-ons installed by policies
// Firefox (on Desktop) will prompt to re-enable this when necessary
// Unfortunately Android and Thunderbird don't have a prompt like this :( - so we won't disable this by default there - but we'll still set the pref to `true` to expose it via the `about:config` 
// Setting this pref to `sticky` causes it to reset per session, which is quite nice from a security perspective, as it allows users to enable this functionality only when it's necessary...
// Ex: A user attempts to install an extension, sees the extra prompt/warning, and selects `Enable` (which temporarily sets this pref to `true`...). The user then proceeds to install the extension. On the next launch of Firefox, this pref is reset back to `false`, meaning the ability to install extensions is fully disabled without them even thinking about it
pref("xpinstall.enabled", true); // [HIDDEN] [DEFAULT]
pref("xpinstall.enabled", false, sticky); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable mozAddonManager
// mozAddonManager prevents extensions from working on `addons.mozilla.org` (`addons.thunderbird.net` for Thunderbird), and this API also exposes a list of the user's installed add-ons to `addons.mozilla.org` (`addons.thunderbird.net` for Thunderbird)...
// Note that disabling the following preferences unfortunately break installation of extensions from `addons.mozilla.org` on Android, and from `addons.thunderbird.net` on Thunderbird
// https://bugzilla.mozilla.org/show_bug.cgi?id=1952390#c4
// https://bugzilla.mozilla.org/show_bug.cgi?id=1384330
// https://github.com/thunderbird/addons-server/issues/332
pref("extensions.webapi.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("extensions.webapi.enabled", true); // [ANDROID-ONLY] [THUNDERBIRD] [DEFAULT]
pref("privacy.resistFingerprinting.block_mozAddonManager", true); // [NO-ANDROID] [NO-MAIL]
pref("privacy.resistFingerprinting.block_mozAddonManager", false); // [ANDROID-ONLY] [THUNDERBIRD] [DEFAULT]

/// Enable Add-on Distribution Control (Install Origins)
// Prevents extensions being installed from websites that they don't specify in their manifest
// https://groups.google.com/g/firefox-dev/c/U7GpHE4R-ZY
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/internal/XPIDatabase.sys.mjs#403
pref("extensions.install_origins.enabled", true);

/// Enable AMRemoteSettings by default to expose via the `about:config`
// Used for ex. updating the list of quarantined domains
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/docs/AMRemoteSettings-overview.rst
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/AddonManager.sys.mjs
pref("extensions.remoteSettings.disabled", false); // [HIDDEN] [DEFAULT]

/// Enable optional permission prompts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1392176
pref("extensions.webextOptionalPermissionPrompts", true); // [DEFAULT]

/// Enable Mozilla's Extension Blocklist
pref("extensions.blocklist.enabled", true); // [DEFAULT]

/// Enable Manifest V3
// https://blog.mozilla.org/addons/2022/05/18/manifest-v3-in-firefox-recap-next-steps/
pref("extensions.manifestV3.enabled", true); // [DEFAULT]

/// Enable restricted/quarantined domains by default
// https://support.mozilla.org/kb/quarantined-domains
pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT]
pref("extensions.quarantinedDomains.uiDisabled", false); // [DEFAULT] [HIDDEN]

/// Enable userScripts
// userScripts ran this way run in separate isolated sandboxes
// https://wiki.mozilla.org/WebExtensions/UserScripts
// https://bugzilla.mozilla.org/show_bug.cgi?id=1875475
pref("extensions.userScripts.mv3.enabled", true); // [DEFAULT]
pref("extensions.webextensions.userScripts.enabled", true); // [DEFAULT]

/// Ensure Web Compatibility interventions use the MV3 API instead of the older MV2 one
// https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/all.js#4090
pref("extensions.webcompat.useScriptingAPI", true); // [DEFAULT]

/// Harden CSP policy
// Compared to Firefox's default, this:
// Blocks scripts unless they're loaded from the same origin
// Blocks unsafe eval() - including WebAssembly (WASM)
// Upgrades network requests to HTTPS
// Etc...
pref("extensions.webextensions.base-content-security-policy", "script-src 'self' 'unsafe-inline'; upgrade-insecure-requests;"); // `unsafe-inline` is required for Web Compatibility interventions (`about:compat`)
pref("extensions.webextensions.base-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy", "script-src 'self'; upgrade-insecure-requests;");
pref("extensions.webextensions.default-content-security-policy.v3", "script-src 'self'; upgrade-insecure-requests;"); // [DEFAULT]

/// Never allow installing extensions without first prompting the user
pref("extensions.postDownloadThirdPartyPrompt", false, locked); // [HIDDEN - Android/Thunderbird] https://github.com/arkenfox/user.js/issues/1090
pref("xpinstall.whitelist.add", "", locked); // [DEFAULT - non-Android] [HIDDEN - non-Android]
pref("xpinstall.whitelist.directRequest", false); // [HIDDEN] For direct URL requests https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4463
pref("xpinstall.whitelist.fileRequest", false); // [DEFAULT - Android] [HIDDEN - non-Android] For `file://` requests https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/mozapps/extensions/internal/XPIInstall.sys.mjs#4475
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

/// Prevent certain Mozilla extensions from accessing restricted/quarantined domains...
pref("extensions.quarantineIgnoredByUser.ads@mozac.org", false, locked); // Mozilla Android Components - Ads Telemetry...
pref("extensions.quarantineIgnoredByUser.cookies@mozac.org", false, locked); // Mozilla Android Components - Search Telemetry...
pref("extensions.quarantineIgnoredByUser.ddg@search.mozilla.org", false, locked); // DuckDuckGo - search engine...
pref("extensions.quarantineIgnoredByUser.wikipedia@search.mozilla.org", false, locked); // Wikipedia (en) - search engine...

/// Prevent extensions from opening pop-ups to remote websites
// https://bugzilla.mozilla.org/show_bug.cgi?id=1760608
// https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/components/extensions/ExtensionActions.sys.mjs#275
pref("extensions.manifestV2.actionsPopupURLRestricted", true); // [DEFAULT - Android]

/// Prevent extensions from opening pop-ups without user interaction
// https://searchfox.org/mozilla-central/rev/20fc11f1/browser/components/extensions/parent/ext-browserAction.js#1030
// https://searchfox.org/mozilla-central/rev/20fc11f1/mobile/shared/components/extensions/ext-browserAction.js#168
pref("extensions.openPopupWithoutUserGesture.enabled", false); // [DEFAULT - non-Nightly]

/// Prevent extensions from using the Gecko Profiler
// Includes certain Mozilla extensions by default
// https://firefox-source-docs.mozilla.org/tools/profiler/index.html
pref("extensions.geckoProfiler.acceptedExtensionIds", ""); // [DEFAULT - Android] [HIDDEN - Android]

/// Prevent unprivileged extensions from accessing experimental APIs by default
// https://searchfox.org/mozilla-central/source/toolkit/components/extensions/docs/basics.rst#142
pref("extensions.experiments.enabled", false); // [DEFAULT - non-Thunderbird]

/// Prevent hiding extensions [NO-ANDROID]
pref("devtools.aboutdebugging.showHiddenAddons", true, locked); // [NO-ANDROID]

/// Require secure origins to install add-ons
pref("extensions.install.requireSecureOrigin", true); // [HIDDEN]

pref("browser.phoenix.status", "016");

/*** 017 AI ***/

// https://support.mozilla.org/kb/ai-chatbot

/// Allow managing models from `about:addons`
// https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/mozapps/extensions/internal/ModelHubProvider.sys.mjs#20
pref("extensions.htmlaboutaddons.local_model_management", true); // [NIGHTLY] [DEFAULT]

/// Allow typing a custom prompt based on your selection (if pop-up when highlighting text is enabled) [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.shortcuts.custom", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable AI functionality by default
pref("browser.ml.chat.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT] AI Chatbot
pref("browser.ml.chat.shortcuts", false); // [NO-ANDROID] [NO-MAIL] Pop-up when highlighting text
pref("browser.ml.enable", false); // [DEFAULT - non-Nightly] "Experimental Machine Learning Inference Engine"

/// Disable AI/ML "Autofill Experiment"
// https://searchfox.org/mozilla-central/source/toolkit/components/formautofill/MLAutofill.sys.mjs
pref("extensions.formautofill.ml.experiment.enabled", false); // [HIDDEN - Thunderbird]

/// Disable Link Preview [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/components/genai/tests/browser/browser_link_preview.js [NO-ANDROID] [NO-MAIL]
pref("browser.ml.linkPreview.enabled", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Disable Perplexity URL bar promotion [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/f1e32fa7/browser/app/profile/firefox.js#447 [NO-ANDROID] [NO-MAIL]
pref("browser.urlbar.perplexity.hasBeenInSearchMode", true); // [NO-ANDROID] [NO-MAIL]

/// Remove privacy-invasive AI Chatbot providers [NO-ANDROID] [NO-MAIL]
// (Anthropic Claude, ChatGPT, Google Gemini, and Le Chat Mistral) [NO-ANDROID] [NO-MAIL]
// HuggingChat's privacy policy is OK, though it does leave room for improvement - but best option out of the built-in [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/rev/a589ce1e/browser/components/genai/GenAI.sys.mjs#63 [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.providers", "huggingchat"); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Set the default AI Chatbot (if enabled) to DuckDuckGo [NO-ANDROID] [NO-MAIL]
// Unfortunately this is not compatible with the pop-up when selecting text [NO-ANDROID] [NO-MAIL]
// Also AFAICT currently not possible to add this as a persistent option [NO-ANDROID] [NO-MAIL]
pref("browser.ml.chat.provider", "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat"); // [NO-ANDROID] [NO-MAIL] 

pref("browser.phoenix.status", "017");

/*** 018 GEOLOCATION ***/

/// Block websites from prompting to access geolocation by default [NO-ANDROID] [NO-MAIL]
pref("permissions.default.geo", 2); // [NO-ANDROID] [NO-MAIL]

/// Disable logging Geolocation requests by default
// This is already Firefox's default setting - but setting it here exposes it in the `about:config` since it's hidden
// https://searchfox.org/mozilla-central/rev/f1e32fa7/dom/system/NetworkGeolocationProvider.sys.mjs#21
pref("geo.provider.network.logging.enabled", false); // [HIDDEN] [DEFAULT] 

/// Disable Microsoft Location Services [WINDOWS-ONLY]
// https://searchfox.org/mozilla-central/source/dom/geolocation/Geolocation.cpp [WINDOWS-ONLY]
pref("geo.prompt.open_system_prefs", false); // [WINDOWS-Only] Ensure users aren't prompted to open settings and enable it - https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#6406
pref("geo.provider.ms-windows-location", false); // [WINDOWS-ONLY]

/// Disable Mozilla's GeoIP/Region Service
// Prevents Firefox from monitoring the user's region/general location
// Note: Firefox will still use different regional search engines based on the browser/system locale (ex. tested with Wikipedia), but this prevents using geolocation
// https://firefox-source-docs.mozilla.org/toolkit/modules/toolkit_modules/Region.html
// https://searchfox.org/mozilla-central/source/toolkit/modules/Region.sys.mjs
pref("browser.region.local-geocoding", false); // [HIDDEN] [DEFAULT]
pref("browser.region.network.scan", false); // [DEFAULT] [DEFENSE IN DEPTH] Disable Wi-Fi scanning for these requests
pref("browser.region.network.url", "");
pref("browser.region.update.enabled", false);
pref("browser.search.region", "US"); // [HIDDEN]
pref("doh-rollout.home-region", "US"); // [HIDDEN]

/// Enable Apple Location Services for macOS by default [OSX-ONLY] [NO-MAIL]
pref("geo.provider.use_corelocation", true); // [OSX-ONLY] [NO-MAIL] [DEFAULT]

/// Enable Geoclue for GNU/Linux distros by default [LINUX-ONLY] [NO-MAIL]
pref("geo.provider.use_geoclue", true); // [LINUX-ONLY] [NO-MAIL] [DEFAULT]

/// Prevent unconditionally providing high location accuracy [LINUX-ONLY]
// By default, Firefox provides all websites with high location accuracy, even if they don't request it... [LINUX-ONLY]
// https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#6389 [LINUX-ONLY]
pref("geo.provider.geoclue.always_high_accuracy", false); // [LINUX-ONLY]

/// Set BeaconDB as the default network Geolocation provider
// Default is Google :/
// https://searchfox.org/mozilla-central/source/dom/geolocation/Geolocation.cpp
// https://searchfox.org/mozilla-central/source/dom/geolocation/MLSFallback.h
pref("geo.provider.network.url", "https://api.beacondb.net/v1/geolocate");
pref("geo.provider.testing", false); // [HIDDEN] [DEFAULT] When set to `true`, this forces the use of the network Geolocation provider (BeaconDB for us), regardless of anything else - https://searchfox.org/mozilla-central/rev/f1e32fa7/dom/geolocation/Geolocation.cpp#779
pref("geo.provider.use_mls", true); // [NO-MAIL] [HIDDEN] [DEFAULT] Ensure the network Geolocation provider (BeaconDB for us) is enabled

/// Update info URL to ours so that users receive accurate information [NO-ANDROID] [NO-MAIL]
pref("browser.geolocation.warning.infoURL", "https://phoenix.celenity.dev/geo"); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "018");

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

/// Enable the ability to add signatures
pref("pdfjs.enableSignatureEditor", true);

/// Never allow documents to prevent copying text
pref("pdfjs.enablePermissions", false); // [DEFAULT]

/// Open external links in new tabs/windows
// https://github.com/mozilla/pdf.js/blob/master/extensions/chromium/preferences_schema.json
pref("pdfjs.externalLinkTarget", 2);

/// Open PDFs inline where possible
pref("browser.download.open_pdf_attachments_inline", true); // [DEFAULT - Android]

/// Show sidebar by default when viewing PDFs
pref("pdfjs.sidebarViewOnLoad", 2);

pref("browser.phoenix.status", "019");

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

/// Enable an additional plug-in blocklist from Mozilla
pref("urlclassifier.blockedTable", "moztest-block-simple,mozplugin-block-digest256"); // [DEFAULT - Nightly]

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
pref("browser.safebrowsing.id", "navclient-auto-ffox"); // [DEFAULT - Official] Ensure we use Mozilla's ID
pref("browser.safebrowsing.malware.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.phishing.enabled", true); // [DEFAULT]
pref("browser.safebrowsing.update.enabled", true); // [DEFAULT, HIDDEN]
pref("urlclassifier.downloadAllowTable", "goog-downloadwhite-proto"); // [DEFAULT - non-Android]
pref("urlclassifier.downloadBlockTable", "goog-badbinurl-proto"); // [DEFAULT - non-Android]

/// Ensure users can override Safe Browsing warnings by default
pref("browser.safebrowsing.allowOverride", true); // [DEFAULT]

/// Prevent sending metadata of downloaded files to Google
// https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work#w_how-does-phishing-and-malware-protection-work-in-firefox
// https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
pref("browser.safebrowsing.downloads.remote.enabled", false);

/// Prevent sharing data with Google & Mozilla
// https://searchfox.org/mozilla-central/source/netwerk/url-classifier/nsChannelClassifier.cpp#364
// https://searchfox.org/mozilla-central/source/toolkit/components/url-classifier/nsUrlClassifierDBService.cpp#1964
// https://bugzilla.mozilla.org/show_bug.cgi?id=1351147
pref("browser.safebrowsing.provider.google.dataSharing.enabled", false, locked); // [DEFAULT] [HIDDEN - non-Android]
pref("browser.safebrowsing.provider.google.dataSharingURL", "", locked); // [DEFAULT] [HIDDEN]
pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false, locked); // [DEFAULT]
pref("browser.safebrowsing.provider.google4.dataSharingURL", "", locked);
pref("browser.safebrowsing.provider.mozilla.dataSharing.enabled", false, locked); // [DEFAULT] [HIDDEN]
pref("browser.safebrowsing.provider.mozilla.dataSharingURL", "", locked); // [DEFAULT] [HIDDEN]

/// Proxy Safe Browsing
// These are using the servers we've set up for IronFox, hosted on our Cloudflare storage bucket (in EU jurisdiction)
pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");

/// Unclear whether these are actually used or not, but looks like Firefox has some kind of functionality to view a "report" from Safe Browsing about the safety, history, & general status of a site
// By default, it unnecessarily redirects from ex. https://safebrowsing.google.com/safebrowsing/diagnostic?site=example.org to https://transparencyreport.google.com/safe-browsing/search?url=example.org
// We can skip the redirect to improve performance
pref("browser.safebrowsing.provider.google.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");
pref("browser.safebrowsing.provider.google4.reportURL", "https://transparencyreport.google.com/safe-browsing/search?url=");

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
// Analytics/tracking is evidently not a use case that we, as the user agent, should support or assist with.
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

/// Disable Microsoft's Cloud Clipboard/Clipboard History [WINDOWS-ONLY]
// https://docs.microsoft.com/windows/win32/dataxchg/clipboard-formats#cloud-clipboard-and-clipboard-history-formats [WINDOWS-ONLY]
// https://searchfox.org/mozilla-central/source/widget/windows/nsClipboard.cpp#325 [WINDOWS-ONLY]
pref("clipboard.copyPrivateDataToClipboardCloudOrHistory", false); // [WINDOWS-ONLY] [DEFAULT]

/// Disable Reporting API
// PRIVACY: Fingerprinting concerns, used for analytics by design
// SECURITY: Attack Surface Reduction
// https://w3c.github.io/reporting/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1492036
pref("dom.reporting.crash.enabled", false); // [DEFAULT]
pref("dom.reporting.delivering.maxFailures", 0); // [DEFENSE IN DEPTH]
pref("dom.reporting.delivering.maxReports", 0); // [DEFENSE IN DEPTH]
pref("dom.reporting.enabled", false); // [DEFAULT]
pref("dom.reporting.featurePolicy.enabled", false); // [DEFAULT]
pref("dom.reporting.header.enabled", false); // [DEFAULT]

/// Disable WebGPU
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// https://gpuweb.github.io/gpuweb/#privacy-considerations
// https://gpuweb.github.io/gpuweb/#security-considerations
// https://browserleaks.com/webgpu
pref("dom.webgpu.enabled", false); // [DEFAULT - non-Nightly]
pref("dom.webgpu.workers.enabled", false); // For DOM workers [DEFAULT - non-Nightly]

/// Disable WebMIDI
// PRIVACY: Fingerprinting concerns
// SECURITY: Attack Surface Reduction
// See "Privacy Considerations" & "Security Considerations": https://webaudio.github.io/web-midi-api
// Toggling 'dom.webmidi.enabled' itself could be fingerprintable, but setting these instead just causes the permission to be automatically denied at a random interval
// https://searchfox.org/mozilla-central/source/dom/midi/MIDIPermissionRequest.cpp#119
// Test: https://permission.site/
pref("dom.sitepermsaddon-provider.enabled", false);
pref("dom.webmidi.gated", true, locked); // [DEFAULT]

/// Enable Messaging Layer Security (MLS)
// PRIVACY: Ensures messages are only received by the intended recipient
// SECURITY: Protects the authenticity and integrity of messages
// Security layer for E2EE messaging
// https://wikipedia.org/wiki/Messaging_Layer_Security
// https://blog.mozilla.org/mozilla/messaging-layer-security-is-now-an-internet-standard/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1876002
pref("dom.origin-trials.mls.state", 1);

pref("browser.phoenix.status", "021");

/*** 022 MISC. PRIVACY ***/

/// Disable CSP reporting
// Fingerprinting concerns, Used for analytics by design
// Also reduces unsolicited network activity and bandwidth consumption
// Glad we managed to convince Mozilla to add this :)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
pref("security.csp.reporting.enabled", false); // [NIGHTLY]

/// Disable Firefox Sync by default [NO-ANDROID]
// When signing in to Firefox Sync, this controls the items (checkboxes) that are set to sync (under about:preferences#sync). [NO-ANDROID]
// This allows the user to control and choose for themselves what they'd like to sync, rather than automatically syncing everything (like the default) [NO-ANDROID]
pref("services.sync.engine.addons", false); // [NO-ANDROID]
pref("services.sync.engine.addresses", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.bookmarks", false); // [NO-ANDROID]
pref("services.sync.engine.creditcards", false); // [NO-ANDROID] [DEFAULT]
pref("services.sync.engine.history", false); // [NO-ANDROID]
pref("services.sync.engine.passwords", false); // [NO-ANDROID]
pref("services.sync.engine.prefs", false); // [NO-ANDROID]
pref("services.sync.engine.tabs", false); // [NO-ANDROID]

/// Disable Hyperlink Auditing (Click Tracking)
// https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/
pref("browser.send_pings", false); // [DEFAULT]
pref("browser.send_pings.max_per_link", 0); // [DEFENSE IN DEPTH]
pref("browser.send_pings.require_same_host", true); // [DEFENSE IN DEPTH]

/// Disable Network Error Logging
// Fingerprinting concerns, Used for analytics by design
// https://developer.mozilla.org/docs/Web/HTTP/Network_Error_Logging
// https://w3c.github.io/network-error-logging/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1145235
// https://searchfox.org/mozilla-central/rev/a589ce1e/modules/libpref/init/StaticPrefList.yaml#13370
pref("network.http.network_error_logging.enabled", false); // [DEFAULT]

/// Disable online speech recognition
// https://searchfox.org/mozilla-central/source/dom/media/webspeech/recognition/OnlineSpeechRecognitionService.cpp
// https://searchfox.org/mozilla-central/source/dom/media/webspeech/recognition/SpeechRecognition.cpp
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

/// Disable TLS session identifiers [ANDROID-ONLY]
// Fingerprinting/tracking concerns [ANDROID-ONLY]
// I'm not worried about this for desktop since these are session-only, but I feel like the situation is very different for Android. Users likely leave the app open (and by extension: keep their browsing session active) for days at a time, much longer than on Desktop. [ANDROID-ONLY]
// So this does concern me and I think it's worth setting here. [ANDROID-ONLY]
// For reference, this is also disabled by ex. Cromite [ANDROID-ONLY]
// https://arxiv.org/abs/1810.07304 [ANDROID-ONLY]
pref("security.ssl.disable_session_identifiers", true); // [ANDROID-ONLY]

/// Enable Containers
// https://support.mozilla.org/kb/how-use-firefox-containers
// https://searchfox.org/mozilla-central/source/toolkit/components/contextualidentity/ContextualIdentityService.sys.mjs
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
pref("dom.storage_access.auto_grants.exclude_third_party_trackers", true); // [DEFAULT - Nightly] Automatic storage access grants
pref("privacy.restrict3rdpartystorage.heuristic.exclude_third_party_trackers", true); // [DEFAULT - Nightly]

/// Improve built-in query stripping to be on par with LibreWolf and Brave
// See Mozilla's defaults here: https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/query-stripping/changeset?_expected=0
// https://codeberg.org/librewolf/settings/src/commit/e93018221243f0af7cdbbf737b6af17d70cde8aa/librewolf.cfg#L103
// https://github.com/brave/brave-core/blob/master/components/query_filter/utils.cc
pref("privacy.query_stripping.strip_list", "__hsfp __hssc __hstc __s _bhlid _branch_match_id _branch_referrer _gl _hsenc _kx _openstat at_recipient_id at_recipient_list bbeml bsft_clkid bsft_uid dclid et_rid fb_action_ids fb_comment_id fbclid gbraid gclid guce_referrer guce_referrer_sig hsCtaTracking igshid irclickid mc_eid mkt_tok ml_subscriber ml_subscriber_hash msclkid mtm_cid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id pk_cid rb_clickid s_cid sc_customer sc_eh sc_uid srsltid ss_email_id twclid unicorn_click_id vero_conv vero_id vgo_ee wbraid wickedid yclid ymclid ysclid");

//// Unbreak urldefense.com redirects
/// (ex. https://urldefense.com/v3/__https://www.portainer.io/hs/preferences-center/en/direct?data=W2nXS-N30h-M1W45lXqV2nFX8ZW3SzKNq3gnnN0W4cQh6C1Bnn1kW1VjfB24fr2-BW4mm3dy3T2wkqW2MWfBj49z9PPW4mqs512qWTfrW4px5K71Nn7N2W32DKbz1V7s-qW21bSln2KWpS4W1SdHmq2YwgS9W3P8RNt2r6W8pW49QSSt1_tcPsW3GSrf749CfyJW2PPdX33JPrgmW4hcHf84hm-NmW2FS2pd2sMKL-W2YGYkz43RS-9W4pjpV52t0rxlW3SB_f94psLW2W3_Sm6w2FGVTjW3K2-cG4fzZLWW2qDSdB3bzPyBW3j8X_q2PMxWzW36CtK22MvcXrW4hNdFB3DLWP3W3VMWNy3SYMyvW1Vs-MC43NZJNW4hLsTd2B1T2JW2sB9wk3DMh2mW2D0QS-2t04tYW43Cpv42Tz6SwW32rgcB3_SfvDW4mq1yB36nnnkW3BNLQw2YfSH9W49sKsP3z4zKPW3zd1YL1Zm6S3W4kmj3Z2sQ7WVW36xkSD2RSm5hW1Q0SqC30sK9ZW2-kSbQ2nH5KcW36fNc_2RjGNjW36pblN43qsbhW2CCNvJ3_SL29W1_sQHx4fqK9NW3Sy1cb4mpD3h0&utm_campaign=XNF&utm_source=hs_automation&utm_medium=email&utm_content=264158909&_hsenc=p2ANqtz--9JvIgI266aB1UVizENwYNYREZSotsXOhWcMNeKjZLJO9ZwmR9xlyfsQN2orbT25IymZ_vKUNTANMKQMVQBnzowi2339ExVoOKMJaHx0t2yn5esgg&_hsmi=264158909__;!!MlclJBHn!0eDf-zTf69h-IhFT9WDu2GIXAtCy6RENwguPVpTF1k2K-Nbnzy1NXix2Gj7azc8yDFyI2z3Tz4nTFuGe2hlLzsBl$)
/// https://github.com/brave/brave-browser/issues/41134
pref("privacy.query_stripping.allow_list", "urldefense.com");

/// Isolate content from Firefox Home with containers [NO-ANDROID] [NO-MAIL]
pref("browser.discovery.containers.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Isolate permissions per container (if containers are enabled)
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("permissions.isolateBy.userContext", true);

/// Isolate resources (ex. referrers & cookies) injected by extensions
// (ex. https://searchfox.org/mozilla-central/source/toolkit/components/extensions/test/xpcshell/test_ext_contentscript_antitracking.js)
pref("privacy.antitracking.isolateContentScriptResources", true); // [NIGHTLY]

/// Limit CSP reporting
// We block CSP reports with uBlock Origin by default (and disable them entirely on IronFox)
// Mozilla thankfully listened and added support for disabling CSP reports; but the pref (security.csp.reporting.enabled) is currently only available on Nightly, so we'll keep these for the time being, but eventually remove
// https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
pref("security.csp.reporting.limit.count", 1); // [DEFAULT: 100]
pref("security.csp.reporting.limit.timespan", 999999999); // [DEFAULT: 2]
pref("security.csp.reporting.script-sample.max-length", 0); // [DEFAULT: 40]
pref("security.csp.truncate_blocked_uri_for_frame_navigations", true); // [DEFAULT] Ensure we truncate  blocked-uris

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
// https://searchfox.org/mozilla-central/source/extensions/pref/autoconfig/src/nsAutoConfig.cpp#220
pref("autoadmin.append_emailaddr", false, locked); // [DEFAULT] [HIDDEN]

/// Prevent third parties from setting cookies unless the third party already has cookies as a first party (Like Safari)
// https://webkit.org/tracking-prevention/#the-default-cookie-policy
// https://bugzilla.mozilla.org/show_bug.cgi?id=1587182
pref("privacy.dynamic_firstparty.limitForeign", true);

/// Reduce information shared with Firefox Sync [NO-ANDROID]
pref("services.sync.sendVersionInfo", false); // [NO-ANDROID]

/// Restrict tracking referers
pref("network.http.referer.defaultPolicy.trackers", 1);
pref("network.http.referer.defaultPolicy.trackers.pbmode", 1);

/// Set default homepage to `about:home` [NO-ANDROID] [NO-MAIL]
// This is typically the default, but overriden by some distro-packaged versions of Firefox (ex. Fedora) [NO-ANDROID] [NO-MAIL]
pref("browser.startup.homepage", "about:home"); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.startup.page", 1); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Set LibreWolf/forks to use our custom enhanced uBlock Origin config by default [NO-ANDROID] [NO-MAIL]
// We do not support LibreWolf at the moment, but this will be beneficial if that changes in the future [NO-ANDROID] [NO-MAIL]
// https://phoenix.celenity.dev/content-blocking [NO-ANDROID] [NO-MAIL]
pref("librewolf.uBO.assetsBootstrapLocation", "https://gitlab.com/celenityy/Phoenix/-/raw/pages/uBlock/assets.json"); // [NO-ANDROID] [NO-MAIL]

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

/// Always warn users before launching other apps
pref("network.protocol-handler.warn-external.file", true); // [ANDROID-ONLY]
pref("network.protocol-handler.warn-external.mailto", true); // [NO-MAIL] [DEFAULT - non-Thunderbird] [HIDDEN - THUNDERBIRD]
pref("network.protocol-handler.warn-external.sms", true); // [ANDROID-ONLY]
pref("network.protocol-handler.warn-external.tel", true); // [ANDROID-ONLY]
pref("network.protocol-handler.warn-external.vnd.youtube", true); // [ANDROID-ONLY]
pref("network.protocol-handler.warn-external-default", true); // [DEFAULT]
pref("security.external_protocol_requires_permission", true); // [NO-ANDROID] [DEFAULT - non-Thunderbird] Removed from Firefox, but we'll keep for ESR for the time being

/// Apply CSP to internal browser.xhtml
pref("security.browser_xhtml_csp.enabled", true); // [DEFAULT]
pref("security.browser_xhtml_csp.report-only", false);

/// Disable GNOME Integration [LINUX-ONLY]
// https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp [LINUX-ONLY]
pref("browser.gnome-search-provider.enabled", false); // [LINUX-ONLY] [HIDDEN]

/// Disable Navigator Media Objects & getUserMedia Support in insecure contexts
// https://developer.mozilla.org/docs/Web/API/Navigator/mediaDevices
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("media.devices.insecure.enabled", false); // [DEFAULT]
pref("media.getusermedia.insecure.enabled", false); // [DEFAULT]

/// Disable Win32k System Calls [WINDOWS-ONLY]
// https://security.googleblog.com/2016/10/disclosing-vulnerabilities-to-protect.html [WINDOWS-ONLY]
// https://docs.google.com/document/d/1gJDlk-9xkh6_8M_awrczWCaUuyr0Zd2TKjNBCiPO_G4/edit [WINDOWS-ONLY]
pref("security.sandbox.content.win32k-disable", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.gmp.win32k-disable", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.socket.win32k-disable", true); // [WINDOWS-ONLY] [DEFAULT]

/// Do not block additional ports by default
// This is just to expose the preferences via the `about:config`
pref("network.security.ports.banned", ""); // [DEFAULT] [HIDDEN]
pref("network.security.ports.banned.override", ""); // [DEFAULT] [HIDDEN]

/// Enable Arbitrary Code Guard (ACG) [WINDOWS-ONLY]
// https://medium.com/@boutnaru/the-windows-security-journey-acg-arbitrary-code-guard-74b08a8bd1e5 [WINDOWS-ONLY]
pref("security.sandbox.gmp.acg.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.rdd.acg.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.utility-wmf.acg.enabled", true); // [WINDOWS-ONLY] [DEFAULT]

/// Enable Code Integrity Guard (CIG) for pre-spawn [WINDOWS-ONLY]
// https://medium.com/@boutnaru/the-windows-security-journey-cig-code-integrity-guard-7e410c8d2304 [WINDOWS-ONLY]
pref("security.sandbox.cig.prespawn.enabled", true); // [WINDOWS-ONLY] [DEFAULT - Nightly]

/// Enable content process sandboxing [NO-ANDROID]
// These are especially useful for ex. Thunderbird, which seems to disable sandboxing by default... [NO-ANDROID]
// Sandbox is obviously critical from a security perspective as well, so doesn't hurt IMO to explicitly enable here [NO-ANDROID]
pref("security.sandbox.content.level", 6); // [LINUX-ONLY] [DEFAULT] https://searchfox.org/mozilla-central/rev/20fc11f1/browser/app/profile/firefox.js#1531
pref("security.sandbox.content.level", 3); // [OSX-ONLY] [DEFAULT] https://searchfox.org/mozilla-central/rev/20fc11f1/browser/app/profile/firefox.js#1485
pref("security.sandbox.content.level", 20); // [WINDOWS-ONLY] (Default = 8: https://searchfox.org/mozilla-central/rev/20fc11f1/browser/app/profile/firefox.js#1473 - This strengthens it: https://searchfox.org/mozilla-central/rev/20fc11f1/security/sandbox/win/src/sandboxbroker/sandboxBroker.cpp#860)

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
// https://searchfox.org/mozilla-central/source/security/sandbox/win/src/sandboxbroker/sandboxBroker.cpp#1181
// https://searchfox.org/mozilla-central/source/security/sandbox/chromium/sandbox/win/src/security_level.h#38
pref("security.sandbox.gpu.level", 2); // [1 = USER_RESTRICTED_NON_ADMIN (Default - Windows), 2 = USER_LIMITED (Stricter)]

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
pref("dom.ipc.processCount.webIsolated", 1); // [DEFAULT - Android] Use one isolated content process per origin https://searchfox.org/mozilla-central/source/dom/docs/ipc/process_model.rst
pref("fission.autostart", true); // [DEFAULT - non-Android]
pref("fission.autostart.session", true); // [DEFAULT - non-Android]
pref("fission.disableSessionHistoryInParent", false); // [DEFAULT - non-Android] SHIP, required for Fission
pref("fission.webContentIsolationStrategy", 1); // [DEFAULT - non-Android] Isolate everything https://searchfox.org/mozilla-central/source/dom/ipc/ProcessIsolation.cpp
pref("gfx.webrender.all", true);

/// Enable the Sanitizer API
// https://github.com/WICG/sanitizer-api
pref("dom.security.sanitizer.enabled", true);

/// Enable Shadow Stacks [WINDOWS-ONLY]
// https://wikipedia.org/wiki/Shadow_stack [WINDOWS-ONLY]
pref("security.sandbox.content.shadow-stack.enabled", true); // [WINDOWS-ONLY]
pref("security.sandbox.gmp.shadow-stack.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.gpu.shadow-stack.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.rdd.shadow-stack.enabled", true); // [WINDOWS-ONLY] [DEFAULT]
pref("security.sandbox.socket.shadow-stack.enabled", true); // [WINDOWS-ONLY] [DEFAULT]

/// Enable socket process sandboxing
// https://bugzilla.mozilla.org/show_bug.cgi?id=1608558
pref("security.sandbox.socket.process.level", 1); // [DEFAULT - Linux, non-Thunderbird]

/// Enable Spectre mitigations for isolated content
// Also enabled by ex. Tor Browser
pref("javascript.options.spectre.disable_for_isolated_content", false);

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

/// Ensure we block old/obsolete libavcodec libraries
// https://searchfox.org/mozilla-central/source/testing/profiles/unittest-required/user.js
pref("media.libavcodec.allow-obsolete", false); // [DEFAULT]

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

/// Prevent AutoConfig files (if being used) from gaining privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
// https://searchfox.org/mozilla-central/source/extensions/pref/autoconfig/src/nsReadConfig.cpp
pref("general.config.sandbox_enabled", true, locked); // [HIDDEN] [DEFAULT]

/// Prevent remoteTypes from triggering process switches they shouldn't be able to...
// https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#1035
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
pref("security.block_fileuri_script_with_wrong_mime", true);
pref("security.block_Worker_with_wrong_mime", true); // [DEFAULT]

/// Use a separate content process for `file://` URLs
pref("browser.tabs.remote.separateFileUriProcess", true); // [DEFAULT - non-Android]

/// Warn on unprivileged namespaces [LINUX-ONLY]
pref("security.sandbox.warn_unprivileged_namespaces", true); // [LINUX-ONLY] [DEFAULT]

/// Yes, this is a real pref... 
// https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("security.turn_off_all_security_so_that_viruses_can_take_over_this_computer", false, locked); // [HIDDEN] [DEFAULT]

pref("browser.phoenix.status", "023");

/*** 024 MISC. ***/

/// Block pop-ups by default
pref("dom.disable_open_during_load", true); // [DEFAULT - non-Thunderbird]

/// Block websites from prompting to display notifications by default [NO-ANDROID] [NO-MAIL]
// I have yet to see a legitimate use-case for websites using push notifications... [NO-ANDROID] [NO-MAIL]
// but I see them constantly abused for malicious purposes & spam :/ [NO-ANDROID] [NO-MAIL]
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

/// Disable weather on Firefox Home by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.showWeather", false); // [NO-ANDROID] [NO-MAIL]

/// Disable WebVTT Testing Events
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml
pref("media.webvtt.testing.events", false); // [DEFAULT]

/// Enable Firefox's newer 'Felt privacy' design for Certificate Errors
pref("security.certerrors.felt-privacy-v1", true); // [HIDDEN - Android/Thunderbird]

/// Enable Firefox's newer 'Felt privacy' design for Private Browsing [NO-ANDROID] [NO-MAIL]
pref("browser.privatebrowsing.felt-privacy-v1", true); // [NO-ANDROID] [NO-MAIL]

/// Enable the Remote Settings Firefox Relay Allowlist Collection by default to expose via the `about:config`
// https://searchfox.org/mozilla-central/source/toolkit/components/satchel/integrations/FirefoxRelay.sys.mjs
// https://firefox.settings.services.mozilla.com/v1/buckets/main/collections/fxrelay-allowlist/changeset?_expected=0
pref("signon.firefoxRelay.allowListRemoteSettingsCollection", "fxrelay-allowlist"); // [DEFAULT] [HIDDEN]

/// Enable more detailed property error messages
pref("javascript.options.property_error_message_fix", true); // [DEFAULT - Nightly/Dev]

/// Hide the Firefox logo from Firefox Home by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", false); // [NO-ANDROID] [NO-MAIL]

/// Force pop-up windows to open in new tabs instead
pref("browser.link.open_newwindow", 3); // [DEFAULT]
pref("browser.link.open_newwindow.restriction", 0); // [DEFAULT - Android/Thunderbird]

/// Limit what events can cause pop-ups
pref("dom.popup_allowed_events", "click dblclick");

/// Notify on Pop-up blocking by default [NO-ANDROID] [NO-MAIL]
pref("privacy.popups.showBrowserMessage", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Open links from external programs in new tabs by default [NO-ANDROID] [NO-MAIL]
pref("browser.link.open_newwindow.override.external", 3); // [NO-ANDROID] [NO-MAIL]

/// Prevent scripts from moving, resizing, and messing with windows
pref("dom.allow_scripts_to_close_windows", false); // [DEFAULT]
pref("dom.disable_window_flip", true); // [DEFAULT - non-Android]
pref("dom.disable_window_move_resize", true); // [DEFAULT - Android]

/// Prevent websites from automatically refreshing
pref("accessibility.blockautorefresh", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.meta_refresh_when_inactive.disabled", true); // [DEFAULT - Android]

/// Show advanced details on pages blocked by Safe Browsing by default [NO-ANDROID] [NO-MAIL]
pref("browser.xul.error_pages.show_safe_browsing_details_on_load", true); // [NO-ANDROID] [NO-MAIL]

/// Show 'Always ask' for camera & microphone in the permissions drop-down (when that's what the user chose...) [NO-ANDROID] [NO-MAIL]
pref("permissions.media.show_always_ask.enabled", true); // [NO-ANDROID] [NO-MAIL]

/// Show an error page/details instead of a blank page for HTTP responses with certain error codes (ex. 4xx, 5xx, & Content-Length: 0)
// ex. https://ozuma.sakura.ne.jp/httpstatus/400
pref("browser.http.blank_page_with_error_response.enabled", false); // [DEFAULT - non-Android]

pref("browser.phoenix.status", "024");

/*** 025 DEBUGGING ***/

/// Allow inspecting the browser chrome by default
pref("devtools.chrome.enabled", true); // [DEFAULT - Thunderbird]

/// Allow inspecting the DOM by default [NO-ANDROID]
pref("devtools.dom.enabled", true); // [NO-ANDROID]

/// Always prompt before connecting to Remote Debugging...
pref("devtools.debugger.prompt-connection", true, locked); // [DEFAULT - non-Nightly]

/// Disable annoying "A simpler highlighter can be enabled in the settings..." banner when using developer tools [NO-ANDROID] [NO-MAIL]
pref("devtools.inspector.simple-highlighters.message-dismissed", true); // [NO-ANDROID] [NO-MAIL] [HIDDEN]

/// Disable editor onboarding [NO-ANDROID]
pref("devtools.webconsole.input.editorOnboarding", false); // [NO-ANDROID]

/// Disable pausing on debugger statements by default [NO-ANDROID]
pref("devtools.debugger.pause-on-debugger-statement", false); // [NO-ANDROID]

/// Disable Remote Debugging + only allow enabling it per-session
// https://firefox-source-docs.mozilla.org/devtools/backend/protocol.html
pref("devtools.debugger.remote-enabled", false, sticky); // [DEFAULT - non-Thunderbird]

/// Disable the Remote Debugging Web Socket
pref("devtools.debugger.remote-websocket", false, locked); // [DEFAULT]

/// Disable sending console output to logcat by default [ANDROID-ONLY]
// https://bugzilla.mozilla.org/show_bug.cgi?id=1415318 [ANDROID-ONLY]
pref("consoleservice.logcat", false); // [ANDROID-ONLY]
pref("geckoview.console.enabled", false); // [ANDROID-ONLY]

/// Display content scripts injected by extensions when debugging by default [NO-ANDROID] [NO-MAIL]
pref("devtools.debugger.show-content-scripts", true); // [NO-ANDROID] [NO-MAIL]

/// Display Web Console timestamps by default [NO-ANDROID]
// https://searchfox.org/mozilla-central/rev/f1e32fa7/browser/app/profile/firefox.js#3057
pref("devtools.webconsole.timestampMessages", true); // [NO-ANDROID]

/// Disable WebDriver BiDi experimental commands and events
// https://wiki.mozilla.org/WebDriver/RemoteProtocol/WebDriver_BiDi
pref("remote.experimental.enabled", false, locked); // [DEFAULT - non-Nightly]

/// Enable DevTools buttons by default [NO-ANDROID]
pref("devtools.command-button-errorcount.enabled", true); // [NO-ANDROID] [DEFAULT] Error Count - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/framework/toolbox.js#2198
pref("devtools.command-button-frames.enabled", true); // [NO-ANDROID] [DEFAULT] Frame Target - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/framework/toolbox.js#2178
pref("devtools.command-button-measure.enabled", true); // [NO-ANDROID] Measure - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/themes/toolbox.css#542 
pref("devtools.command-button-noautohide.enabled", true); // [NO-ANDROID] No Pop-up Autohide - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/framework/components/ToolboxToolbar.js#118
pref("devtools.command-button-pick.enabled", true); // [NO-ANDROID] [DEFAULT] Pick
pref("devtools.command-button-responsive.enabled", true); // [NO-ANDROID] [DEFAULT] Responsive - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/definitions.js#525
pref("devtools.command-button-rulers.enabled", true); // [NO-ANDROID] Ruler - https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/themes/toolbox.css#538
pref("devtools.command-button-screenshot.enabled", true); // [NO-ANDROID] Screenshot

/// Enable experimental DevTools preferences by default [NO-ANDROID]
pref("devtools.command-button-experimental-prefs.enabled", true); // [NO-ANDROID] [HIDDEN - non-MOZILLA_OFFICIAL builds] [DEFAULT - non-MOZILLA_OFFICIAL builds]

/// Enable network monitoring by default [NO-ANDROID]
pref("devtools.browserconsole.enableNetworkMonitoring", true); // [NO-ANDROID]

/// Enable the Web Console sidebar toggle [NO-ANDROID]
// https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/webconsole/webconsole-ui.js#46 [NO-ANDROID]
pref("devtools.webconsole.sidebarToggle", true); // [NO-ANDROID] [DEFAULT - Nightly]

/// Enforce local debugging only
pref("devtools.debugger.force-local", true, locked); // [DEFAULT]
pref("devtools.inspector.remote", false, locked); // [NO-ANDROID] [DEFAULT]

/// Highlight syntax when viewing the source of webpages (via `view-source:`)
pref("view_source.syntax_highlight", true); // [DEFAULT - non-Thunderbird]

/// Limit GeckoView's log level to "Warn" by default [ANDROID-ONLY]
pref("geckoview.logging", "Warn"); // [ANDROID-ONLY] [DEFAULT - non-Debug]

/// Pretty print code when debugging by default [NO-ANDROID]
pref("devtools.debugger.auto-pretty-print", true); // [NO-ANDROID]

/// Prevent adding global `dump` function to log strings to `stdout`
// https://searchfox.org/mozilla-central/source/devtools/docs/contributor/getting-started/development-profiles.md
pref("browser.dom.window.dump.enabled", false); // [DEFAULT - non-Android, desktop `MOZILLA_OFFICIAL` builds]

/// Prevent automatically clearing log messages after page reloads/navigation [NO-ANDROID]
pref("devtools.netmonitor.persistlog", true); // [NO-ANDROID]
pref("devtools.webconsole.persistlog", true); // [NO-ANDROID]

/// Prevent console API from writing to `stdout` when used by chrome content
pref("devtools.console.stdout.chrome", false); // [DEFAULT - non-Android, `MOZILLA_OFFICIAL` builds]

/// Prevent logging URLs in Reader errors
pref("reader.errors.includeURLs", false); // [DEFAULT - Android/Thunderbird]

/// Set Browser/Error Console scope to "Multiprocess" instead of "Parent process only" by default [NO-ANDROID]
// https://searchfox.org/mozilla-central/rev/f1e32fa7/devtools/client/webconsole/webconsole-ui.js#47 [NO-ANDROID]
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
// https://searchfox.org/mozilla-central/rev/f1e32fa7/dom/script/ScriptCompression.cpp#100
// (Default = 0, which means it's off)
pref("browser.cache.jsbc_compression_level", 3);

/// Decrease the content notification interval
// https://bugzilla.mozilla.org/show_bug.cgi?id=72138
// https://searchfox.org/mozilla-central/rev/c1180ea13e73eb985a49b15c0d90e977a1aa919c/modules/libpref/init/StaticPrefList.yaml#1824-1834
// (Default = 120000 (.12 secs))
pref("content.notify.interval", 100000); // .10 secs

/// Disable certain UI animations by default // [NO-ANDROID]
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp // [NO-ANDROID]
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h // [NO-ANDROID]
pref("sidebar.animation.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("ui.panelAnimations", 0); // [NO-ANDROID] [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [NO-ANDROID] [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [NO-ANDROID] [HIDDEN]

/// Disable CSS error reporting by default
// https://bugzilla.mozilla.org/show_bug.cgi?id=831123
pref("layout.css.report_errors", false); // [DEFAULT - Android]

/// Disable extra extension logging by default
// https://searchfox.org/mozilla-central/rev/f1e32fa7/browser/app/profile/firefox.js#29
pref("extensions.logging.enabled", false); // [DEFAULT]

/// Disable pacing requests
// https://codeberg.org/celenity/Phoenix/issues/84
pref("network.http.pacing.requests.enabled", false);

/// Disable tab hover previews by default [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.hoverPreview.enabled", false); // [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.hoverPreview.showThumbnails", false); // [NO-ANDROID] [NO-MAIL]

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
pref("gfx.canvas.accelerated.cache-items", 8192); // [DEFAULT]
pref("gfx.canvas.accelerated.cache-size", 512); // Increase cache size (Default = 256)

/// Enable CSS Masonry Layout
// https://www.smashingmagazine.com/native-css-masonry-layout-css-grid/ - for testing: https://codepen.io/rachelandrew/pen/wvWmZWB 
pref("layout.css.grid-template-masonry-value.enabled", true); // [DEFAULT - Nightly/Thunderbird] 

/// Enable the "fetchpriority" attribute
// https://web.dev/articles/fetch-priority
pref("network.fetchpriority.enabled", true); // [DEFAULT - non-ESR]

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

/// Enable Window Occlusion [WINDOWS-ONLY]
// https://chromeenterprise.google/policies/#WindowOcclusionEnabled [WINDOWS-ONLY]
// https://searchfox.org/mozilla-central/source/gfx/thebes/gfxPlatform.cpp#3229 [WINDOWS-ONLY]
pref("widget.windows.window_occlusion_tracking.enabled", true); // [WINDOWS-ONLY] [DEFAULT]

/// Increase buffering for video playback
// This doesn't apply to videos delivered via Media Source Extensions
// https://www.cloudflare.com/learning/video/what-is-buffering/
// https://bugzilla.mozilla.org/show_bug.cgi?id=1540573
// https://searchfox.org/mozilla-central/rev/f1e32fa7/dom/media/ChannelMediaDecoder.cpp#473
pref("media.cache_readahead_limit", 7200); // (Default = 60)
pref("media.cache_readahead_limit.cellular", 7200); // (Default = 30)
pref("media.cache_resume_threshold", 3600); // (Default = 30)
pref("media.cache_resume_threshold.cellular", 3600); // (Default = 10)
pref("media.throttle-cellular-regardless-of-download-rate", false); // [HIDDEN - non-Android] [DEFAULT - non-Android]

/// Increase the chunk size for calls to image decoders
// (Default = 16384)
pref("image.mem.decode_bytes_at_a_time", 32768);

/// Increase DNS caching
pref("network.dnsCacheExpiration", 3600); // (Default = 60)
pref("network.dnsCacheExpirationGracePeriod", 240); // (Default = 60)
pref("network.dnsCacheEntries", 1000); // (Default = 800)

/// Increase the file-backed media cache size for cellular connections
// (Default = 32768)
// This is set to match the value of "media.cache_size"
pref("media.cache_size.cellular", 512000);

/// Increase the memory-backed media cache size
// (Default = 8192)
pref("media.memory_cache_max_size", 65536);

/// Increase the skia font cache size (Like Chromium)
// https://bugzilla.mozilla.org/show_bug.cgi?id=1239151#c2
// (Default = 5)
pref("gfx.content.skia-font-cache-size", 20);

/// Increase the maximum number of HTTP connections
pref("network.http.max-connections", 1800); // (Default = 128 for Android, 900 elsewhere)
pref("network.http.max-persistent-connections-per-proxy", 48); // (Default = 20 for Android, 32 elsewhere)
pref("network.http.max-persistent-connections-per-server", 10); // (Default = 6)
pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // (Default = 3)

/// Increase TLS token caching
// https://codeberg.org/celenity/Phoenix/issues/84
// https://searchfox.org/mozilla-central/source/netwerk/base/SSLTokensCache.cpp
// (Default = 2048)
pref("network.ssl_tokens_cache_capacity", 10240);

/// Use higher performance pinch-zoom
// https://searchfox.org/mozilla-central/rev/20fc11f1/modules/libpref/init/StaticPrefList.yaml#7820
pref("gfx.webrender.low-quality-pinch-zoom", true); // [DEFAULT - Android Nightly]

pref("browser.phoenix.status", "026");

/*** 027 Personal Touch 💜 ***/

/// Things that are nice to have™
// Not directly privacy & security related

/// Allow downloading and switch locales [NO-ANDROID]
pref("app.update.langpack.enabled", true); // [NO-ANDROID] [DEFAULT]
pref("intl.multilingual.downloadEnabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]
pref("intl.multilingual.enabled", true); // [NO-ANDROID] [DEFAULT - non-Developer/Nightly]

/// Allow enabling the weather on Firefox Home by default [NO-ANDROID] [NO-MAIL]
// (This only controls the UI setting, `browser.newtabpage.activity-stream.showWeather` is what actually controls whether the weather is actually displayed or not) [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.system.showWeather", true); // [NO-ANDROID] [NO-MAIL]

/// Allow opening iframes in new tabs/windows [NO-ANDROID]
pref("security.xfocsp.hideOpenInNewWindow", false); // [NO-ANDROID] [ESR]

/// Allow Picture-in-Picture on all websites, even if they try to block it...
pref("media.videocontrols.picture-in-picture.respect-disablePictureInPicture", false);

/// Allow zoom on all websites, even if they try to block it...
// (This is the `Zoom on all websites` UI setting for Android)
pref("browser.ui.zoom.force-user-scalable", true);

/// Allow the use of custom CSS by default [NO-ANDROID]
pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [NO-ANDROID]

/// Always display the Bookmarks toolbar by default [NO-ANDROID] [NO-MAIL]
// https://support.mozilla.org/kb/bookmarks-toolbar-display-favorite-websites [NO-ANDROID] [NO-MAIL]
pref("browser.toolbars.bookmarks.visibility", "always"); // [NO-ANDROID] [NO-MAIL]

/// Always load bookmarks in new tabs by default [NO-ANDROID] [NO-MAIL]
pref("browser.tabs.loadBookmarksInTabs", true); // [NO-ANDROID] [NO-MAIL]

/// Clean-up default UI [NO-ANDROID] [NO-MAIL]
pref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","back-button","forward-button","stop-reload-button","vertical-spacer","urlbar-container","_testpilot-containers-browser-action","fxa-toolbar-menu-button","developer-button","ublock0_raymondhill_net-browser-action","downloads-button","reset-pbm-toolbar-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks","personal-bookmarks"],"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","back-button","forward-button","vertical-spacer","stop-reload-button","urlbar-container","_testpilot-containers-browser-action","fxa-toolbar-menu-button","reset-pbm-toolbar-button","developer-button","ublock0_raymondhill_net-browser-action","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"vertical-tabs":[]},"seen":["reset-pbm-toolbar-button","developer-button","_testpilot-containers-browser-action","ublock0_raymondhill_net-browser-action","reset-pbm-toolbar-button","_testpilot-containers-browser-action","ublock0_raymondhill_net-browser-action","developer-button"],"dirtyAreaCache":["nav-bar","vertical-tabs","PersonalToolbar","unified-extensions-area","TabsToolbar","unified-extensions-area","nav-bar","vertical-tabs"],"currentVersion":21,"newElementCount":7}'); // [NO-ANDROID] [NO-MAIL]

/// Clean-up Firefox Home by default [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.section.highlights", false); // [NO-ANDROID] [NO-MAIL] Highlights
pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false); // [NO-ANDROID] [NO-MAIL] Bookmarks
pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false); // [NO-ANDROID] [NO-MAIL] Downloads
pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false); // [NO-ANDROID] [NO-MAIL] Visited websites

/// Disable annoying Web Speech API errors, especially relevant on Linux
// https://searchfox.org/mozilla-central/source/browser/actors/SpeechDispatcherParent.sys.mjs#8
pref("media.webspeech.synth.dont_notify_on_error", true); // [HIDDEN]

/// Disable extra logging for policies by default [NO-ANDROID] [NO-MAIL] 
// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config [NO-ANDROID] [NO-MAIL] 
// https://searchfox.org/mozilla-central/source/browser/components/enterprisepolicies/Policies.sys.mjs [NO-ANDROID] [NO-MAIL] 
pref("browser.policies.loglevel", "error"); // [NO-ANDROID] [NO-MAIL] [HIDDEN] [DEFAULT]

/// Disable fullscreen delay + warning
pref("full-screen-api.transition-duration.enter", "0 0"); // [Default = 200 200]
pref("full-screen-api.transition-duration.leave", "0 0"); // [Default = 200 200]
pref("full-screen-api.warning.delay", -1); // [Default = 500, -1 = Automatic]
pref("full-screen-api.warning.timeout", 0); // [Default = 3000]

/// Display the option to enable `Compact` mode at `Customize toolbar...` [NO-ANDROID] [NO-MAIL]
pref("browser.compactmode.show", true); // [NO-ANDROID] [NO-MAIL]

/// Display the search bar at `Customize toolbar...` [NO-ANDROID] [NO-MAIL]
pref("browser.search.widget.inNavBar", true); // [HIDDEN] [NO-ANDROID] [NO-MAIL]

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

/// Enable Firefox Labs (`about:preferences#experimental`) by default [NO-ANDROID] [NO-MAIL]
pref("browser.preferences.experimental", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.preferences.experimental.hidden", false); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Enable Firefox Translations (+ the pop-up) by default [NO-MAIL]
// Translations are done locally - very nice to have [NO-MAIL]
// https://support.mozilla.org/kb/website-translation [NO-MAIL]
// Currently broken on Thunderbird :( [NO-MAIL]
pref("browser.translations.automaticallyPopup", true); // [NO-MAIL] [DEFAULT]
pref("browser.translations.enable", true); // [NO-MAIL] [DEFAULT - non-Thunderbird]
pref("browser.translations.select.enable", true); // [NO-MAIL] [DEFAULT - non-Android/Thunderbird]
pref("browser.translations.newSettingsUI.enable", true); // [NO-ANDROID] [NO-MAIL] Enables the new UI at `about:preferences#general`

/// Enable IPv6
// Important, nice to have
pref("network.dns.disableIPv6", false); // [DEFAULT]

/// Enable overscrolling by default
// https://www.omgubuntu.co.uk/2024/09/mozilla-firefox-130-new-features
pref("apz.overscroll.enabled", true); // [DEFAULT]

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

/// Enable wallpapers on Firefox Home by default [NO-ANDROID] [NO-MAIL]
// https://searchfox.org/mozilla-central/source/browser/extensions/newtab/lib/WallpaperFeed.sys.mjs [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.feeds.wallpaperfeed", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customColor.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.customWallpaper.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.newtabWallpapers.enabled", true); // [NO-ANDROID] [NO-MAIL] [DEFAULT]

/// Ensure the escape key exits fullscreen by default... [OSX-ONLY]
pref("browser.fullscreen.exit_on_escape", true); // [OSX-ONLY] [DEFAULT]

/// Ensure users can always control Nimbus recipes
// https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#344
// https://searchfox.org/mozilla-central/rev/20fc11f1/toolkit/components/nimbus/lib/RemoteSettingsExperimentLoader.sys.mjs#513
pref("nimbus.debug", true); // [HIDDEN - non-Firefox Desktop]
pref("nimbus.validation.enabled", false); // [HIDDEN - non-Firefox Desktop]

/// Export bookmarks to a `bookmarks.html` file by default [NO-ANDROID] [NO-MAIL]
pref("browser.bookmarks.autoExportHTML", true); // [NO-ANDROID] [NO-MAIL]

/// Expose hidden UI preferences in the about:config [NO-ANDROID]
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp [NO-ANDROID]
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h [NO-ANDROID]
pref("ui.hideCursorWhileTyping", 1); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.prefersReducedTransparency", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]
pref("ui.scrollToClick", 1); // [NO-ANDROID] [HIDDEN]
pref("ui.useAccessibilityTheme", 0); // [NO-ANDROID] [HIDDEN] [DEFAULT]

/// Hide the Title Bar by default
pref("browser.tabs.inTitlebar", 1);

/// Highlight all Findbar (Ctrl + F) results by default
pref("findbar.highlightAll", true);

/// Improve the reliability of extension storage sync [NO-ANDROID] [NO-MAIL]
pref("services.sync.extension-storage.skipPercentageChance", 0); // [NO-ANDROID] [NO-MAIL]

/// Prevent the alt key from toggling menu bar by default
pref("ui.key.menuAccessKeyFocuses", false); // [DEFAULT - non-Windows/Linux]

/// Prevent displaying Private Browsing windows as separate icons on Windows' Taskbar by default [NO-ANDROID] [NO-MAIL]
pref("browser.privateWindowSeparation.enabled", false); // [NO-ANDROID] [NO-MAIL] [WINDOWS-ONLY]

/// Prevent including the space next to words when double-clicking/selecting text
// https://codeberg.org/celenity/Phoenix/issues/84#issuecomment-3097957
pref("layout.word_select.eat_space_to_next_word", false); // [DEFAULT - non-Windows]

/// Prevent searches from Firefox Home from jumping to the URL bar [NO-ANDROID] [NO-MAIL]
// https://www.reddit.com/r/firefox/comments/oxwvbo/firefox_start_page_search_options/ [NO-ANDROID] [NO-MAIL]
pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false); // [NO-ANDROID] [NO-MAIL]

/// Set the default log level for Background Tasks
// This is the default value - this just exposes the pref via the `about:config`
// https://searchfox.org/mozilla-central/source/toolkit/components/backgroundtasks/BackgroundTasksManager.sys.mjs
pref("toolkit.backgroundtasks.loglevel", "error"); // [DEFAULT] [HIDDEN]

/// Set the default log level for Remote Settings
// This is the default value - this just exposes the pref via the `about:config`
pref("services.settings.loglevel", "warn"); // [DEFAULT] [HIDDEN]

/// Set default URL to load when navigating to `moz://a`
// Default is https://www.mozilla.org/about/manifesto/
// https://searchfox.org/mozilla-central/source/toolkit/components/mozprotocol/MozProtocolHandler.sys.mjs
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
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/AddonManager.sys.mjs
pref("extensions.systemAddon.update.enabled", true); // [DEFAULT]
pref("extensions.systemAddon.update.url", "https://aus5.mozilla.org/update/3/SystemAddons/%VERSION%/%BUILD_ID%/%BUILD_TARGET%/%LOCALE%/%CHANNEL%/%OS_VERSION%/%DISTRIBUTION%/%DISTRIBUTION_VERSION%/update.xml"); // [HIDDEN - Thunderbird] [DEFAULT - non-Thunderbird]
pref("extensions.update.autoUpdateDefault", true); // [HIDDEN - ANDROID] [DEFAULT]
pref("extensions.update.enabled", true); // [DEFAULT]
pref("media.gmp-manager.updateEnabled", true); // [HIDDEN] [DEFAULT]

/// Check for browser updates hourly [NO-ANDROID]
pref("app.update.background.interval", 3600); // [NO-ANDROID] (Default: 25200 (7 hours))
pref("app.update.interval", 3600); // [NO-ANDROID] (Default: 21600 (6 hours))

/// Check for extension/theme updates hourly
// Default is once every 24 hours
pref("extensions.update.interval", 3600);

/// Disable insecure extension updates
// https://searchfox.org/mozilla-central/source/toolkit/mozapps/extensions/AddonManager.sys.mjs
pref("extensions.checkUpdateSecurity", true); // [HIDDEN] [DEFAULT]

/// Notify users for extension updates by default
// https://searchfox.org/mozilla-central/source/remote/shared/RecommendedPreferences.sys.mjs#253
pref("extensions.update.notifyUser", true); // [HIDDEN]

/// Sync with Remote Settings hourly, rather than the default of only once a day
// This is used for delivering lots of security-critical databases (Ex. CRLite/revocation checks, malicious add-on blocklists, etc...)
// So let's make sure our users are up to date as quick as possible
pref("services.settings.poll_interval", 3600);

pref("browser.phoenix.status", "028");

/*** 029 SYNC ***/ // [NO-ANDROID] [NO-MAIL]

// Sync additional preferences... [NO-ANDROID] [NO-MAIL]

pref("services.sync.prefs.sync.browser.bookmarks.autoExportHTML", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.bookmarks.openInTabClosesMenu", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.compactmode.show", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.download.open_pdf_attachments_inline", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.discoverystream.recentSaves.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showRecentSaves", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showWeather", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-dark", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-light", true); // [NO-ANDROID] [NO-MAIL]
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
pref("services.sync.prefs.sync.security.xfocsp.hideOpenInNewWindow", true); // [NO-ANDROID] [NO-MAIL] [ESR]
pref("services.sync.prefs.sync.sidebar.main.tools", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.sidebar.revamp", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.startup.homepage_override_nimbus_disable_wnp", true); // [NO-ANDROID] [NO-MAIL]
pref("services.sync.prefs.sync.view_source.wrap_long_lines", true); // [NO-ANDROID] [NO-MAIL]

pref("browser.phoenix.status", "029"); // [NO-ANDROID] [NO-MAIL]

/*** 030 SPECIALIZED/CUSTOM CONFIGS ***/ // [NO-ANDROID]

/// Configure remote AutoConfig files (if active) [NO-ANDROID]
pref("autoadmin.failover_to_cached", true); // [NO-ANDROID]
pref("autoadmin.offline_failover", true); // [NO-ANDROID]
pref("autoadmin.refresh_interval", 60); // [NO-ANDROID]

/// Enable support for custom/specialized configs... [NO-ANDROID] [NO-OSX] [NO-WINDOWS]
pref("general.config.filename", "phoenix.cfg"); // [NO-ANDROID] [NO-OSX] [NO-WINDOWS]
pref("general.config.obscure_value", 0); // [NO-ANDROID] [NO-OSX] [NO-WINDOWS]
pref("general.config.vendor", "phoenix"); // [NO-ANDROID] [NO-OSX] [NO-WINDOWS]

pref("browser.phoenix.status", "030"); // [NO-ANDROID]

pref("browser.phoenix.status", "successfully applied :D", locked);
