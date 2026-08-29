syntax on
filetype plugin indent on 

set autoindent
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set linebreak
set noerrorbells

let &t_EI = "\e[2 q"  " Normal mode: steady block
let &t_SI = "\e[6 q"  " Insert mode: steady vertical bar 

if &term =~'kitty'
    set termguicolors
endif 
highlight Visual guibg=#ff69b4 guifg=#000000

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-autoformat/vim-autoformat'
call plug#end()

autocmd BufWritePre *.py Autoformat

nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
