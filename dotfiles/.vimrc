set nocompatible                                           " Must come first because it changes other options.

set t_Co=256                                               " 256 colors...

syntax enable                                              " Turn on syntax highlighting.


" vundle init
set nocompatible                                           " be iMproved, required
filetype off                                               " required

let mapleader = " "

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

let isFzfPresent = executable('fzf')

Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
Plug 'vale1410/vim-minizinc'
Plug 'ngmy/vim-rubocop'
Plug 'tomtom/tcomment_vim'
Plug 'henrik/vim-indexed-search'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme="base16_ocean"
"Plug 'Valloric/YouCompleteMe'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'bronson/vim-trailing-whitespace'
let g:VtrUseVtrMaps = 1
Plug 'christoomey/vim-tmux-runner'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wincent/loupe'
Plug 'editorconfig/editorconfig-vim'
Plug 'danro/rename.vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim'
if isFzfPresent
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  nnoremap <c-p> :FZF<cr>
  nnoremap <leader>F :Lines<cr>
  nnoremap <leader>f :BLines<cr>
  nnoremap <leader>b :Buffers<cr>
else
  Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_custom_ignore = 'node_modules\|git'
endif
Plug 'b4winckler/vim-angry'
Plug 'vim-syntastic/syntastic'

Plug 'udalov/kotlin-vim'

Plug 'HerringtonDarkholme/yats.vim'
if has("nvim")
  Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  " For async completion
  Plug 'Shougo/deoplete.nvim'
  " For Denite features
  Plug 'Shougo/denite.nvim'

  " Java
  Plug 'artur-shaik/vim-javacomplete2'
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd BufWritePost *.java
      \ if filereadable('tags') |
      \   call system('ctags -a '.expand('%')) |
      \ endif

endif

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

"""" VIM - align """"""""""""""""""
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"""""""""""""""""""""""""""""""""""


"""" FZF send to quickfix """"""""""""""""""""
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

function! g:FZFGitOnly()
    let $FZF_DEFAULT_COMMAND=' (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'
endfunction

function! g:FZFAllFiles()
    let $FZF_DEFAULT_COMMAND="command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
endfunction

"""""""""""""""""""""""""""""""""""

"""" ULTISNIPS """"""""""""""""""""
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"""""""""""""""""""""""""""""""""""

call plug#end()

filetype plugin indent on



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
set sidescrolloff=3                                        " Same as above, but horizontally

set title                                                  " Set the terminal's title

set visualbell                                             " No beeping.

set fillchars=vert:┃                                       " Nice vertical separators

set foldmethod=indent
set foldlevelstart=20                                      " No indentation when opening files

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

if has('mksession')
  if isdirectory('~/local/.vim/tmp')
    set viewdir=~/local/.vim/tmp/view
  else
    set viewdir=~/.vim/tmp/view                            " override ~/.vim/view default
  endif                                                    " save/restore just these (with `:{mk,load}view`)
endif

set mouse=a                                                " Use the mouse if available for scaling wins, activating tabs.

set list lcs=trail:·,tab:»·

if has('linebreak')
  let &showbreak='╰ '                                      " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

set shortmess+=A                                           " ignore annoying swapfile messages
set shortmess+=I                                           " no splash screen
set shortmess+=O                                           " file-read message overwrites previous
set shortmess+=T                                           " truncate non-file messages in middle
set shortmess+=W                                           " don't echo "[w]"/"[written]" when writing
set shortmess+=a                                           " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                                           " overwrite file-written messages
set shortmess+=t                                           " truncate file messages at start

set splitright                                             " vertical splits open new window to the right
set splitbelow                                             " horizontal splits open new window to the bottom

set tabstop=4                                              " Global tab width.
set shiftwidth=4                                           " And again, related.
set shiftround                                             " always indent by multiple of shiftwidth
set expandtab                                              " Use spaces instead of tabs

set laststatus=2                                           " Show the status line all the time
" Useful status information at bottom of screen

set lazyredraw                                             " don't bother updating screen during macro playback

" Dark
" ----
" jellybeans
" lucius
" wombat256dave
" seoul256
" iceberg
" darth
" lizard256
"
"
" Very Dark
" ---------
" hybrid
" sorcerer
" spacegray
"
"
" Light
" -----
" hybrid-light
" summerfruit256

try
  " colorscheme Atelier_EstuaryDark
  colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

if filereadable(".vimrc.local")
  source .vimrc.local
endif


" syntactic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['java'] }

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


" VimTmuxRunner - run current paragraph
nnoremap <Leader>sp myvip:VtrSendLinesToRunner<CR>`y

" Python things
let g:VtrStripLeadingWhitespace = 0
" let g:VtrClearEmptyLines = 0
" let g:VtrAppendNewline = 1
let g:pymode_python = 'python3'


" TypeScript bindings
autocmd FileType typescript nnoremap <buffer> <Leader>r :TSRename<cr>
autocmd FileType typescript nnoremap <buffer> <Leader>i :TSGetCodeFix<cr>
autocmd FileType typescript nnoremap <buffer> <Leader>x :TSGetErrorFull<cr>
autocmd FileType typescript nnoremap <buffer> <Leader>t :TSType<cr>
autocmd FileType typescript nnoremap <buffer> <Leader>d :TSDoc<cr>
autocmd FileType typescript nnoremap <buffer> <c-]> :TSDef<cr>
autocmd FileType typescript nnoremap <buffer> <c-^> :TSRefs<cr>

autocmd FileType typescript setlocal foldmethod=syntax

" still useful while not in develop's version of .editorconfig
autocmd FileType typescript setlocal shiftwidth=4 tabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4
"=====================

let g:netrw_liststyle = 3
