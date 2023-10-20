# VSCode
if [[ "$TERM_PROGRAM" == "vscode" ]]; then 
  EDITOR="code --wait"
else
  EDITOR=nano
fi

# WORDCHARS
WORDCHARS=${WORDCHARS/\//}
WORDCHARS=${WORDCHARS/=/}

# History
HISTFILE=~/.zsh_history
HISTFILESIZE=1000000000
HISTSIZE=1000000000
HISTTIMEFORMAT="[%F %T] "
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

# Autosuggestions
autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Colors
autoload -U colors && colors

# Prompt
if [[ -z "${LOCAL_WORKSPACE_FOLDER}" ]]; then
  DEVCONTAINER_PROMPT_FRAGMENT="devcontainer"
else
  DEVCONTAINER_PROMPT_FRAGMENT="devcontainer: ${LOCAL_WORKSPACE_FOLDER}"
fi
PROMPT="
🤖 %B%{$fg[green]%}$DEVCONTAINER_PROMPT_FRAGMENT%{$reset_color%}%b
📁 %~
> "
