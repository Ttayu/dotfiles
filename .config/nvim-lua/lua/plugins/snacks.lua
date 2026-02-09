return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = true,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      input = { enabled = true },
      notifier = { enabled = true },
      notify = { enabled = false },
      picker = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<Space>/",   function() Snacks.picker.lines() end,                         desc = "Buffer Lines" },
      { "<Space>;",   function() Snacks.picker.command_history() end,               desc = "Command History" },
      { "<Space>n",   function() Snacks.picker.notifications() end,                 desc = "Notification History" },
      { "<Space>e",   function() Snacks.explorer() end,                             desc = "File Explorer" },
      -- find
      { "<Leader>fs", function() Snacks.picker.smart() end,                         desc = "Smart Find Files" },
      { "<Leader>fb", function() Snacks.picker.buffers() end,                       desc = "Buffers" },
      { "<Leader>ff", function() Snacks.picker.files() end,                         desc = "Find Files" },
      { "<Leader>fg", function() Snacks.picker.git_files() end,                     desc = "Find Git Files" },
      { "<Leader>fp", function() Snacks.picker.projects() end,                      desc = "Projects" },
      { "<Leader>fr", function() Snacks.picker.registers() end,                     desc = "Registers" },
      { "<Leader>f?", function() Snacks.picker.help() end,                          desc = "Help Pages" },
      { "<Leader>fh", function() Snacks.picker.command_history() end,               desc = "Command History" },
      { "<Leader>fp", function() Snacks.picker.pickers() end,                       desc = "Pickers" },
      -- Grep
      { "<Leader>sb", function() Snacks.picker.grep_buffers() end,                  desc = "Grep Open Buffers" },
      { "<Leader>sg", function() Snacks.picker.grep() end,                          desc = "Grep" },
      { "*",          function() Snacks.picker.grep_word() end,                     desc = "Visual selection or word", mode = { "n", "x" } },
      -- LSP
      { "Z",          function() Snacks.zen.zen({ toggles = { dim = false } }) end, desc = "Zen Mode" },
    }
  },
}
