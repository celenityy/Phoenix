# 🔒 Locking Preferences

The goal of this wiki page is to define a clear criteria for determining when to 'lock' certain preferences and functionality and when not to.

Locking a setting serves the main purpose of preventing a user from easily changing it. Advanced users can still override the desired setting (via means such as creating their own custom config file), though this is not recommended or supported.

This is something I've long struggled with since starting the project. We want to not only preserve, but enhance privacy & security of Firefox - while still preserving & also enhancing the freedom of users to control their browsing experience.

Generally speaking, I believe we should take the following into consideration:

* Is it related to telemetry/data collection? If so, it should be locked.

* Does it pose a detrimental risk to privacy and/or security? If so, it should be locked.

One of the main goals of Phoenix is to **prevent** users from having to dig around and use custom 'override' files like this. Phoenix is supposed to be easy and accessible to use - so where viable, users should be able to change functionality via `about:preferences` or the `about:config`.

