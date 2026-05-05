" set global mark for this file with mV; jump to file start: 'V; jump to cursor position in the marked line `V


" Ctrl-v U 2014 Enter -- enters an em-dash; can use this pattern for other Unicode numbers
" delete all blank lines: :g/^$/d [last-line mode, global, regex for blank line, delete]
" :v/.../ is inverse of g/.../
" reload from within vim with :source ~/.vimrc

" : 'colon' commands in status bar are ex commands; ex mode == escape mode == last-line mode
" modes:  normal, insert, visual, visual-line, visual-block, select, replace, command, ex mode (Q in normal mode)
" <fromaddress>co(py)<belowaddress>; https://www.gnu.org/software/emacs/manual/html_node/vip/Ex-Command-Reference.html
" :reg to list registers
" add a space above all functions:
" :g/def/normal O
" move all lines with prefix 'tag:' to top of file: :g/tag:.*/m0 ...m$ for bottom of file
" element of symbol (∈) is C-k (-
" gamma is <C-k> g*, white box is OS, checkmark is OK, written x is XX
" en dash is <C-k> -N (M for em dash)
" vim repeat '=' 30 times: <Normal>30i=<Esc>
" tmux: leader-Z toggles current pane to full pane (for copy-paste, for example)
" count number of things in a line: :s/,//gn counts commas
" insert tab when expandtab is on: insert mode C-v<Tab> or turn expandtab off: set expandtab!
" :%retab to retab
" ½ is <C-k> 12
" ¼ is <C-k> 14
" degree symbol (º) is <C-k> -o
" rot13: g?G
" launch browser and open URL under cursor: gx

syntax on
set number
" set relativenumber
set ruler
" Disable the default Vim startup message.
set shortmess+=I

" Always show the status line at the bottom, even if you only have one window open.
" set laststatus=2
set ignorecase
" set smartcase
set incsearch

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start " equivalent to set backspace=2; check with :set backspace?
set whichwrap+=h,l

set history=200
nmap Q <Nop> " 'Q' in normal mode enters Ex mode
set noerrorbells visualbell t_vb=

imap fj <Esc>:update<CR> " hit f and j together to save edits and enter normal mode
imap jf <Esc>:update<CR>

" instead of !!date or :r! date "<format>":
imap \dt # ----- <C-R>=strftime('%Y-%m-%d %H:%M:%S %a %b %d')<CR><CR><Esc>
