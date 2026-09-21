return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'nvimtools/none-ls-extras.nvim',
  },

  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        require('none-ls.diagnostics.eslint_d').with({
          condition = function(utils)
            return utils.root_has_file({
              '.eslintrc',
              '.eslintrc.js',
              '.eslintrc.cjs',
              '.eslintrc.yaml',
              '.eslintrc.yml',
              '.eslintrc.json',
              'eslint.config.js',
              'eslint.config.mjs',
              'eslint.config.cjs',
              'eslint.config.ts',
              'eslint.config.mts',
              'eslint.config.cts',
            })
          end,
        }),
      },
    }
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
