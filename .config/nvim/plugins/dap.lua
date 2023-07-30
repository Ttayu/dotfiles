local dap = require("dap")

vim.api.nvim_set_keymap("n", "[dap]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>b", "[dap]", { noremap = false })
vim.api.nvim_set_keymap("n", "[dap]b", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]c", ":DapContinue<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]r", ":lua require('dap').run_last()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]i", ":DapStepInto<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]o", ":DapStepOut<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]s", ":DapStepOver<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[dap]e", ":lua require('dapui').eval()<CR>", { noremap = true, silent = true })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointTextHl" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedTextHl" })
dap.adapters = {
	debugpy = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	},
}
dap.configurations = {
	python = {
		{
			name = "Launch file",
			type = "debugpy",
			request = "launch",
			program = "${file}",
			pythonPath = vim.fn.fnamemodify("~/.pyenv/shims/python", ":p"),
		},
	},
}

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
