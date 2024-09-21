local dap = require("dap")

dap.adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			-- runtimeExecutable = os.getenv("HOME") .. "/.config/yarn/global/node_modules/.bin/ts-node"
			runtimeExecutable = "/home/camille/code/neomi/neomi/back/node_modules/.bin/ts-node",
		},
	}
end

vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>co", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>so", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>si", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>D", ":lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>ev", ":lua require'dapui'.eval()<CR>")

require("dapui").setup()
