local lspconfig = require("lspconfig")
local nix = require("camille.nix")
local cmp = require("cmp")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP Actions",
	callback = function(event)
		local opts = { buffer = event.buf, remap = false }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vd", "<cmd>Telescope diagnostics<CR>", opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<leader>sh", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

local volar_derivation_path = nix.find_derivation_path("vue-language-server")
local typescript_plugin_path = volar_derivation_path
	.. "lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = typescript_plugin_path,
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
	settings = {
		typescript = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
		javascript = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
			},
		},
	},
})

local typescript_derivation_path = nix.find_derivation_path("tsc")
local typescript_sdk_path = typescript_derivation_path .. "lib/node_modules/typescript/lib"

lspconfig.volar.setup({
	capabilities = capabilities,
	filetypes = { "vue" },
	init_options = {
		typescript = {
			tsdk = typescript_sdk_path,
		},
		vue = {
			hybridMode = true,
		},
	},
})

lspconfig.yamlls.setup({
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = { kubernetes = "globPattern" },
		},
	},
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	filetypes = {
		"go",
		"gomod",
		"gowork",
		"gotmpl",
	},
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true, -- TODO not working
			},
		},
	},
})

local basic_servers = { "pyright", "rust_analyzer", "nil_ls", "terraformls", "svelte", "bashls" }
for _, server in ipairs(basic_servers) do
	lspconfig[server].setup({ capabilities = capabilities })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local orig_util = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border
		or {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		}
	return orig_util(contents, syntax, opts, ...)
end

cmp.setup({
	sources = {
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
	}),
})
