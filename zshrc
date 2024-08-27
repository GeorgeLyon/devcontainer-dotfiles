# ᓚᘏᗢ
# shellcheck shell=bash
# shellcheck disable=SC2034  # Unused variables are exported into shell

# Ensure private keys are loaded into ssh-agent (and suppress output)
case "$(uname -s)" in
  Darwin*)    
    (ssh-add --apple-load-keychain 2> /dev/null > /dev/null &)
    ;;
esac

# VSCode
if [[ "$TERM_PROGRAM" == "vscode" ]]; then 
  EDITOR="code -w"
else
  EDITOR=nano
fi

# Brew
if [[ -d "/opt/homebrew/" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Utilities
PATH=~/Support/Utilities:${PATH}
PATH=~/Support/Utilities/cmake/bin:${PATH}
PATH=~/.docker/bin:${PATH}

# WORDCHARS
WORDCHARS=${WORDCHARS/\//}
WORDCHARS=${WORDCHARS/=/}

# Swift
SCCACHE_CACHE_SIZE=50G
SWIFT_BACKTRACE=enable=yes

# ccache
CCACHE_DIR=~/.ccache
CCACHE_MAXSIZE="20G"

# History
# HISTFILE=~/Support/Configs/Zsh/history.txt
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
export FPATH=~/Support/Configs/Zsh/Functions:$FPATH
# autoload -Uz compinit && compinit -i
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
# shellcheck disable=SC1090
if [[ -f ~/Support/Configs/Zsh/Plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/Support/Configs/Zsh/Plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Prompt
autoload -U colors && colors
print_failed_status() {
  local last_status=$?
  # 130 is the status code when typing Ctrl-C
  if [[ $last_status -ne 0 && $last_status -ne 130 ]]; then
    # shellcheck disable=SC2154
    echo "🔸 ${fg_bold[yellow]}$last_status${reset_color}"
  fi
}
precmd_functions+=(print_failed_status)
if [[ -z "${LOCAL_WORKSPACE_FOLDER}" ]]; then
  DEVCONTAINER_PROMPT_FRAGMENT="devcontainer"
else
  DEVCONTAINER_PROMPT_FRAGMENT="devcontainer: ${LOCAL_WORKSPACE_FOLDER}"
fi
PROMPT="
🤖 %B%{$fg[green]%}$DEVCONTAINER_PROMPT_FRAGMENT%{$reset_color%}%b
📁 %~
⭐️ "

