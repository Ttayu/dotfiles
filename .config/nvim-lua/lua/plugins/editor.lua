return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<Leader>l", group = "Lsp" },
        },
        {
          mode = { "n", "v" },
          { "<Leader>f", group = "file/find" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    }
  },
  {
    "smoka7/hop.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      { "ff", "<CMD>HopWord<CR>",      desc = "HopWord" },
      { "fl", "<CMD>HopLineStart<CR>", desc = "HopLineStart" },
    }
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "VeryLazy",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)", desc = "Accelerated gj movement" },
      { "k", "<Plug>(accelerated_jk_gk)", desc = "Accelerated gk movement" },
    }
  }
}
