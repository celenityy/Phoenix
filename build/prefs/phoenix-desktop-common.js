
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
007: GEOLOCATION
008: DEBUGGING
009: MISC. PRIVACY
010: MISC. SECURITY
011: PERFORMANCE
012: Personal Touch 💜
013: UPDATES
014: SPECIALIZED/CUSTOM CONFIGS

*/

/*** 001 DATA COLLECTION ***/

/// Disable Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro
pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [HIDDEN - Thunderbird] [DEFAULT]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [HIDDEN - Thunderbird] [DEFAULT - non-Nightly]

/// Disable Data Reporting & Telemetry
pref("browser.urlbar.quicksuggest.onboardingDialogChoice", "reject_2", locked); // [ESR] [HIDDEN] https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst
pref("services.sync.log.logger.telemetry", "Fatal"); // [HIDDEN]
pref("services.sync.telemetry.maxEventsCount", 0, locked); // [HIDDEN] Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.maxPayloadCount", 0, locked); // Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("services.sync.telemetry.submissionInterval", 999999999, locked); // Disable `sync` ping https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/sync-ping.rst
pref("toolkit.telemetry.dap_helper", "", locked); // [ESR]
pref("toolkit.telemetry.dap_helper_owner", "", locked); // [ESR]
pref("toolkit.telemetry.dap_leader", "", locked); // [ESR]
pref("toolkit.telemetry.dap_leader_owner", "", locked); // [ESR]

/// Disable Experiments/Studies
pref("messaging-system.rsexperimentloader.enabled", false, locked); // [ESR]

pref("browser.phoenix.status.desktop.common", "001");

/*** 002 MOZILLA CRAP™ ***/

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
pref("toolkit.winRegisterApplicationRestart", false); // [HIDDEN - Thunderbird] [NO-OSX]

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

pref("browser.phoenix.status.desktop.common", "005");

/*** 006 ATTACK SURFACE REDUCTION ***/

/// Disable WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API
pref("permissions.default.xr", 2); // [HIDDEN on Thunderbird]

pref("browser.phoenix.status.desktop.common", "006");

/*** 007 GEOLOCATION [NO-OSX] ***/

// Disable Microsoft Location Services [WINDOWS] [NO-OSX]
pref("geo.provider.ms-windows-location", false); // [NO-OSX]

pref("browser.phoenix.status.desktop.common", "007"); // [NO-OSX]

/*** 008 DEBUGGING ***/

/// Enforce local debugging only
pref("devtools.inspector.remote", false, locked); // [DEFAULT]

pref("browser.phoenix.status.desktop.common", "008");

/*** 009 MISC. PRIVACY ***/

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

/// Enable Containers
// https://support.mozilla.org/kb/how-use-firefox-containers
pref("privacy.userContext.enabled", true);

/// Prevent saving clipboard history/contents to the cloud [WINDOWS] [NO-OSX]
pref("clipboard.copyPrivateDataToClipboardCloudOrHistory", false); // [DEFAULT] [NO-OSX]

/// Prevent sharing identifying info if a remote AutoConfig is being used
pref("autoadmin.append_emailaddr", false, locked); // [HIDDEN]

pref("browser.phoenix.status.desktop.common", "009");

/*** 010 MISC. SECURITY ***/

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

pref("browser.phoenix.status.desktop.common", "010");

/*** 011 PERFORMANCE ***/

/// Disable certain UI animations
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h
pref("ui.panelAnimations", 0); // [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [HIDDEN]

/// Taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
pref("network.http.max-connections", 1800); // [Default = 900]

pref("browser.phoenix.status.desktop.common", "011");

/*** 012 Personal Touch 💜 ***/

/// Things that are  nice to have™
// Not directly privacy & security related

/// Developer tools...
pref("devtools.command-button-experimental-prefs.enabled", true); // [HIDDEN]
pref("devtools.command-button-measure.enabled", true);
pref("devtools.command-button-rulers.enabled", true);
pref("devtools.command-button-screenshot.enabled", true);
pref("devtools.debugger.ui.editor-wrapping", true); // Enables long line wrapping in developer tools https://discourse.mozilla.org/t/long-line-wrapping-in-developer-tools-css-editor-and-debugger-code-views/47058
pref("devtools.dom.enabled", true);
pref("devtools.inspector.showUserAgentStyles", true); // Show default/browser styles in the Inspector by default
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

pref("security.xfocsp.hideOpenInNewWindow", false); // [ESR]

pref("browser.phoenix.status.desktop.common", "012");

/*** 013 UPDATES ***/

/// Browser Updates
pref("app.update.badgeWaitTime", 0); // Immediately show badge on hamburger menu when update is available
pref("app.update.notifyDuringDownload", true); // Ensure that users are notified when an update is downloaded
pref("app.update.promptWaitTime", 3600); // Decrease time between update prompts, default is very generous...

pref("browser.phoenix.status.desktop.common", "013");

/*** 014 SPECIALIZED/CUSTOM CONFIGS ***/

/// Configure remote AutoConfig files (if active)
pref("autoadmin.failover_to_cached", true);
pref("autoadmin.offline_failover", true);
pref("autoadmin.refresh_interval", 60);

pref("browser.phoenix.status.desktop.common", "014");

pref("browser.phoenix.status.desktop.common", "successfully applied :D", locked);

