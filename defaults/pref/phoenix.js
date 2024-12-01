// Enforce that we (or any other mozilla.cfg files) do not get privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
pref("general.config.sandbox_enabled", true);

pref("general.config.filename", "phoenix.cfg");
pref("general.config.obscure_value", 0);