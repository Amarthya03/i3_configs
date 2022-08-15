" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer / NERDTree
    Plug 'scrooloose/NERDTree'
    " NERDTree Icons
    Plug 'ryanoasis/vim-devicons'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Tagbar
    Plug 'preservim/tagbar'
    " Fuzzy Finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'    
    " Vim Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Vim ctrlspace
    Plug 'vim-ctrlspace/vim-ctrlspace'
    " Syntax highlighting for NERDTree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Palenight theme
    Plug 'drewtempelmeyer/palenight.vim'    
call plug#end()

