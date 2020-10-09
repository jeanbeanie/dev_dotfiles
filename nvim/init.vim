nnoremap ; :

" undo settings
set undofile                       " store undofile
set undodir=~/.config/nvim/undodir " undo file dir
set undolevels=90000               " max number of undos
set tabstop=2 shiftwidth=2 expandtab smarttab

" Enable syntax highlighting
syntax on
colorscheme 1989

"nnoremap <silent><buffer><expr> f
"	\ defx#do_action('call', {'split':'vertical', 'winwidth':50, 'direction':'topleft'})

"nnoremap <silent><buffer><expr> <enter> defx#do_action('open')

"PACKAGE MANAGEMENT
" don't forget to :PlugInstall
call plug#begin('~/.config/nvim/plugged')

Plug 'leafgarland/typescript-vim', {'build':'./install.sh'}  " ts type checking
Plug 'Quramy/tsuquyomi'  " ts completions
"Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}  " general lsp competions
Plug 'neoclide/coc.nvim', {'branch': 'release'} " general lsp competions
Plug 'flazz/vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim' " file fuzzyfinder ctrl+p 
Plug 'roxma/vim-tmux-clipboard' " yank to tmux clipboard
Plug 'tpope/vim-fugitive' " many advanced git operations :Gblame :Glog etc
Plug 'itchyny/vim-cursorword' " underline the word under the cursor
Plug 'machakann/vim-highlightedyank' " highlight yanked content
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " styled-components
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " golang support

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" tYPESCRIPT STUFF

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
"Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'
" Enable deoplete at startup
"let g:deoplete#enable_at_startup = 1

call plug#end()