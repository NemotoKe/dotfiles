set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

set clipboard=unnamedplus

" Neovim側で再度有効化
filetype plugin indent on
syntax enable
set termguicolors

highlight! @markup.heading.1.markdown guifg=#FF4FD8 gui=bold
highlight! @markup.heading.2.markdown guifg=#35FFF2 gui=bold
highlight! @markup.heading.3.markdown guifg=#9D7BFF gui=bold

highlight! @markup.raw.markdown_inline guifg=#5CFFB0
highlight! @markup.raw.block.markdown guifg=#5CFFB0

" Python 用の設定

lua << EOF
-- =========================
-- Python LSP
-- =========================
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- 型情報・補完は BasedPyright
    if client.name == 'basedpyright' then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end

    -- hover は BasedPyright に任せる
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


-- =========================
-- Python 保存時 Ruff format
-- =========================
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


-- =========================
-- Terminal
-- =========================
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

-- Normal mode で T → ターミナルを開く
vim.keymap.set('n', 'T', '<cmd>T<CR>', {
  noremap = true,
  silent = true,
})

-- Terminal → Normal mode → 上のエディタへ
vim.keymap.set(
  't',
  '<Esc><Esc>',
  [[<C-\><C-n><C-w>k]],
  { silent = true }
)


-- =========================
-- Bufferline
-- =========================
require("bufferline").setup({
  options = {
    mode = "buffers",
  }
})

vim.keymap.set(
  'n',
  ']b',
  '<cmd>BufferLineCycleNext<CR>'
)

vim.keymap.set(
  'n',
  '[b',
  '<cmd>BufferLineCyclePrev<CR>'
)


-- =========================
-- Neo-tree
-- =========================
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


-- =========================
-- hlslens
-- =========================
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


-- =========================
-- Scrollbar
-- =========================
require("scrollbar").setup()

require("scrollbar.handlers.search").setup()


-- =========================
-- which-key
-- =========================
require("which-key").setup({
  preset = "modern",
})


-- =========================
-- Diffview
-- =========================
require("diffview").setup()

vim.keymap.set(
  'n',
  '<leader>gd',
  '<cmd>DiffviewOpen<CR>',
  {
    desc = 'Git diff',
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
EOF
