{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    lua-language-server

    # typescript & vue
    typescript
    pkgs-unstable.typescript-language-server
    pkgs-unstable.vue-language-server

    svelte-language-server

    gopls
    rust-analyzer
    pyright
    nil
    terraform-ls
    yaml-language-server
    bash-language-server
  ];
}
