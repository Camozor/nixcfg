local ft = require("guard.filetype")

ft("go"):fmt("gofmt")
ft("typescript,vue"):fmt("prettier")
ft("nix"):fmt("nixfmt")
ft("rust"):fmt("rustfmt")

require("guard").setup({
	fmt_on_save = true,
	lsp_as_default_formatter = false,
})
