return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup{}
      vim.diagnostic.config({
        float = {
          source = "if_many", -- Or "if_many"
        },
        virtual_text = true,
        -- https://github.com/nvimdev/lspsaga.nvim/issues/1520#issuecomment-2631782677
        severity_sort = true,
        update_in_insert = false,
        underline = true,
      })

      vim.lsp.inlay_hint.enable(true)

      function PrintDiagnostics(opts, bufnr, line_nr)
        opts = opts or {}

        bufnr = bufnr or 0
        line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
        local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = line_nr })
        if vim.tbl_isempty(line_diagnostics) then
          return
        end

        for _, diagnostic in ipairs(line_diagnostics) do
          local output = string.format(
            "[%s] %s [%s]",
            diagnostic.source or "",
            diagnostic.message or "",
            vim.diagnostic.severity[diagnostic.severity] or ""
          )
          local lines = vim.split(output, '\n')

          if #lines > 2 then
            output = table.concat({ lines[1], lines[2] .. " ..." }, "\n")
          end
          local winwidth = vim.fn.winwidth(0)
          if #output > winwidth * 2 then
            output = output:sub(0, math.floor(winwidth * 2 * 0.9)) .. " ..."
          end
          vim.api.nvim_echo({ { output } }, false, {})
          break
        end
      end
      vim.cmd([[ autocmd CursorHold * lua PrintDiagnostics() ]])
    end
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      { "<Leader>la",  "<CMD>Lspsaga code_action<CR>",                                   desc = "LSP Code Action" },
      { "<Leader>lc",  "<CMD>lua vim.lsp.buf.declaration()<CR>",                         desc = "Goto Declaration" },
      { "<Leader>ldp", "<CMD>Lspsaga peek_definition<CR>",                               desc = "Peek Definition" },
      { "<Leader>ldd", "<CMD>Lspsaga goto_definition<CR>",                               desc = "Goto Definition" },
      { "<Leader>lf",  "<CMD>lua vim.lsp.buf.format{ timeout_ms=5000, async=true }<CR>", desc = "Format Buffer" },
      { "<Leader>lh",  "<CMD>Lspsaga hover_doc<CR>",                                     desc = "Hover Documentation" },
      { "<Leader>li",  "<CMD>lua vim.lsp.buf.implementation()<CR>",                      desc = "Goto Implementation" },
      { "<Leader>lx",  "<CMD>lua vim.lsp.buf.references()<CR>",                          desc = "References" },
      { "<Leader>lr",  "<CMD>Lspsaga rename<CR>",                                        desc = "Rename Symbol" },
      { "<Leader>lt",  "<CMD>Lspsaga goto_type_definition<CR>",                          desc = "Type Definition" },
      { "<Leader>lo",  "<CMD>Lspsaga outline<CR>",                                       desc = "Type Definition" },
      -- diagnostics
      { "<Leader>le",  "<CMD>Lspsaga show_line_diagnostics<CR>",                         desc = "Line Diagnostics" },
      { "<Leader>lb",  "<CMD>Lspsaga show_buf_diagnostics<CR>",                          desc = "Buffer Diagnostics" },
      { "<Leader>ln",  "<CMD>Lspsaga diagnostic_jump_next<CR>",                          desc = "Next Diagnostic" },
      { "<Leader>lp",  "<CMD>Lspsaga diagnostic_jump_prev<CR>",                          desc = "Prev Diagnostic" },
      -- signature help
      { "<Leader>s",   "<CMD>lua vim.lsp.buf.signature_help()<CR>",                      desc = "Signature Help" },
      { "<C-s>",       "<CMD>lua vim.lsp.buf.signature_help()<CR>",                      mode = "i",                  desc = "Signature Help (Insert)" },
    }
  }
}
