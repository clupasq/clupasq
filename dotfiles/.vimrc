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

Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
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
Plug 'b4winckler/vim-angry'
Plug 'itchyny/vim-haskell-indent'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'Olical/vim-expand'
let g:highlightedyank_highlight_duration = 200

let isFzfPresent = executable('fzf')
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

Plug 'maxmellon/vim-jsx-pretty'

" Completion
" Plug 'HerringtonDarkholme/yats.vim'
let isNodeInstalled = executable('node')
if isNodeInstalled && has('nvim')
  Plug 'honza/vim-snippets'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  " Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  " Plug 'jparise/vim-graphql'

  " coc-snippets tab completion
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  let g:coc_snippet_next = '<tab>'
  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'
  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'
  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  " set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  " xmap <leader>f  <Plug>(coc-format-selected)
  " nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>x  <Plug>(coc-codeaction-selected)
  nmap <leader>x  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>a  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>d  :<C-u>CocList diagnostics<cr>
  " " Manage extensions.
  " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " " Show commands.
  " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  nnoremap <silent><nowait> <space>i  :<C-u>CocFix<CR>
  " Resume latest coc list.
  " nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

  " Scroll in COC popups
  nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

endif

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
  set backupdir=~/.vim/tmp/backup                         " keep backup files out of the way
  set backupdir+=.
endif

set cursorline                                             " highlight current line

if exists('$SUDO_USER')
  set noswapfile                                           " don't create root-owned files
else
  set directory=~/.vim/tmp/swap//                         " keep swap files out of the way
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                         " don't create root-owned files
  else
    set undodir=~/.vim/tmp/undo                           " keep undo files out of the way
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
  " Transparency in text and non-text background
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
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
let g:VtrAppendNewline = 1
let g:pymode_python = 'python3'

" still useful while not in develop's version of .editorconfig
autocmd FileType typescript setlocal shiftwidth=4 tabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4
"=====================

" OSM files as XML
autocmd BufNewFile,BufRead *.osm set filetype=xml
autocmd BufNewFile,BufRead *.osc set filetype=xml
" GEOJSON files as JSON
autocmd BufNewFile,BufRead *.geojson set filetype=json
" ==================

let g:netrw_liststyle = 3
