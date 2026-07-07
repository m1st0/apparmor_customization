#!/bin/zsh

# Maulik Mistry <mistry01.com>
# Copyright (c) 2025–2026 Maulik Mistry
#
# This project is licensed under the BSD License. See the LICENSE.txt file for details.
#
# If you appreciate my work or help, consider supporting me through donations.
# You can donate via Venmo at https://venmo.com/code?user_id=3319592654995456106&created=1756212520  
# or PayPal at https://www.paypal.com/paypalme/m1st0 

echo "Installing AppArmor customizations..."

# Symlink my_customizations to /etc/apparmor.d/my_customizations which loads the custom profiles boot.
if [ ! -L /etc/apparmor.d/my_customizations ]; then
  sudo ln -s "$(pwd)/load_customizations" /etc/apparmor.d/load_customizations
  echo "Linked load_customizations to /etc/apparmor.d/load_customizations"
else
  echo "/etc/apparmor.d/load_customizations symlink failed."
  exit 1
fi

# Symlink customizations to /etc/apparmor.d/local/my_customizations which are the cutomized profiles.
if [ ! -L /etc/apparmor.d/local/my_customizations ]; then
  sudo ln -s "$(pwd)/customizations" /etc/apparmor.d/local/my_customizations
  echo "Linked customizations to /etc/apparmor.d/local/my_customizations"
else
  echo "/etc/apparmor.d/local/my_customizations symlink failed."
  exit 1
fi

echo "Installation complete. Reloading AppArmor profiles."
sudo apparmor_parser -r /etc/apparmor.d/load_customizationsns
sudo systemctl restart apparmor
sudo systemctl status apparmor


