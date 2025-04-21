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

    nixfmt-classic

    terraform

    stylua

    nodejs_20
    yarn

    ghc
    ormolu
  ];
}
