PROMPT="%n@%m %c %% "
CLICOLOR=1
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt interactivecomments
setopt histignorespace
setopt correct
setopt correct_all
setopt autocd
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

alias ls='ls --color -G'
alias ll='ls --color -lG'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 1Password-Cli completion
eval "$(op completion zsh)"; compdef _op op

# PATH
export PATH=$HOME/Applications/:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# BEGIN ANSIBLE MANAGED BLOCK FOR GO PATH
export PATH="$HOME/Applications/go/bin:$PATH"
export GOPATH="$HOME/go"
# END ANSIBLE MANAGED BLOCK FOR GO PATH
