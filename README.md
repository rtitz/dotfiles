# dotfiles - macOS configuration

This is a tool to backup and restore macOS configuration in Git.

# Table of Contents
- [dotfiles - macOS configuration](#dotfiles---macos-configuration)
- [Table of Contents](#table-of-contents)
  - [Setup](#setup)
  - [Add files to repo](#add-files-to-repo)
  - [Pull current configuration on other machines](#pull-current-configuration-on-other-machines)
  - [Documentations](#documentations)

## Setup
```zsh
/Volumes/external-0/0_Backup/Mac/restore-ssh-keys.sh # SSD external-0 must be connected. This restores SSH-Keys
sudo xcode-select --install
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:rtitz/dotfiles-rene.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local push.autoSetupRemote true
dotfiles checkout  # To overwrite local files with the files in Git use: dotfiles checkout -f
```

## Add files to repo
```zsh
dotfiles add .gitignore
dotfiles add .gitconfig
dotfiles add .profile
dotfiles add .vimrc
dotfiles add .zshrc
dotfiles add README.md
dotfiles commit -m "first commit"
dotfiles push
```

## Pull current configuration on other machines
```zsh
dotfiles pull
```

## Documentations

 * [Backup Home Dir](.bin/docs/backup-home-dir.md)
 * [Encrypt files](.bin/docs/encrypt-files.md)
 * [Monitor DDC/CI issues](.bin/docs/monitor-issues.md)
 * [Git-Repos](.bin/docs/git-repos.md)
 * [Install macOS](.bin/docs/install-macos.md)
