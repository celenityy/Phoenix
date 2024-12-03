// Enforce that we (or any other mozilla.cfg files) do not get privileged browser access...
// https://www.mozilla.org/firefox/62.0/releasenotes/
pref("general.config.sandbox_enabled", true);

// Defense in depth, enforces users can never be identified...
pref("mail.identity.useremail", "");
pref("autoadmin.append_emailaddr", false);

pref("general.config.filename", "phoenix.cfg");
pref("general.config.vendor", "phoenix");
pref("general.config.obscure_value", 0);