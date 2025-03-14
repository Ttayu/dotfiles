-- https://github.com/yetone/avante.nvim
require('avante_lib').load()
---@type AvanteProvider
local base = {
  __inherited_from = "ollama",
  api_key_name = "",
  endpoint = "http://127.0.0.1:11434",
  max_tokens = 32768,
  options = {
    num_ctx = 16384
  }
}

require('avante').setup({
  auto_suggestions_provider = "qwq",
  cursor_applying_provider = "qwq",
  memory_summary_provider = "qwq",
  provider = "qwq",
  vendors = {
    qwq = vim.tbl_extend("force", base, { model = "qwq" }),
    phi4 = vim.tbl_extend("force", base, { model = "phi4" }),
    deepseek = vim.tbl_extend("force", base, { model = "deepseek-r1:14b" }),
    ["qwen2.5"] = vim.tbl_extend("force", base, { model = "qwen2.5-coder:32b", }),
  },
  mappings = {
    toggle = {
      debug = "<Leader>aD", -- ignore '<Leader>ad' for add_docstring when asking.
    },
  },
  behaviour = {
    enable_cursor_planning_mode = true,
  },
})

-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
  require('avante.api').edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = 'Correct the text to standard English, but keep any code blocks inside intact.'
local avante_keywords = 'Extract the main keywords from the following text'
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = 'Optimize the following code'
local avante_summarize = 'Summarize the following text'
local avante_translate = 'Translate this into Japanese, but keep any code blocks inside intact'
local avante_explain_code = 'Explain the following code'
local avante_complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
local avante_add_docstring = 'Add docstring to the following codes'
local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
local avante_add_tests = [[
  Implement tests.
  Some tests to consider:
  - Don't test private methods
  - Test edge cases
  - Test for exceptions
  - Do black box testing
  - Minimize the use of mocks and stubs from third party libraries
]]

local avante_ask = require('avante.api').ask
local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

-- reserved. ?, a, d, f, h, r, R, s, t
map({ 'n', 'v' }, '[avante]', '<Nop>')
map({ 'n', 'v' }, '<Leader>a', '[avante]', { remap = true })

map('n', '[avante]g', function()
  avante_ask { question = avante_grammar_correction }
end)
map('v', '[avante]g', function()
  prefill_edit_window(avante_grammar_correction)
end)

map({ 'n', 'v' }, '[avante]k', function()
  avante_ask { question = avante_keywords }
end)

map({ 'n', 'v' }, '[avante]l', function()
  avante_ask { question = avante_code_readability_analysis }
end)

map('n', '[avante]o', function()
  avante_ask { question = avante_optimize_code }
end)
map('v', '[avante]o', function()
  prefill_edit_window(avante_optimize_code)
end)

map({ 'n', 'v' }, '[avante]m', function()
  avante_ask { question = avante_summarize }
end)
map({ 'n', 'v' }, '[avante]n', function()
  avante_ask { question = avante_translate }
end)
map({ 'n', 'v' }, '[avante]x', function()
  avante_ask { question = avante_explain_code }
end)
map('n', '[avante]c', function()
  avante_ask { question = avante_complete_code }
end)
map('v', '[avante]c', function()
  prefill_edit_window(avante_complete_code)
end)
map('n', '[avante]d', function()
  avante_ask { question = avante_add_docstring }
end)
map('v', '[avante]d', function()
  prefill_edit_window(avante_add_docstring)
end)
map('n', '[avante]b', function()
  avante_ask { question = avante_fix_bugs }
end)
map('v', '[avante]b', function()
  prefill_edit_window(avante_fix_bugs)
end)
map({ 'n', 'v' }, '[avante]u', function()
  avante_ask { question = avante_add_tests }
end)
