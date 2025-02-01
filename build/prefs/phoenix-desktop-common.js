
//

// This file contains preferences shared across Phoenix & Dove on Desktop.

// 001 DATA COLLECTION

/// Default Browser Agent
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html

pref("default-browser-agent.enabled", false, locked);

pref("browser.phoenix.desktop.common.status", "001");

// 002 HTTP(S) - Mixed Content & General Network Hardening

/// Enforce using HTTPS as much as possible

pref("dom.security.https_only_mode", true, locked);
pref("dom.security.https_only_mode_pbm", true, locked);

pref("browser.phoenix.desktop.common.status", "002");

// 003 CERTIFICATES

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

/// Ensure users can always view and manage Firefox's internal certificates...

pref("security.disable_button.openCertManager", false, locked); // [DEFAULT]

pref("browser.phoenix.desktop.common.status", "003");

// 004 GEOLOCATION

/// Blocks websites from accessing geolocation by default

pref("permissions.default.geo", 2);

/// Configure OS Geolocation Providers

pref("geo.provider.ms-windows-location", false); // Disable Microsoft Location Services for Windows users
pref("geo.provider.use_corelocation", true); // [DEFAULT] - Enable Apple Location Services for macOS
pref("geo.provider.use_geoclue", true); // [DEFAULT] - Enable Geoclue for Linux distros

pref("browser.phoenix.desktop.common.status", "004");

// 005 DISK AVOIDANCE

/// Prevent automatically starting Firefox & restoring session after reboot on Windows

pref("toolkit.winRegisterApplicationRestart", false);

pref("browser.phoenix.desktop.common.status", "005");

// 006 EXTENSIONS

// Only allow signed language packs & whitelisted extensions...

pref("extensions.langpacks.signatures.required", true, locked); // [DEFAULT]
pref("xpinstall.whitelist.required", true, locked); // [DEFAULT]

// Enable panel for our own extension recommendations...

pref("extensions.getAddons.showPane", true); // [DEFAULT]

pref("browser.phoenix.desktop.common.status", "006");

// 007 ATTACK SURFACE REDUCTION

/// Disable WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API

pref("permissions.default.xr", 2);

pref("browser.phoenix.desktop.common.status", "007");

// 008 MISC. SECURITY

/// Disable GNOME Integration
// https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp

pref("browser.gnome-search-provider.enabled", false);

pref("browser.phoenix.desktop.common.status", "008");

// 009 MEDIA

/// Microsoft PlayReady DRM

pref("media.eme.playready.enabled", false);

pref("browser.phoenix.desktop.common.status", "009");

// 010 PERFORMANCE
// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

pref("browser.cache.jsbc_compression_level", 3);
pref("browser.sessionstore.interval", 60000);
pref("gfx.webrender.compositor", true);
pref("media.cache_readahead_limit", 7200);
pref("media.cache_resume_threshold", 3600);
pref("media.ffmpeg.vaapi.enabled", true); // Enable VA-API by default
pref("network.http.max-connections", 1800);

pref("browser.phoenix.desktop.common.status", "010");

// 011 Personal Touch

/// Enable Spellcheck for both multi-line and single-line boxes
// [Default = 1, only checks multi-line boxes]
// https://codeberg.org/celenity/Phoenix/issues/33

pref("layout.spellcheckDefault", 2);

/// Enable custom CSS by default

pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

pref("browser.phoenix.desktop.common.status", "011");

pref("browser.phoenix.desktop.common.status", "successfully applied :D", locked);

