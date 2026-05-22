# 🔥 Extended

For advanced users who would like to go above & beyond when protecting their
privacy & security, at the cost of occasional breakage, Phoenix offers an
**Extended** configuration. For a [list of features specific to Phoenix Extended,
please see here](https://phoenix.celenity.dev/extended).

> [!TIP]
> **Unlike Phoenix's standard default configuration, Extended is
> profile-specific.** This means that you can use the Extended config as needed
> when you desire the extra protection, and revert back to Phoenix's standard
> config through another profile for everything else.

Personally, if you're up for it, I would highly recommend trying out the
Extended config, and setting overrides as needed.

> [!TIP]
> Phoenix makes it very easy to set overrides through your
> `about:config`. No more manual `override` files!)

You can see for a
[list of known sites that have issues or quirks](https://phoenix.celenity.dev/compat#extended)
with Phoenix **Extended**, and what you need to toggle to fix them.

**To enable Phoenix Extended**, simply set the **`browser.phoenix.extended`**
preference to **`true`** from [`about:config`](about:config),
and restart the browser.

If preferred, you can also enable Phoenix Extended with a `user.js` file:

```js
user_pref(“browser.phoenix.extended”, true);
```
