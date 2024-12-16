# Phoenix

**Phoenix is a suite of configurations & advanced modifications for Mozilla Firefox, designed to put the user first.** 

It is not a simple user.js like you might expect - but it is not a fork either. It is installed on top of your standard Firefox installation.

**Phoenix strives to create the best browsing experience possible, and does so through significantly hardening user privacy & security, and protecting user freedom.** We also include various other QOL tweaks, performance enhancements, & nice-to-have features where possible.

> [!IMPORTANT]
>**⚠️ All users are HIGHLY RECOMMENDED to check out our Wiki [here](https://phoenix.celenity.dev/wiki), especially the [Important](https://phoenix.celenity.dev/important) & [Limitations](https://phoenix.celenity.dev/limitations) pages!!**

<br>

> [!NOTE]
> This project is hosted on both [Codeberg](https://codeberg.org/celenity/Phoenix) (which will be the primary & preferred place to contribute), & [GitHub](https://github.com/celenityy/Phoenix).

___

# 📖Glossary

**<details><summary>Click me</summary>**

- [Phoenix](#phoenix)
- [📖Glossary](#glossary)
- [💪Motivation](#motivation)
- [⭐Features](#features)
- [🚀Install](#install)
	- [🐧GNU-Linux](#gnu-linux)
	- [🍎macOS](#macos)
	- [🪟Windows](#windows)
- [👋Uninstall](#uninstall)
	- [🐧GNU-Linux](#gnu-linux-1)
	- [🍎macOS](#macos-1)
- [🔥Complete Coverage](#complete-coverage)
- [📛Manual Mode *(Not recommended)*](#manual-mode-not-recommended)
- [💜Attribution](#attribution)

</details>

# 💪Motivation

Believe it or not, in the not so distant past, browsers were designed to put the user first. There's a reason that another word to refer to them is [**user agent**](https://wikipedia.org/wiki/User_agent)...

Sadly, this time has passed. The majority of browser marketshare is now controlled by Google, an ad surveillance company. In all fairness to Google, they **do** put their customers first - it's just that their customers are the advertisers they siphon data to, not users like you and me. And this is the company behind the engine powering nearly every modern web browser in the world. Talk about a conflict of interest...

Unfortunately, most ot the competition is no better - Just take a look at [Microsoft & the 800 ad companies they share your data with](https://proton.me/blog/outlook-is-microsofts-new-data-collection-service)...

But it doesn't have to be this way.

# ⭐Features

See [here](https://phoenix.celenity.dev/features) for a non-exhaustive list of features & enhancements Phoenix provides.

You should also check out our [Comparison table](https://phoenix.celenity.dev/compare), so that you can see what Phoenix offers and how it compares to similar projects in the space.

# 🚀Install

Phoenix offers easy to use install scripts for various platforms. All you have to do is have Firefox installed & ready, paste the command that corresponds to your platform of choice in your terminal, and you should be good to go. :)

## 🐧GNU-Linux

> [!IMPORTANT] 
> **⚠️ Firefox Flatpak & Snap packages are currently not supported.**

> [!NOTE]
> Phoenix only supports 39, 40 and 41 versions of Fedora.

```sh
sudo bash -c "$(curl -fsSL https://phoenix.celenity.dev/install.sh)"
```

</details>

___

## 🍎macOS

> [!IMPORTANT] 
> ⚠️ **You must have [Homebrew](https://brew.sh/) installed, and you must grant Terminal the `App Management` Permission.**

```sh
bash -c "$(curl -fsSL https://phoenix.celenity.dev/install.sh)"
```

___

## 🪟Windows

See Codeberg issue [here](https://codeberg.org/celenity/Phoenix/issues/3) & GitHub issue [here](https://github.com/celenityy/Phoenix/issues/1)

**HELP WANTED!!**

___

# 👋Uninstall

If Phoenix isn't right for you - no worries! We also have easy to use uninstall scripts. Please be sure to [leave us feedback](https://phoenix.celenity.dev/issues) though so we can improve for the future!

## 🐧GNU-Linux

```sh
sudo bash -c "$(curl -fsSL https://phoenix.celenity.dev/uninstall.sh)"
```

</details>

___

## 🍎macOS

```sh
bash -c "$(curl -fsSL https://phoenix.celenity.dev/uninstall.sh)"
```

___

# 🔥Complete Coverage

Out of the box, [Phoenix in its 'base' configuration is already substantially hardened compared to vanilla Firefox & most of its derivatives](https://phoenix.celenity.dev/compare).

However, we make it a point to balance privacy, security, & usability. We try to avoid breakage where possible.

If you're an advanced user, and would like to go the extra mile, at the cost of mild breakage & a little headache, you can install our **Hardened** config.

> [!TIP]
> **Unlike our base config, Hardened is profile specific.** This means that you can use our hardened config as needed when you desire the extra protection, & revert back to our base through another profile for everything else. 

Personally, if you're up for it, I would highly recommend trying out the Hardened config, and setting overrides as needed 

> [!TIP] 
> *Phoenix makes it very easy to set overrides through your `about:config`* 

You can see [here](https://phoenix.celenity.dev/compat#hardened) for a list of known sites with issues & what you need to toggle to fix them. 

> [!CAUTION] 
> **This is not for everyone though, and if you want a 'just works' set-up with no issues or tweaking, just stick to the base config.**

To install **Hardened**

**1:** Install Phoenix like usual, via the script for your platform of choice above.

**2:** Locate the `Hardened` user.js file on your device.

**For GNU/Linux users**, it is located at:
```sh
/etc/firefox/phoenix/userjs/hardened/user.js
```

**For macOS users**, it is located at:
```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/hardened/user.js
```

If you use any of the [Firefox-UI-Fix](https://github.com/black7375/Firefox-UI-Fix) CSS skins, you should instead use use the `user.js file at the following location: 

**For GNU/Linux users**:
```sh
/etc/firefox/phoenix/userjs/ui-fix/hardened/user.js
```

**For macOS users**:
```sh
/opt/homebrew/opt/phoenix-osx/userjs/macos/ui-fix/hardened/user.js
```

**3:** Find your profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will probably be different, and you should replace this path on the next step with your actual profile directory's path.**

**4:** Simply move *(or copy & paste)* your user.js to your profile's directory! You can either drag and drop it manually, or run the command below. For example's sake, we'll say our user.js is located at `/etc/firefox/phoenix/userjs/hardened/user.js`. **Yours may be different, and you should replace this path on the next step with the actual location of your user.js as described above.**

```sh
mv /etc/firefox/phoenix/userjs/hardened/user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js
```

Congratulations, you're done. Similar to the rest of the Phoenix project, your hardened config will automatically update with the rest of Phoenix via your package manager, and you can set any overrides you wish through the about:config. You can just sit back, relax, & enjoy.

# 📛Manual Mode *(Not recommended)*

By default, Phoenix is installed by your operating system's package manager. This allows for fast, easy updates & fixes as needed, right with the rest of your system!

> [!CAUTION] 
>**This is the set-up we would highly recommend most users stick to if possible.**

However, if this is not desirable for you & your situation, or you would simply like to use Phoenix on an unsupported platform, you can manually install Phoenix with the following steps:

**1:** Download our `phoenix.cfg` file from [here](https://phoenix.celenity.dev/phoenix.cfg). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

```sh
wget https://phoenix.celenity.dev/phoenix.cfg
```

**2:** Download `phoenix.js` from [here](https://phoenix.celenity.dev/defaults/pref/phoenix.js). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal: 

```sh
wget https://phoenix.celenity.dev/defaults/pref/phoenix.js
```

**3:** Download `policies.json` from [here](https://phoenix.celenity.dev/policies.json). You can right click and select `Save page as` from your browser, or you can run the following command in your terminal:

```sh
wget https://phoenix.celenity.dev/policies.json
```

**4:** Locate your Firefox installation directory. This will vary depending on your platform, you can generally find it by navigating to `about:support` & checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/firefox/firefox` next to `Application Binary`. This means our installation directory is `/usr/lib64/firefox`.

> [!CAUTION] 
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this path on the following steps with your actual installation directory's path.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command, assuming `/usr/lib64/firefox` is your installation directory:

```sh
sudo mv phoenix.cfg /usr/lib64/firefox/phoenix.cfg
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
sudo mv phoenix.js /usr/lib64/firefox/defaults/pref/phoenix.js
```

**For all non-Flatpak GNU/Linux users:**
```sh
sudo mv phoenix.js /etc/firefox/defaults/pref/phoenix.js
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
sudo mv policies.json /usr/lib64/firefox/distribution/policies.json
```

GNU/Linux users should **instead** move `policies.json` to their `/etc/firefox/policies` folder they just created.

```sh
sudo mv policies.json /etc/firefox/policies/policies.json
```

Congratulations, you're done. Enjoy Phoenix, and be sure to keep up with updates!

___

# 💜Attribution

Huge thank you to the following projects & individuals for making Phoenix possible. Please show them support!

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

- **[Chrome Mask](https://github.com/denschub/chrome-mask)**
	- 🪪 [Dennis Schubert](https://github.com/denschub)
	- ⚖️ [MIT](https://raw.githubusercontent.com/denschub/chrome-mask/main/LICENSE)
	- 💸 [Donate](https://ko-fi.com/denschub)
	- Pre-installed extension

- **[Quad9](https://quad9.net/)**
	- 🪪 [Quad9 Team](https://quad9.net/about/team/)
	- 💸 [Donate](https://www.quad9.net/donate/)
	- Default DNS Over HTTPS Resolver

And of course...

- **[Firefox](https://mozilla.org/firefox)**
	- 🪪 [Mozilla](https://www.mozilla.org/)
	- ⚖️ [MPL-2.0](https://www.mozilla.org/foundation/licensing/)
	- 💸 [Donate](https://foundation.mozilla.org/donate/)

[gnu-linux]: #-gnulinux-
