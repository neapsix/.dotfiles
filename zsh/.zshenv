# .zshenv - sourced for all shells and scripts
# Configure the path here if needed so that scripts can access all commands.

# Don't add anything to the path if it's there already. 
typeset -U path

# Add MacPorts install location to the path.
path=(/opt/local/bin /opt/local/sbin $path)
