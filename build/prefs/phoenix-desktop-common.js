
//

// This file contains preferences shared across Phoenix & Dove on Desktop.

// 001 DATA COLLECTION

/// Default Browser Agent
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html

pref("default-browser-agent.enabled", false, locked);

/// Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro

pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [DEFAULT]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [DEFAULT on Stable - but set to true on Nightly :/]
pref("browser.tabs.crashReporting.includeURL", false, locked); // [DEFAULT] - Defense in depth
pref("browser.tabs.crashReporting.sendReport", false, locked);

/// Misc. Telemetry

pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [DEFAULT]
pref("browser.urlbar.quicksuggest.onboardingDialogChoice", "reject_2", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/environment.rst https://searchfox.org/mozilla-central/source/browser/components/urlbar/tests/quicksuggest/browser/browser_quicksuggest_onboardingDialog.js

pref("browser.phoenix.desktop.common.status", "001");

// 002 MOZILLA CRAP™

/// Fakespot

pref("browser.urlbar.fakespot.featureGate", false); // [DEFAULT]
pref("browser.urlbar.suggest.fakespot", false);

/// Pocket

pref("browser.urlbar.pocket.featureGate", false);
pref("browser.urlbar.suggest.pocket", false);

/// "Top Sites"/Sponsored content/etc.
// https://searchfox.org/mozilla-central/source/toolkit/components/nimbus/FeatureManifest.yaml

pref("browser.urlbar.sponsoredTopSites", false, locked);

/// Firefox Suggest

pref("browser.urlbar.addons.featureGate", false);
pref("browser.urlbar.groupLabels.enabled", false);
pref("browser.urlbar.mdn.featureGate", false);
pref("browser.urlbar.merino.endpointURL", "");
pref("browser.urlbar.merino.providers", "");
pref("browser.urlbar.quicksuggest.contextualOptIn", false);
pref("browser.urlbar.quicksuggest.enabled", false);
pref("browser.urlbar.quicksuggest.hideSettingsUI", true);
pref("browser.urlbar.quicksuggest.scenario", "offline");
pref("browser.urlbar.quicksuggest.shouldShowOnboardingDialog", false);
pref("browser.urlbar.quicksuggest.showedOnboardingDialog", true);
pref("browser.urlbar.quicksuggest.sponsoredPriority", false, locked);
pref("browser.urlbar.suggest.addons", false);
pref("browser.urlbar.suggest.mdn", false);
pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
pref("browser.urlbar.suggest.quicksuggest.sponsored", false, locked);
pref("browser.urlbar.suggest.trending", false);
pref("browser.urlbar.suggest.weather", false);
pref("browser.urlbar.suggest.yelp", false);
pref("browser.urlbar.trending.featureGate", false);
pref("browser.urlbar.weather.featureGate", false);
pref("browser.urlbar.yelp.featureGate", false);

pref("browser.phoenix.desktop.common.status", "002");

// 003 Search & URL Bar

/// Allow adding custom search engines in about:preferences#search

pref("browser.urlbar.update2.engineAliasRefresh", true); // [HIDDEN]

/// Never trim URLs

pref("browser.urlbar.trimHttps", false);
pref("browser.urlbar.trimURLs", false);

// Remove Search Engine Placeholders

pref("browser.urlbar.placeholderName", "");
pref("browser.urlbar.placeholderName.private", "");

/// Do not autofill/autocomplete URLs by default

pref("browser.urlbar.autoFill", false);

// Always show URL instead of search terms

pref("browser.urlbar.showSearchTerms.enabled", false);
pref("browser.urlbar.showSearchTerms.featureGate", false);

/// Enforce that JavaScript URLS are excluded from results

pref("browser.urlbar.filter.javascript", true); // [DEFAULT]

/// Disable "Recent Searches" being suggested since we disable Search & Form History anyways

pref("browser.urlbar.recentsearches.featureGate", false);
pref("browser.urlbar.suggest.recentsearches", false);

// Nice to have

pref("browser.urlbar.clipboard.featureGate", false);
pref("browser.urlbar.suggest.bookmark", true);
pref("browser.urlbar.suggest.calculator", true);
pref("browser.urlbar.suggest.clipboard", false);
pref("browser.urlbar.suggest.engines", false);
pref("browser.urlbar.suggest.history", false);
pref("browser.urlbar.suggest.openpage", true);
pref("browser.urlbar.unitConversion.enabled", true);

pref("browser.phoenix.desktop.common.status", "003");

// 004 Implicit Connections

/// Disable Network Prefetching

pref("browser.urlbar.speculativeConnect.enabled", false);

/// Disable Search Suggestions

pref("browser.urlbar.showSearchSuggestionsFirst", false);
pref("browser.urlbar.suggest.searches", false);

/// Prevent leaking single word searches to DNS provider

pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);

pref("browser.phoenix.desktop.common.status", "004");

// 005 HTTP(S) - Mixed Content & General Network Hardening

/// Enforce using HTTPS as much as possible

pref("dom.security.https_only_mode", true, locked);
pref("dom.security.https_only_mode_pbm", true, locked);

pref("browser.phoenix.desktop.common.status", "005");

// 006 CERTIFICATES

/// Enforce Strict Certificate Pinning
// https://wiki.mozilla.org/SecurityEngineering/Public_Key_Pinning#How_to_use_pinning

pref("security.cert_pinning.enforcement_level", 2, locked);

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

pref("browser.phoenix.desktop.common.status", "006");

// 007 GEOLOCATION

/// Configure OS Geolocation providers

pref("geo.provider.ms-windows-location", false); // Disable Microsoft Location Services for Windows users

pref("browser.phoenix.desktop.common.status", "007");

// 008 DISK AVOIDANCE

/// Prevent automatically starting Firefox & restoring session after reboot on Windows

pref("toolkit.winRegisterApplicationRestart", false);

pref("browser.phoenix.desktop.common.status", "008");

// 009 EXTENSIONS

// Only allow signed language packs & whitelisted extensions...

pref("extensions.langpacks.signatures.required", true, locked); // [DEFAULT]
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT]

// Enable panel for our own extension recommendations...

pref("extensions.getAddons.showPane", true); // [DEFAULT]

pref("browser.phoenix.desktop.common.status", "009");

// 010 ATTACK SURFACE REDUCTION

/// Disable WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API

pref("permissions.default.xr", 2);

pref("browser.phoenix.desktop.common.status", "010");

// 011 MISC. SECURITY

/// Disable GNOME Integration
// https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp

pref("browser.gnome-search-provider.enabled", false);

pref("browser.phoenix.desktop.common.status", "011");

// 012 MEDIA

/// Always sandbox GMP on GNU/Linux
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml

pref("media.gmp.insecure.allow", false); // [DEFAULT]

/// Remove DRM toggle in `about:preferences#general`

pref("browser.eme.ui.enabled", false);

/// Disable Microsoft PlayReady DRM

pref("media.eme.playready.enabled", false);

/// Explicitly disable Windows Media Foundation Clearkey DRM

pref("media.eme.wmf.clearkey.enabled", false); // [DEFAULT]

/// Disable Windows Media Foundation Media Engine for protected content (DRM), but enable it for standard content
// https://learn.microsoft.com/windows/win32/medfound/about-the-media-foundation-sdk

pref("media.wmf.media-engine.enabled", 3);

pref("browser.phoenix.desktop.common.status", "012");

// 013 PERFORMANCE
// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

pref("browser.cache.jsbc_compression_level", 3);
pref("browser.sessionstore.interval", 60000);
pref("gfx.webrender.compositor", true);
pref("media.cache_readahead_limit", 7200);
pref("media.cache_resume_threshold", 3600);
pref("media.ffmpeg.vaapi.enabled", true); // Enable VA-API by default
pref("network.http.max-connections", 1800);

pref("browser.phoenix.desktop.common.status", "013");

// 014 Personal Touch

/// Enable Spellcheck for both multi-line and single-line boxes
// [Default = 1, only checks multi-line boxes]
// https://codeberg.org/celenity/Phoenix/issues/33

pref("layout.spellcheckDefault", 2);

/// Enable custom CSS by default

pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

pref("browser.phoenix.desktop.common.status", "014");

pref("browser.phoenix.desktop.common.status", "successfully applied :D", locked);

