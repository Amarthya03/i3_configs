set number
set relativenumber
set nocompatible
set hidden
set encoding=utf-8
" let g:CtrlSpaceDefaultMappingKey = "<C-space> "
set tabstop=4

source $HOME/.config/nvim/vim-plug/plugins.vim

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Theme
" set background=dark
" colorscheme palenight
" let g:lightline = { 'colorscheme': 'palenight' }
" let g:airline_theme = "palenight"

" Mappings
" Basic Mappings
" nnoremap <C-w> :q <Cr>

" Splits
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-Left> :vertical resize +3 <Cr>
nnoremap <C-Right> :vertical resize -3 <Cr>
nnoremap <C-Up> :resize +3 <Cr>
nnoremap <C-Down> :resize -3 <Cr>

" Terminal 
nnoremap <C-t> :terminal <Cr>

" Plugin Mappings
" Fuzzy Finder
nnoremap <C-p> :Files <Cr>
" NERDTree
nnoremap <C-b> :NERDTreeToggle <Cr>

