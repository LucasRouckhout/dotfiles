# Author: Lucas Rouckhout <lucas.rouckhout@gmail.com>
#
# My ZSHRC

#------------------------------
# PATH
#------------------------------
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "/usr/local/bin" ]] ; then
    export PATH="/usr/local/bin:$PATH"
fi

if [[ -f $HOME/.zfunctions.sh ]]; then
    source $HOME/.zfunctions.sh
fi

#------------------------------
# dircolors
#------------------------------
if [[ -f "$HOME/.dir_colors" ]]; then
    test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
fi

#------------------------------
# Editor
#------------------------------
export EDITOR='vim'

#------------------------------
# Aliases
#------------------------------
alias vim="nvim"
alias ls="ls --color=auto"
alias ll="ls -hAl"
alias l="ls -hal"
alias gco='git branch -a | grep -v HEAD | sed -e "s/remotes\/origin\///" | sed -e "s/*//" | sort -u | fzf --height 40% --border --preview "git log --oneline --graph --date=short --color --pretty=\"format:%C(auto)%cd %h%d %s\" $(echo {} | tr -d \"[:space:\"]\")" | xargs git checkout'
#alias fuzz="vim $(fzf)"

# Curltime
# https://stackoverflow.com/questions/18215389/how-do-i-measure-request-and-response-times-at-once-using-curl
if [[ -f $HOME/.curl-format.txt ]]; then
    alias curltime="curl -w \"@$HOME/.curl-format.txt\" -o /dev/null -s "
fi

#------------------------------
# Prompt
#------------------------------

# Enable vcs_info so we can use it in our prompt
autoload -Uz vcs_info
precmd() { vcs_info }

# Allows for string substitution using %
setopt PROMPT_SUBST; 

# Change vcs style
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' formats 'on %F{yellow}%b %{%F{red}%}%u%{%f%}%f '

# Set actual prompt
PROMPT='%F{cyan}%1~%f ${vcs_info_msg_0_}'

#------------------------------
# Autocompletion
#------------------------------
autoload -Uz compinit && compinit
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
