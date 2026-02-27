{ pkgs, pkgs-25-05, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    lua-language-server

    # typescript & vue
    typescript
    typescript-language-server
    pkgs-25-05.vue-language-server

    svelte-language-server

    pkgs-unstable.gopls
    rust-analyzer
    pyright
    nil
    terraform-ls
    yaml-language-server
    bash-language-server

    haskell-language-server
  ];
}
