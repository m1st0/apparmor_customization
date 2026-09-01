<!--
SPDX-FileCopyrightText: Copyright (c) 2025-2026 Maulik Mistry
SPDX-License-Identifier: Apache-2.0
-->
# AppArmor Setup for Customized Locations for Apps

Installing apps in customized locations triggers some AppArmor policies. This is an example of how to work with customized installs alongside AppArmor.
This repository contains AppArmor profile setups designed for apps in `$HOME/my_applications/application_folder/app` .

Copyright © 2025–2026 Maulik Mistry

This project is licensed under the Apache License 2.0. See the [LICENSE.txt](./LICENSE.txt) file for details.

Please share support: 
- [Paypal](https://www.paypal.com/paypalme/m1st0)
- [Venmo](https://venmo.com/code?user_id=3319592654995456106&created=1753283702)

## Setup and Use

1. Clone this repo and make scripts executable:

    ```
    git clone --recurse-submodules https://github.com/m1st0/apparmor_customization.git  apparmor_customization
    cd apparmor_customization
    ```

    If the project was already cloned without its submodules:

    ```
    git submodule update --init --recursive
    ```

2. Make the desired scripts executable:

    ```
    chmod +x ./unlock_apps.zsh
    chmod +x ./remove_customizations.zsh
    ```

3. Run the applicable script.

## Scripts

- `unlock_apps.zsh` — Sets up the the customized AppArmor profiles and activates them.
- `remove_customizations.zsh` — Unloads customized AppArmor profiles.

