return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
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
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ao"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["ai"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["ah"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["al"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
            ["af"] = { query = "@function.outer", desc = "Select outerpart of a function region." },
            ["if"] = { query = "@function.inner", desc = "Select outerpart of a function region." },
            ["ac"] = { query = "@class.outer", desc = "Select outerpart of a class region." },
            ["ic"] = { query = "@class.inner", desc = "Select outerpart of a class region." },
          }
        }
      },
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
  },
  {
    "andymass/vim-matchup",
    opts = {
      treesitter = {
        stopline = 500,
      }
    }
  }
}
