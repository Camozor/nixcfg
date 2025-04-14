vim.cmd.colorscheme("catppuccin")

-- FIXME hack, understand why syntax highlighting is broken for golang
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.cmd("TSBufEnable highlight")
	end,
})
