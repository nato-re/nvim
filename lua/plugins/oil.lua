return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Toggle file explorer' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    experimental_watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
  },
}
