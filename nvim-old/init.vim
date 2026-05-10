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
