#!/usr/bin/env bash
set -euo pipefail

echo "Docker Desktop full uninstall script for macOS"
echo "Date: 2026-05-01"
echo

confirm() {
  local prompt="$1"
  read -r -p "$prompt [y/N]: " resp
  case "$resp" in
    [yY][eE][sS]|[yY]) return 0 ;;
    *) return 1 ;;
  esac
}

# Quit Docker processes
if pgrep -f Docker >/dev/null 2>&1; then
  echo "Stopping Docker processes..."
  pkill -f Docker || true
  sleep 1
fi

# 1) Homebrew uninstall
if command -v brew >/dev/null 2>&1; then
  if brew list --cask --versions docker >/dev/null 2>&1 || brew list --versions docker >/dev/null 2>&1; then
    if confirm "Uninstall Docker via Homebrew (if present)?"; then
      brew uninstall --cask docker 2>/dev/null || true
      brew uninstall docker docker-compose docker-machine 2>/dev/null || true
      echo "Homebrew uninstall attempted."
    fi
  fi
fi

# 2) App bundle
if [ -d "/Applications/Docker.app" ] || [ -d "$HOME/Applications/Docker.app" ]; then
  if confirm "Remove Docker.app from /Applications and ~/Applications?"; then
    sudo rm -rf /Applications/Docker.app 2>/dev/null || true
    rm -rf "$HOME/Applications/Docker.app" 2>/dev/null || true
    echo "Docker.app removed."
  fi
fi

# 3) CLI binaries
if confirm "Remove Docker CLI binaries from /usr/local/bin (docker, docker-compose, com.docker.cli, docker-credential-*)?"; then
  sudo rm -f /usr/local/bin/docker \
               /usr/local/bin/docker-compose \
               /usr/local/bin/docker-credential-desktop \
               /usr/local/bin/docker-credential-osxkeychain \
               /usr/local/bin/com.docker.cli 2>/dev/null || true
  echo "CLI binaries removed."
fi

# 4) User files and containers
if confirm "Remove Docker user files (~/.docker, ~/Library/Group Containers/group.com.docker, ~/Library/Containers/com.docker.* and related)?"; then
  rm -rf ~/.docker 2>/dev/null || true
  rm -rf ~/Library/Group\ Containers/group.com.docker 2>/dev/null || true
  rm -rf ~/Library/Containers/com.docker.* 2>/dev/null || true
  rm -rf ~/Library/Application\ Support/Docker\ Desktop 2>/dev/null || true
  rm -rf ~/Library/Preferences/com.docker.* 2>/dev/null || true
  rm -rf ~/Library/Logs/com.docker.* 2>/dev/null || true
  rm -rf ~/Library/Saved\ Application\ State/com.electron.docker-frontend.savedState 2>/dev/null || true
  rm -rf ~/Library/Preferences/com.electron.docker-frontend.plist 2>/dev/null || true
  rm -f ~/Library/LaunchAgents/com.docker.* 2>/dev/null || true
  echo "User files removed."
fi

# 5) System files (requires sudo)
if confirm "Remove system files (requires sudo): /var/lib/docker, /var/run/docker.sock, /Library/PrivilegedHelperTools, /Library/LaunchDaemons and /var/tmp entries?"; then
  sudo rm -rf /var/lib/docker 2>/dev/null || true
  sudo rm -f /var/run/docker.sock 2>/dev/null || true
  sudo rm -rf /var/tmp/com.docker.* 2>/dev/null || true
  sudo rm -f /Library/LaunchDaemons/com.docker.vmnetd.plist 2>/dev/null || true
  sudo rm -f /Library/PrivilegedHelperTools/com.docker.vmnetd 2>/dev/null || true
  sudo rm -f /Library/PrivilegedHelperTools/com.docker.helper 2>/dev/null || true
  # Remove Docker launch agents and helpers
  rm -f /Library/LaunchDaemons/com.docker.* 2>/dev/null || true
  rm -f /Library/LaunchAgents/com.docker.* 2>/dev/null || true
  echo "System files removed."
fi

# 6) Networking / config files
if confirm "Remove Docker network/config files if present (/etc/docker/daemon.json, /etc/paths.d/docker*)?"; then
  sudo rm -f /etc/docker/daemon.json 2>/dev/null || true
  sudo rm -f /etc/paths.d/docker 2>/dev/null || true
  sudo rm -f /etc/paths.d/docker-cli 2>/dev/null || true
  echo "Network/config files removed."
fi

# 7) Kubernetes data
if confirm "Remove Kubernetes and kube config (~/.kube and Docker's kube data)?"; then
  rm -rf ~/.kube 2>/dev/null || true
  rm -rf ~/Library/Group\ Containers/group.com.docker/kube 2>/dev/null || true
  echo "Kubernetes data removed."
fi

# 8) Optional: search for leftovers
if confirm "Search for large Docker-related leftover paths (will list matches under $HOME and /)?"; then
  echo "Searching common locations (may take a moment)..."
  sudo du -sh /var/lib/docker 2>/dev/null || true
  du -sh ~/.docker 2>/dev/null || true
  du -sh ~/Library/*docker* 2>/dev/null || true
  du -sh /var/tmp/com.docker.* 2>/dev/null || true
  echo "If you see any paths you want removed, delete them manually with caution."
fi

# 9) Final instructions / reboot
echo "Finished. Recommend rebooting manually to fully clear system state."
