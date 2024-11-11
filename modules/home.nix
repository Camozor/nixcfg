{ pkgs, ... }:

let user = "camille";
in {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

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
    discord
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
        C = "| xargs echo -n | xclip -selection clipboard";
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

  home.file.".config/dunst".source = ../home/dunst;
  home.file.".config/hypr".source = ../home/hypr;
  home.file.".config/k9s".source = ../home/k9s;
  home.file.".config/kitty".source = ../home/kitty;
  home.file.".config/nvim".source = ../home/nvim;
  home.file.".config/tmux".source = ../home/tmux;
  home.file.".config/waybar".source = ../home/waybar;
  home.file.".config/yazi".source = ../home/yazi;

  home.file.".config/i3".source = ../home/i3;
  home.file.".config/i3blocks".source = ../home/i3blocks;
}
