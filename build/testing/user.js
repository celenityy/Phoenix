// User.js file for development and testing

/*** NOTE TO SELF: REPLACE [XXXXXX] AT "Configure DoH" ***/

/// Add `about:config`, `about:policies`, `about:support`, `about:addons`, `about:debugging`, and `about:processes` to `about:home`
user_pref("browser.newtabpage.pinned", '[{"url":"about:config","label":"about:config"},{"url":"about:policies","label":"about:policies"},{"url":"about:support","label":"about:support"},{"url":"about:addons","label":"about:addons"},{"url":"about:debugging","label":"about:debugging"},{"url":"about:processes","label":"about:processes"}]');

/// Disable DNS cache
user_pref("network.dnsCacheEntries", 0);

/// Disable DoH
user_pref("network.trr.mode", 0);

/// Display network requests in browser console
user_pref("devtools.browserconsole.filter.net", true);
user_pref("devtools.browserconsole.filter.netxhr", true);

/// Display network requests in web console
user_pref("devtools.webconsole.filter.net", true);
user_pref("devtools.webconsole.filter.netxhr", true);

/// Enable additional logging
user_pref("app.normandy.logging.level", 0);
user_pref("browser.dom.window.dump.enabled", true);
user_pref("browser.policies.loglevel", "debug");
user_pref("browser.region.log", true);
user_pref("browser.safebrowsing.debug", true);
user_pref("browser.search.log", true);
user_pref("browser.uitour.loglevel", "Debug");
user_pref("browser.urlbar.loglevel", "Debug");
user_pref("captchadetection.loglevel", "Debug");
user_pref("cookiebanners.listService.logLevel", "Debug");
user_pref("devtools.console.stdout.chrome", true);
user_pref("dom.push.loglevel", "Debug");
user_pref("extensions.logging.enabled", true);
user_pref("geo.provider.network.logging.enabled", true);
user_pref("media.gmp.log.dump", true);
user_pref("messaging-system.log", "debug");
user_pref("privacy.fingerprintingProtection.WebCompatService.logLevel", "Debug");
user_pref("remote.log.level", "Debug");
user_pref("remote.log.truncate", false);
user_pref("services.settings.loglevel", "debug");
user_pref("privacy.resistFingerprinting.jsmloglevel", "Debug");
user_pref("toolkit.backgroundtasks.loglevel", "debug");
user_pref("toolkit.contentRelevancy.log", true);
user_pref("toolkit.coverage.log-level", 0);
user_pref("toolkit.telemetry.dap.logLevel", "Debug");
user_pref("toolkit.telemetry.log.dump", true);
user_pref("toolkit.telemetry.log.level", "Debug");
user_pref("toolkit.telemetry.translations.logLevel", "Debug");
user_pref("toolkit.telemetry.user_characteristics_ping.logLevel", "Debug");

/// Enable network monitoring
user_pref("devtools.browserconsole.enableNetworkMonitoring", true);

/// Enable PDF.js debugging
user_pref("pdfjs.pdfBugEnabled", true);

/// Sanitize data on exit
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);

/// Switch to new tabs immediately upon opening links
user_pref("browser.tabs.loadInBackground", true);
