return {
  svelte = {
    filetypes = {
      'svelte',
    },
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
              pattern = {
                '*.js',
                '*.ts',
              },
              callback = function(ctx)
                client.notify('$/onDidChangeTsOrJsFile', {
                  uri = ctx.match,
                })
                vim.notify(client.name .. ' server reloading for file ' .. ctx.match, vim.log.levels.INFO)
              end,
            })
            vim.api.nvim_create_user_command('SvelteReload', function()
              client.notify('$/onDidChangeSvelteFile', {
                uri = vim.api.nvim_buf_get_name(0),
              })
              vim.notify(client.name .. ' server reloading for file ' .. vim.api.nvim_buf_get_name(0), vim.log.levels.INFO)
            end, {
              nargs = 0,
            })
          end,
        },
      },
      syntax = {
        'svelte',
      },
    },
  },
}
