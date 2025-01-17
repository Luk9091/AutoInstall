syntax on


" set number relativenumber
set number
set nowrap

" Use 4 spaces as tab
set smartindent
" set tabstop=4
set expandtab
set shiftwidth=4

set noswapfile
set nohlsearch


" Esc to inser



" Use Ctrl+s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
