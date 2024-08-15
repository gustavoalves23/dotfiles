return {
  svelte = {
    filetypes = { 'svelte' },
    snippets = {
      extends = {
        'typescript',
      },
    },
    language = {
      servers = {
        svelte = {
          on_attach = function(client)
            vim.api.nvim_create_autocmd('BufWritePost', {
              pattern = { '*.js', '*.ts' },
              callback = function(ctx)
                if client.name == 'svelte' then
                  client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
                end
              end,
            })
          end,
        },
      },
      syntax = {
        'svelte',
      },
    },
    linters = {
      'eslint_d',
    },
    formatters = {
      'eslint_d',
    },
  },
}
