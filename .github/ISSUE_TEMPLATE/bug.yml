name: Bug
description: For any general issues or unexpected/unintended behavior you come across while using Phoenix.
title: "[BUG] PLEASE REPLACE THIS TEXT WITH A SUMMARY OF YOUR ISSUE..."
labels: ["bug"]
assignees:
  - celenity
  - celenityy
body:
  - type: textarea
    id: version
    attributes:
      label: What version of Phoenix are you using?
      description: |
        An easy way to tell is by checking the value of `browser.phoenix.version` in your `about:config`.
    validations:
      required: true

  - type: textarea
    id: browser
    attributes:
      label: What version of Firefox are you using with Phoenix?
      description: |
        An easy way to tell is by checking the value besides `Version` on `about:support`.
    validations:
      required: true

  - type: dropdown
    id: platform
    attributes:
      label: What operating system are you experiencing this issue on?
      description: |
        If your operating system is not listed, please select `Other` and enter its name in the comment field below. **Note that operating systems other than what's listed below are only supported on a best case basis.**
      multiple: true
      options:
        - Android
        - Arch Linux
        - Debian
        - Fedora Linux
        - macOS
        - Ubuntu
        - Other
    validations:
      required: true
  - type: input
    id: other
    attributes:
      label: Other
    validations:
      required: false

  - type: textarea
    id: reason
    attributes:
      label: Please explain the issue you are experiencing.
      description: |
        Be sure to include as many relevant details as possible! :)
    validations:
      required: true
