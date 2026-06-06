autoload -Uz vcs_info

precmd() {
  vcs_info
}

zstyle ':vcs_info:git:*' formats ' (%b)'

setopt PROMPT_SUBST

if [[ -n "$SSH_CONNECTION" ]]; then
  PROMPT='%(?..[%?] )%m:%~${vcs_info_msg_0_} '
else
  PROMPT='%(?..[%?] )%~${vcs_info_msg_0_} '
fi

PROMPT+='%(#.!!.>) '

setopt globdots
setopt extended_glob

alias python='python3'
alias g='cd ~/rlocal/projects/tellident/' # current project: g for go/goals/get it
alias n='cd ~/Dropbox/home/; vim now'
alias nn='cd ~/Dropbox/home/'
alias ll='ls -AFltr --color=auto'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

export EDITOR='vim'
bindkey -v
export PATH=./:~/.local/bin:$PATH

dotsync() {
  local msg="${*:-sync}"
  git -C "$HOME/.dotfiles" add -A &&
  git -C "$HOME/.dotfiles" commit -m "$msg" &&
  git -C "$HOME/.dotfiles" push
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    printf "\n\033[1;31m*** USE GHOSTTY INSTEAD OF TERMINAL ***\033[0m\n\n"
    open -a Ghostty
    sleep 2
    exit
fi
