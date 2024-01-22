return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        -- JS/TS
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
        -- JS/TS
        --LUA
        null_ls.builtins.formatting.stylua,
        --LUA
        --CSS
        -- null_ls.builtins.diagnostics.stylelint,
        -- null_ls.builtins.formatting.stylelint,
        --CSS
      },
    })
  end,
}
