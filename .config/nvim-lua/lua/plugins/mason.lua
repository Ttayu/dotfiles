return {
  {
      "mason-org/mason-lspconfig.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        {"mason-org/mason.nvim", opts={}},
        "neovim/nvim-lspconfig",
      },
      opts = {},
  }
}
