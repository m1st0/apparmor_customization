#!/usr/bin/env zsh
# SPDX-FileCopyrightText: Copyright (c) 2025-2026 Maulik Mistry
# SPDX-License-Identifier: Apache-2.0
#
# install.zsh - Install customized AppArmor setup.
#
# Author: Maulik Mistry
# Please share support: https://www.paypal.com/paypalme/m1st0
#                       https://venmo.com/code?user_id=3319592654995456106&created=1753283702


SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/vendor/tput_shell_colorize/tput_shell_colorize.sh"

messenger_std "Installing AppArmor customizations..."

# Link the AppArmor customization loader.
loader="/etc/apparmor.d/load_customizations"
if [[ ! -L "$loader" ]]; then
  if sudo ln -s "$SCRIPT_DIR/load_customizations" "$loader"; then
    messenger_std "Linked load_customizations."
  else
    messenger_end "Failed to link load_customizations."
    exit 1
  fi
else
  messenger_std "AppArmor customization loader already exists: $loader"
fi

# Link the custom profile directory.
custom_dir="/etc/apparmor.d/local/my_customizations"
if [[ ! -L "$custom_dir" ]]; then
  if sudo ln -s "$SCRIPT_DIR/customizations" "$custom_dir"; then
    messenger_std "Linked customizations."
  else
    messenger_end "Failed to link customizations."
    exit 1
  fi
else
  messenger_std "AppArmor customization directory already exists: $custom_dir"
fi

# Disable default profiles so custom AppArmor attachments take precedence.
for profile in firefox thunderbird; do
  messenger_std "Disable default AppArmor profile for $profile? [y/N]"
  read -r answer

  if [[ "$answer" == [Yy]* ]]; then
    if sudo aa-disable "/etc/apparmor.d/$profile"; then
      messenger_std "Disabled $profile."
    else
      messenger_std "Failed to disable $profile."
    fi
  else
    messenger_std "Skipped $profile."
  fi
done

messenger_std "Loading AppArmor customizations..."
sudo apparmor_parser -r "$loader" || exit 1

messenger_std "Reloading AppArmor profiles."
sudo apparmor_parser -r /etc/apparmor.d/load_customizations
sudo systemctl restart apparmor
sudo systemctl status apparmor
messenger_end "AppArmor custom setup complete. May need system restart."
