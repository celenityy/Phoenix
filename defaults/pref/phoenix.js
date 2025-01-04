//
//
// Enforce that we (or any other mozilla.cfg files) do not get privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
pref("general.config.sandbox_enabled", true, locked);

pref("general.config.filename", "phoenix.cfg", locked);
pref("general.config.vendor", "phoenix", locked);
pref("general.config.obscure_value", 0);

pref("browser.phoenix.js.applied", true, locked);
