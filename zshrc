#############################
# General Configuration
#############################
set -o vi

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

export VISUAL=nvim
export EDITOR=nvim

setopt share_history

#############################
# Autocompletion
#############################
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
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
PS1='%{$fg[cyan]%}%c%{$fg_bold[green]%}$(__git_ps1 " (\uE0A0 %s)" 2> /dev/null) %{$fg[cyan]%}λ%{$reset_color%} '

#############################
# Aliases
#############################
alias vim='nvim'
alias ls='exa'
alias cat='bat'

alias g='git'

#############################
# Go
#############################
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

#############################
# Node
#############################
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
