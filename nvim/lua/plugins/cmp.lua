local langs = require 'langs'

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      config = function()
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        vim.keymap.set('i', '<C-k>', function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end)

        for _, lang in pairs(langs) do
          if lang.snippets then
            local extends = lang.snippets.extends
            local custom = lang.snippets.custom
            local filetypes = lang.filetypes
            if extends then
              for _, extended_lang in pairs(filetypes) do
                luasnip.filetype_extend(extended_lang, extends)
              end
            end

            if custom then
              for _, extended_lang in pairs(filetypes) do
                local s = luasnip.snippet
                local t = luasnip.text_node
                local i = luasnip.insert_node

                luasnip.add_snippets(extended_lang, custom(s, t, i))
              end
            end
          end
        end
      end,
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      keyword = { range = 'prefix' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      accept = { auto_brackets = { enabled = false } },
      trigger = {
        show_on_insert_on_trigger_character = false,
      }
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
