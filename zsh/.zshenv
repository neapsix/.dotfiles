# .zshenv - sourced for all shells and scripts
# Configure the path here if needed so that scripts can access all commands.

# Don't add anything to the path if it's there already.
typeset -U path

case "$OSTYPE" in
  darwin*)
    # Add MacPorts install location to the path.
    path=(/opt/local/bin /opt/local/sbin $path)
  ;;
  linux*)
    # ...
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*)
    # ...
  ;;
esac

# Add rustup environment.
test -r "$HOME/.cargo/env" && source "$HOME/.cargo/env"

# Add personal and user scripts directories
path=($HOME/.local/bin $HOME/bin $path)
