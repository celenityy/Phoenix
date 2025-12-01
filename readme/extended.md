# 🔥Extended

For advanced users who would like to go above & beyond when protecting their privacy & security, at the cost of occasional breakage, Phoenix offers an **Extended** config. **For a list of features specific to Phoenix Extended, please see [here](https://phoenix.celenity.dev/extended)**.

> [!TIP]
> **Unlike Phoenix's standard default configuration, Extended is profile-specific.** This means that you can use our Extended config as needed when you desire the extra protection, & revert back to Phoenix's standard config through another profile for everything else.

Personally, if you're up for it, I would highly recommend trying out the Extended config, and setting overrides as needed.

> [!TIP]
> Phoenix makes it very easy to set overrides through your `about:config`. No more manual `override` files! ;)

You can see [here](https://phoenix.celenity.dev/compat#extended) for a list of known sites that have issues or quirks with Phoenix's **Extended** config, and what you need to toggle to fix them.

## Extended Installation

**1:** Install Phoenix via the script for your platform of choice above.

**2:** After installation is complete, locate the `Extended` user.js file on your device.

Depending on your operating system, it will be located at:

**<details><summary>GNU/Linux</summary>**

**Standard**:

```sh
/etc/firefox/phoenix/userjs/extended/user.js
```

**Flatpak**:

```sh
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/extended/user.js
```

</details>

**<details><summary>macOS</summary>**

**Apple Silicon**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/extended/user.js
```

**Intel**:

```sh
/usr/local/opt/phoenix-osx/userjs/extended/user.js
```

</details>

<br>

If you use any of the [Firefox-UI-Fix](https://github.com/black7375/Firefox-UI-Fix) CSS skins with Firefox, you should instead use use the `user.js` file at the following locations:

**<details><summary>GNU/Linux</summary>**

**Standard**:

```sh
/etc/firefox/phoenix/userjs/ui-fix/extended/user.js
```

**Flatpak**:

```sh
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/extended/user.js
```

</details>

**<details><summary>macOS</summary>**

**Apple Silicon**:

```sh
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/extended/user.js
```

**Intel**:

```sh
/usr/local/opt/phoenix-osx/userjs/ui-fix/extended/user.js
```

</details>

<br>

**3:** Find your Firefox profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will be different, and you should replace this path on the next step with your actual profile directory's path.**

**4:** Simply move *(or copy & paste)* your `user.js` file to your profile's directory! You can either drag and drop it manually, or run the command below. For example's sake, we'll say our user.js is located at `/etc/firefox/phoenix/userjs/extended/user.js`. **Yours may be different, and you should replace this path on the next step with the actual location of your user.js as described above.**

```sh
cp /etc/firefox/phoenix/userjs/extended/user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js
```

Congratulations, you're done. Similar to the rest of the Phoenix project, your Extended config will automatically update with the rest of Phoenix via your package manager, and you can set any overrides you wish through the about:config. You can just sit back, relax, and enjoy.
