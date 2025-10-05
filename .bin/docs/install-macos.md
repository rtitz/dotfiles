# Install macOS

**[BACK](../../README.md)**

## TouchID in Terminal for sudo
```zsh
sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
```

## Install Git
```zsh
sudo xcode-select --install
```

## TimeMachine and other system setttings
```zsh
sudo systemsetup -getcomputername
sudo systemsetup -getlocalsubnetname
sudo systemsetup -setcomputername jupiter
sudo systemsetup -setlocalsubnetname jupiter
sudo systemsetup -getcomputername
sudo systemsetup -getlocalsubnetname
sudo systemsetup setRemoteLogin on

sudo tmutil setdestination -p /Volumes/TimeMachine
sudo tmutil destinationinfo
sudo tmutil addexclusion -v /Volumes/external-0
sudo tmutil addexclusion -v /Volumes/TimeMachine
sudo tmutil addexclusion -v /Volumes/ramdisk_1g

# Exclusions Melanie
sudo tmutil addexclusion -p /Users/melanie/Downloads/
sudo tmutil addexclusion -p /Users/melanie/Music/
sudo tmutil addexclusion -p /Users/melanie/Movies/
sudo tmutil addexclusion -p /Users/melanie/tmp/
sudo tmutil addexclusion -p /Users/melanie/S3/
sudo tmutil addexclusion -p /Users/melanie/VirtualBox\ VMs/
sudo tmutil addexclusion -p /Users/melanie/Library/Containers/com.utmapp.UTM/
sudo tmutil addexclusion -p /Users/melanie/Library/Containers/com.docker.docker

# Exclusions Rene
sudo tmutil addexclusion -p /Users/rene/Downloads/
sudo tmutil addexclusion -p /Users/rene/Music/
sudo tmutil addexclusion -p /Users/rene/Movies/
sudo tmutil addexclusion -p /Users/rene/tmp/
sudo tmutil addexclusion -p /Users/rene/S3/
sudo tmutil addexclusion -p /Users/rene/VirtualBox\ VMs/
sudo tmutil addexclusion -p /Users/rene/Library/Containers/com.utmapp.UTM/
sudo tmutil addexclusion -p /Users/rene/Library/Containers/com.docker.docker
```

## Install brew
  * Download the pkg file from https://github.com/Homebrew/brew/releases/latest
  * Execute the pkg file to install brew
  * For more info see: [https://brew.sh](https://brew.sh)

```zsh
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Only needed if not installed via pkg file

brew install mas htop nmap screen watch pwgen tree stress-ng awscli aws-cdk ansible 
brew install --cask libreoffice
brew install --cask libreoffice-language-pack
brew install 1password-cli # AFTER 1PASSWORD IS INSTALLED NOT BEFORE !!!
brew cleanup --prune=all #; go clean -cache # go clean only needed if Go is installed
```

## Upgrade all
```zsh
brew update && brew upgrade && brew upgrade --cask && brew autoremove && brew cleanup; mas upgrade; softwareupdate -l
```

## Applictications (Download DMG or PKG file from the Internet)
  * 1Password
  * Google Chrome
  * AppCleaner
  * VSCode
  * Logi Options+
  * LibreOffice (Only if not installed via brew)
  * DaVinciResolve
  * Brother_PrinterDrivers_MonochromeLaser_1_5_0.dmg
  * Brother_ScannerDrivers_ICA_1_5_0.dmg

## Applictications (via the AppStore)
  * 1Password for Safari (Safari Extention for 1Password)
  * Sweet Home 3D
  * WireGuard
  * Windows App
  * Numbers

### Alternative for AppStore Applications via 'mas' command in terminal
  * brew install mas needed to install the mas command!
```zsh
# 1569813296  1Password for Safari  (8.10.82)
# 1295203466  Windows App           (11.2.0)
# 1451685025  WireGuard             (1.0.16)
# 409203825   Numbers               (14.4)
# 669289700   Sweet Home 3D         (7.5.350)

mas install 1569813296 1295203466 1451685025 409203825 669289700
```

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

## Open Shell scripts by default with Terminal
- Right click on .sh file
- Information
- Under "Open with" select Terminal.app
- Apply to all


**[BACK](../../README.md)**
