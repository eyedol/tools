# My personal zsh configuration file
# Author: Henry Addo <henry@addhen.org>

autoload -Uz promptinit
promptinit
export PS1=":-)"

#Set editor to use by default
EDITOR=vim
VISUAL=$EDITOR
export EDITOR VISUAL

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# autocd so I can avoid the tedious cd command
setopt autocd

#Set extended globbing so I can do stuff like cp ^*.(tar|bz2|gz)
setopt extendedglob

#Set alias for the frequently used commands
alias ls='ls --color -F'
alias grep='grep --color=auto'
alias df='df -h'
alias ll='ls -lh'
alias lh='ls -A'

#auto complete subdirectory in project folder
cdpath=($cdpath ~ ~/Work/Workspace ..)
typeset -U path cdpath fpath manpath

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
