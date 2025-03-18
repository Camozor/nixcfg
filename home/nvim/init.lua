require("camille")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				dependencies = {
					{
						"SmiteshP/nvim-navbuddy",
						dependencies = {
							"SmiteshP/nvim-navic",
							"MunifTanjim/nui.nvim",
						},
						opts = { lsp = { auto_attach = true } },
					},
				},
			},
			-- Autocompletion
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
					"benfowler/telescope-luasnip.nvim",
				},
				config = function(_, opts)
					if opts then
						require("luasnip").config.setup(opts)
					end
					vim.tbl_map(function(type)
						require("luasnip.loaders.from_" .. type).lazy_load()
					end, { "vscode", "snipmate", "lua" })

					-- friendly-snippets - enable standardized comments snippets
					require("luasnip").filetype_extend("typescript", { "tsdoc", "javascript", "typescript" })
					require("luasnip").filetype_extend("javascript", { "jsdoc" })
					require("luasnip").filetype_extend("lua", { "luadoc" })
					require("luasnip").filetype_extend("python", { "pydoc" })
					require("luasnip").filetype_extend("rust", { "rustdoc" })
					require("luasnip").filetype_extend("cs", { "csharpdoc" })
					require("luasnip").filetype_extend("java", { "javadoc" })
					require("luasnip").filetype_extend("sh", { "shelldoc" })
				end,
			}, -- Required
		},
	},
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{ "ThePrimeagen/harpoon" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{ "lewis6991/gitsigns.nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})
		end,
	},
	{ "folke/neodev.nvim", opts = {} },
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim" },
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{ "mhinz/vim-startify" },
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").create_default_mappings()
		end,
	},
	{ "nvim-pack/nvim-spectre", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{ "mattn/emmet-vim" },
	-- 	{
	-- 		dev = true,
	-- 		lazy = false,
	-- 		dir = "spotify",
	-- 		config = function(opts)
	-- 			require("spotify").setup({ dir = opts.dir })
	-- 		end,
	-- 	},
	-- }, {
	-- 	dev = {
	-- 		path = "$HOME/code/perso/lua/",
	-- 	},
})
