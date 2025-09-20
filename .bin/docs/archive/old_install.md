
# OLD

---
Applications:
googlechrome.dmg
AppCleaner_3.6.zip
Rectangle0.50.dmg
LibreOffice_7.2.5_MacOS_x86-64.dmg
LibreOffice_7.2.5_MacOS_x86-64_langpack_de.dmg
VSCode-darwin-arm64.zip
darktable-3.8.1.dmg
DaVinci_Resolve_17.4.3_Mac.zip
Brother_PrinterDrivers_MonochromeLaser_1_5_0.dmg
Brother_ScannerDrivers_ICA_1_5_0.dmg
vlc-3.0.16-arm64.dmg
KeePassXC-2.6.6-arm64.dmg

Apps from Apple AppStore:
- WireGuard
- Microsoft Remote Desktop

Settings:
- Keyboard
  - Key Repeat: Fastest
  - Delay until Repeat: Shortest or a little bit less
- Security & Privacy
  - Privacy
    - Full Disk Access -> Enable Terminal.app

SSH:
ssh-add -K ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa_aws

XCODE:
xcode-select --install

GIT:
git config --global user.name "rtitz"
git config --global user.email xaron266@gmail.com
git config --global core.editor vim
git config --global pack.windowMemory 256m
git config --global credential.helper "cache --timeout=36000"

git clone ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/aws-rene01

BREW:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/${USER}/.profile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install htop nmap screen watch pwgen tree stress-ng awscli aws-cdk  
brew install raspberry-pi-imager

/etc/pam.d/sudo (Vor erste "auth"-Zeile):
auth       sufficient     pam_tid.so # TouchID for sudo

ZSH-Shell configuration:
# https://scriptingosx.com/2019/06/moving-to-zsh/
echo "HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history" | tee -a ~/.zshrc
echo "setopt EXTENDED_HISTORY" | tee -a ~/.zshrc
echo "SAVEHIST=5000" | tee -a ~/.zshrc
echo "HISTSIZE=2000" | tee -a ~/.zshrc
echo "setopt SHARE_HISTORY" | tee -a ~/.zshrc
echo "setopt APPEND_HISTORY" | tee -a ~/.zshrc
echo "setopt INC_APPEND_HISTORY" | tee -a ~/.zshrc
echo "setopt HIST_EXPIRE_DUPS_FIRST" | tee -a ~/.zshrc
echo "setopt HIST_IGNORE_DUPS" | tee -a ~/.zshrc
echo "setopt HIST_FIND_NO_DUPS" | tee -a ~/.zshrc
echo "setopt HIST_REDUCE_BLANKS" | tee -a ~/.zshrc
echo "setopt interactivecomments" | tee -a ~/.zshrc
echo "setopt histignorespace" | tee -a ~/.zshrc
echo "setopt correct" | tee -a ~/.zshrc
echo "setopt correct_all" | tee -a ~/.zshrc
#echo "PS1=\"%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%n@%m %1~%f%b %# \"" | tee -a ~/.zshrc
echo "setopt autocd" | tee -a ~/.zshrc
echo "zstyle ':completion:*' completer _complete" | tee -a ~/.zshrc
echo "zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'" | tee -a ~/.zshrc
echo "autoload -Uz compinit" | tee -a ~/.zshrc
echo "compinit" | tee -a ~/.zshrc
echo "alias ls='ls -G'" | tee -a ~/.zshrc
echo "alias ll='ls -lG'" | tee -a ~/.zshrc


Computername and other system settings:
sudo systemsetup -getcomputername
sudo systemsetup -getlocalsubnetname
sudo systemsetup -setcomputername jupiter
sudo systemsetup -setlocalsubnetname jupiter
sudo systemsetup -getcomputername
sudo systemsetup -getlocalsubnetname
sudo systemsetup setRemoteLogin on
sudo tmutil setdestination -p smb://rene@10.0.0.8/timemachine0
sudo tmutil destinationinfo


Create a RAM-Disk:
diskutil partitionDisk $(hdiutil attach -nomount ram://2048000) 1 GPTFormat APFS 'ramdisk_1g' '100%'
# 2048 times the amount of megabytes you want: 2048 * 1000 = 2048000 (1GB) or 2048 * 100 = 204800 (100MB)
# Eject via Finder (also frees the RAM again) or via Terminal:
diskutil list
diskutil eject /dev/disk[number_from_list_output] 
