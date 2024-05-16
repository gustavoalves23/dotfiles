-- return { 'github/copilot.vim' }
return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-j>" } },
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
      },
      layout = {
        position = "bottom",
        ratio = 0.4,
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
