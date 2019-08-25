" Vundle + plugin delcs {{{
set shell=/bin/bash
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jgdavey/tslime.vim'

" Wiki
Plugin 'vimwiki/vimwiki'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'

" IDE
Plugin 'lyuts/vim-rtags'
"Plugin 'jeaye/color_coded'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'

" Search and browsing
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" Editing Enhancements
Plugin 'altercation/vim-colors-solarized'
Plugin 'Raimondi/delimitMate'
Plugin 'justinmk/vim-sneak'
"Plugin 'MaryHal/AceJump.vim' get this working!!!
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/Align'
Plugin 'junegunn/vim-easy-align'
Plugin 'godlygeek/tabular'

" Haskell
Plugin 'neovimhaskell/haskell-vim'
"Plugin 'enomsg/vim-haskellConcealPlus' learn 'the ascii way' first..
Plugin 'Shougo/vimproc.vim'  "requirement of ghcmod-vim and vim-delve
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'Twinside/vim-hoogle'
Plugin 'mpickering/hlint-refactor-vim'

" Elm
Plugin 'ElmCast/elm-vim'

" Go
Plugin 'fatih/vim-go'
Plugin 'sebdah/vim-delve'
Plugin 'Shougo/vimshell.vim' " requirement for vim-delve

" Allow pane movement to jump out of vim into tmux
Plugin 'christoomey/vim-tmux-navigator'

" Python
"Plugin 'davidhalter/jedi-vim'
"Plugin 'vim-scripts/Conque-GDB'
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" General {{{
set number                  " line numbers
syntax on
set nohlsearch              " stop search highlighting. i can see thx
:let loaded_matchparen = 1  " stop parenthesis highlighting
:let mapleader = " "
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//  " don't dump swp files just anywhere, put 'em here

set background=dark
colorscheme solarized

" Set to auto read when a file is changed from the outside
set autoread
" }}}

" .vimrc specific {{{
augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  if has('nvim')
    autocmd bufwritepost init.vim source $MYVIMRC
  else
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
augroup END
" }}}

" Vim UI {{{
" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
set t_Co=256

" Force redraw
map <silent> <leader>r :redraw!<CR>

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Makes search act like search in modern browsers
set incsearch

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" close every window in current tabview but the current
nnoremap <leader>bo <c-w>o

" }}}

" Customised mappings {{{
" substitute word under the cursor
:nnoremap <Leader>s :.,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" append a semi-colon at end of line and escape to normal mode. Useful for
" c-style coding and best used in conjunction with Raimondi/delimitMate
:inoremap <C-e> A;

" bring up list of recently accessed files
:nnoremap <Leader>f :bro old

" map clang-formatter
map <C-K> :pyf /usr/share/clang/clang-format-3.8/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format-3.8/clang-format.py<cr>
" }}}

" Use ripgrep when we can {{{
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'

  " also use rg for ack
  let g:ackprg = 'rg --vimgrep --no-heading'
endif
" }}}

" CtrlP config {{{
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work)$' }
" }}}

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless the file is already
" using tabs, in which case tabs will be inserted.
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Copy and paste to os clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Alignment {{{

" easy-align config
map ga <Plug>(EasyAlign)
map ga <Plug>(EasyAlign)

" Stop Align plugin from forcing its mappings on us
"let g:loaded_AlignMapsPlugin=1
" Align on equal signs
"map <Leader>a= :Align =<CR>
" Align on commas
"map <Leader>a, :Align ,<CR>
" Align on pipes
"map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
"map <leader>ap :Align
" Align on double quotes
"map <leader>a" :Align "
" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" }}}

" tagbar {{{

map <leader>tb :TagbarToggle<CR>

set tags=tags;/
set cst
set csverb

" }}}

" Git {{{

let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
nmap <leader>gs :Gstatus<CR>
nmap <leader>gg :copen<CR>:GGrep 
nmap <leader>gl :Extradite!<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfunction

" Show list of last-committed files
nnoremap <silent> <leader>g? :call CommittedFiles()<CR>:copen<CR>

" }}}

" Completion {{{
set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" }}}

" Slime {{{

vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" }}}

" Source Haskell {{{
let haskell_config = $HOME . "/.vimrc.haskell"
execute 'source '. haskell_config
" }}}

" Ale error display {{{
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
" }}}

" only use linters that uses compile_commands.json
let g:ale_linters.cpp = ['clangcheck', 'clangtidy', 'cppcheck']

" clang-fromat
map <C-I> :pyf ~/llvmInstalls/llvm-gcc-14-02-2018/share/clang/clang-format.py<cr>
imap <C-I> <c-o>:pyf ~/llvmInstalls/llvm-gcc-14-02-2018/share/clang/clang-format.py<cr>

let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
