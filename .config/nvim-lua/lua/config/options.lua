-- General options
local o = vim.opt

-- Always show the sign column to avoid text shifting
o.signcolumn = "yes"
-- Command-line height for messages
o.cmdheight = 1
-- Disable backup and swap, enable undo file
o.backup = false
o.swapfile = false
o.undofile = true                -- persist undo history
-- Auto-reload files changed outside of Neovim
o.autoread = true
-- Allow hidden buffers (open multiple files without saving)
o.hidden = true
-- Show partially typed command in the last line
o.showcmd = true
-- Use system clipboard
o.clipboard:append("unnamedplus")
-- Line numbers
o.number = true
o.relativenumber = true
-- Highlight current line and column
o.cursorline = true
o.cursorcolumn = true
-- Show matching brackets when typing
o.showmatch = true
-- Global status line (Neovim 0.7+)
o.laststatus = 3
-- Command-line completion
o.wildmenu = true
o.wildmode = { "list", "longest" }
-- Keep at least 3 lines visible above/below cursor
o.scrolloff = 3
o.sidescrolloff = 3
-- When splitting vertically, place new window to the right
o.splitright = true
-- Tabs and indentation
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 0
o.shiftround = true
o.expandtab = true
o.smartindent = true
o.autoindent = true
-- Search settings
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.wrapscan = true
o.hlsearch = true
-- Fix preview window height
o.previewheight = 2
-- Folding method by markers {{{ }}}
o.foldmethod = "marker"
-- Enable mouse support in all modes
o.mouse = "n"
-- Disable copying files on write
o.backupcopy = "no"
-- Command history length
o.history = 1000
-- Ignore negative sign for CTRL-A/X
o.nrformats = "unsigned"
-- Fancy window separators
o.fillchars = {
  horiz      = "━",
  horizup    = "┻",
  horizdown  = "┳",
  vert       = "┃",
  vertleft   = "┫",
  vertright  = "┣",
  verthoriz  = "╋",
}
-- QuickFix behavior
vim.api.nvim_create_augroup("QuickFix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "QuickFix",
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("WinEnter", {
  group = "QuickFix",
  callback = function()
    if vim.bo.filetype == "qf" and vim.fn.winnr("$") == 1 then
      vim.cmd("quit")
    end
  end,
})
-- Disable unused providers (enable python3 if you need plugins in Python)
vim.g.loaded_node_provider   = 0
vim.g.loaded_perl_provider   = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider   = 0
-- WSL clipboard integration
if vim.fn.has("wsl") == 1 then
  if vim.fn.executable("xsel") == 0 then
    vim.notify("xsel not found, clipboard integration won't work", vim.log.levels.WARN)
  else
    vim.g.clipboard = {
      name = "xsel (WSL)",
      copy = {
        ["+"] = "xsel -bi",
        ["*"] = "xsel -bi",
      },
      paste = {
        ["+"] = function()
          return vim.fn.systemlist('xsel -bo | cat | tr -d "\r"', { "" }, 1) -- '1' keeps empty lines
        end,
        ["*"] = function()
          return vim.fn.systemlist('xsel -bo | cat | tr -d "\r"', { "" }, 1) -- '1' keeps empty lines
        end,
      },
      cache_enabled = true,
    }
  end
end
