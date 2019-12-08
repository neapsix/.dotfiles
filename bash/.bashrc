# .bashrc - sourced for non-login shells
# do most configuration here so that login and non-login shells match.

# Enable bash-completion.

# MacPorts install location:
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

# Enable bash-completion scripts.

# MacPorts install location:
if [ -r /opt/local/share/bash-completion/completions/pass ]; then
    . /opt/local/share/bash-completion/completions/pass
fi

# Set up colors for command line output.

# Always use colors in ls.
export CLICOLOR=1
# Determine what color things are in ls output. Use LS_COLORS in Linux.
export LSCOLORS=Exfxcxdxbxegedabagacad
# Use colors and symbols in ls output.
alias ls='ls -GFh'

# Always use colors in grep.
export GREP_OPTIONS='--color=auto'

# Aliases

# ls flags
alias la='ls -A'
alias ll='ls -alh'

# grep for something in bash history
alias gh='history | grep -i $1'

# Add personal scripts folder to path.
# PATH='$HOME/bin:$PATH'
