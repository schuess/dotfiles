PROMPT='%m:%/> '

setopt globdots
setopt extended_glob
bindkey -v
export EDITOR='vim'
export PATH=./:~/.local/bin:$PATH

alias python='python3'

alias g='cd ~/rlocal/projects/tellident/' # g for go/goals/get it
alias n='cd ~/Dropbox/home/; vim now'
alias nn='cd ~/Dropbox/home/'

alias ll='ls -AFltr --color=auto'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

dotsync() {
  local msg="${*:-sync}"
  git -C "$HOME/.dotfiles" add -A &&
  git -C "$HOME/.dotfiles" commit -m "$msg" &&
  git -C "$HOME/.dotfiles" push
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
