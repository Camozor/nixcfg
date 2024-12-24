local s = {
	buffer = -1,
	window = -1,
}

--- @alias state {buffer: integer, window: integer}
--- @alias create_float_windows_opts {buffer?: number, width?: number, height?: number}
--- @param opts create_float_windows_opts
--- @return state
local function create_float_window(opts)
	local width = opts.width or math.floor(0.8 * vim.o.columns)
	local height = opts.height or math.floor(0.8 * vim.o.lines)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buffer = opts.buffer or vim.api.nvim_create_buf(false, true)

	local window_option = {
		relative = "editor",
		col = col,
		row = row,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	}

	local window = vim.api.nvim_open_win(buffer, true, window_option)

	return { buffer = buffer, window = window }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(s.window) then
		s = create_float_window({})
		if vim.bo[s.buffer].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(s.window)
	end
end
vim.api.nvim_create_user_command("Floaterm", toggle_terminal, {})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set({ "n", "t" }, "<space>tt", toggle_terminal)
