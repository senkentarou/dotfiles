#
# .bash_profile Settings
#
# load commands on brew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Check .bashrc
test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc"
