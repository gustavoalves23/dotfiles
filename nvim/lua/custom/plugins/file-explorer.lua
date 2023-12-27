-- return {
--   {
--     "preservim/nerdtree",
--     config = function()
--       vim.g.NERDTreeShowHidden = 1
--       vim.g.NERDTreeMinimalUI = 1
--       vim.g.NERDTreeDirArrows = 1
--       vim.g.NERDTreeDirArrowExpandable = "▸"
--       vim.g.NERDTreeDirArrowCollapsible = "▾"
--       vim.g.NERDTreeWinSize = 50
--       vim.g.NERDTreeIgnore = { ".git", "node_modules", ".cache" }
--       vim.g.NERDTreeShowLineNumbers = 1
--       vim.g.NERDTreeShowBookmarks = 1
--       vim.g.NERDTreeShowFiles = 1
--       vim.g.NERDTreeShowHidden = 1
--       vim.g.NERDTreeShowLineNumbers = 1
--       vim.g.NERDTreeShowLineNumbers = 1
--       vim.g.NERDTreeQuitOnOpen = 1
--     end,
--     dependencies = { "ryanoasis/vim-devicons" }
--   },
--   {
--     "Xuyuanp/nerdtree-git-plugin",
--     requires = "preservim/nerdtree",
--     config = function()
--       vim.g.NERDTreeGitStatusUseNerdFonts = 1
--     end
--   },
--   { "tiagofumo/vim-nerdtree-syntax-highlight" }
-- }

return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    keymaps = {
      ["<C-h>"] = false,
      ["<C-c>"] = "actions.select_split",
    }
  }
}
