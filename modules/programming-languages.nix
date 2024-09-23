{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
  ];
}
