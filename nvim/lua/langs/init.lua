local dap_fn = require 'langs.debug'
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
    treesitter = {
      'tsx',
    },
    lsp = {
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
    treesitter = {
      'javascript',
      'typescript',
    },
    lsp = {
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
    debug_fn = dap_fn.node2,
  },
  csharp = {
    filetypes = { 'cs' },
    treesitter = { 'c_sharp' },
    lsp = {
      servers = {
        csharp_ls = {},
      },
    },
    debug_fn = dap_fn.netcoredbg,
  },
  python = {
    filetypes = { 'python' },
    treesitter = { 'python' },
    lsp = {
      servers = {
        pylsp = {},
      },
    },
  },
  lua = {
    filetypes = { 'lua' },
    formatters = { 'stylua' },
    treesitter = { 'lua' },
    lsp = {
      servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
  },
  rust = {
    filetypes = { 'rust' },
    treesitter = { 'rust' },
    lsp = {
      servers = {
        rust_analyzer = {},
      },
    },
  },
  others = {
    treesitter = {
      'regex',
      'markdown',
      'markdown_inline',
      'vimdoc',
      'vim',
      'bash',
    },
    lsp = {
      servers = {
        cssls = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
      },
    },
  },
}
