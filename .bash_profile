#
# .bash_profile Settings
#
# load commands on brew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Check .bashrc
test -r "${HOME}/.bashrc" && . "${HOME}/.bashrc"
