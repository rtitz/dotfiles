# Install macOS

**[BACK](../../README.md)**

## Configure macOS (System settings)
```zsh
newHostname="Renes-Macbook-Air" .bin/configure-hostname-git-touchid.zsh
.bin/configure-timemachine.zsh
```

## Apply macOS-Defaults (User Settings)
```zsh
.bin/macos-defaults-$(whoami)
```

## Install VSCode
```zsh
curl -Lo vscode-darwin-arm64.dmg "https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64-dmg"
open vscode-darwin-arm64.dmg
```

## Install 1Password
 * See: https://1password.com/de/downloads/mac
```zsh
curl -LOJ https://downloads.1password.com/mac/1Password.zip && unzip 1Password.zip && open 1Password\ Installer.app
```
 * After 1Password installation install the Browser extensions: https://1password.com/de/downloads/browser-extension

## Install brew
  * Download the pkg file from https://github.com/Homebrew/brew/releases/latest
  * Execute the pkg file to install brew
  * For more info see: [https://brew.sh](https://brew.sh)

```zsh
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Only needed if not installed via pkg file (See: https://brew.sh)

brew install gh
brew install htop nmap screen watch pwgen tree stress-ng exiftool awscli aws-cdk ansible
brew install --cask libreoffice
brew install --cask libreoffice-language-pack
brew install 1password-cli # AFTER 1PASSWORD IS INSTALLED NOT BEFORE !!!
brew cleanup --prune=all #; go clean -cache # go clean only needed if Go is installed
```

## Upgrade all
```zsh
brew update && brew upgrade && brew upgrade --cask && brew autoremove && brew cleanup --prune=all; softwareupdate -l
```

## Restore SSH-Keys
```zsh
/Volumes/external-0/0_Backup/Mac/restore-ssh-keys.sh # SSD external-0 must be connected. This restores SSH-Keys
```

## Applications (Download DMG or PKG file from the Internet)
  * [1Password](https://1password.com/de/downloads/mac)
  * [Google Chrome](https://chrome.google.com/)
  * [AppCleaner](https://freemacsoft.net/appcleaner/)
  * [VSCode](https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64-dmg)
  * [Docker](https://www.docker.com/get-started/)
  * [LibreOffice (Only if not installed via brew)](https://www.logitech.com/software/logi-options-plus)
  * [DaVinciResolve](https://www.blackmagicdesign.com/products/davinciresolve)
  * [Brother_PrinterDrivers_MonochromeLaser_1_5_0.dmg](File: /Volumes/external-0/shared/Apple/Mac/Software)
  * [Brother_ScannerDrivers_ICA_1_5_0.dmg](File: /Volumes/external-0/shared/Apple/Mac/Software)

## Applications (via the AppStore)
  * 1Password for Safari (Safari Extention for 1Password)
  * Sweet Home 3D
  * WireGuard
  * Windows App
  * Numbers


## Install Go

  * [https://github.com/rtitz/ansible-collection-go](https://github.com/rtitz/ansible-collection-go)
**Alternative way:**
  * [https://go.dev/doc/install](https://go.dev/doc/install)


## Settings
- General
  - Share -> File share (Dateifreigabe): Aktiviren
- Security & Privacy
  - Privacy
    - Full Disk Access -> Add & Enable Terminal.app
    - Bedienungshilfen -> Add & Enable 1Password
- Network
  - Firewall: Enable
- Keyboard -> Keyboard navigation: Enable
- TrackPad -> More Gestures -> App-Expose -> 3 fingers down

## Open Shell scripts by default with Terminal
- Right click on .sh file
- Information
- Under "Open with" select Terminal.app
- Apply to all


**[BACK](../../README.md)**
