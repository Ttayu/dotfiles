-- Set leader key (before any map)
vim.g.mapleader = ","

-- Helper: default options for non-recursive and silent
local opts = { noremap = true, silent = true }
local function opts_with(overrides)
  -- Create a shallow copy of base_opts, then extend with overrides
  local merged = vim.tbl_extend("force", {}, opts, overrides)
  return merged
end

-- 's' in normal mode if truly unused
vim.keymap.set("n", "s", "<Nop>", opts)

-- switch colon to semicolon
vim.keymap.set({ "n", "i", "c" }, ":", ";", opts_with({ silent = false }))
vim.keymap.set({ "n", "i", "c" }, ";", ":", opts_with({ silent = false }))


-- Window splitting shortcuts
vim.keymap.set("n", "ss", "<cmd>split<CR>", opts)  -- Horizontal split
vim.keymap.set("n", "sv", "<cmd>vsplit<CR>", opts) -- Vertical split

-- Tab management
vim.keymap.set("n", "st", "<cmd>tabnew<CR>", opts) -- New tab
vim.keymap.set("n", "sp", "<cmd>tabprevious<CR>", opts)
vim.keymap.set("n", "sn", "<cmd>tabnext<CR>", opts)
vim.keymap.set("n", "sw", "<cmd>tabclose<CR>", opts)

-- Window navigation with Ctrl+h/j/k/l
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Line beginnings and ends
vim.keymap.set({ "n", "v", "o" }, "H", "^", opts)
vim.keymap.set({ "n", "v", "o" }, "L", "$", opts)

-- Parenthesis matching
vim.keymap.set("n", "<Space>m", "%", opts_with({ desc = "Parenthesis matching" }))

-- Wrap-aware movement
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", opts_with({ expr = true }))
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", opts_with({ expr = true }))
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", opts_with({ expr = true }))
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", opts_with({ expr = true }))

-- Quick save & esc in insert mode
vim.keymap.set("i", "jj", "<ESC>:w<CR>", opts)

-- Insert-mode cursor movement
vim.keymap.set("i", "<C-h>", "<Left>", opts)
vim.keymap.set("i", "<C-j>", "<Down>", opts)
vim.keymap.set("i", "<C-k>", "<Up>", opts)
vim.keymap.set("i", "<C-l>", "<Right>", opts)
vim.keymap.set("i", "<C-b>", "<BS>", opts)

-- Delete without yank
vim.keymap.set("n", "x", '"_x', opts)

-- Yank and paste whole buffer
vim.keymap.set("n", "<Space>y", "ggyG", opts_with({ desc = "Yank whole buffer" }))
vim.keymap.set("n", "<Space>p", "gg\"_dGp", opts_with({ desc = "Paste whole buffer" }))

-- Escape right in insert mode
vim.keymap.set("i", "<C-]>", "<ESC>l", opts)

-- Highlight word under cursor
vim.keymap.set('n', '<Space><Space>', function()
  local word = vim.fn.expand('<cword>')
  vim.fn.setreg('z', word)
  vim.fn.setreg('/', '\\<' .. word .. '\\>')
  vim.opt.hlsearch = true
end, opts_with({ desc = "Highlight word under cursor" }))

-- Find and replace current word
vim.keymap.set('n', '#',
  '<Space><Space>;%s/<C-r>///g<Left><Left>',
  { remap = true, desc = "Highlight and prepare to replace word under cursor." }
)

-- Clear highlights
vim.keymap.set("n", "<Space><CR>", "<cmd>nohlsearch<CR>", opts)

-- Move line(s) up/down in normal & visual modes
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Terminal toggling and navigation
vim.keymap.set("n", "<leader>t", "<cmd>vsplit<CR><cmd>terminal<CR><cmd>setlocal nonumber norelativenumber<CR>",
  opts_with({ desc = "Terminal toggling" }))
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "jj", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Command-line editing
vim.keymap.set("c", "<C-a>", "<Home>", { silent = false })
vim.keymap.set("c", "<C-e>", "<End>", { silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { silent = false })
vim.keymap.set("c", "<C-p>", "<Up>", { silent = false })
vim.keymap.set("c", "<C-b>", "<BS>", { silent = false })
vim.keymap.set("c", "<C-h>", "<Left>", { silent = false })
vim.keymap.set("c", "<C-l>", "<Right>", { silent = false })
vim.keymap.set("c", "<M-h>", "<Left>", { silent = false })
vim.keymap.set("c", "<M-l>", "<Right>", { silent = false })
vim.keymap.set("c", "<C-d>", "<Del>", { silent = false })

-- Comment-out keymaps
vim.keymap.set({ "n", "x", "o" }, ",c", "gccj", { remap = true })
vim.keymap.set("v", ",c", "gc", { remap = true })
