#!/bin/zsh

# Maulik Mistry <mistry01.com>
# Copyright (c) 2025–2026 Maulik Mistry
#
# This project is licensed under the BSD License. See the LICENSE.txt file for details.
#
# If you appreciate my work or help, consider supporting me through donations.
# You can donate via Venmo at https://venmo.com/code?user_id=3319592654995456106&created=1756212520  
# or PayPal at https://www.paypal.com/paypalme/m1st0 

echo "Removing AppArmor customization symlinks..."

for profile in /etc/apparmor.d/local/my_customizations/*(N); do
    [[ -f "$profile" ]] && sudo apparmor_parser -R "$profile"
done

for link in /etc/apparmor.d/load_customizations /etc/apparmor.d/local/my_customizations; do
  if [ -L "$link" ]; then
    echo "Remove symlink $link? [y/N]"
    read -r answer
    if [[ "$answer" == [Yy]* ]]; then
      sudo rm -rf "$link"
      echo "Removed $link"
    else
      echo "Skipped $link"
    fi
  else
    echo "No symlink found at $link"
  fi
done

echo "Done. Reload AppArmor profiles with:"
echo "  sudo systemctl reload apparmor"

