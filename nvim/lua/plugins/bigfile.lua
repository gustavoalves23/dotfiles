-- Disable nvim features for big files
return {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {
    filesize = 0.5,
  },
}
