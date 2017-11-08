set nocompatible              " be iMproved, required
let g:mapleader = "\<Space>"

" autoinstall vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-endwise'
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'

Plug 'bronson/vim-trailing-whitespace'

Plug 'iCyMind/NeoSolarized'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
  function! s:goyo_enter()
    Limelight
    set spell noci nosi noai nolist noshowmode noshowcmd
    let &background = ( &background == "light" ? "dark" : "light" )
    let b:complete = &complete
    set complete+=s
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  endfunction

  function! s:goyo_leave()
    Limelight!
    set nospell ci si ai noshowmode showcmd
    let &background = ( &background == "light" ? "dark" : "light" )
    let &complete = b:complete
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
        qa
      endif
    endif
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

  nmap <leader>p :Goyo<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nmap <silent> <leader><space> :ProjectFiles<CR>
  nmap <silent> <leader>f :Buffers<CR>
  nmap <silent> <leader>? :History<CR>

  " Try to search in git root, then fallback to current directory
  function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  endfunction

  command! ProjectFiles execute 'Files' s:find_git_root()

Plug 'scrooloose/nerdtree'
  nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
  nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_sign_added = '∙'
  let g:gitgutter_sign_modified = '∙'
  let g:gitgutter_sign_removed = '∙'
  let g:gitgutter_sign_modified_removed = '∙'

Plug 'christoomey/vim-tmux-navigator'
Plug 'zephod/vim-iterm2-navigator'

Plug 'tpope/vim-unimpaired'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'

Plug 'jeffkreeftmeijer/vim-numbertoggle'
  set number relativenumber

call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Make backspace work on indents.
set backspace=indent,eol,start

" Python syntax highlighting
let python_highlight_all=1

" 80 character column highlight
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=235
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Remap split navigation
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" More natural split openings
set splitbelow
set splitright

" Faster escape
inoremap kj <Esc>

" Disable escape on insert
inoremap <ESC> <NOP>

autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab

" Reload on file write
set autoread

" Buffer around cursor
set scrolloff=6

" Set true colors (NeoVim)
set termguicolors

" Python bindings
let g:python_host_prog = '/Users/tyler/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/tyler/.pyenv/versions/neovim3/bin/python'

" Turn on syntax highlighting
set background=dark
colorscheme NeoSolarized

" Airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" Enable powerline symbols
set encoding=utf-8

" Mouse mode!
set mouse=a

" Auto change directories
set autochdir

" Open and close NERDTree easily
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

let g:jsx_ext_required = 0

" " Ctrl-P settings
" let g:ctrlp_max_files=0
" let g:ctrlp_max_depth=40
" " Make Ctrl-P ignore files in .gitignore
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'rg --files %s']
"
" let g:path_to_matcher = '/usr/local/bin/matcher'
" let g:ctrlp_match_func = { 'match': 'GoodMatch' }
"
" function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
"
  " " Create a cache file if not yet exists
  " let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  " if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    " call writefile(a:items, cachefile)
  " endif
  " if !filereadable(cachefile)
    " return []
  " endif
"
  " " a:mmode is currently ignored. In the future, we should probably do
  " " something about that. the matcher behaves like "full-line".
  " let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  " if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    " let cmd = cmd.'--no-dotfiles '
  " endif
  " let cmd = cmd.a:str
"
  " return split(system(cmd), "\n")
"
" endfunction

