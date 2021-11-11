""""""""""""""""""""""""""""""""""""""""
" 1. golbal setting
""""""""""""""""""""""""""""""""""""""""
syntax on
set smartindent
set relativenumber
set nowrap
set enc=utf8
set scrolloff=3
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noswapfile
set mouse=a
nnoremap <S-Tab> <<
nnoremap <Tab> >>
""""""""""""""""""""""""""""""""""""""""
" 2. vundle
""""""""""""""""""""""""""""""""""""""""
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

Plugin 'Valloric/YouCompleteMe'

call vundle#end()

let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0