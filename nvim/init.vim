" ============================================================
" Runtimepath & Plugin initialization
" ============================================================
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ============================================================
" Plugins
" ============================================================
call plug#begin('~/.vim/plugged')

" File explorer
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x' }

" Search & UI
Plug 'kevinhwang91/nvim-hlslens'
Plug 'folke/which-key.nvim'
Plug 'petertriho/nvim-scrollbar'

" Git
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'dominikduda/vim_current_word'
Plug 'bullets-vim/bullets.vim'
Plug 'nathanaelkane/vim-indent-guides'

" Navigation & buffers
Plug 'ctrlpvim/ctrlp.vim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'

call plug#end()

" ============================================================
"  Auto Read
"" ============================================================

set autoread

augroup autoread
  autocmd!
  autocmd FocusGained,BufEnter * checktime
augroup END

" ============================================================
" Appearance & Basic Settings
" ============================================================
syntax enable
filetype plugin indent on
set background=dark
set termguicolors
set clipboard=unnamedplus

set number relativenumber
set cursorline
set wildmenu
set mouse=a

colorscheme synthwave84
highlight Statement guifg=#35FFF2 gui=bold

" Markdown highlights
highlight! @markup.heading.1.markdown guifg=#FF4FD8 gui=bold
highlight! @markup.heading.2.markdown guifg=#35FFF2 gui=bold
highlight! @markup.heading.3.markdown guifg=#9D7BFF gui=bold
highlight! @markup.raw.markdown_inline guifg=#5CFFB0
highlight! @markup.raw.block.markdown guifg=#5CFFB0

" Git Diff
highlight DiffAdd    guibg=#16352a guifg=NONE
highlight DiffDelete guibg=#351d2a guifg=NONE
highlight DiffChange guibg=#1b2d40 guifg=NONE
highlight DiffText   guibg=#4a315f guifg=NONE gui=bold

" ============================================================
" Search & Navigation
" ============================================================
let mapleader = " "

set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden

" Escで検索ハイライト解除
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 現在行の上下移動
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" ============================================================
" File Navigation (CtrlP)
" ============================================================
" Space + p : プロジェクト内のファイル検索
nnoremap <silent> <leader>p :CtrlP<CR>

" Space + b : 開いているバッファ検索
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Space + r : 最近開いたファイル
nnoremap <silent> <leader>r :CtrlPMRUFiles<CR>

let g:ctrlp_map = ''
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|node_modules|target|build|dist)$',
      \ 'file': '\v\.(class|jar|war|log)$'
      \ }

" ============================================================
" Search
" ============================================================
" カーソル下の単語を検索
nnoremap <silent> <leader>s :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<CR>n

" 次・前の検索結果
nnoremap <silent> ]s n
nnoremap <silent> [s N

" ============================================================
" Comment (vim-commentary)
" ============================================================
" gcc      : 現在行をコメント切替
" gc{移動} : 範囲をコメント切替
" 選択→gc  : 選択範囲をコメント切替
nmap <leader>/ gcc
xmap <leader>/ gc

" ============================================================
" Indent Guides
" ============================================================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
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
" Git Commands
" ============================================================
" Space + g : Gitステータス
nnoremap <silent> <leader>g :Git<CR>

" Space + gb : 行の変更履歴
nnoremap <silent> <leader>gb :Git blame<CR>

" Space + gc : コミット
nnoremap <silent> <leader>gc :Git commit<CR>

" Space + gp : push
nnoremap <silent> <leader>gp :Git push<CR>

lua << EOF
-- ============================================================
-- Java LSP Configuration
-- ============================================================
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',

  callback = function()
    local config = {
      cmd = { 'jdtls' },

      root_dir = vim.fs.root(0, {
        'gradlew',
        'mvnw',
        'pom.xml',
        'build.gradle',
        'settings.gradle',
        '.git',
      }),

      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = 'JavaSE-21',
                path = os.getenv('JAVA_HOME'),
                default = true,
              },
            },
          },
        },
      },

      init_options = {
        bundles = {},
      },
    }

    require('jdtls').start_or_attach(config)
  end,
})

-- ============================================================
-- LSP Configuration (Python)
-- ============================================================
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Enable completion for BasedPyright
    if client.name == 'basedpyright' then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end

    -- Disable hover for Ruff (use BasedPyright instead)
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    local opts = {
      buffer = args.buf,
      silent = true,
    }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({
        filter = function(c)
          return c.name == 'ruff'
        end,
      })
    end, opts)
  end,
})

-- Format on save with Ruff
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name == 'ruff'
      end,
    })
  end,
})

-- ============================================================
-- Swift LSP Configuration
-- ============================================================

vim.lsp.config('sourcekit', {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift' },
  root_markers = { 'Package.swift', '.git' },
})

vim.lsp.enable('sourcekit')

-- ============================================================
-- Java LSP Configuration
-- ============================================================

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

-- ============================================================
-- Terminal Configuration
-- ============================================================
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.cmd('startinsert')
  end,
})

vim.api.nvim_create_user_command('T', function()
  vim.cmd('botright 20new')
  vim.cmd('terminal')
end, {
  force = true,
})

vim.keymap.set('n', 'T', '<cmd>T<CR>', {
  noremap = true,
  silent = true,
})

vim.keymap.set(
  't',
  '<Esc><Esc>',
  [[<C-\><C-n><C-w>k]],
  { silent = true }
)

-- ============================================================
-- Bufferline Setup
-- ============================================================
require("bufferline").setup({
  options = {
    mode = "buffers",
  }
})

vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>')

-- ============================================================
-- Neo-tree Setup (File Explorer)
-- ============================================================
require("neo-tree").setup({
  close_if_last_window = false,
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },
  window = {
    position = "left",
    width = 35,
  },
})

vim.keymap.set(
  'n',
  '<leader>e',
  '<cmd>Neotree toggle<CR>',
  {
    desc = 'Toggle file explorer',
    silent = true,
  }
)

-- ============================================================
-- Search UI (hlslens)
-- ============================================================
require("hlslens").setup({
  calm_down = true,
})

vim.keymap.set(
  'n',
  'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { silent = true }
)

vim.keymap.set(
  'n',
  'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  { silent = true }
)

-- ============================================================
-- UI Enhancements
-- ============================================================
require("scrollbar").setup()
require("scrollbar.handlers.search").setup()

require("which-key").setup({
  preset = "modern",
})

-- ============================================================
-- Git Diff View (Diffview)
-- ============================================================
require("diffview").setup()

vim.keymap.set(
  'n',
  '<leader>gd',
  '<cmd>DiffviewOpen<CR>',
  {
    desc = 'Open git diff',
    silent = true,
  }
)

vim.keymap.set(
  'n',
  '<leader>gh',
  '<cmd>DiffviewFileHistory %<CR>',
  {
    desc = 'File history',
    silent = true,
  }
)

vim.keymap.set(
  'n',
  '<leader>gq',
  '<cmd>DiffviewClose<CR>',
  {
    desc = 'Close diffview',
    silent = true,
  }
)

local function goto_source()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].buftype == ''
      and vim.bo[buf].filetype ~= 'nerdtree'
    then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end

vim.keymap.set('n', '<C-g>', goto_source)

vim.keymap.set('t', '<C-g>', function()
  vim.cmd('stopinsert')
  goto_source()
end)

EOF
