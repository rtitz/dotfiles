# dotfiles - macOS configuration

This is a tool to backup and restore macOS configuration in Git.

# Table of Contents
- [dotfiles - macOS configuration](#dotfiles---macos-configuration)
- [Table of Contents](#table-of-contents)
  - [Setup](#setup)
  - [After GitHub Cli is installed login to GitHub to be able to add new or changed files to repo](#after-github-cli-is-installed-login-to-github-to-be-able-to-add-new-or-changed-files-to-repo)
  - [Add files to repo](#add-files-to-repo)
  - [Pull current configuration on other machines](#pull-current-configuration-on-other-machines)
  - [Configure macOS](#configure-macos)
  - [Documentations](#documentations)

## Setup
```zsh
sudo xcode-select --install
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/rtitz/dotfiles.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local push.autoSetupRemote true
dotfiles checkout  # To overwrite local files with the files in Git use: dotfiles checkout -f
```

## After GitHub Cli is installed login to GitHub to be able to add new or changed files to repo
 * See [Brew installation](.bin/docs/configure-macos.md#install-brew)
```zsh
gh auth login
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

## Configure macOS
 * [Configure macOS](.bin/docs/configure-macos.md)


## Documentations
 * [Backup Home Dir](.bin/docs/backup-home-dir.md)
 * [Encrypt files](.bin/docs/encrypt-files.md)
 * [Monitor DDC/CI issues](.bin/docs/monitor-issues.md)
 * [Git-Repos](.bin/docs/git-repos.md)
 * [Install macOS](.bin/docs/configure-macos.md)
