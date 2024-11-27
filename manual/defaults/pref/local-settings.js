pref("general.config.filename", "base.cfg");

pref("general.config.obscure_value", 0);

// Enforce that we (or any other mozilla.cfg files) do not get privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
pref("general.config.sandbox_enabled", true);