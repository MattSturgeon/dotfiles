return {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })
    wk.register({
      ['<leader>'] = {
        -- Register some groups
        f = { name = 'file' },
        g = { name = 'git' },
        s = { name = 'search' },
      },
    })
  end,
}
