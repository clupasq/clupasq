" Must come first because it changes other options.
set nocompatible

" 256 colors...
set t_Co=256

" Turn on syntax highlighting.
syntax enable

let mapleader = " "

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
Plug 'tomtom/tcomment_vim'
Plug 'henrik/vim-indexed-search'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-runner'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wincent/loupe'
Plug 'editorconfig/editorconfig-vim'
Plug 'danro/rename.vim'
Plug 'b4winckler/vim-angry'
Plug 'itchyny/vim-haskell-indent'
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'Olical/vim-expand'

let isFzfPresent = executable('fzf')
if isFzfPresent
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"""" VIM - align """"""""""""""""""
Plug 'junegunn/vim-easy-align'
"""""""""""""""""""""""""""""""""""

Plug 'dense-analysis/ale'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

if !empty($USE_COPILOT)
  Plug 'github/copilot.vim'
endif

call plug#end()

" ========================
" PLUGIN SETTINGS
" ========================

let g:airline_theme = "supernova"

let g:VtrUseVtrMaps = 1

let g:highlightedyank_highlight_duration = 200

let g:ale_linters = {'javascript': ['eslint']}             " Fix: was b:ale_linters (buffer-local, ineffective at startup)

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" CtrlP
if !isFzfPresent
  let g:ctrlp_custom_ignore = 'node_modules\|git'
endif

" FZF
if isFzfPresent
  nnoremap <c-p> :FZF<cr>
  nnoremap <leader>F :Lines<cr>
  nnoremap <leader>f :BLines<cr>
  nnoremap <leader>b :Buffers<cr>
endif

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

" VimTmuxRunner
let g:VtrStripLeadingWhitespace = 0
let g:VtrAppendNewline = 1
let g:pymode_python = 'python3'

" Netrw
let g:netrw_liststyle = 3


" ========================
" GENERAL SETTINGS
" ========================

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
set sidescrolloff=3

set title                                                  " Set the terminal's title

set visualbell                                             " No beeping.

set fillchars=vert:┃                                       " Nice vertical separators

set foldmethod=indent
set foldlevelstart=20                                      " No folding when opening files

if exists('$SUDO_USER')
  set nobackup                                             " don't create root-owned files
  set nowritebackup                                        " don't create root-owned files
else
  set backupdir=~/.vim/tmp/backup                          " keep backup files out of the way
  set backupdir+=.
endif

set cursorline                                             " highlight current line

if exists('$SUDO_USER')
  set noswapfile                                           " don't create root-owned files
else
  set directory=~/.vim/tmp/swap//                          " keep swap files out of the way
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                         " don't create root-owned files
  else
    set undodir=~/.vim/tmp/undo                            " keep undo files out of the way
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
      set viminfo+=n~/.vim/tmp/viminfo                     " override ~/.viminfo default
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
  endif
endif

set mouse=a                                                " Use the mouse if available for scaling wins, activating tabs.

set list lcs=trail:·,tab:»·

if has('linebreak')
  let &showbreak='╰ '
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

set lazyredraw                                             " don't bother updating screen during macro playback

function! g:MakeBackgroundTransparent()
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
endfunction

try
  colorscheme jellybeans
  call MakeBackgroundTransparent()
catch /^Vim\%((\a\+)\)\=:E185/
  " deal with it
endtry

if filereadable(".vimrc.local")
  source .vimrc.local
endif


" ========================
" MAPPINGS
" ========================

" VISUAL
" ------
" use ctrl+direction to switch windows
xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l

" COMMAND
" -------
" commandline style go to beginning/end
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" NORMAL
" ------
" avoid pressing Q to go to Ex mode
nnoremap Q q

" make Y behave like C, D
noremap Y y$

" Ctrl+dir navigation between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Repurpose cursor keys for use with the quickfix window
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" LEADER
" ------
" use leader leader to switch between file and alt file
nnoremap <Leader><Leader> <C-^>

" Show the path of the current file
nnoremap <Leader>p :echo expand('%')<CR>

" Edit file, starting in same directory as current file.
nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" VimTmuxRunner - run current paragraph
nnoremap <Leader>sp myvip:VtrSendLinesToRunner<CR>`y


" ========================
" AUTOCOMMANDS
" ========================

augroup filetype_overrides
  autocmd!
  " still useful while not in develop's version of .editorconfig
  autocmd FileType typescript setlocal shiftwidth=4 tabstop=4
  autocmd FileType php setlocal shiftwidth=4 tabstop=4
  " OSM files as XML
  autocmd BufNewFile,BufRead *.osm set filetype=xml
  autocmd BufNewFile,BufRead *.osc set filetype=xml
  " GEOJSON files as JSON
  autocmd BufNewFile,BufRead *.geojson set filetype=json
  " Jenkinsfile is written in Groovy
  autocmd BufNewFile,BufRead Jenkinsfile set syntax=groovy
augroup end
