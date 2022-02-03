vim.api.nvim_set_keymap('n', '[lsp]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '[lsp]', { noremap = false })
vim.api.nvim_set_keymap('n', '[lsp]a', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]c', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]d', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]f', ':lua vim.lsp.buf.formatting()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]h', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]x', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]t', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[lsp]e', ':lua vim.diagnostic.open_float()<CR>', { noremap = true })

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
vim.o.updatetime = 10
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

local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local shell = require "nvim-lsp-installer.installers.shell"

-- julia
local server_name = "julials"
local root_dir = server.get_server_root_path(server_name)
-- -- 1. (optional, only if lspconfig doesn't already support the server)
-- --    Create server entry in lspconfig
configs[server_name] = {
    default_config = {
        filetypes = { "julia" },
        root_dir = lspconfig.util.root_pattern(".git", "project.toml"),
    },
}
-- require'lspconfig'.julials.setup{}

local julials = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    languages = { "julia" },
    installer = shell.bash [[
      julia -e 'using Pkg; Pkg.add("LanguageServer")'
    ]],
    default_options = {
        cmd = { "julia", "-e", "using LanguageServer, LanguageServer.SymbolServer; runserver()"
        },
    },
}

-- 3. (optional, recommended) Register your server with nvim-lsp-installer.
--    This makes it available via other APIs (e.g., :LspInstall, lsp_installer.get_available_servers()).
servers.register(julials)

-- r-languageserver
server_name = "r_language_server"
root_dir = server.get_server_root_path(server_name)

require'lspconfig'.r_language_server.setup{}

local r_ls = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    languages = { "r", "rmd" },
    installer = shell.bash [[
      R -e 'install.packages("languageserver", repos = "https://cran.r-project.org")'
    ]],
    default_options = {
        cmd = { "R", "--slave", "-e", "languageserver::run()"
        },
    },
}
servers.register(r_ls)

-- python
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "pylsp" then
        opts.diagnostics = {enable = true}
        opts.completion = {ignorePatterns = {"^_{1,3}$|^_[^_].*$|^__.*(?<!__)$"} }
        opts.settings = {
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
    end
    server:setup(opts)
end)
