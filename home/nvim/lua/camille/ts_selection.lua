--- Treesitter incremental selection.
--- `nvim-treesitter` dropped it in the `main` rewrite, so it lives here now.
local M = {}

---@type table<integer, TSNode[]>
local stack = {}

---@param a TSNode
---@param b TSNode
local function same_range(a, b)
	local a_srow, a_scol, a_erow, a_ecol = a:range()
	local b_srow, b_scol, b_erow, b_ecol = b:range()
	return a_srow == b_srow and a_scol == b_scol and a_erow == b_erow and a_ecol == b_ecol
end

---@param node TSNode
local function select_node(node)
	local srow, scol, erow, ecol = node:range()

	if ecol == 0 then
		erow = erow - 1
		ecol = #(vim.api.nvim_buf_get_lines(0, erow, erow + 1, false)[1] or "")
	end

	if vim.fn.mode():match("[vV\22]") then
		vim.cmd("normal! \27")
	end

	vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
end

--- Select the node under the cursor
function M.init()
	local parser = vim.treesitter.get_parser(0, nil, { error = false })
	if not parser then
		return
	end
	parser:parse(true)

	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	stack[vim.api.nvim_get_current_buf()] = { node }
	select_node(node)
end

--- Grow the selection to the closest bigger parent node
function M.increment()
	local nodes = stack[vim.api.nvim_get_current_buf()]
	if not nodes or #nodes == 0 then
		return M.init()
	end

	local node = nodes[#nodes]
	local parent = node:parent()
	while parent and same_range(parent, node) do
		parent = parent:parent()
	end

	if not parent then
		return select_node(node)
	end

	nodes[#nodes + 1] = parent
	select_node(parent)
end

--- Shrink the selection back to the previously selected node
function M.decrement()
	local nodes = stack[vim.api.nvim_get_current_buf()]
	if not nodes or #nodes == 0 then
		return
	end

	if #nodes > 1 then
		nodes[#nodes] = nil
	end
	select_node(nodes[#nodes])
end

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	desc = "Drop treesitter incremental selection state",
	callback = function(event)
		stack[event.buf] = nil
	end,
})

return M
