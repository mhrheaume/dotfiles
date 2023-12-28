#############################
# General Configuration
#############################
set -o vi
setopt IGNOREEOF

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

export VISUAL=nvim
export EDITOR=nvim

export SAVEHIST=100000
export HISTSIZE=$SAVEHIST

setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#############################
# Autocompletion
#############################
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.helm.zsh ] && source ~/.helm.zsh

_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}

if type gt &>/dev/null; then
  compdef _gt_yargs_completions gt
fi

#############################
# Prompt
#############################

# Git Prompt
GIT_PS1_OMITPARSESTATE=true
source ~/.git-prompt.sh

autoload -Uz colors
colors

setopt PROMPT_SUBST
PS1='%{$fg[blue]%}%c%{$fg_bold[green]%}$(__git_ps1 " (\uE0A0 %s)" 2> /dev/null) %{$fg[blue]%}λ%{$reset_color%} '

#############################
# Aliases
#############################
alias vim='nvim'
alias ls='eza'
alias cat='bat'
alias find='fd'
alias grep='rg'

alias g='git'
alias k='kubectl'

#############################
# Local bin
#############################
export PATH=$HOME/bin:$PATH

#############################
# Python
#############################
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#############################
# Go
#############################
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

#############################
# Node
#############################
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#############################
# zoxide
#############################
eval "$(zoxide init zsh)"

#############################
# Per-machine
#############################
[[ -f "~/.zsh.local" ]] && source ~/.zsh.local
