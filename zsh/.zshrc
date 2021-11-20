# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/ben/.zshrc'

# Make Homebrew completions available before running compinit.
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Initialize zsh completions.
autoload -Uz compinit
compinit
# End of lines added by compinstall

# .zshrc - sourced for all shells but not scripts.
# Do most configuration here so that login and non-login shells match.

export EDITOR=vi

# Determine what color things are in ls output.
case "$OSTYPE" in
    darwin*|dragonfly*|freebsd*|netbsd*|openbsd*)
        # Always use colors in BSD ls.
        export CLICOLOR=1
        # Set colors in macOS/FeeBSD format.
        export LSCOLORS=Exfxcxdxbxegedabagacad
    ;;
    linux*)
        # Always use colors in GNU ls in terminals.
        alias ls='ls --color=auto'
    ;;
esac

# If dircolors is provided as gdircolors (as in brew coreutils), alias it.
type gdircolors &>/dev/null && alias dircolors='gdircolors'

# Set ls colors in GNU coreutils format.
# If dircolors is present, use it to color code ls output by file extension.
if type dircolors &>/dev/null; then
    # Read the .dir_colors file or use the defaults to set LS_COLORS.
    test -r $HOME/.dir_colors && \
        eval "$(dircolors -b $HOME/.dir_colors)" || \
        eval "$(dircolors)"
else
    # If dircolors isn't present, set basic LS_COLORS to color code by category.
    export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi

# Color code zsh completion, too. Use LS_COLORS because zsh needs GNU format. 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Aliases

# ls flags
alias la='ls -A'
alias ll='ls -alh'

# grep for something in shell history
alias ghist='history | grep -i $1'

# pass commands - password manager
alias p='pass -c'
alias pp='pass'
alias pe='pass edit'

# ttdl commands - todo.txt tool
export TTDL_FILENAME="$HOME/Documents/todo.txt"
alias t='ttdl'
# Standard fields are: done,pri,finished,created,due,thr,description.
alias td='ttdl l --fields=done,pri,due,description -s=done,pri,due,proj --human --compact --all '
alias tt='ttdl start'
alias ts='ttdl stop'
alias d='ttdl done'
alias ud='ttdl undone'
alias wtd='clear; while td; do sleep 2; clear; done'

# Set zsh prompt
PROMPT='%F{8}%m%f' # gray hostname
PROMPT+=':'
PROMPT+='%F{8}%1~%f ' # gray directory
PROMPT+='%(!.%F{9}.%F{6})%n%f ' # username red if elevated or cyan if not
PROMPT+='%# ' # % or #
