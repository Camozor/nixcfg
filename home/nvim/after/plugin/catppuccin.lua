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
			NormalFloat = { bg = "#1e1e2e" }, -- change this to your preferred hover background
			FloatBorder = { fg = colors.mauve, bg = "#1e1e2e" },
		}
	end,
	integrations = {
		treesitter = true,
	},
})
