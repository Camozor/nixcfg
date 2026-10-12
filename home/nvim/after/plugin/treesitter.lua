-- nvim-treesitter `main` branch: no more `nvim-treesitter.configs`.
-- Parsers/queries are installed by the plugin, every feature is enabled by hand.
local ts = require("nvim-treesitter")

ts.setup({
	-- prepended to runtimepath, parsers land in ~/.local/share/nvim/site
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- async, no-op when already installed (replaces `ensure_installed`)
ts.install({
	"bash",
	"go",
	"javascript",
	"json",
	"lua",
	"nix",
	"python",
	"rust",
	"terraform",
	"tsx",
	"typescript",
	"vue",
	"yaml",
})

--------------------------------------------------------------------------------
-- Incremental selection (dropped by `main`, see lua/camille/ts_selection.lua)
--------------------------------------------------------------------------------

local selection = require("camille.ts_selection")

vim.keymap.set("n", "vv", selection.init, { desc = "Init treesitter selection" })
vim.keymap.set("x", "vv", selection.increment, { desc = "Increment treesitter selection" })
vim.keymap.set("x", "vV", selection.decrement, { desc = "Decrement treesitter selection" })

--------------------------------------------------------------------------------
-- Textobjects (also `main` branch: setup + explicit keymaps)
--------------------------------------------------------------------------------

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
		include_surrounding_whitespace = true,
	},
	move = {
		set_jumps = true,
	},
})

local select = require("nvim-treesitter-textobjects.select")
local swap = require("nvim-treesitter-textobjects.swap")
local move = require("nvim-treesitter-textobjects.move")

---@param lhs string
---@param query string
---@param group string
---@param desc string
local function map_select(lhs, query, group, desc)
	vim.keymap.set({ "x", "o" }, lhs, function()
		select.select_textobject(query, group)
	end, { desc = desc })
end

map_select("af", "@function.outer", "textobjects", "a function")
map_select("if", "@function.inner", "textobjects", "inner function")
map_select("ac", "@class.outer", "textobjects", "a class")
map_select("ic", "@class.inner", "textobjects", "inner class")
map_select("as", "@local.scope", "locals", "a language scope")

vim.keymap.set("n", "<leader>z", function()
	swap.swap_next("@parameter.inner")
end, { desc = "Swap with next parameter" })
vim.keymap.set("n", "<leader>Z", function()
	swap.swap_previous("@parameter.inner")
end, { desc = "Swap with previous parameter" })

---@param lhs string
---@param fn fun(query: string|string[], group: string)
---@param query string|string[]
---@param group string
---@param desc string
local function map_move(lhs, fn, query, group, desc)
	vim.keymap.set({ "n", "x", "o" }, lhs, function()
		fn(query, group)
	end, { desc = desc })
end

-- TODO clean up useless binding
map_move(";", move.goto_next_start, "@function.outer", "textobjects", "Next function start")
map_move("]]", move.goto_next_start, "@class.outer", "textobjects", "Next class start")
map_move("]o", move.goto_next_start, { "@loop.inner", "@loop.outer" }, "textobjects", "Next loop start")
map_move("]s", move.goto_next_start, "@local.scope", "locals", "Next scope")
map_move("]z", move.goto_next_start, "@fold", "folds", "Next fold")

map_move("]M", move.goto_next_end, "@function.outer", "textobjects", "Next function end")
map_move("][", move.goto_next_end, "@class.outer", "textobjects", "Next class end")

map_move(",", move.goto_previous_start, "@function.outer", "textobjects", "Previous function start")
map_move("[[", move.goto_previous_start, "@class.outer", "textobjects", "Previous class start")

map_move("[M", move.goto_previous_end, "@function.outer", "textobjects", "Previous function end")
map_move("[]", move.goto_previous_end, "@class.outer", "textobjects", "Previous class end")

map_move("]d", move.goto_next, "@conditional.outer", "textobjects", "Next conditional")
map_move("[d", move.goto_previous, "@conditional.outer", "textobjects", "Previous conditional")
