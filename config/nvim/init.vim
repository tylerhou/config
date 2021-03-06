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
Plug 'jparise/vim-graphql'

" Add jsx syntax highlighting to TypeScript
Plug 'leafgarland/typescript-vim'
autocmd BufNewFile,BufRead *.ts  set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype typescript.jsx

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

"   set hidden

"   let g:LanguageClient_serverCommands = {
"       \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
"       \ 'reason': ['ocaml-language-server', '--stdio'],
"       \ 'ocaml': ['ocaml-language-server', '--stdio'],
"       \ 'typescript': ['javascript-typescript-stdio'],
"       \ 'javascript': ['javascript-typescript-stdio'],
"       \ }

"   let g:LanguageClient_rootMarkers = {
"     \ 'javascript': ['jsconfig.json'],
"     \ 'typescript': ['tsconfig.json'],
"     \ }

"   " Automatically start language servers.
"   let g:LanguageClient_autoStart = 1

"   Plug 'reasonml-editor/vim-reason-plus'

" Disabled because of interactions with coc.vim
" Plug 'tpope/vim-endwise'
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
    set spell noci nosi noai nolist noshowmode noshowcmd linebreak
    " let &background = ( &background == "light" ? "dark" : "light" )
    let b:complete = &complete
    set complete+=s
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

    noremap j gj
    noremap k gk
    noremap 0 g0
    noremap $ g$
  endfunction

  function! s:goyo_leave()
    Limelight!
    set nospell ci si ai noshowmode showcmd nolinebreak
    " let &background = ( &background == "light" ? "dark" : "light" )
    let &complete = b:complete
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
        qa
      endif
    endif

    unmap j
    unmap k
    unmap 0
    unmap $
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

  nmap <leader>p :Goyo<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nmap <silent> <leader><space> :Files<CR>
  nmap <silent> <leader>f :Buffers<CR>
  nmap <silent> <leader>? :History<CR>

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

Plug 'sbdchd/neoformat'
  augroup fmt
    autocmd!
    autocmd BufWritePre * | Neoformat
  augroup END

Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> coc#refresh()

  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
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
  xmap <silent> gf  <Plug>(coc-format-selected)
  nmap <silent> gf  <Plug>(coc-format-selected)

  let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ ]

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

" Breaks coc definition window.
" set winheight=40
set winwidth=82

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

" Transparent background, for better rendering with Alacritty.
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE

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

