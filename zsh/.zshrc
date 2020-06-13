# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle :compinstall filename '/Users/ben/.zshrc'

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
else
  autoload -Uz compinit
  compinit
fi

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# .zshrc - sourced for all shells but not scripts.
# Do most configuration here so that login and non-login shells match.

# Always use colors in ls.
export CLICOLOR=1

# Determine what color things are in ls output. 
# Use equivalent colors in macOS/FeeBSD LSCOLORS format and Linux LS_COLORS format.
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Set colors in zsh completion to use LS_COLORS. 
# zsh can handle LS_COLORS format but not LSCOLORS format.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Aliases

# ls flags
alias la='ls -A'
alias ll='ls -alh'

# grep for something in bash history
alias gh='history | grep -i $1'

# Add personal scripts folder to path (don't add if already there).
typeset -U path
path=($HOME/bin $path)

# Set zsh prompt
PROMPT='%F{8}%m%f' # gray hostname
PROMPT+=':'
PROMPT+='%F{8}%1~%f ' # gray directory
PROMPT+='%(!.%F{9}.%F{6})%n%f ' # username red if elevated or cyan if not
PROMPT+='%# ' # % or #
