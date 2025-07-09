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
        {
          mode = { "n", "v" },
          { "<Leader>g", group = "Git" },
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
      { "<Leader>gs", "<CMD>Gitsigns stage_hunk<CR>",          mode = { "n", "v" },         desc = "Stage Hunk" },
      { "<Leader>gr", "<CMD>Gitsigns reset_hunk<CR>",          mode = { "n", "v" },         desc = "Reset Hunk" },
      { "<Leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>",     desc = "Undo Stage Hunk" },
      { "<Leader>gp", "<CMD>Gitsigns preview_hunk<CR>",        desc = "Preview Hunk" },
      { "<Leader>gi", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview Hunk Inline" },
      { "<Leader>gb", "<CMD>Gitsigns blame<CR>",               desc = "Blame Buffer" },
      { "<Leader>gd", "<CMD>Gitsigns diffthis<CR>",            desc = "Diff This" },
      { "<Leader>gt", "<CMD>Gitsigns toggle_deleted<CR>",      desc = "Toggle Deleted" },
      { "<Leader>gw", "<CMD>Gitsigns toggle_word_diff<CR>",    desc = "Toggle Word Diff" },
    }
  },
  {
    "stevearc/oil.nvim",
    config = true,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    keys = {
      { "<Leader>fo", "<CMD>Oil<CR>", desc = "Oil" },
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
    lazy = false,
    opts = {
      sections = {
        lualine_x = { "overseer" },
      }
    }
  },
}
