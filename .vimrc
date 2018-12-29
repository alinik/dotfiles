set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set number
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=5
set laststatus=2
set nobackup
set noswapfile
set background=dark 
set encoding=utf-8
set noerrorbells

colorscheme solarized 
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
