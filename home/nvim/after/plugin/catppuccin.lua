require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		},
	},
	custom_highlights = function(colors)
		return {
			-- Identifier = { fg = colors.flamingo },
			-- Function = { fg = colors.mauve },
			-- Comment = { fg = colors.mauve },
		}
	end,
	integrations = {
		treesitter = true,
	},
})
