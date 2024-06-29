local debug_fn = require('langs.utils').dap_fn_config
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
  },
  react = {
    filetypes = {
      'javascriptreact',
      'typescriptreact',
    },
    language = {
      syntax = {
        'tsx',
      },
      servers = {
        cssmodules_ls = {},
        tailwindcss = {},
      },
    },
    snippets = {
      extends = {
        'html',
      },
      custom = function(s, t, i)
        return {
          s('cssm', {
            t 'className={S.',
            i(1),
            t '}',
          }),
        }
      end,
    },
  },
  javascript = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'svelte',
    },
    language = {
      syntax = {
        'javascript',
        'typescript',
      },
      servers = {
        vtsls = {},
        -- tsserver = {},
      },
    },
    linters = {
      'eslint_d',
    },
    formatters = {
      'eslint_d',
    },
    debuggers = {
      {
        name = 'node2',
        fn = debug_fn.node2,
      },
    },
  },
  csharp = {
    filetypes = { 'cs' },
    language = {
      syntax = { 'c_sharp' },
      servers = {
        csharp_ls = {},
      },
    },
    debuggers = {
      {
        name = 'coreclr',
        fn = debug_fn.netcoredbg,
      },
    },
    extra_lib = {
      'Hoffs/omnisharp-extended-lsp.nvim',
    },
  },
  python = {
    filetypes = { 'python' },
    language = {
      syntax = { 'python' },
      servers = {
        pyright = {},
      },
    },
  },
  lua = {
    filetypes = { 'lua' },
    formatters = { 'stylua' },
    language = {
      syntax = { 'lua' },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },
  rust = {
    filetypes = { 'rust' },
    language = {
      syntax = { 'rust' },
      servers = {
        rust_analyzer = {},
      },
    },
  },
  aspvbs = {
    filetypes = { 'aspvbs' },
    snippets = {
      extends = {
        'html',
        'css',
        'javascript',
      },
    },
  },
  handlebars = {
    filetypes = { 'hbs' },
    snippets = {
      extends = {
        'html',
      },
    },
  },
  others = {
    language = {
      syntax = {
        'regex',
        'markdown',
        'markdown_inline',
        'vimdoc',
        'vim',
        'bash',
      },
      servers = {
        cssls = {},
        html = {},
      },
    },
  },
}
