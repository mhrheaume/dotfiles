#############################
# General Configuration
#############################
set -o vi
setopt IGNOREEOF

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

export VISUAL=nvim
export EDITOR=nvim

export XDG_CONFIG_HOME=$HOME/.config

export SAVEHIST=100000
export HISTSIZE=$SAVEHIST

setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#############################
# Autocompletion
#############################
if type brew &>/dev/null; then
  eval "$(brew shellenv)"

  autoload -Uz compinit
  compinit
fi

# Most programs installed through brew will be captured by $(brew shellenv) above; fzf is the
# only one we need to configure manually.
[ fzf > /dev/null 2>&1 ] && source <(fzf --zsh)
[ docker > /dev/null 2>&1 ] && source $HOME/.docker/completions/_docker

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
PS1='%{$fg[blue]%}%d%{$fg_bold[green]%}$(__git_ps1 " (\uE0A0 %s)" 2> /dev/null) %{$fg[blue]%}λ%{$reset_color%} '

#############################
# Aliases
#############################
alias vim='nvim'
alias ls='eza'
alias cat='bat'

alias g='git'
alias tf='terraform'
alias tg='terragrunt'
alias k='kubectl'
alias kc='kubectl --context'

#############################
# Local bin
#############################
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

#############################
# Mise
#############################
eval "$(mise activate zsh)"

#############################
# Go
#############################
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

###############################
# Python
###############################

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

uvsh() {
    local venv_name=${1:-'.venv'}
    venv_name=${venv_name//\//} # remove trailing slashes (Linux)
    venv_name=${venv_name//\\/} # remove trailing slashes (Windows)

    local venv_bin=
    if [[ -d ${WINDIR} ]]; then
        venv_bin='Scripts/activate'
    else
        venv_bin='bin/activate'
    fi

    local activator="${venv_name}/${venv_bin}"
    echo "[INFO] Activate Python venv: ${venv_name} (via ${activator})"

    if [[ ! -f ${activator} ]]; then
        echo "[ERROR] Python venv not found: ${venv_name}"
        return
    fi

    # shellcheck disable=SC1090
    . "${activator}"
}

# Fix completions for uv run.
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

#############################
# Google Cloud
#############################
if [ -f '/Users/mhr/workspace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mhr/workspace/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/mhr/workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mhr/workspace/google-cloud-sdk/completion.zsh.inc'; fi

#############################
# Node
#############################
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#############################
# Rust
#############################
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

#############################
# zoxide
#############################
eval "$(zoxide init zsh)"

#############################
# AI
#############################
source ~/.zsh-ai-cmd/zsh-ai-cmd.plugin.zsh
export ZSH_AI_CMD_PROVIDER='anthropic'

#############################
# Per-machine
#############################
[[ -f "$HOME/.zsh.local" ]] && source $HOME/.zsh.local
