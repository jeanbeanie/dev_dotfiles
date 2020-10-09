nnoremap ; :

" undo settings
set undofile                       " store undofile
set undodir=~/.config/nvim/undodir " undo file dir
set undolevels=90000               " max number of undos

set tabstop=2 shiftwidth=2 expandtab smarttab
set updatetime=100


" COLOR SETTINGS
syntax enable
set t_Co=256
set number
colorscheme 1989

" Override colorscheme for dark transparent background
hi Normal guibg=NONE ctermbg=NONE
hi Nontext guibg=NONE ctermbg=NONE

" Sign column and status line related things
"set signcolumn=yes
highlight SignColumn guibg=black ctermbg=black
highlight LineNr ctermfg=grey ctermbg=black
highlight StatusLineNC ctermfg=magenta ctermbg=black
highlight StatusLine ctermfg=white ctermbg=darkmagenta
highlight GitGutterAdd    guifg=#009900 ctermfg=2 ctermbg=black
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=black
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=black
highlight VertSplit ctermfg=darkgrey ctermbg=black

"PACKAGE MANAGEMENT
" don't forget to :PlugInstall
call plug#begin('~/.config/nvim/plugged')

Plug 'leafgarland/typescript-vim', {'build':'./install.sh'}  " ts type checking
Plug 'Quramy/tsuquyomi'  " ts completions
Plug 'neoclide/coc.nvim', {'branch': 'release'} " general lsp competions
Plug 'flazz/vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim' " file fuzzyfinder ctrl+p 
Plug 'roxma/vim-tmux-clipboard' " yank to tmux clipboard
Plug 'tpope/vim-fugitive' " many advanced git operations :Gblame :Glog etc
Plug 'itchyny/vim-cursorword' " underline the word under the cursor
Plug 'machakann/vim-highlightedyank' " highlight yanked content
Plug 'airblade/vim-gitgutter' "git gutter goodness
let g:gitgutter_set_sign_backgrounds = 1

Plug 'vim-airline/vim-airline' " top buffer tabs
Plug 'vim-airline/vim-airline-themes'
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'


if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For Denite features
Plug 'Shougo/denite.nvim'


call plug#end()
