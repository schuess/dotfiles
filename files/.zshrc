PROMPT='%m:%/> ' 
alias python='python3'


alias g='cd /Users/r/rlocal/projects/tellident/' # g for go/goals/get it
alias n='cd /Users/r/Dropbox/home/; vim now'
alias nn='cd /Users/r/Dropbox/home/'

alias ll='setopt globdots; ls -AFltr --color=auto'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

setopt globdots
setopt extended_glob
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
