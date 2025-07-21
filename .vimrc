let mapleader = " "

set hlsearch
set incsearch
set ignorecase
set smartcase

set number
set relativenumber
set linebreak

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set so=4

set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2

set hidden
set noerrorbells
set mouse="a"

syntax on
filetype plugin indent on
set updatetime=500

inoremap <Esc> <Esc> " for some reason when i was hitting Esc in insert it wasn't doing anything

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>x :x<CR>

nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR>
