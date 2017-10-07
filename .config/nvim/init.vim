set nocompatible              " be iMproved, required

" autoinstall vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'pangloss/vim-javascript' ", { 'for': 'javascript' }
Plug 'mxw/vim-jsx' ", { 'for': 'javascript' }

Plug 'tpope/vim-surround'

Plug 'iCyMind/NeoSolarized'

Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

Plug 'christoomey/vim-tmux-navigator'
Plug 'zephod/vim-iterm2-navigator'
call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Make backspace work.
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
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

" Open and close NERDTree easily
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

let g:jsx_ext_required = 0

" Ctrl-P settings
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
" Make Ctrl-P ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
