require "lspsaga".setup({
  on_insert = false,
})

vim.api.nvim_set_keymap('n', '[lsp]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '[lsp]', { noremap = false })
vim.api.nvim_set_keymap('n', '[lsp]a', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]c', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]dp', ':Lspsaga peek_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]dd', ':Lspsaga goto_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]f', ':lua vim.lsp.buf.format{timeout_ms = 5000, async = true}<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]h', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]x', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]r', ':Lspsaga rename<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]t', ':Lspsaga goto_type_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]e', ':Lspsaga show_line_diagnostics<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]b', ':Lspsaga show_buf_diagnostics<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]n', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]p', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[lsp]s', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

-- general settings
vim.diagnostic.config({
  float = {
    source = "always", -- Or "if_many"
  },
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = false,
})

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

function PrintDiagnostics(opts, bufnr, line_nr)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = line_nr })
  if vim.tbl_isempty(line_diagnostics) then return end

  for _, diagnostic in ipairs(line_diagnostics) do
    local output = string.format("[%s] %s [%s]",
      diagnostic.source or "",
      diagnostic.message or "",
      vim.diagnostic.severity[diagnostic.severity] or ""
    )
    if #output > 140 then
      output = string.sub(output, 0, 140) .. '...'
    end
    vim.api.nvim_echo({ { output } }, false, {})
    break
  end
end

vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

local mason = require "mason"
mason.setup {}
local lspconfig = require "lspconfig"

local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup {}
mason_lspconfig.setup_handlers({ function(server_name)
  lspconfig[server_name].setup {}
end })
-- Lua {{{
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
-- }}}

-- python {{{
lspconfig.pylsp.setup({
  root_dir = function(fname)
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
    }
    return lspconfig.util.root_pattern(unpack(root_files))(fname) or lspconfig.util.find_git_ancestor(fname)
  end,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = { enabled = true },
        autopep8 = { enabled = false },
        pyls_flake8 = { enabled = false },
        pylsp_black = { enabled = true },
        pyls_isort = { enabled = true },
        yapf = { enabled = false },
        pylsp_mypy = { enabled = true, overrides = { true, "--ignore-missing-imports" } },
        rope_autoimport = { enabled = true },
      }
    }
  }
})
-- }}}

-- typescript {{{
lspconfig.denols.setup({
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "denops"),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
})

lspconfig.tsserver.setup({
  single_file_support = false,
  root_dir = lspconfig.util.root_pattern("package.json"),
})
-- }}}
--
local function apply_text_edits(edits)
  local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local bufnr = vim.api.nvim_get_current_buf()
  local applying_edits = vim.tbl_filter(function(t)
    return t.range.start.line ~= (lnum - 1)
  end, edits)
  vim.lsp.util.apply_text_edits(applying_edits, bufnr, "utf-8")
end

local group_id = vim.api.nvim_create_augroup("AutoImport", { clear = true })
vim.keymap.set("i", "<C-y>", "<Cmd>call pum#map#confirm()<CR>")

vim.api.nvim_create_autocmd("User", {
  pattern = "PumCompleteDone",
  group = group_id,
  callback = function()
    local completed = vim.g["pum#completed_item"]
    if completed == nil or completed.user_data == nil or completed.user_data.lspitem == nil then
      return
    end

    local lspitem = vim.json.decode(completed.user_data.lspitem)

    if lspitem.additionalTextEdits ~= nil then
      apply_text_edits(lspitem.additionalTextEdits)
    else
      -- try to call completionItem/resolve.
      local method = "completionItem/resolve"
      local method_supported = false
      for _, client in pairs(vim.lsp.buf_get_clients(0)) do
        if client.supports_method(method) then
          method_supported = true
        end
      end

      if not method_supported then
        return
      end

      local cancel = vim.lsp.buf_request_all(0, method, lspitem, function(responses)
        local edits = {}
        for _, r in pairs(responses) do
          -- require("notify")(vim.inspect(r))
          if r.result ~= nil and r.result.additionalTextEdits ~= nil then
            for _, e in pairs(r.result.additionalTextEdits) do
              table.insert(edits, e)
            end
          end
        end

        apply_text_edits(edits)
      end)
      if not cancel then
        return
      end
    end
  end,
  desc = "Apply additionalTextEdits if exists.",
})
