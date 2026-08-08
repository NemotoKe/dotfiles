syntax enable
set background=dark
set termguicolors
set number relativenumber
set cursorline

colorscheme synthwave84
highlight Statement guifg=#35FFF2 gui=bold


" Markdownを読みやすくする
autocmd FileType markdown setlocal wrap linebreak breakindent
autocmd FileType markdown setlocal conceallevel=0
autocmd FileType markdown setlocal spelllang=en_us

highlight markdownH1 guifg=#FF4FD8 gui=bold
highlight markdownH2 guifg=#35FFF2 gui=bold
highlight markdownH3 guifg=#9D7BFF gui=bold
highlight markdownCode guifg=#5CFFB0
highlight markdownCodeBlock guifg=#5CFFB0

" ============================================================
" Plugins
" ============================================================
call plug#begin('~/.vim/plugged')

" Neo-tree
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x' }

" Search
Plug 'kevinhwang91/nvim-hlslens'

" Keymap helper
Plug 'folke/which-key.nvim'

" Scrollbar
Plug 'petertriho/nvim-scrollbar'

" Git diff
Plug 'sindrets/diffview.nvim'

Plug 'tpope/vim-commentary'
Plug 'dominikduda/vim_current_word'
Plug 'bullets-vim/bullets.vim'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

call plug#end()

" ============================================================
" Basic
" ============================================================
let mapleader = " "

set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set number
set cursorline
set wildmenu

" Escで検索ハイライト解除
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" ============================================================
" File navigation
" ============================================================

" Space + e : ファイルツリー
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" Space + p : プロジェクト内のファイル検索
nnoremap <silent> <leader>p :CtrlP<CR>

" Space + b : 開いているバッファ検索
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Space + r : 最近開いたファイル
nnoremap <silent> <leader>r :CtrlPMRUFiles<CR>

" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1

" ============================================================
" Git
" ============================================================

" Space + g : Gitステータス
nnoremap <silent> <leader>g :Git<CR>

" Space + gd : 現在の変更差分
nnoremap <silent> <leader>gd :Gdiffsplit<CR>

" Space + gb : 行の変更履歴
nnoremap <silent> <leader>gb :Git blame<CR>

" Space + gc : コミット
nnoremap <silent> <leader>gc :Git commit<CR>

" Space + gp : push
nnoremap <silent> <leader>gp :Git push<CR>

" ============================================================
" Comment
" ============================================================

" 標準操作
" gcc      : 現在行をコメント切替
" gc{移動} : 範囲をコメント切替
" 選択→gc  : 選択範囲をコメント切替

" Space + / でもコメント切替
nmap <leader>/ gcc
xmap <leader>/ gc

" ============================================================
" Search
" ============================================================

" カーソル下の単語を検索
nnoremap <silent> <leader>s :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<CR>n

" 次・前の検索結果
nnoremap <silent> ]s n
nnoremap <silent> [s N

" ============================================================
" Indent guides
" ============================================================

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" Space + i : インデントガイド切替
nnoremap <silent> <leader>i :IndentGuidesToggle<CR>

" ============================================================
" Bullets
" ============================================================

let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit'
      \ ]

" ============================================================
" CtrlP
" ============================================================

let g:ctrlp_map = ''
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1

" node_modulesやGit内部は除外
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|node_modules|target|build|dist)$',
      \ 'file': '\v\.(class|jar|war|log)$'
      \ }

