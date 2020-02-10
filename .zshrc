# Tree
#[ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 }
#[ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD='tree -L 1'

# tmux automatic attachment
function attach_tmux() {
    # Is exist tmux?
    if [ ! type 'tmux' >/dev/null 2>&1 ]; then
        echo 'tmux command not found.'
        return 1
    fi
    # Is tmux mode?
    if [ ! -z "$TMUX" ]; then
        echo 'Hello, tmux!'
        return 0
    # Is sty mode?
    elif [ ! -z "$STY" ]; then
        echo 'This is on screen.'
        return 0
    # Is not ssh connection?
    elif [ ! -z "$PS1" ] && [ -z "$SSH_CONECTION" ]; then
        #
        if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '(.*]|.*\))$'; then
            tmux list-sessions
            echo -n 'tmux: attach? {y(=latest)/N(=new)/<num>}: '
            read
            if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                tmux attach-session
                if [ $? -eq 0 ]; then
                    echo "$(tmux -V) attached session."
                    return 0
                fi
            elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                tmux attach -t "$REPLY"
                if [ $? -eq 0 ]; then
                    echo "$(tmux -V) attached session"
                    return 0
                fi
            fi
        fi
        # mac OS settings (need to install: reattach-to-user-namespace (brew install reattach-to-user-namespace))
        if [[ "$OSTYPE" == "darwin*" ]] && [ type 'reattach-to-user-namespace' >/dev/null 2>&1 ]; then
            tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
            tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi
}
attach_tmux  # execute

setopt correct
setopt nobeep
setopt notify
setopt auto_cd
setopt auto_pushd
setopt auto_param_keys
setopt auto_menu
setopt auto_param_slash
setopt interactive_comments
setopt prompt_subst
setopt mark_dirs
setopt list_types
setopt interactive_comments
setopt magic_equal_subst
setopt complete_in_word
setopt complete_aliases
setopt globdots
setopt extended_glob
setopt ignore_eof

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt hist_no_store
setopt hist_reduce_blanks

# zsh_env
export LANGUAGE='en_US.UTF-8'
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# Add path
export PATH="${HOME}/.bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"

export EDITOR=vim
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export HISTFILE='~/.z_history'
export HISTSIZE=10000
export SAVEHIST=10000

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# rbenv
export RBENV_ROOT="$HOME/.rbenv"
if [ -d "$RBENV_ROOT" ]; then
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"
fi

autoload -Uz colors
colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo

# prompt
primary_prompt="[@%m:%/]"
rear_prompt=""
spelling_prompt="%{${fg[yellow]}%}%r is correct? [yes, no, abort, edit]:%{${reset_color}%} "
SPROMPT="$spelling_prompt"

# git status
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats "[%b|%a]"

# user status settings
function status_prompt() {
    tmp=""
    tree=($(pwd | tr -s ' ' '_' | tr -s '/' ' '))
    if [[ ${#tree[@]} -gt 1 ]]; then
        for i in $(seq $(( ${#tree[@]}-1 ))); do
            cont="${tree[$i]:0:1}"
            if [[ "${cont}" = "." ]]; then
                cont="${tree[$i]:0:2}"
            fi
            tmp="${tmp}/${cont}"
        done
        prompt="${tmp}/${tree[((${#tree[@]}))]}"
    else
        prompt="$(pwd)"
    fi

    # start prompt string
    primary_prompt="%{${fg[green]}%}[@%m:${prompt}]%{${reset_color}%}"
    rear_prompt=""
    # set git status
    vcs_info
    primary_prompt="${primary_prompt}${vcs_info_msg_0_}"
    # for pyenv
    if [[ -n $PYENV_SHELL ]]; then
        version=${(@)$(pyenv version)[1]}
        if [[ $version != system ]]; then
            rear_prompt="${rear_prompt}[pyenv:$version]"
        fi
    fi
    # for rbenv
    if [[ -n $RBENV_SHELL ]]; then
        version=${(@)$(rbenv version)[1]}
        if [[ $version != system ]]; then
            rear_prompt="${rear_prompt}[rbenv:$version]"
        fi
    fi
    # for root
    if [[ ${UID} -eq 0 ]]; then
        primary_prompt="(root) ${primary_prompt}"
    fi
    # for SSH
    if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
        primary_prompt="${HOST%%.*} ${primary_prompt}"
    fi

    # end prompt string
    primary_prompt="${primary_prompt} %(!.#.$) "
}
add-zsh-hook precmd status_prompt


# for rewriting secondary prompt on execution
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
function left_down_prompt_preexec()
{
        print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-line-init zle-keymap-select zle-line-finish ()
{
    case $KEYMAP in
        main|viins)  secondary_prompt="%{${fg[cyan]}%}-- INSERT --%{${reset_color}%}"  ;;
        vicmd)       secondary_prompt="%{${fg[white]}%}-- NORMAL --%{${reset_color}%}"  ;;
    esac
    PROMPT="%{${terminfo_down_sc}${secondary_prompt}${terminfo[rc]}%}${primary_prompt}"
    RPROMPT="${rear_prompt}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{},|'
zstyle ':zle:*' word-style unspecified

autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:*files' ignored-patterns '*?.pyc' '*?~' '*\#'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''

# Vim-like keybind as default
bindkey -v
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-delete-char
bindkey -M viins '^C' self-insert
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-char
bindkey -M viins '^I' expand-or-complete
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins '^K' kill-line
bindkey -M viins '^L' clear-screen
bindkey -M viins '^M' accept-line
bindkey -M viins '^N' self-insert
bindkey -M viins '^O' self-insert
bindkey -M viins '^P' self-insert
bindkey -M viins '^Q' vi-quoted-insert
bindkey -M viins '^S' self-insert
bindkey -M viins '^T' self-insert
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^V' vi-quoted-insert
bindkey -M viins '^W' backward-kill-word
#bindkey -M viins '^X' self-insert
bindkey -M viins '^Y' yank
bindkey -M viins '^Z' self-insert
bindkey -M viins '^?' backward-delete-char

bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^E' end-of-line
bindkey -M vicmd '^K' kill-line
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history
bindkey -M vicmd '^Y' yank
bindkey -M vicmd '^W' backward-kill-word
bindkey -M vicmd '^U' backward-kill-line
bindkey -M vicmd '/'  vi-history-search-forward
bindkey -M vicmd '?'  vi-history-search-backward
bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G'  end-of-line
bindkey -M vicmd 'O'  beginning-of-line
bindkey -M vicmd 'o'  beginning-of-line

# Aliases
alias vim='/usr/local/bin/vim'
alias vi='vim'
alias vimrc='vim ~/.vim/vimrc'
alias view='vim -R'
alias disp='vim -M'
alias ..='cd ..'
alias :q='pwd'
alias c='clear'
alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -lAGF'
alias du='du -h'  # using space
alias df='df -h'  # free space
alias f='open'
alias src="source ${HOME}/.zshrc"

# tmux
compdef tm=tmux
alias tm='tmux new -s'
alias tmls='tmux ls'
alias tma='tmux attach -t'
alias tmk='tmux kill-session -t'
alias tmka='tmux kill-server'

# git
compdef g=git
alias g='git'
alias gs='git status --short --branch'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git pull origin'
alias gps='git push'
alias gpsu='git push -u origin'
alias gf='git fetch'
alias gd='git diff'
alias gr='git reset'
alias gb='git checkout -b'
alias gm='git remote updata -u'

# docker
alias dp='docker ps'
alias di='docker images'

