# ❗ Important

Things to note

*Covers important information you need to know*

* You might notice various search engines listed under `about:addons` or in your extensions menu. These are **not** actual extensions, please see [here](Search.md).

* Phoenix enables [DNS over HTTPS](https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/) without fallback & routes traffic through [Mullvad *(Base)*](https://mullvad.net/help/dns-over-https-and-dns-over-tls) by default, due to the major privacy and security benefits this provides. You can change providers or disable DNS over HTTPS entirely (not recommended) in `about:preferences#privacy`.

* Phoenix enforces [Strict Certificate Pinning](https://bugzilla.mozilla.org/show_bug.cgi?id=1059392) due to the **significant** privacy & security improvement it provides. Without this preference, it is possible for other software on your computer to intercept (MITM) your web traffic, which essentially defeats the point of HTTPS...  If you notice a `MOZILLA_PKIX_ERROR_KEY_PINNING_FAILURE` error, it likely means you either have some kind of anti-virus or web filtering installed (in which case, please uninstall it... it's directly harming your privacy & security despite claiming to do the opposite), you are in some kind of corporation/managed environment (in which case the website you're trying to access wouldn't have worked anyways or if it did, would not have been the actual site you were trying to reach...), or a malicious actor is trying to MITM your traffic. AdGuard's desktop apps are also known to MITM your connections like this - so, please just disable that functionality in the app if you use it, it's completely unnecessary.

* By default, Phoenix disables Autofill/Autocomplete in the URL Bar, to prevent any undesired or accidental connections. You can re-enable it through the `about:config`  by setting `browser.urlbar.autoFill` to `true`.

* Phoenix currently pre-installs [uBlock Origin](https://github.com/gorhill/ublock) *with our custom enhanced configuration, see [here](Content-Blocking.md)*. uBlock Origin was added due to the extreme privacy & security benefits it provides *(as well as general usability...)*. Our goal is to keep included extensions at a minimum, so we probably won't be adding any more for the foreseeable future - but we will look into making a page of certain trustworthy, high quality extensions we recommend using depending on your use case. It should also be noted that if you already have uBlock Origin installed, our uBlock Origin configuration won't immediately be applied unless you reset your default settings (Found at the bottom of the `Settings` tab). You can however simply choose the option to `Back up to file...`, & after resetting, choose `Restore from file...` to keep your existing settings.

* Phoenix completely removes & disables all DRM technology. See [here](https://celenity.dev/posts/thoughts/drm/) for the rationale as to why. This means that certain proprietary streaming services won't play content or will only play content at a lower quality than anticipated. Websites impacted by this are documented [here](Web-Compat.md). I would strongly recommend avoiding these types of streaming services entirely & instead consuming content by other means... but if you do insist on using them (not recommended), I would recommend either streaming this type of content from the provider's app or on a separate device.

* If you have any privacy concerns, see [here](Transparency.md), and [feel free to reach out](https://celenity.dev/contact/)!
