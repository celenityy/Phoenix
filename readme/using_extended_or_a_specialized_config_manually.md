## 🤔Using Extended or a Specialized Config Manually

With a manual installation of Phoenix, if you would like to use Phoenix's [Extended](#extended) config, or one of our [specialized configs](#specialized-configs), you'll need to follow these steps.

**1:** Download the `.cfg` file of your choice for your platform:

- Linux: [See here](https://gitlab.com/celenity/Phoenix/-/tree/pages/linux/configs).
- macOS: [See here](https://gitlab.com/celenity/Phoenix/-/tree/pages/macos/configs).
- Windows: [See here](https://gitlab.com/celenity/Phoenix/-/tree/pages/windows/configs).

 from [here](https://gitlab.com/celenityy/Phoenix/-/tree/pages/configs). For this example, we'll use `youtube.cfg`. **Simply replace mentions of `youtube.cfg` below with the configuration you would like to use.**

You can right click and select `Save page as` from your browser on the `.cfg` file, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Phoenix/-/raw/pages/configs/youtube.cfg
```

**2:** Store the `.cfg` file you just downloaded somewhere safe that you can remember. For this example, we'll keep it simple and say I chose to save `youtube.cfg` at `~/youtube.cfg`. **Replace mentions of `~/youtube.cfg` below with the actual location of your file.**

You can either drag and drop the file manually, or run the command below:

```sh
cp youtube.cfg ~/youtube.cfg
```

**3:** Download the `user.js` file located [here](https://gitlab.com/celenityy/Phoenix/-/raw/pages/user.js).

You can right click and select `Save page as` from your browser on the `user.js` file, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Phoenix/-/raw/pages/user.js
```

**4:** Edit the `user.js` file you just downloaded, and replace **file://`put_your_cfg_file_location_here`** with the location of your `.cfg` file from Step 2.

Assuming our file is still located at `~/youtube.cfg` and our username is `user`, we'll change the contents of the `user.js` file we downloaded to:

```sh
user_pref("autoadmin.global_config_url", "file:///home/user/youtube.cfg");
```

**5:** Find your Firefox profile's directory. This depends on your platform, but an easy way to find it is by navigating to `about:profiles`, and it'll be the path listed beside **Root Directory**. For example's sake, we'll say our profile's directory is `/home/user/.mozilla/firefox/153acxao.default-release`. **Yours will be different, and you should replace this path on the next step with your actual profile directory's path.**

**6:** Simply copy & paste your `user.js` file to your profile's directory! You can either drag and drop it manually, or run the command below. For example's sake, we'll say our user.js is located at `~/Downloads/user.js`. **If this is not the path of your downloaded `user.js` file from Step 3, replace it with its actual location.**

```sh
cp ~/Downloads/user.js /home/user/.mozilla/firefox/153acxao.default-release/user.js
```
