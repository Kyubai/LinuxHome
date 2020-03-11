if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

setopt auto_cd
setopt correct
# setopt correct_all
setopt auto_list
setopt auto_menu
setopt always_to_end
setopt sharehistory
setopt incappendhistory
setopt histignoredups
setopt histignorespace

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILESIZE=20000
export HISTFILE="/root/.zhistory"

autoload -U colors && colors
export PROMPT="%{$fg[cyan]%}%n@%M%{$reset_color%}:%{$fg[blue]%}[%~] %{$reset_color%}"

# export PROMPT_COMMAND="fc -IR"

# precmd() { eval "$PROMPT_COMMAND" }

# load zsh plugins
source /usr/share/zplug/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/git-auto-fetch", from:oh-my-zsh
# zplug "plugins/git-prompt", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "djui/alias-tips"

# bind arrow up and arrow down to history substring search !!! Needs to be loaded after zsh-syntax-highlighting!!!
zplug "zsh-users/zsh-history-substring-search"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zplug load

# enable tab completion
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

zmodload -i zsh/complist
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
