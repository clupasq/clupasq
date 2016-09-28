set nocompatible                                           " Must come first because it changes other options.

set t_Co=256                                               " 256 colors...

syntax enable                                              " Turn on syntax highlighting.

runtime macros/matchit.vim                                 " Load the matchit plugin.

set showcmd                                                " Display incomplete commands.
set showmode                                               " Display the mode you're in.

set backspace=indent,eol,start                             " Intuitive backspacing.

set hidden                                                 " Handle multiple buffers better.

set wildmenu                                               " Enhanced command line completion.
set wildmode=list:longest                                  " Complete files like a shell.

set ignorecase                                             " Case-insensitive searching.
set smartcase                                              " But case-sensitive if expression contains a capital letter.

set number                                                 " Show line numbers.
set relativenumber
set ruler                                                  " Show cursor position.

set incsearch                                              " Highlight matches as you type.
set hlsearch                                               " Highlight matches.

set wrap                                                   " Turn on line wrapping.
set scrolloff=3                                            " Show 3 lines of context around the cursor.

set title                                                  " Set the terminal's title

set visualbell                                             " No beeping.


if exists('$SUDO_USER')
  set nobackup                                             " don't create root-owned files
  set nowritebackup                                        " don't create root-owned files
else
  set backupdir=~/local/.vim/tmp/backup
  set backupdir+=~/.vim/tmp/backup                         " keep backup files out of the way
  set backupdir+=.
endif

set cursorline                                             " highlight current line

if exists('$SUDO_USER')
  set noswapfile                                           " don't create root-owned files
else
  set directory=~/local/.vim/tmp/swap//
  set directory+=~/.vim/tmp/swap//                         " keep swap files out of the way
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                         " don't create root-owned files
  else
    set undodir=~/local/.vim/tmp/undo
    set undodir+=~/.vim/tmp/undo                           " keep undo files out of the way
    set undodir+=.
    set undofile                                           " actually use undo files
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                                           " don't create root-owned files
  else
    if isdirectory('~/local/.vim/tmp')
      set viminfo+=n~/local/.vim/tmp/viminfo
    else
      set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
    endif

    if !empty(glob('~/.vim/tmp/viminfo'))
      if !filereadable(expand('~/.vim/tmp/viminfo'))
        echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif

set mouse=a                                                " Use the mouse if available for scaling wins, activating tabs.

set list lcs=trail:·,tab:»·

if has('linebreak')
  let &showbreak='⤷ '                                      " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

set tabstop=2                                              " Global tab width.
set shiftwidth=2                                           " And again, related.
set expandtab                                              " Use spaces instead of tabs

set laststatus=2                                           " Show the status line all the time
" Useful status information at bottom of screen

set lazyredraw                                             " don't bother updating screen during macro playback

" vundle init
set nocompatible                                           " be iMproved, required
filetype off                                               " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|git'
Plugin 'ngmy/vim-rubocop'
Plugin 'scrooloose/nerdcommenter'
Plugin 'henrik/vim-indexed-search'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'mattn/emmet-vim'
Plugin 'bogado/file-line'
Plugin 'bronson/vim-trailing-whitespace'
let g:VtrUseVtrMaps = 1
Plugin 'christoomey/vim-tmux-runner'
Plugin 'tpope/vim-surround'
Plugin 'wincent/loupe'


"""" ULTISNIPS """"""""""""""""""""
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"""""""""""""""""""""""""""""""""""

"  " The following are examples of different formats supported.
"  " Keep Plugin commands between vundle#begin/end.
"  " plugin on GitHub repo
"  Plugin 'tpope/vim-fugitive'
"  " plugin from http://vim-scripts.org/vim/scripts.html
"  Plugin 'L9'
"  " Git plugin not hosted on GitHub
"  Plugin 'git://git.wincent.com/command-t.git'
"  " git repos on your local machine (i.e. when working on your own plugin)
"  Plugin 'file:///home/gmarik/path/to/plugin'
"  " The sparkup vim script is in a subdirectory of this repo called vim.
"  " Pass the path to set the runtimepath properly.
"  Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"  " Install L9 and avoid a Naming conflict if you've already installed a
"  " different version somewhere else.
"  Plugin 'ascenator/L9', {'name': 'newL9'}
"
" All of your Plugins must be added before the following line
call vundle#end()                                          " required
filetype plugin indent on                                  " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ========================================

colorscheme jellybeans

let mapleader = " "

if filereadable(".vimrc.local")
  source .vimrc.local
endif

" ========
" MAPPINGS
" ========

" VISUAL
" ========
" use ctrl+direction to switch windows
xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l

" COMMAND
" ========
" commandline style go to beginning/end
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" NORMAL
" ========
" avoid pressing Q to go to Ex mode
nnoremap Q q

" make Y behave like C, D
noremap Y y$

" Ctrl+dir navigation between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" unset K (manual lookup)
nnoremap K <nop>

" Repurpose cursor keys for use with the quickfix window
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" Use - to open the folder the current file is in
"nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" LEADER
" ========
" use leader leader to switch between file and alt file
nnoremap <Leader><Leader> <C-^>

" <Leader>p -- Show the path of the current file (mnemonic: path; useful when
" you have a lot of splits and the status line gets truncated).
nnoremap <Leader>p :echo expand('%')<CR>

" <LocalLeader>e -- Edit file, starting in same directory as current file.
nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
