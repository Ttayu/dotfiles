return {
  {

    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Default options:
      require('kanagawa').setup({
        transparent = true,
      })
      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa-wave")
    end
  },
}
