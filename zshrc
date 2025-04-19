PROMPT='%m:%/> ' 
alias python='python3'

alias n='cd /Users/r/Dropbox/home/; vim now'
alias nn='cd /Users/r/Dropbox/home/'

alias ll='setopt globdots; ls -AFltr --color=auto'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

. "$HOME/.local/bin/env"

setopt globdots
setopt extended_glob
export EDITOR='vim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH=./:~/.local/bin:$PATH

# Added by Windsurf
export PATH="/Users/r/.codeium/windsurf/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/r/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/r/google-cloud-sdk/completion.zsh.inc'; fi
