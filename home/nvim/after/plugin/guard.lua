local ft = require("guard.filetype")

ft("go"):fmt("gofmt")
ft("typescript,vue,javascript"):fmt("prettier")
ft("nix"):fmt("nixfmt")
ft("rust"):fmt("rustfmt")
ft("lua"):fmt("stylua")
ft("sh"):fmt("shfmt")
ft("haskell"):fmt("ormolu")

require("guard").setup({
	fmt_on_save = true,
	lsp_as_default_formatter = false,
})
