set number

call plug#begin()
 Plug 'itchyny/lightline.vim'
 Plug 'blueshirts/darcula'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
call plug#end()

let g:lightline = { 'colorscheme': 'one' }

set termguicolors
colorscheme darcula

nmap <C-S-UP> :m-2<CR>  
nmap <C-S-DOWN> :m+1<CR>
nmap <C-d> yyp
map <C-S-n> :Telescope find_files<CR>

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_alto = 1
let g:netrw_altv = 1

let mapleader=" "
nnoremap <leader>ff <cmd>Telescop find_files<cr>
nnoremap <leader>fg <cmd>Telescop live_grep<cr>
nnoremap <leader>fb <cmd>Telescop buffers<cr>

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "v"},
  highlight = {
    enable = true,
  },
}
EOF
