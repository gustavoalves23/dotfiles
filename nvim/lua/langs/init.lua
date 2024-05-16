local debug_fn = require('langs.utils').dap_fn_config
return {
  svelte = {
    filetypes = { 'svelte' },
    snippets = {
      extends = {
        'typescript',
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
        csharp_ls = {},
      },
    },
    debuggers = {
      {
        name = 'coreclr',
        fn = debug_fn.netcoredbg,
      },
    },
  },
  python = {
    filetypes = { 'python' },
    language = {
      syntax = { 'python' },
      servers = {
        pylsp = {},
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
