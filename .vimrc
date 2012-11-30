set t_Co=256
source ~/.vim/plugin/syntastic.vim
call pathogen#infect()
call pathogen#helptags()
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-u>"
set hidden
let mapleader = ","
let maplocalleader = "m"
set history=1000
set wildmenu
set wildmode=list:longest
set title
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
set number
syntax on
set backspace=indent,eol,start
filetype plugin indent on
set hlsearch
set incsearch
nnoremap <leader>f :FufFile<CR>
nnoremap <leader>b :FufBuffer<CR>
nnoremap <leader>t :FufTaggedFile<CR>
nnoremap <leader>i :JavaImport<CR>
nnoremap <leader>s :JavaSearchContext<CR>
set expandtab
set shiftwidth=2
set softtabstop=2
let vimclojure#WantNailgun = 1
set laststatus=2
set background=light
colorscheme solarized
