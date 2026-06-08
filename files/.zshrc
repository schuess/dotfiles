autoload -Uz vcs_info

precmd() {
  vcs_info
}

zstyle ':vcs_info:git:*' formats ' (%b)'

setopt PROMPT_SUBST
setopt autocd

if [[ -n "$SSH_CONNECTION" ]]; then
  PROMPT='%(?..[%?] )%m:%~${vcs_info_msg_0_} '
else
  PROMPT='%(?..[%?] )%~${vcs_info_msg_0_} '
fi

PROMPT+='%(#.!!.>) '

setopt globdots
setopt extended_glob

export EDITOR='vim'
alias vi='vim'
alias vmi='vim'
alias view='vim -R'

alias python='python3'
alias pythong='python3'

alias ll='ls -AFltr'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

# cursor
function cursor_beam() {
    printf '\e[6 q'
}
function cursor_block() {
    printf '\e[2 q'
}
function cursor_underline() {
    printf '\e[4 q'
}
function zle-keymap-select {
    case $KEYMAP in
        vicmd) cursor_block ;;
        viins|main) cursor_beam ;;
    esac
}
function zle-line-init {
    cursor_beam
}
TRAPEXIT() {
    cursor_beam
}
zle -N zle-keymap-select
zle -N zle-line-init
bindkey -v

export WALDEN="https://www.gutenberg.org/files/205/205-0.txt"
export ALICE="https://www.gutenberg.org/files/11/11-0.txt"

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

dotsync() {
  local msg="${*:-sync}"
  git -C "$HOME/.dotfiles" add -A
  git -C "$HOME/.dotfiles" commit -m "$msg" || true
  git -C "$HOME/.dotfiles" push
}

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    printf "\n\033[1;31m*** USE GHOSTTY INSTEAD OF TERMINAL ***\033[0m\n\n"
    open -a Ghostty
    sleep 2
    exit
fi

