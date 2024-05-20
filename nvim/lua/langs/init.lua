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
        svelte = {},
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
        tsserver = {},
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
        omnisharp = {
          version = "v1.39.8",
          on_attach = function()
            local lazy_require = require("utils.lazy-require")
            local omnisharp_extended = lazy_require.require_on_exported_call('omnisharp_extended')

            vim.keymap.set('n', 'gd', omnisharp_extended.lsp_definition, { desc = 'Omnisharp: [G]oto [D]efinition' })
            vim.keymap.set('n', 'gr', omnisharp_extended.lsp_references, { desc = 'Omnisharp: [G]oto [R]eferences' })
            vim.keymap.set('n', 'gI', omnisharp_extended.lsp_implementation,
              { desc = 'Omnisharp: [G]oto [I]mplementation' })
            vim.keymap.set('n', 'gD', omnisharp_extended.lsp_type_definition,
              { desc = 'Omnisharp: [G]oto [D]eclaration' })
          end,
          has_custom_decompiler = true,
        }
      },
    },
  },
  debuggers = {
    {
      name = 'coreclr',
      fn = debug_fn.netcoredbg,
    },
    extra_lib = {
      "Hoffs/omnisharp-extended-lsp.nvim"
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
        'bash'
      },
      servers = {
        cssls = {},
        html = {},
      },
    },
  },
}
