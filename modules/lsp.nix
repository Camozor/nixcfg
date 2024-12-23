{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    lua-language-server

    # typescript & vue
    typescript
    pkgs-unstable.typescript-language-server
    pkgs-unstable.vue-language-server

    gopls
    rust-analyzer
    pyright
    nil
  ];
}
