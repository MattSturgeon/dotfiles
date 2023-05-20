local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
  }
}

M.config = function()
  local lsp = require('lsp-zero').preset({})

  lsp.on_attach(function(_, bufnr)
    -- TODO consider custom keymappings
    lsp.default_keymaps({buffer = bufnr})
  end)

  lsp.setup()
end

return M
