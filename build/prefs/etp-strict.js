//
// This config manually enables various protections from ETP/Strict
// Useful for ex. Android & Thunderbird, where ETP Strict either isn't supported or doesn't cover the same protections.

pref("extensions.webcompat.enable_shims", true); // [HIDDEN]
pref("extensions.webcompat.perform_injections", true); // [HIDDEN]
pref("extensions.webcompat.perform_ua_overrides", true); // [HIDDEN]
pref("network.cookie.cookieBehavior", 5);
pref("network.cookie.cookieBehavior.optInPartitioning", true);
pref("network.cookie.cookieBehavior.optInPartitioning.pbmode", true);
pref("network.cookie.cookieBehavior.pbmode", 5);
pref("network.cookie.cookieBehavior.trackerCookieBlocking", true);
pref("network.http.referer.disallowCrossSiteRelaxingDefault", true);
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode", true);
pref("network.http.referer.disallowCrossSiteRelaxingDefault.pbmode.top_navigation", true);
pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
pref("privacy.annotate_channels.strict_list.enabled", true);
pref("privacy.annotate_channels.strict_list.pbmode.enabled", true);
pref("privacy.bounceTrackingProtection.enabled", true);
pref("privacy.bounceTrackingProtection.mode", 1); // Fully enables Bounce Tracking Protection - https://searchfox.org/mozilla-central/source/toolkit/components/antitracking/bouncetrackingprotection/nsIBounceTrackingProtection.idl#11
pref("privacy.fingerprintingProtection", true);
pref("privacy.fingerprintingProtection.pbmode", true);
pref("privacy.partition.always_partition_third_party_non_cookie_storage", true);
pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false);
pref("privacy.partition.bloburl_per_partition_key", true);
pref("privacy.partition.network_state", true);
pref("privacy.partition.network_state.ocsp_cache", true);
pref("privacy.partition.network_state.ocsp_cache.pbmode", true);
pref("privacy.partition.serviceWorkers", true);
pref("privacy.query_stripping.enabled", true);
pref("privacy.query_stripping.enabled.pbmode", true);
pref("privacy.query_stripping.redirect", true);
pref("privacy.reduceTimerPrecision", true);
pref("privacy.socialtracking.block_cookies.enabled", true);
pref("privacy.trackingprotection.cryptomining.enabled", true);
pref("privacy.trackingprotection.emailtracking.enabled", true);
pref("privacy.trackingprotection.emailtracking.pbmode.enabled", true);
pref("privacy.trackingprotection.enabled", true);
pref("privacy.trackingprotection.fingerprinting.enabled", true);
pref("privacy.trackingprotection.pbmode.enabled", true);
pref("privacy.trackingprotection.socialtracking.enabled", true);

pref("browser.phoenix.etp-strict.status", "successfully applied :D", locked);

