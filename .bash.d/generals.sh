#
# stty
#

# bash history: ctrl+r
#   back:    ctrl+r
#   forward: ctrl+s
# updef screen lock (ctrl+s)
stty stop undef
# updef screen unlock (ctrl+q)
stty start undef

#
# asdf
#

# see https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
# shellcheck disable=SC1091
. "$(brew --prefix asdf)/libexec/asdf.sh"
