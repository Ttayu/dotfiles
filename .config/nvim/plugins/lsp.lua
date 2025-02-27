require("lspsaga").setup({
  diagnostic = {
    on_insert = false,
  },
})
vim.api.nvim_set_keymap("n", "[lsp]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>l", "[lsp]", { noremap = false })
vim.api.nvim_set_keymap("n", "[lsp]a", ":Lspsaga code_action<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]c", ":lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]dp", ":Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]dd", ":Lspsaga goto_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "[lsp]f",
  ":lua vim.lsp.buf.format{timeout_ms = 5000, async = true}<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "[lsp]h", ":Lspsaga hover_doc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]i", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]x", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]r", ":Lspsaga rename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]t", ":Lspsaga goto_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]e", ":Lspsaga show_line_diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]b", ":Lspsaga show_buf_diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]n", ":Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]p", ":Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[lsp]s", ":lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap = true, silent = true })

-- general settings
vim.diagnostic.config({
  float = {
    source = "always", -- Or "if_many"
  },
  virtual_text = false,
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = false,
  underline = false,
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

local mason = require("mason")
mason.setup({})
local lspconfig = require("lspconfig")

local mason_lspconfig = require("mason-lspconfig")
local capabilities = require("ddc_source_lsp").make_client_capabilities()
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {},
})
require("null-ls").setup({})

-- Lua {{{
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
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
    local root = lspconfig.util.root_pattern(unpack(root_files))(fname)
        or lspconfig.util.find_git_ancestor(fname)
        or vim.fn.getcwd()
    return root
  end,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        flake8 = { enabled = false },
        autopep8 = { enabled = false },
        pyls_flake8 = { enabled = false },
        pylsp_black = { enabled = true },
        pyls_isort = { enabled = true },
        yapf = { enabled = false },
        pylsp_mypy = {
          enabled = true,
          overrides = { true, "--ignore-missing-imports", "--no-site-packages" },
          live_mode = false,
        },
        ruff = { enabled = true },
      },
    },
  },
  before_init = function(_, config)
    local venv_path = vim.fs.joinpath(config.root_dir, "/.venv")
    if vim.fn.isdirectory(venv_path) == 1 then
      vim.env.VIRTUAL_ENV = venv_path
      vim.env.PATH = vim.fs.joinpath(venv_path, "/bin:", vim.env.PATH)
    end
    local python_executable = vim.fs.joinpath(venv_path, "/bin/python")
    print(python_executable)
    -- local python_executable = vim.fn.trim(vim.fn.system("which python"))
    config.settings.pylsp.plugins.jedi = {}
    config.settings.pylsp.plugins.jedi.environment = python_executable

    local pdm_packages = vim.fs.joinpath(config.root_dir, "__pypackages__")
    if vim.fn.isdirectory(pdm_packages) == 0 then
      -- vim.notify("Not found __pypackages__")
      return
    end

    local python_version = vim.fn.trim(vim.fn.system("python -V"))
    local major_minor_version = string.match(python_version, "Python (%d+%.%d+)")
    local python_packages = vim.fs.joinpath(pdm_packages, major_minor_version, "lib")
    if vim.fn.isdirectory(python_packages) == 0 then
      -- vim.notify("Not found python_packages")
      return
    end

    config.settings.pylsp.plugins.jedi.extra_paths = { python_packages }
  end,
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

lspconfig.ts_ls.setup({
  single_file_support = false,
  root_dir = lspconfig.util.root_pattern("package.json"),
})
-- }}}

-- rust {{{
lspconfig.rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy",
      },
    },
  },
})
-- }}}
