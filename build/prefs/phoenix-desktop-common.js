
//

// This file contains preferences shared across Phoenix & Dove on Desktop.

// 001 HTTP(S) - Mixed Content & General Network Hardening

/// Enforce using HTTPS as much as possible

pref("dom.security.https_only_mode", true, locked);
pref("dom.security.https_only_mode_pbm", true, locked);

pref("browser.phoenix.desktop.common.status", "001", locked);

// 002 CERTIFICATES

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

pref("browser.phoenix.desktop.common.status", "002", locked);

// 003 SAFE BROWSING

/// Proxy Safe Browsing
// These are using the servers we've set up for IronFox, hosted on our Cloudflare storage bucket (in EU jurisdiction)

pref("browser.safebrowsing.provider.google4.gethashURL", "https://safebrowsing.ironfoxoss.org/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");
pref("browser.safebrowsing.provider.google4.updateURL", "https://safebrowsing.ironfoxoss.org/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST");

pref("browser.phoenix.desktop.common.status", "003", locked);

// 004 PERFORMANCE
// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

pref("browser.cache.jsbc_compression_level", 3);
pref("browser.sessionstore.interval", 60000);
pref("gfx.webrender.compositor", true);
pref("media.cache_readahead_limit", 7200);
pref("media.cache_resume_threshold", 3600);
pref("network.http.max-connections", 1800);

pref("browser.phoenix.desktop.common.status", "004", locked);

// 005 Personal Touch

/// Enable Spellcheck for both multi-line and single-line boxes
// [Default = 1, only checks multi-line boxes]
// https://codeberg.org/celenity/Phoenix/issues/33

pref("layout.spellcheckDefault", 2);

/// Enable custom CSS by default

pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

pref("browser.phoenix.desktop.common.status", "005", locked);

pref("browser.phoenix.desktop.common.status", "successfully applied :D", locked);

