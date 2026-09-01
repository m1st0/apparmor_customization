#!/usr/bin/env zsh
# SPDX-FileCopyrightText: Copyright (c) 2025-2026 Maulik Mistry
# SPDX-License-Identifier: Apache-2.0
#
# uninstall.zsh - Remove customized AppArmor setup.
#
# Author: Maulik Mistry
# Please share support: https://www.paypal.com/paypalme/m1st0
#                       https://venmo.com/code?user_id=3319592654995456106&created=1753283702


SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/vendor/tput_shell_colorize/tput_shell_colorize.sh"

custom_profiles=(
  firefox-custom
  firefox-sh
  thunderbird-custom
  thunderbird-sh
  zen-custom
  zen-sh
)

messenger_std "Remove AppArmor customizations installed by this project? [y/N]"
read -r answer

if [[ "$answer" == [Yy]* ]]; then
  messenger_std "Removing AppArmor customizations..."

  for profile in "${custom_profiles[@]}"; do
    local profile_file="/etc/apparmor.d/local/my_customizations/$profile"

    if [[ -f "$profile_file" ]]; then
      sudo apparmor_parser -R "$profile_file"
      sudo rm "$profile_file"
      messenger_std "Removed $profile"
    fi
  done

  if [[ -L /etc/apparmor.d/load_customizations ]]; then
    sudo rm /etc/apparmor.d/load_customizations
    messenger_std "Removed AppArmor customization loader."
  fi

  messenger_std "AppArmor customizations removed."
else
  messenger_end "AppArmor customization removal skipped. Exiting."
  exit 0
fi

# Enable default profiles.
for link in firefox thunderbird; do
  sudo aa-enforce "/etc/apparmor.d/$link"
done

messenger_std "Reloading AppArmor profiles."
sudo systemctl restart apparmor
sudo systemctl status apparmor
messenger_end "AppArmor customization removed. May need system restart."
