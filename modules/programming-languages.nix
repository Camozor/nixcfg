{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    shfmt

    gcc
    gdb
    gnumake

    go
    air

    cargo
    rustc
    rustfmt

    python3

    nixfmt

    terraform

    stylua

    nodejs_26
    yarn

    ghc
    ormolu
  ];
}
