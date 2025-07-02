return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "RRethy/nvim-treesitter-textsubjects",
    },
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
      textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        }
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
      max_lines = 4
    }
  },
  {
    "Wansmer/treesj",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "J", "<Cmd>TSJToggle<CR>", desc = "Toggle TSJ" },
    },
  }
}
