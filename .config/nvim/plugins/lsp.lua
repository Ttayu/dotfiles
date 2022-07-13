vim.api.nvim_set_keymap('n', '[lsp]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '[lsp]', { noremap = false })
vim.api.nvim_set_keymap('n', '[lsp]a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]c', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]d', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]f', ':lua vim.lsp.buf.format{timeout_ms = 5000, async = true}<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]h', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]x', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]t', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]e', ':lua vim.diagnostic.open_float()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]n', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]p', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true })

-- general settings
vim.diagnostic.config({
  float = {
    source = "always",  -- Or "if_many"
  },
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

function PrintDiagnostics(opts, bufnr, line_nr)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  local line_diagnostics = vim.diagnostic.get(bufnr, {lnum = line_nr})
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
    vim.api.nvim_echo({{ output }}, false, {})
    break
  end
end
vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

-- nvim-lsp-installer
local lsp_installer = require"nvim-lsp-installer"
lsp_installer.setup{}
local lspconfig = require "lspconfig"

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup{}
end
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"}
      },
    },
  },
})
lspconfig.pylsp.setup({
  root_dir = function(fname)
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
    }
    return lspconfig.util.root_pattern(table.unpack(root_files))(fname) or lspconfig.util.find_git_ancestor(fname)
  end,
  settings = {
    pylsp = {
      configurationSources = {"flake8"},
      plugins = {
        pyflakes = {enabled = false},
        pycodestyle = {enabled = false},
        mccabe = {enabled = false},
        flake8 = {enabled = true},
        autopep8 = {enabled = false},
        pyls_flake8 = {enabled = false},
        pylsp_black = {enabled = true},
        pyls_isort = {enabled = true},
        pylsp_mypy = {enabled = true, overrides = {true, "--ignore-missing-imports"}},
      }
    }
  }
})
