#!/bin/bash

# Time
SECONDS=0

# General Setting
LOG='/dev/null'
COLOR_PRECAP='\033['
COLOR_AFTCAP='m'
COLOR_RED="${COLOR_PRECAP}31${COLOR_AFTCAP}"
COLOR_YELLOW="${COLOR_PRECAP}33${COLOR_AFTCAP}"
COLOR_GREEN="${COLOR_PRECAP}32${COLOR_AFTCAP}"
COLOR_CYAN="${COLOR_PRECAP}36${COLOR_AFTCAP}"
COLOR_OFF="${COLOR_PRECAP}${COLOR_AFTCAP}"

echo_normal() {
    echo "* ${1}" | tee -a ${LOG}
}
echo_error() {
    echo -e "$COLOR_RED * ERROR: $1 $COLOR_OFF" | tee -a $LOG
}
echo_warning() {
    echo -e "$COLOR_YELLOW * WARNING: $1 $COLOR_OFF" | tee -a $LOG
}
echo_success() {
    echo -e "$COLOR_GREEN * SUCCESS: $1 $COLOR_OFF" | tee -a $LOG
}
echo_info() {
    echo -e "$COLOR_CYAN * INFOMATION: $1 $COLOR_OFF" | tee -a $LOG
}
function is_exist_command() {
    which "$1" >/dev/null 2>&1
    return $?
}
function detect_os() {
    case "$OSTYPE" in
        *'linux'*)   PLATFORM='linux'  ;;
        *'darwin'*)  PLATFORM='osx'  ;;
        *)           PLATFORM='unknown'  ;;
    esac
    export PLATFORM
    return 0
}
function install_osx_command() {
    if ! is_exist_command 'brew'; then
        echo_normal 'Installing brew ..'
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_error 'brew installation was failed'; exit 1
    fi

    local brew_commands=('git' 'vim' 'zsh' 'tmux' 'anyenv' 'direnv' 'docker' 'reattach-to-user-namespace')
    local brew_casks=('docker' 'iterm2' 'google-chrome' 'firefox' 'slack')

    echo_normal 'Update and upgrade brew ..'
    brew update
    brew upgrade

    echo_normal 'Install brew packages'
    for bc in ${brew_commands[@]}; do
        if ! brew list | grep -wq "$bc"; then
            echo_normal "Installing $bc .."
            brew install "$bc"
            echo_info "Installed $bc"
        else
            echo_warning "$bc is already installed in brew"
        fi
    done
    for bcs in ${brew_casks[@]}; do
        if ! brew cask list | grep -wq "$bcs"; then
            echo_normal "Installing $bcs .."
            brew cask install "$bcs"
            echo_info "Installed $bcs"
        else
            echo_warning "$bcs is already installed in brew cask"
        fi
    done

    echo_normal 'Cleaning brew ..'
    brew cleanup
    #brew linkapps  # out-of-date

    echo_success "$0"
    return 0
}


if [ -z "${DOTPATH:-}" ]; then
    export DOTPATH="${HOME}/.dotfiles"
fi
export DOTFILES_GITHUB='https://github.com/senkentarou/dotfiles.git'

function dotfiles_download() {
    echo_normal 'dotfiles downloading ..'
    if [ -d "$DOTPATH" ]; then
        echo_warning "$DOTPATH: already exist"
        return 1
    fi

    # download from DOTFILES_GITHUB
    if is_exist_command 'git'; then
        git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
    elif is_exist_command 'curl'; then
        :
    elif is_exist_command 'wget'; then
        :
    else
        echo_error 'git or curl or wget are required'
        return 1
    fi

    echo_normal 'Downloaded'
    return 0
}

function dotfiles_deploy() {
    echo_normal 'dotfiles deploying ..'
    if [ ! -d "$DOTPATH" ]; then
        echo_error "$DOTPATH: not found"
        return 1
    fi

    # link
    local exception_reexp="(.git)"
    local point_find_curdirs="$(( ${#DOTPATH}+2 ))"
    echo_normal "make symbolic link"
    for dotfile in $(find "$DOTPATH" -maxdepth 1 -name '.??*' | cut -c ${point_find_curdirs}- | grep -Evx "$exception_reexp"); do
        ln -sfnv "$DOTPATH/$dotfile" "$HOME/${dotfile##*/}"
    done

    echo_normal 'Deployed'
    return 0
}

function dotfiles_initialize() {
    if [ ! -d "$DOTPATH" ]; then
        echo_error "$DOTPATH: not found"
        exit 1
    fi

    # vim
    bash "$HOME/.vim/tool/download_colorscheme.sh"
}

#
# Main procedure
#

detect_os
install_osx_command
dotfiles_download
dotfiles_deploy
dotfiles_initialize

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
echo "Reboot shell in seconds .."
sleep 5

# Reboot shell or change shell to zsh
if [ "$SHELL" != '/bin/zsh' ]; then
    echo_info "change shell $SHELL to /bin/zsh"
    chsh -s /usr/local/bin/zsh
    exec /usr/local/bin/zsh
else
    exec "${SHELL}" -l
fi
