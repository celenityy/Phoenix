# Phoenix
<p align="center">
    <img src="assets/phoenix.png"
        alt="Phoenix"
        height="200">
</p>

**Phoenix is a suite of configurations & advanced modifications for Mozilla Firefox, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.**

> [!NOTE]
> While Phoenix's home is [Codeberg](https://codeberg.org/celenity/Phoenix), this repo is also mirrored to both [GitLab](https://gitlab.com/celenity/Phoenix) & [GitHub](https://github.com/celenityy/Phoenix).

> [!NOTE]
> **Thunderbird users should consider taking a look at [Dove](https://dove.celenity.dev) - Phoenix's sister project.**

### Want to join the Phoenix Community?

We'd love to see you over on [Matrix](https://matrix.to/#/#phoenix:unredacted.org) *(Recommended)* and [Discord](https://discord.gg/AMZ2GRxxjr)!

___

Phoenix works by leveraging Firefox's [AutoConfig](https://support.mozilla.org/kb/customizing-firefox-using-autoconfig) & [Enterprise Policies](https://mozilla.github.io/policy-templates/) functionality, and is installed on top of your standard, official Firefox installation. **This allows us to go above and beyond what a simple `user.js` file can offer, without the security risks a fork can introduce**. For example, forks often fall behind on Firefox updates, **which can leave users open to severe, detrimental vulnerabilities.** Phoenix's approach allows users to continue receiving immediate updates, directly from Mozilla.

Phoenix's approach also provides users with a seamless experience that is accessible and easy to use. Gone are the days of creating `override` files, manually keeping track of updates, resetting old preferences, & adding your `user.js` file to each and every profile you make. **Not only is Phoenix the most effective & comprehensive approach to configuring Firefox, it is also the most accessible & easiest to use.**

Phoenix's changes to Firefox are carefully considered based on extensive research & studying of Firefox's inner workings. **For an incomplete, non-exhaustive list of Phoenix's features & enhancements, see [here](https://phoenix.celenity.dev/features).**

**Phoenix is designed to maintain website compatibility and to avoid breakage as much as possible, while still substantially improving privacy & security compared to vanilla Firefox & most other web browsers.** For users who **are** fine with breakage and want to go even further in enhancing their privacy & security, Phoenix also offers an **Extended** config. This is completely optional and primarily recommended for advanced users. For more information on Phoenix's compatibility with websites and known issues, please see [here](https://phoenix.celenity.dev/compat).

**You should also see [here](https://phoenix.celenity.dev/compare) for a comparison between Phoenix, standard Firefox, Arkenfox, Betterfox, LibreWolf, & various other widely used projects of similar nature.**

Additionally, **Phoenix disables various anti-features & strives to put the user back in control of their browsing experience.** Phoenix also includes quality of life enhancements, performance improvements, and other 'goodies' where possible and where it doesn't compromise user privacy or security.

At the end of the day, above all else:

**Phoenix is designed from the ground up to always put the user first.**

> [!IMPORTANT]
>**⚠️ All users MUST read the Wiki [here](https://phoenix.celenity.dev/wiki) before proceeding. The [Important](https://phoenix.celenity.dev/important) & [Limitations](https://phoenix.celenity.dev/limitations) pages are of extra importance!!**

___

# 📖Glossary

**<details><summary>Click me</summary>**

- [Phoenix](#phoenix)
		- [Want to join the Phoenix Community?](#want-to-join-the-phoenix-community)
- [📖Glossary](#glossary)
- [💪Motivation](#motivation)
- [🚀Install](#install)
- [👋Uninstall](#uninstall)
- [🔥Extended](#extended)
	- [Extended Installation](#extended-installation)
- [💡Specialized Configs](#specialized-configs)
- [📛Manual Installation](#manual-installation)
	- [🤔Using Extended or a Specialized Config Manually](#using-extended-or-a-specialized-config-manually)
- [💜Attribution](#attribution)

</details>

# 💪Motivation

Believe it or not, in the not so distant past, browsers were designed to put the user first. There's a reason that another word to refer to them is [**user agent**](https://wikipedia.org/wiki/User_agent)...

Sadly, this time has passed. The majority of browser marketshare is now controlled by Google, an ad surveillance company. In all fairness to Google, they **do** put their customers first - it's just that their customers are the advertisers they siphon data to, not users like you and me. And this is the company behind the engine powering nearly every modern web browser in the world. Talk about a conflict of interest...

Unfortunately, most ot the competition is no better - Just take a look at [Microsoft & the 800 ad companies they share your data with](https://proton.me/blog/outlook-is-microsofts-new-data-collection-service)...

It doesn't have to be this way.

# 🚀Install

> [!IMPORTANT]
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first run with Phoenix installed. **This ensures all of Phoenix's changes are applied...**

Phoenix currently provides official support for:

* **Android**
* **Arch Linux**
* **Debian** *(& derivatives...)*
* **Fedora Linux** *(39-41)*
* **macOS**
* **Ubuntu** *(& derivatives...)*

> [!IMPORTANT]
> ⚠️ **macOS users must have [Homebrew](https://brew.sh/) installed, and must grant Terminal the `App Management` Permission.**

> [!IMPORTANT]
> ⚠️ **Flatpak & Snap packages of Firefox are currently not supported.**

Other platforms have unfortunately proven difficult to support, though progress **is** being made. Contributions are always welcome and appreciated.

**If your platform is supported *(with the exception of Android)*, simply run the following command in your terminal to install Phoenix:**

```sh
sudo bash -c "$(wget -O- https://phoenix.celenity.dev/install.sh 2>/dev/null)"
```

> [!IMPORTANT]
> **Android users are recommended to install [IronFox](https://gitlab.com/ironfox-oss/IronFox) *(Recommended)*, which uses Phoenix for its configs. Android users can also manually install Phoenix for any Firefox-based browser on Android via the directions [here](https://phoenix.celenity.dev/android).**

**If you would like to use Phoenix on any other unsupported platform, see [📛Manual Installation](#manual-installation).**

___

# 👋Uninstall

If Phoenix isn't right for you - no worries!

**Simply run the following command in your terminal to uninstall Phoenix:**

```sh
sudo bash -c "$(wget -O- https://phoenix.celenity.dev/uninstall.sh 2>/dev/null)"
```

Please [leave us feedback](https://phoenix.celenity.dev/issues) on the way out, so we can improve for the future!

___

# 🔥Extended

For advanced users who would like to go above & beyond when protecting their privacy & security, at the cost of occasional breakage, Phoenix offers an **Extended** config.

> [!TIP]
> **Unlike Phoenix's standard default configuration, Extended is profile-specific.** This means that you can use our Extended config as needed when you desire the extra protection, & revert back to Phoenix's standard config through another profile for everything else.

Personally, if you're up for it, I would highly recommend trying out the Extended config, and setting overrides as needed.

> [!TIP]
> Phoenix makes it very easy to set overrides through your `about:config`. No more manual `override` files! ;)

You can see [here](https://phoenix.celenity.dev/compat#hardened) for a list of known sites that have issues or quirks with Phoenix's **Extended** config, and what you need to toggle to fix them.

## Extended Installation

**1:** Install Phoenix via the script for your platform of choice above.

**2:** After installation is complete, locate the `Hardened` user.js file on your device.

Depending on your operating system, it will be located at:

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/hardened/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/hardened/user.js
```

**User**

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/hardened/user.js
```

</details>

<br>

If you use any of the [Firefox-UI-Fix](https://github.com/black7375/Firefox-UI-Fix) CSS skins with Firefox, you should instead use use the `user.js` file at the following locations:

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/ui-fix/hardened/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/hardened/user.js
```

**User**

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/ui-fix/hardened/user.js
```

</details>

<br>

**3:** Find your Firefox profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will be different, and you should replace this path on the next step with your actual profile directory's path.**

**4:** Simply move *(or copy & paste)* your `user.js` file to your profile's directory! You can either drag and drop it manually, or run the command below. For example's sake, we'll say our user.js is located at `/etc/firefox/phoenix/userjs/hardened/user.js`. **Yours may be different, and you should replace this path on the next step with the actual location of your user.js as described above.**

```sh
cp /etc/firefox/phoenix/userjs/hardened/user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js
```

> [!IMPORTANT] 
> ⚠️ **macOS (User) users must edit the `user.js` file and replace `phoenix-osx` with `phoenix-osx-user`. This will be simplified & handled better in the future.**

Congratulations, you're done. Similar to the rest of the Phoenix project, your Extended config will automatically update with the rest of Phoenix via your package manager, and you can set any overrides you wish through the about:config. You can just sit back, relax, and enjoy.

# 💡Specialized Configs

It should also be noted that Phoenix contains specialized configurations for **Discord**, **Twitter**, and **YouTube**. These configs are designed to be used in their own, separate Firefox profile, and provide means to safely and easily use these privacy-invasive services.

The installation of these configs is the same as `Extended`, with the only exception being the location of the `user.js` file. **You can find the location of these user.js files at the following locations:**

**<details><summary>Discord</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/discord/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/discord/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/discord/user.js
```

</details>

</details>

**<details><summary>Discord (Firefox-UI-Fix)</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/ui-fix/discord/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/discord/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/ui-fix/discord/user.js
```

</details>

</details>

**<details><summary>Element</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/element/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/element/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/element/user.js
```

</details>

</details>

**<details><summary>Element (Firefox-UI-Fix)</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/ui-fix/element/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/element/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/ui-fix/element/user.js
```

</details>

</details>

**<details><summary>Twitter</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/twitter/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/twitter/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/twitter/user.js
```

</details>

</details>

**<details><summary>Twitter (Firefox-UI-Fix)</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/ui-fix/twitter/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/twitter/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/ui-fix/twitter/user.js
```

</details>

</details>

**<details><summary>Twitter</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/twitter/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/twitter/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/twitter/user.js
```

</details>

</details>

**<details><summary>YouTube</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/youtube/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/youtube/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/youtube/user.js
```

</details>

</details>

**<details><summary>YouTube (Firefox-UI-Fix)</summary>**

**<details><summary>GNU/Linux</summary>**

```sh
/etc/firefox/phoenix/userjs/ui-fix/youtube/user.js
```

</details>

**<details><summary>macOS</summary>**

**System**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/youtube/user.js
```

**User**:

```sh
/opt/homebrew/opt/phoenix-osx-user/userjs/macos/ui-fix/youtube/user.js
```

</details>

</details>

# 📛Manual Installation

> [!CAUTION] 
>**This is NOT recommended for most users.**

By default, Phoenix is installed & updated via your operating system's package manager. This allows for fast, easy updates & fixes as needed, right with the rest of your system!

However, if this is not desirable for you & your situation, or you would simply like to use Phoenix on an unsupported operating system, you can manually install Phoenix with the following steps:

**1:** Download `phoenix.cfg` from [here](https://phoenix.celenity.dev/phoenix.cfg). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/phoenix.cfg
```

**2:** Download `phoenix.js` from [here](https://phoenix.celenity.dev/prefs/phoenix-desktop.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/prefs/phoenix-desktop.js
```

**3:** Download `policies.json` from [here](https://phoenix.celenity.dev/policies.json). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/policies.json
```

**4:** Locate your Firefox installation directory. This will vary depending on your platform. An easy way to find it id by navigating to `about:support` & checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/firefox/firefox` next to `Application Binary`. This means our installation directory is `/usr/lib64/firefox`.

> [!CAUTION]
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command, assuming `/usr/lib64/firefox` is your installation directory:

```sh
sudo cp phoenix.cfg /usr/lib64/firefox/phoenix.cfg
```

**6:** **For macOS & Flatpak users**: If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. You can do this manually through your file explorer, or assuming `/usr/lib64/firefox` is your installation directory *(it won't be)*, you could run the following command:

```sh
sudo mkdir -p /usr/lib64/firefox/defaults/pref
```

**For GNU/Linux users:** If it does not already exist, you will want to create a folder named `firefox` located in your system's `etc` directory. Inside this `firefox` folder, create a new folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. This will work **regardless of your distribution** - even Snaps are supported. You can also just run the command below:

```sh
sudo mkdir -p /etc/firefox/defaults/pref
```

On macOS & GNU/Linux, you'll also want to ensure that the folder you created has proper permissions:

**For macOS users:** - assuming `/usr/lib64/firefox` is your installation directory *(it won't be)*

```sh
sudo chmod 744 /usr/lib64/firefox/defaults/pref
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo chmod 655 /etc/firefox/defaults/pref
```

**7:** Move `phoenix.js` to the `pref` folder that you just created. Assuming your installation directory is `/usr/lib64/firefox`, you can run the following command:

```sh
sudo cp phoenix.js /usr/lib64/firefox/defaults/pref/phoenix.js
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo cp phoenix.js /etc/firefox/defaults/pref/phoenix.js
```

**8:** On macOS & Windows, in the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or assuming `/usr/lib64/firefox` is your installation directory, you can run the following command:

```sh
sudo mkdir -p /usr/lib64/firefox/distribution
```

GNU/Linux users should **instead** create a `policies` folder inside of a `firefox` folder located in `/etc`. This will work **regardless** of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/firefox/policies
```

On macOS & GNU/Linux, you'll also want to ensure that the folder you created has proper permissions:

**For macOS users:** - assuming `/usr/lib64/firefox` is your installation directory *(it won't be)*

```sh
sudo chmod 744 /usr/lib64/firefox/distribution
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo chmod 655 /etc/firefox/policies
```

**9:** Finally, those on Windows & macOS should move `policies.json` to the `distribution` folder that you just created. Assuming your installation directory is `/usr/lib64/firefox`, you can run the following command:

```sh
sudo cp policies.json /usr/lib64/firefox/distribution/policies.json
```

GNU/Linux users should **instead** move `policies.json` to their `/etc/firefox/policies` folder they just created.

```sh
sudo cp policies.json /etc/firefox/policies/policies.json
```

Congratulations, you're done. Enjoy Phoenix, and be sure to keep up with updates!

___

## 🤔Using Extended or a Specialized Config Manually

With a manual installation of Phoenix, if you would like to use Phoenix's [Extended](#extended) config, or one of our [specialized configs](#specialized-configs), you'll need to follow these steps.

**1:** Download the `.cfg` file of your choice from [here](https://codeberg.org/celenity/Phoenix/src/branch/pages/configs). For this example, we'll use `youtube.cfg`. **Simply replace mentions of `youtube.cfg` below with the configuration you would like to use.**

You can right click and select `Save page as` from your browser on the `.cfg` file, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/configs/youtube.cfg
```

**2:** Store the `.cfg` file you just downloaded somewhere safe that you can remember. For this example, we'll keep it simple and say I chose to save `youtube.cfg` at `~/youtube.cfg`. **Replace mentions of `~/youtube.cfg` below with the actual location of your file.**

You can either drag and drop the file manually, or run the command below:

```sh
mv youtube.cfg ~/youtube.cfg
```

**3:** Download the `user.js` file located [here](https://phoenix.celenity.dev/user.js).

You can right click and select `Save page as` from your browser on the `user.js` file, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/user.js
```

**4:** Edit the `user.js` file you just downloaded, and replace **file://`put_your_cfg_file_location_here`** with the location of your `.cfg` file from Step 2.

Assuming our file is still located at `~/youtube.cfg` and our username is `user`, we'll change the contents of the `user.js` file we downloaded to:

```sh
user_pref("autoadmin.global_config_url", "file:///home/user/youtube.cfg");
```

**5:** Find your Firefox profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will be different, and you should replace this path on the next step with your actual profile directory's path.**

**6:** Simply move *(or copy & paste)* your `user.js` file to your profile's directory! You can either drag and drop it manually, or run the command below. For example's sake, we'll say our user.js is located at `~/Downloads/user.js`. **If this is not the path of your downloaded `user.js` file from Step 3, replace it with its actual location.**

```sh
mv ~/Downloads/user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js
```

# 💜Attribution

Huge thank you to the following projects & individuals for making Phoenix possible. Please show them support!

- **[Seyed Mohamad Amin Modaresi](https://codeberg.org/gnu1)**
	- Designed Phoenix's icon, created the install & uninstall scripts, assisted with README formatting, provided general advice & support, and responsible for various other significant contributions to the project.

- **[GW72](https://codeberg.org/GW72)**
	- Invaluable feedback & support of the project.

- **[Arkenfox](https://github.com/arkenfox/user.js)**
	- 🪪 [Thorin-Oakenpants](https://github.com/thorin-oakenpants) + [earthlng](https://github.com/earthlng) + [claustromaniac](https://github.com/claustromaniac)
	- ⚖️ [MIT](https://github.com/arkenfox/user.js/blob/master/LICENSE.txt)
	- Discovered various prefs - Also learned lots from their excellent research & documentation

- **[Betterfox](https://github.com/yokoffing/Betterfox)**
	- 🪪 [yokoffing](https://github.com/yokoffing)
	- ⚖️ [MIT](https://github.com/yokoffing/Betterfox/blob/main/LICENSE)
    - 💸 [Donate](https://github.com/sponsors/yokoffing)
    - Various performance-related prefs

- **[Narsil's mozilla.cfg](https://codeberg.org/Narsil/mozilla.cfg)**
	- 🪪 [Narsil](https://codeberg.org/Narsil)
	- ⚖️ [GPLv3](https://codeberg.org/Narsil/mozilla.cfg/src/branch/master/LICENSE.txt)
	- Certain prefs & some inspiration

- **[Brace](https://codeberg.org/divested/brace)**
	- 🪪 [Divested Computing Group](https://divested.dev/)
	- ⚖️ [GPLv3](https://codeberg.org/divested/brace/src/branch/master/LICENSE)
	- 💸 [Donate](https://divested.dev/pages/donate)
	- Where I first learned of the idea to leverage policies & package them... + inspiration

- **[LibreWolf](https://librewolf.net/)**
	- 🪪 [bgstack15](https://codeberg.org/bgstack15) + [fxbrit](https://codeberg.org/fxbrit) + [Malte Jürgens](https://codeberg.org/maltejur) + [ohfp](https://codeberg.org/ohfp) + [James McClain](https://codeberg.org/TheGreatMcPain) + [threadpanic](https://codeberg.org/threadpanic) + [Guillaume](https://codeberg.org/ltguillaume)
	- ⚖️ [MPL-2.0](https://codeberg.org/librewolf/settings/src/branch/master/LICENSE.txt)
	- Inspiration + certain preferences & policies

- **[firefox-config](https://codeberg.org/rusty-snake/firefox-config)**
	- 🪪 [rusty-snake](https://codeberg.org/rusty-snake)
	- ⚖️ [CC0](https://codeberg.org/rusty-snake/firefox-config#license-cc0)
	- Inspiration + certain preferences

- **[mobile-config-firefox](https://gitlab.com/postmarketOS/mobile-config-firefox)**
	- 🪪 [postmarketOS](https://postmarketos.org/)
	- ⚖️ [MPL-2.0](https://gitlab.com/postmarketOS/mobile-config-firefox/-/blob/master/LICENSE)
	- 💸 [Donate](https://opencollective.com/postmarketOS)
	- Inspiration

- **[uBlock Origin](https://github.com/gorhill/uBlock)**
	- 🪪 [Raymond Hill](https://github.com/gorhill) + [ItsProfesssional](https://github.com/ItsProfessional) + [MasterKia](https://github.com/MasterKia) + [peace2000](https://github.com/peace2000) + [Peter Lowe](https://pgl.yoyo.org/) + [PiQuark6046](https://github.com/piquark6046) + [stephenhawk8054](https://github.com/stephenhawk8054)
	- ⚖️ [GPLv3](https://github.com/gorhill/uBlock/blob/master/LICENSE.txt)
	- Pre-installed extension - provides content blocking

- **[Quad9](https://quad9.net/)**
	- 🪪 [Quad9 Team](https://quad9.net/about/team/)
	- 💸 [Donate](https://www.quad9.net/donate/)
	- Default DNS Over HTTPS Resolver

And of course...

- **[Firefox](https://mozilla.org/firefox)**
	- 🪪 [Mozilla](https://www.mozilla.org/)
	- ⚖️ [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- 💸 [Donate](https://foundation.mozilla.org/donate/)
