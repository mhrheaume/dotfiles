# Command history
export HISTSIZE=1000
export SAVEHIST=1000

export HISTFILE=~/.zhistory

setopt inc_append_history

# Tab Completion
autoload -U compinit
compinit

# Prompt appearance
autoload -U colors
colors

if [ $UID = 0 ]; then
    name_color="$fg[red]"
else
    name_color="$fg[green]"
fi

PROMPT="%B%{${name_color}%}%n@%m %{$fg[blue]%}%1d %#%{$reset_color%}%b "
RPROMPT=""

# SSH hosts tab completion
if [ -f $HOME/.ssh/known_hosts ]; then
    local _myhosts
    _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
    zstyle ':completion:*' hosts $_myhosts
fi

alias g='grep -R -n'
alias ls='ls --color'
