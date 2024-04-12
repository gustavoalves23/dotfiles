return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {
    filesize = 2, -- Filesize to enable plugin, in MB
  },
}
