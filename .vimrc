set nocompatible              " be iMproved, required

" autoinstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elmcast/elm-vim'
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

" Disable arrow keys
inoremap   <Up>     <NOP>
inoremap   <Down>   <NOP>
inoremap   <Left>   <NOP>
inoremap   <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

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

" Turn on syntax highlighting
set background=dark
colorscheme solarized
