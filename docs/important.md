# Important

Things to note

*Covers important information you need to know*

* Phoenix enables [DNS over HTTPS](https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/) without fallback by default. For more details, as well as how you can control this functionality, see the [`DNS over HTTPS` section of the `Network Connections` page](./transparency/network-connections#dns-over-https).

* Phoenix enforces [Strict Certificate Pinning](https://bugzilla.mozilla.org/show_bug.cgi?id=1059392) due to the **significant** privacy and security improvement it provides. Without this preference, it is possible for other software on your computer to intercept (MITM) your web traffic, which essentially defeats the point of HTTPS...  If you notice a `MOZILLA_PKIX_ERROR_KEY_PINNING_FAILURE` error, it likely means you either have some kind of anti-virus or web filtering installed (in which case, please uninstall it... it's directly harming your privacy and security despite claiming to do the opposite), you are in some kind of corporation/managed environment (in which case the website you're trying to access wouldn't have worked anyways or if it did, would not have been the actual site you were trying to reach...), or a malicious actor is trying to MITM your traffic. AdGuard's desktop apps are also known to MITM your connections like this - so, please just disable that functionality in the app if you use it, it's completely unnecessary.

* Phoenix disables autofill/cutocomplete in the URL Bar by default, to prevent any undesired/accidental connections. You can re-enable it if desired by setting `browser.urlbar.autoFill` to `true` at [`about:config`](about:config).

* Phoenix currently pre-installs [uBlock Origin](https://github.com/gorhill/ublock) *with our custom enhanced configuration, see [here](./features/content-blocking)*. uBlock Origin was added due to the significant privacy and security benefits it provides *(as well as general usability...)*. It should be noted that if you already have uBlock Origin installed, Phoenix's uBlock Origin configuration won't immediately be applied unless you reset your default settings *(Found at the bottom of uBlock Origin's `Settings` tab)*. You can however simply choose the option to `Back up to file...`, and after resetting uBlock Origin, choose `Restore from file...` to keep your existing settings.

* Phoenix completely disables and does not support DRM technology. See [here](https://celenity.dev/posts/thoughts/drm/) for the rationale as to why. This means that certain proprietary streaming services won't play content, or will only play content at a lower quality than anticipated. Websites impacted by this are documented [here](./info/web-compat). I would strongly recommend avoiding these types of streaming services entirely, and instead consuming content by other means... but if you do insist on using these services *(not recommended)*, you will need to manually override the relevant preferences.

* If you have any privacy concerns, please see the [`Privacy Notice`](./transparency/privacy-notice) and [`Network Connections`](./transparency/network-connections) pages. Also [feel free to reach out if you have any specific unaddressed questions/concerns](https://celenity.dev/contact/)! :)
