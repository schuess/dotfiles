" reload from within vim with :source ~/.vimrc
" set global mark for this file with mV
" :%retab to retab
" : 'colon' commands in status bar are Ex commands; five more:  normal, visual, select, insert, command line
" <fromthisline>co(py)<belowthisline>; https://www.gnu.org/software/emacs/manual/html_node/vip/Ex-Command-Reference.html
" :reg to list registers

set number
set ignorecase
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on

imap fj <Esc>:update<CR> " hit f and j together to save edits and enter normal mode
imap jf <Esc>:update<CR>

" nmap fj <Esc>:update<CR> " make it work in normal mode too
" nmap jf <Esc>:update<CR>

" instead of !!date or :r! date "<format>":
imap \dt <C-R>=strftime('%Y-%m-%d %H:%M:%S %a %b %d')<CR><Esc>

