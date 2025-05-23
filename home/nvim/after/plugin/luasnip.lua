local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",

	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "<-", "Error" } },
			},
		},
	},
})

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

vim.keymap.set("n", "<leader><leader>s", "<cmd>source %<CR>")

ls.add_snippets("lua", {
	s("lf", fmt("local {} = function({})\nend", { i(1), i(2, "") })),
})

ls.add_snippets("vue", {
	s("divc", fmt('<div class="{}">{}</div>', { i(1), i(2) })),
})
