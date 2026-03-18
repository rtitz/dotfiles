#!/bin/zsh
set -euo pipefail

# Provide the hostname here or export before running.
: "${newHostname:?newHostname is not set. Export or set newHostname before running. Example: newHostname=My-Macbook ./set-hostname.zsh}"

# Basic validation (1-63 chars, letters/numbers/hyphen, cannot start/end with hyphen)
if [[ ! "$newHostname" =~ ^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$ ]]; then
  echo "ERROR: newHostname '$newHostname' is invalid." >&2
  exit 2
fi

echo "Setting hostname to: $newHostname"

sudo scutil --set HostName "$newHostname"
sudo scutil --set ComputerName "$newHostname"
sudo scutil --set LocalHostName "$newHostname"

echo "Current kernel hostname:"
hostname

echo "scutil values:"
scutil --get HostName || echo "(HostName not set)"
scutil --get ComputerName || echo "(ComputerName not set)"
scutil --get LocalHostName || echo "(LocalHostName not set)"

# Show local subnet name if available
sudo systemsetup -getlocalsubnetname || true

# Enable Remote Login (SSH)
sudo systemsetup -setremotelogin on

# Enable TouchID for sudo in Terminal
sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

# Install Git
sudo xcode-select --install

echo "Done."
