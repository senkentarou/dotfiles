# fzf
# function refs: [
#   https://github.com/mitubaEX/dotfiles/blob/d5bb5653597244c01c58b087f39e2baac93699ff/.zsh.d/utils/fzf-functions.zsh
#   https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# ]
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

function select-history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--prompt='Command History > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle -N select-history
bindkey -M viins '^R' select-history

# Search a file with fzf inside a Tmux pane and then open it in an editor
function fzf_open_file_by_name() {
  local file=$(rg --files --hidden --glob '!.git' | FZF_DEFAULT_OPTS="--prompt='File Search > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd))

  zle reset-prompt

  if [ -n "$file" ]; then
    BUFFER="${EDITOR:-vim} $file"
  fi

  return 0
}
zle -N fzf_open_file_by_name
bindkey -M viins '^F' fzf_open_file_by_name

function fzf_open_file_by_chars() {
  read -r file line <<< "$(rg --glob '!.git' --line-number --invert-match '^\s*$' | FZF_DEFAULT_OPTS="--prompt='String Search > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) --select-1 --exit-0 | awk -F: '{print $1, $2}')"

  zle reset-prompt

  if [ -n "$file" ] && [ -n "$line" ]; then
    BUFFER="${EDITOR:-vim} $file"
  fi

  return 0
}
zle -N fzf_open_file_by_chars
bindkey -M viins '^V' fzf_open_file_by_chars


# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# zsh
export HISTSIZE=100000
export SAVEHIST=100000


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
    color="%{%(?.${fg[green]}.${fg[red]})%}"
    reset="%{${reset_color}%}"

    primary_prompt="${color}[@%m:${prompt}]${reset}"
    rear_prompt=""
    # set git status
    vcs_info
    primary_prompt="${primary_prompt}${vcs_info_msg_0_}"

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
# If you use other bindkey, you should pick the bindkey setting here to your place
bindkey -v
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-delete-char
bindkey -M viins '^C' self-insert
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
#bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-char
bindkey -M viins '^I' expand-or-complete
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
#bindkey -M viins '^V' vi-quoted-insert
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

# vim
export EDITOR=vim
[[ -f $HOME/nvim-osx64/bin/nvim ]] && alias nvim=$HOME/nvim-osx64/bin/nvim
alias vim=nvim

# git
function gcopr() {
  git fetch upstream pull/$1/head:pr/$1
  git checkout pr/$1
}

function gplpr() {
  git pull upstream pull/$(git branch | grep \* | cut -d ' ' -f2 | sed -e 's/pr\///')/head
}

# alias
alias mux='tmuxinator'
alias k='kubectl'

alias reload="source ${HOME}/.zsh.d/.zshrc"
alias zshconf="vim ${HOME}/.zsh.d/.zshrc"
alias vimconf="vim ${HOME}/.config/nvim/init.vim"

alias less='less -qR'
alias ls='ls -al'
