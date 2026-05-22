# Phoenix Preferences

The following page is meant to serve as documentation
for preferences introduced by Phoenix.
**NOTE**: For any preferences introduced by Phoenix to take effect,
you **MUST** restart the browser.
Additionally, these preferences do **NOT** function on Phoenix for Android,
**with the exception of IronFox**.

## Preferences

- [`browser.phoenix.extended`](#browser-phoenix-extended)
- [`browser.phoenix.FFUIFix`](#browser-phoenix-ffuifix)
- [`browser.phoenix.fingerprintingProtection.global.userOverrides`](#browser-phoenix-fingerprintingprotection-global-useroverrides)
- [`browser.phoenix.fingerprintingProtection.granular.enabled`](#browser-phoenix-fingerprintingprotection-granular-enabled)
  - [`browser.phoenix.fingerprintingProtection.granular.hardenOverrides.enabled`](#browser-phoenix-fingerprintingprotection-granular-hardenoverrides-enabled)
  - [`browser.phoenix.fingerprintingProtection.granular.unbreakOverrides.enabled`](#browser-phoenix-fingerprintingprotection-granular-unbreakoverrides-enabled)
  - [`browser.phoenix.fingerprintingProtection.granular.unbreakTimezoneOverrides.enabled`](#browser-phoenix-fingerprintingprotection-granular-unbreaktimezoneoverrides-enabled)
- [`browser.phoenix.fingerprintingProtection.granular.userOverrides`](#browser-phoenix-fingerprintingprotection-granular-useroverrides)
- [`browser.phoenix.reset.javascript.options.wasm`](#browser-phoenix-reset-javascript-options-wasm)
- [`browser.phoenix.reset.network.http.referer.XOriginPolicy`](#browser-phoenix-reset-network-http-referer-xoriginpolicy)
- [`browser.phoenix.reset.webgl.disabled`](#browser-phoenix-reset-webgl-disabled)
- [`browser.phoenix.reset.xpinstall.enabled`](#browser-phoenix-reset-xpinstall-enabled)
- [`browser.phoenix.trr.autoBootstrap`](#browser-phoenix-trr-autobootstrap)
  - [`browser.phoenix.trr.autoBootstrap.useFallback`](#browser-phoenix-trr-autobootstrap-usefallback)

### browser.phoenix.extended

```javascript
browser.phoenix.extended
```

**Type**: `Boolean`

**Default**: `false`

If `true`, Phoenix configures additional preferences to maximize privacy and security, at the cost of breakage/unintended behavior for some users.

Preferences configured by `browser.phoenix.extended` can still be individually overriden by users if desired, regardless of `browser.phoenix.extended`'s value.

### browser.phoenix.FFUIFix

```javascript
browser.phoenix.FFUIFix
```

**Type**: `Boolean`

**Default**: `false`

If `true`, Phoenix configures preferences to support the [`Firefox-UI-Fix`](https://github.com/black7375/Firefox-UI-Fix) CSS skin.

**NOTE**: This preference is not supported on Android.

### browser.phoenix.fingerprintingProtection.global.userOverrides

```javascript
browser.phoenix.fingerprintingProtection.global.userOverrides
```

**Type**: `String`

**Default**: ` `

This preference contains a list of global overrides for Phoenix's fingerprinting protection. **Targets specified here always take priority over default targets from Phoenix and Mozilla**.

A list of possible targets to override can be found [here](https://searchfox.org/firefox-main/source/toolkit/components/resistfingerprinting/RFPTargets.inc).

For an example of how this preference's value should be formatted:

```javascript
+ProtectionIWantToEnableGlobally,-ProtectionIWantToDisableGlobally
```

### browser.phoenix.fingerprintingProtection.granular.enabled

```javascript
browser.phoenix.fingerprintingProtection.granular.enabled
```

**Type**: `Boolean`

**Default**: `true`

If `false`, Phoenix will disable **all** default granular _(per-site)_ fingerprinting protection overrides. This includes overrides from **both** Phoenix and Mozilla. Overrides specified at `browser.phoenix.fingerprintingProtection.granular.userOverrides` are **not** impacted by this preference.

**NOTE**: Setting this to `false` is **not** recommend, as it **will** cause breakage and degrade your privacy and security.

### browser.phoenix.fingerprintingProtection.granular.hardenOverrides.enabled

```javascript
browser.phoenix.fingerprintingProtection.granular.hardenOverrides.enabled
```

**Type**: `Boolean`

**Default**: `true`

If `true`, Phoenix enables fingerprinting protection overrides to **strengthen** protection for certain websites.

**NOTE**: Setting this preference to `false` is **not** recommend, as it **will** degrade your privacy and security.

If `browser.phoenix.fingerprintingProtection.granular.enabled` is set to `false`, this preference will **not** take effect.

### browser.phoenix.fingerprintingProtection.granular.unbreakOverrides.enabled

```javascript
browser.phoenix.fingerprintingProtection.granular.unbreakOverrides.enabled
```

**Type**: `Boolean`

**Default**: `true`

If `true`, Phoenix enables fingerprinting protection overrides to **relax** protections for certain websites, in order to resolve breakage and unexpected behavior.

**NOTE**: Setting this to `false` is **not** recommend, as it **will** cause breakage.

If `browser.phoenix.fingerprintingProtection.granular.enabled` is set to `false`, this preference will **not** take effect.

### browser.phoenix.fingerprintingProtection.granular.unbreakTimezoneOverrides.enabled

```javascript
browser.phoenix.fingerprintingProtection.granular.unbreakTimezoneOverrides.enabled
```

**Type**: `Boolean`

**Default**: `true`

If `true`, Phoenix enables fingerprinting protection overrides to disable timezone spoofing for certain websites, in order to resolve breakage and unexpected behavior. This preference is **only** effective if timezone spoofing is enabled.

**NOTE**: Setting this to `false` is **not** recommend, as it **will** cause breakage.

If `browser.phoenix.fingerprintingProtection.granular.enabled` is set to `false`, this preference will **not** take effect.

### browser.phoenix.fingerprintingProtection.granular.userOverrides

```javascript
browser.phoenix.fingerprintingProtection.granular.userOverrides
```

**Type**: `String`

**Default**: ` `

This preference contains a list of granular _(per-site)_ overrides for Phoenix's fingerprinting protection. **Overrides specified here always take priority over default overrides from Phoenix and Mozilla**.

A list of possible targets to override can be found [here](https://searchfox.org/firefox-main/source/toolkit/components/resistfingerprinting/RFPTargets.inc).

For an example of how this preference's value should be formatted:

```javascript
{"firstPartyDomain":"example1.invalid","overrides":"+ProtectionIWantToEnableOnThisWebsite,-ProtectionIWantToDisableOnThisWebsite"},{"firstPartyDomain":"*","thirdPartyDomain":"example2.invalid","overrides":"+ThirdPartyDomainsAreSupportedToo"}
```

### browser.phoenix.reset.javascript.options.wasm

```javascript
browser.phoenix.reset.javascript.options.wasm
```

**Type**: `Boolean`

**Default**: `false`

If `true`, Phoenix will reset the preference to enable WebAssembly _(`javascript.options.wasm`)_ per-session.

### browser.phoenix.reset.network.http.referer.XOriginPolicy

```javascript
browser.phoenix.reset.network.http.referer.XOriginPolicy
```

**Type**: `Boolean`

**Default**: `false`

If `true`, Phoenix will reset the preference to control the cross-origin referer policy _(`network.http.referer.XOriginPolicy`)_ per-session.

### browser.phoenix.reset.webgl.disabled

```javascript
browser.phoenix.reset.webgl.disabled
```

**Type**: `Boolean`

**Default**: `false`

If `true`, Phoenix will reset the preference to disable WebGL _(`webgl.disabled`)_ per-session.

### browser.phoenix.reset.xpinstall.enabled

```javascript
browser.phoenix.reset.xpinstall.enabled
```

**Type**: `Boolean`

Default - **Desktop**: `true`

Default - **Android**: `false`

If `true`, Phoenix will reset the preference to enable add-on installation _(`xpinstall.enabled`)_ per-session.

### browser.phoenix.trr.autoBootstrap

```javascript
browser.phoenix.trr.autoBootstrap
```

**Type**: `Boolean`

**Default**: `true`

If `true`, Phoenix will automatically configure the bootstrap address for DNS over HTTPS _(`network.trr.bootstrapAddr`)_, depending on the currently configured provider.

**NOTE**: When this setting is enabled, a browser restart is required upon changing DNS over HTTPS providers.

### browser.phoenix.trr.autoBootstrap.useFallback

```javascript
browser.phoenix.trr.autoBootstrap.useFallback
```

**Type**: `Boolean`

**Default**: `false`

If `true`, for supported DNS over HTTPS providers, Phoenix will set the bootstrap address to that of the secondary/fall-back DNS server, instead of the primary DNS server.

**NOTE**: This preference does nothing if `browser.phoenix.trr.autoBootstrap` is set to `false`.
