return {
  javascript = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    language = {
      syntax = {
        'javascript',
        'typescript',
      },
      servers = {
        vtsls = {
          settings = {
            javascript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        eslint = {
          capabilities = {
            textDocument = {
              formatting = false,
            },
          },
        },
      },
    },
    debuggers = {
      {
        name = 'node2',
        fn = function(dap)
          dap.adapters.node2 = {
            type = 'executable',
            command = 'node',
            args = { vim.fn.stdpath 'data' .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
          }
          dap.configurations.javascript = {
            {
              name = 'Launch',
              type = 'node2',
              request = 'launch',
              program = '${file}',
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = 'inspector',
              console = 'integratedTerminal',
            },
            {
              name = 'Attach to process',
              type = 'node2',
              request = 'attach',
              processId = require('dap.utils').pick_process,
            },
          }
        end,
      },
    },
  },
}
