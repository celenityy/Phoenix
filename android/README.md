# Phoenix for Android

This directory contains specialized Phoenix config files, specifically designed for Firefox on Android. These configs should **NOT** be used on Desktop Firefox releases, & you should **NOT** use our desktop configs on Android.

**The recommended way to use Phoenix on Android is via [IronFox](https://gitlab.com/ironfox-oss/IronFox)**, a fully free & open source fork of the now discontinued [Mull](https://codeberg.org/divested-mobile/mull-fenix) browser. *(Disclaimer: I am a maintainer of IronFox...)*.

However, you may also manually install these configs on:

* **Fennec F-Droid**
* **Firefox**
* **Firefox Beta**
* **Firefox Focus**
* **Firefox Klar**
* **Firefox Nightly**
* **Iceraven**
* & basically **any other Firefox-based Android web browser via the following steps**.

___

## Manual Installation Steps

*This guide has been adapted from the incredible work of [ndv92](https://voz.vn/u/ndv92.790519/) (see their original forum post [here](https://voz.vn/t/tong-hop-nhung-addon-chat-cho-firefox-chromium.682181/page-292#post-27739740)), and [Gunir](https://github.com/gunir) (see their on GitHub [here](https://github.com/yokoffing/Betterfox/issues/240)).* **Thank you to them for making this possible!**

**1:** You're first going to need to install ADB on your computer. You can see a guide to do this [here](https://www.xda-developers.com/install-adb-windows-macos-linux/). You also need to make sure you have Firefox's desktop application installed, and you'll need a USB (C) cable to connect your mobile device to your computer.

**2:** In your Firefox-based web browser **on your Android device**, navigate to `Settings`, scroll down to the bottom, and **enable** `Remote debugging via USB`.

> [!IMPORTANT]
> **Please remember to disable `Remote debugging via USB` when you're done, due to security concerns...**

**3:** On your Android device, you now need to enable ADB debugging. The steps will vary depending on your device's manufacturer, but for AOSP, you can enable it via opening your `Settings` app, and navigating to `System` -> `Developer options` -> `USB debugging`. **Make sure you have Developer options enabled!**

> [!TIP]
> If you don't already have Developer options enabled on your device, the steps will again vary depending on your device's manufacturer, but for AOSP, you can activate it via opening your `Settings` app, navigating to `About phone` *(It may also say `About tablet`, depending on your device...)*, scrolling down to the very bottom, and repeatedly tapping `Build number`, until you see a confirmation screen asking for your device's passcode.

> [!IMPORTANT]
> **Please remember to disable ADB when you're done, due to security concerns...**

**4:** Open Firefox back up on your mobile device, and navigate to `about:support`.

**5:** Ensure ADB is running on your computer *(An easy way to tell is simply via running `adb devices`)*, and connect your mobile device to your computer.

**6:** You'll now see a prompt on your device asking to `Allow USB debugging?`. Select **Allow**.

**7:** Run `adb devices` & confirm your device is attached. If it is attached, proceed to the next steps.

**8:** On your computer, launch Firefox's desktop installation, and navigate to `about:debugging`. Towards the bottom left, you should see your device's name/model, with an option to `Connect`. Select **Connect**. If you don't see it, you should try selecting the `Refresh devices` option, and unplugging + plugging back in your device to your computer.

**9:** Select your device's name/model towards the bottom left. Under the `Tabs` section, you should see an entry titled `Troubleshooting Information`, with the text `about:support` below it. Choose **Inspect** to the right of this text.

**10:** If not already selected, navigate to the Web Console via selecting the **Console** tab; it can be found in between the `Inspector` & `Debugger` options.

**11:** Paste the following content into your Web Console, but do **NOT** enter it yet:

```sh
var locked = "ignore";
var sticky = "ignore";
var pref = function(pref, val, locked, sticky) {
  try {
    if (typeof val == "string") {
      Services.prefs.setStringPref(pref, val);
    } else if (typeof val == "number") {
      Services.prefs.setIntPref(pref, val);
    } else if (typeof val == "boolean") {
      Services.prefs.setBoolPref(pref, val);
    }
  } catch (e) {
    console.log("pref:" + pref + " val:" + val + " e:" + e);
  }
}

// Paste the contents of phoenix-android.js below:

```

*Credit to [ndv92](https://voz.vn/u/ndv92.790519/) for [the creation of the code above](https://voz.vn/t/tong-hop-nhung-addon-chat-cho-firefox-chromium.682181/page-292#post-27739740); I've just slightly tweaked it for our use case.*

**12:** Open up a separate tab on your desktop installation of Firefox, and navigate to the **Android** [`phoenix.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/android/phoenix.js) file. It can be found at the following link:

```sh
https://gitlab.com/celenityy/Phoenix/-/raw/pages/android/phoenix.js
```

**13:** Copy the contents of the file *(Easiest way to select everything is via `Ctrl` + `a`, then `Ctrl` + `c` to copy)*, then navigate back to your Web console, & paste the contents below the `// Paste the contents of phoenix-android.js below:` line. **Now press enter.**

**14:** If you'd also like to use Phoenix's `Extended` Hardening config, you'll first need to navigate to the `about:config` on your Android device & set `devtools.debugger.remote-enabled` to `true`.

**15:** You should then reconnect to your mobile device from `about:debugging` on your computer. You can now **repeat** Steps `11` and `12`, but replace `https://gitlab.com/celenityy/Phoenix/-/raw/pages/android/phoenix.js` with `https://gitlab.com/celenityy/Phoenix/-/raw/pages/android/phoenix-extended.js`:

```sh
ttps://gitlab.com/celenityy/Phoenix/-/raw/pages/android/phoenix-extended.js
```

**16:** Unplug your Android device from your computer, and stop ADB via running `adb kill-server` on your computer.

**17:** Back on your Android device, within Firefox, navigate to `Settings`, scroll down to the bottom, and **disable** `Remote debugging via USB`.

**18:** Close Firefox on your Android device, open up your `Settings` app, navigate back to `Developer options` *(via the same way you accessed it in Step `3`)*, and **disable** `USB debugging`.

**19:** Below `USB debugging`, select **Revoke USB debugging authorizations**, and choose `OK`.

**20:** You're done, enjoy :).
