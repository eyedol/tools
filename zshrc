# My personal zsh configuration file
# Got inspiration from Lorenzo Cabrini's zshrc file http://goo.gl/8DODV

# Author: Henry Addo <henry@addhen.org>

autoload -Uz promptinit
promptinit

autoload colors
colors

#Set editor to use by default
EDITOR=vim
if has("nvim")
  EDITOR=nvim
endif
VISUAL=$EDITOR
export EDITOR VISUAL

SMILE_PROMPT=":-) "

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Custom path

export ANDROID_HOME=/opt/android-sdk/sdk

export ARC_HOME=~/Devel/Workspace/arcanist/arcanist

export PIDCAT_HOME=~/Devel/Workspace/pidcat

export SCREEN_FETCH=~/Devel/Workspace/screenFetch

export MOZ_HOST_BIN=~/.mozbuild/host-utils-37.0a2.en-US.linux-x86_64

export MACH_HOME=~/Devel/Workspace/mozilla-android/mozilla-central

export DM_TRANS=adb

export TMUX_HOME=~/Devel/Workspace/tools/tmux

export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ARC_HOME/bin:$PIDCAT_HOME:$SCREEN_FETCH:$MACH_HOME:$DM_TRANS:$MOZ_HOST_BIN:$TMUX_HOME:$PATH


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

#git stuff

# Grab file here https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
# Install it in .zsh/completion/_git/

zstyle ':completion:*:*:git:*' script ~/.zsh/completion/_git/git-completion.zsh

## Add Git auto completion script
fpath=(~/.zsh $fpath)


#pull current branch name
function current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

# few alias for the git repo
alias gst='git status'
alias gb='git branch'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=5'
alias ggpull='git pull origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
alias ggcmt='git commit  -a'
alias gbc='git checkout -b'
alias gbs='git show-branch'
alias gbS='git show-branch -a'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %C(bold blue)<%an>%Creset %s %Cgreen(%cr) %C(yellow)%d%Creset' --abbrev-commit --date=relative"

typeset -ag chpwd_functions
typeset -ag precmd_functions

export base_right_prompt
export right_prompt_end
export git_repo
export mercurial_repo

function repo_chpwd() {
    if [[ $(git status > /dev/null 2>&1; echo $?) -eq 0 ]]; then
        base_right_prompt="[%{$fg[blue]%}git"
        right_prompt_end="%{$reset_color%}]± "
        git_repo=1
    
    elif [[ $(hg root > /dev/null 2>&1; echo $?) -eq 0 ]]; then
        base_right_prompt="[%{$fg[blue]%}hg"
        right_prompt_end="%{$reset_color%}]☿ "
        mercurial_repo=1

    else
        base_right_prompt=''
        mercurial_repo=0
        git_repo=0
    fi

}

chpwd_functions=('repo_chpwd')

function repo_precmd() {
    if [[ $git_repo -eq 1 ]]; then
        git_status=$(git status)
        remote=$(print $git_status | grep 'Your branch is ahead')
        untracked=$(print $git_status | grep '^nothing added to commit but untracked files present')
        clean=$(print $git_status | grep '^nothing to commit')
        git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
        git_branch_name="%{$fg[yellow]%}:$git_branch"
	    right_prompt=${base_right_prompt}${git_branch_name}
        if [[ -n $remote || -z $clean ]]; then
            right_prompt="${right_prompt}:"
            if [[ -n $remote ]]; then
                right_prompt="${right_prompt}%{$fg[red]%}P"
            fi

            if [[ -n $untracked ]]; then
                right_prompt="${right_prompt}%{$fg[magenta]%}U"
            fi

            if [[ -z $clean ]]; then
                right_prompt="${right_prompt}%{$fg[cyan]%}C"
            fi
        fi

        PROMPT="${right_prompt}${right_prompt_end}"

    elif [[ $mercurial_repo -eq 1 ]]; then
        hg_prompt_info=$(hg prompt ":{bookmark}{status}{update}" 2>/dev/null)
        hg_prompt_info_bg="%{$fg[yellow]%}$hg_prompt_info"
        right_prompt=${base_right_prompt}${hg_prompt_info_bg}
        PROMPT="${right_prompt}${right_prompt_end}"
    else
        PROMPT=$SMILE_PROMPT
    fi
}

precmd_functions=('repo_precmd')

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval   "$(dircolors -b)"
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

