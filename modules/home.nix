{ pkgs, ... }:

{
  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.sessionVariables = { EDITOR = "nvim"; };

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    brave
    libreoffice
    openvpn
    beekeeper-studio
    zathura
    bruno
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = "source ~/.config/zsh/init.sh";
      oh-my-zsh = {
        enable = true;
        theme = "arrow";
        plugins = [ "git" "fzf" "z" "kubectl" "vi-mode" ];
      };
      shellAliases = {
        ls = "lsd";
        cat = "bat";
        y = "yazi";
        v = "nvim";
        s = "nvim $(fzf --preview='bat --color=always {}')";
        gpskip = "git push -o ci.skip";
      };
      shellGlobalAliases = {
        G = "| grep";
        L = "| less";
        C = "| xargs echo -n | wl-copy";
      };

      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
        };
      }];
    };
  };
}
