
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

// 001 DATA COLLECTION

/// Default Browser Agent
// https://firefox-source-docs.mozilla.org/toolkit/mozapps/defaultagent/default-browser-agent/index.html

pref("default-browser-agent.enabled", false, locked);

/// Crash Reporting
// https://github.com/mozilla-services/socorro
// https://wiki.mozilla.org/Socorro

pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false, locked); // [DEFAULT, HIDDEN - Thunderbird]
pref("browser.crashReports.unsubmittedCheck.enabled", false, locked); // [DEFAULT - non-Nightly, HIDDEN - Thunderbird]

/// Misc. Telemetry

pref("browser.urlbar.quicksuggest.dataCollection.enabled", false, locked); // [DEFAULT]
pref("browser.urlbar.quicksuggest.onboardingDialogChoice", "reject_2", locked); // [HIDDEN] https://searchfox.org/mozilla-central/source/browser/components/urlbar/docs/firefox-suggest-telemetry.rst https://searchfox.org/mozilla-central/source/toolkit/components/telemetry/docs/data/environment.rst https://searchfox.org/mozilla-central/source/browser/components/urlbar/tests/quicksuggest/browser/browser_quicksuggest_onboardingDialog.js

pref("browser.phoenix.desktop.common.status", "001");

// 002 MOZILLA CRAP™

/// Firefox Recommendations & "Discovery"

pref("extensions.getAddons.discovery.api_url", "data;"); // https://searchfox.org/mozilla-central/source/testing/profiles/common/user.js
pref("extensions.ui.lastCategory", "addons://list/extension"); // [HIDDEN] Ensure default view of `about:addons` is local/installed extensions...

/// Prevent Mozilla domains from having special privileges

pref("permissions.manager.defaultsUrl", "", locked);
pref("services.sync.addons.trustedSourceHostnames", "");

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

pref("browser.phoenix.desktop.common.status", "003");

// 004 GEOLOCATION

/// Configure OS Geolocation providers

pref("geo.provider.ms-windows-location", false); // Disable Microsoft Location Services for Windows users

pref("browser.phoenix.desktop.common.status", "004");

// 005 DISK AVOIDANCE

/// Sanitization
// Clears cache on sanitization dialog by default

pref("privacy.cpd.cache", true); // [DEFAULT]

/// Set time range when manually clearing data to "everything" by default

pref("privacy.sanitize.timeSpan", 0);

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

// 007 MISC. PRIVACY

/// [WINDOWS] Ensure we never save clipboard history/contents to the cloud...

pref("clipboard.copyPrivateDataToClipboardCloudOrHistory", false); // [DEFAULT]

/// Disable Firefox Sync by default
// When signing in to Firefox Sync, this controls the items (checkboxes) that are set to sync (under about:preferences#sync).
// This allows the user to control and choose for themselves what they'd like to sync...

pref("services.sync.engine.addons", false);
pref("services.sync.engine.addresses", false); // [DEFAULT]
pref("services.sync.engine.bookmarks", false);
pref("services.sync.engine.creditcards", false); // [DEFAULT]
pref("services.sync.engine.history", false);
pref("services.sync.engine.passwords", false);
pref("services.sync.engine.prefs", false);
pref("services.sync.engine.tabs", false);

/// If a remote AutoConfig is being used, ensure identifying info is never shared...

pref("autoadmin.append_emailaddr", false, locked); // [HIDDEN]

pref("browser.phoenix.desktop.common.status", "007");

// 008 ATTACK SURFACE REDUCTION

/// Disable WebXR
// https://developer.mozilla.org/docs/Web/API/WebXR_Device_API

pref("permissions.default.xr", 2); // [HIDDEN on Thunderbird]

pref("browser.phoenix.desktop.common.status", "008");

// 009 MISC. SECURITY

/// [WINDOWS] Disable Win32k System Calls
// https://searchfox.org/mozilla-central/source/modules/libpref/init/StaticPrefList.yaml#15638
// https://security.googleblog.com/2016/10/disclosing-vulnerabilities-to-protect.html
// https://docs.google.com/document/d/1gJDlk-9xkh6_8M_awrczWCaUuyr0Zd2TKjNBCiPO_G4/edit

pref("security.sandbox.content.win32k-disable", true); // [DEFAULT]
pref("security.sandbox.gmp.win32k-disable", true);
pref("security.sandbox.socket.win32k-disable", true); // [DEFAULT]

/// Disable GNOME Integration
// https://searchfox.org/mozilla-central/source/browser/components/shell/nsGNOMEShellService.cpp

pref("browser.gnome-search-provider.enabled", false); // [HIDDEN]

/// If a remote AutoConfig is being used, block it from gaining privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/

pref("general.config.sandbox_enabled", true, locked);

pref("browser.phoenix.desktop.common.status", "009");

// 010 MEDIA

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

/// Enable click to play UI for certain CSS skins by default...
// https://github.com/black7375/Firefox-UI-Fix/blob/master/css/leptonContent.css#L223
// https://github.com/black7375/Firefox-UI-Fix/wiki/Options#defaults-6

pref("userContent.player.click_to_play", true); // [HIDDEN] 

pref("browser.phoenix.desktop.common.status", "010");

// 011 UPDATES

/// Browser Updates

pref("app.update.badgeWaitTime", 0); // Immediately show badge on hamburger menu when update is available
pref("app.update.notifyDuringDownload", true); // Ensure that users are notified when an update is downloaded
pref("app.update.promptWaitTime", 3600); // Decrease time between update prompts, default is very generous...

pref("browser.phoenix.desktop.common.status", "011");

// 012 DEBUGGING

/// Enforce local debugging only

pref("devtools.inspector.remote", false, locked); // [DEFAULT]

pref("browser.phoenix.desktop.common.status", "012");

// 013 MISC.

/// Enable Containers by default
// https://support.mozilla.org/kb/how-use-firefox-containers

pref("privacy.userContext.enabled", true);

/// Never hide any extensions in about:debugging

pref("devtools.aboutdebugging.showHiddenAddons", true, locked);

pref("browser.phoenix.desktop.common.status", "013");

// 014 PERFORMANCE
// A lot of these taken from https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js

pref("media.ffmpeg.vaapi.enabled", true); // Enable VA-API by default
pref("network.http.max-connections", 1800); // [Default = 900]

/// Disables certain UI animations
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h

pref("ui.panelAnimations", 0); // [HIDDEN]
pref("ui.prefersReducedMotion", 1); // [HIDDEN] 
pref("ui.swipeAnimationEnabled", 0); // [HIDDEN]

pref("browser.phoenix.desktop.common.status", "014");

// 015 Personal Touch 💜

/// Things that are  nice to have™
// Not directly privacy & security related

/// Enable Spellcheck for both multi-line and single-line boxes
// [Default = 1, only checks multi-line boxes]
// https://codeberg.org/celenity/Phoenix/issues/33

pref("layout.spellcheckDefault", 2);

/// Enable custom CSS by default

pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

/// This pref allows controlling the log level of policies (extremely useful for troubleshooting...), set here to the default value so that it's exposed in the about:config
// https://searchfox.org/mozilla-central/source/browser/components/BrowserGlue.sys.mjs#967

pref("browser.policies.loglevel", "error"); // [DEFAULT, HIDDEN]

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

/// Expose hidden UI preferences in the about:config...
// https://searchfox.org/mozilla-central/source/widget/nsXPLookAndFeel.cpp
// https://searchfox.org/mozilla-central/source/widget/LookAndFeel.h

pref("ui.hideCursorWhileTyping", 1); // [DEFAULT, HIDDEN]
pref("ui.prefersReducedTransparency", 0); // [DEFAULT, HIDDEN]
pref("ui.scrollToClick", 1); // [HIDDEN]
pref("ui.useAccessibilityTheme", 0); // [DEFAULT, HIDDEN]

pref("browser.phoenix.desktop.common.status", "015");

pref("browser.phoenix.desktop.common.status", "successfully applied :D", locked);

