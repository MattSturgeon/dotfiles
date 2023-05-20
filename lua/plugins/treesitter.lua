return {
  'nvim-treesitter/nvim-treesitter',
  config = {
    ensure_installed = {
      'lua',
      'bash',
      'c',
    },
  },
  build = ':TSUpdate',
}
