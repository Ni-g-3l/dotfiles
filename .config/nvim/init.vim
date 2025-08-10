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
map <C-s> :w<CR>
map <C-S-UP> :m-2<CR>
map <C-S-DOWN> :m+1<CR>
map <C-d> yyp
map <C-S-n> :Telescope find_files<CR>
map <C-S-f> :Telescope live_grep<CR>
map <C-S-b> :Telescope buffers<CR>
map <C-S-T> :terminal<CR>

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_alto = 1
let g:netrw_altv = 1


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "v"},
  highlight = {
    enable = true,
  },
}
EOF
