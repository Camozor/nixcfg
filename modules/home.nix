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
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        tokyo-night-tmux
        vim-tmux-navigator
        yank
      ];

      extraConfig = ''
        # Declare plugins for TPM
        set -g @plugin 'jacoborus/tokyo-night-tmux'
        set -g @plugin 'christoomey/vim-tmux-navigator'
        set -g @plugin 'tmux-plugins/tmux-yank'

        set -g @tokyo-night-tmux_show_music 1

        set-option -sa terminal-features ',xterm-kitty:RGB'
        set-option -ga terminal-overrides ',xterm-kitty:Tc'

        set -g mouse on

        # Prefix
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        # copy mode using 'Esc'
        unbind [
        bind Escape copy-mode

        # 1 based sessions
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel 

        unbind-key 1
        unbind-key 2
        unbind-key 3
        unbind-key 4
        unbind-key 5
        unbind-key 6
        unbind-key 7
        unbind-key 8
        unbind-key 9
        bind-key & select-window -t 1
        bind-key é select-window -t 2
        bind-key \" select-window -t 3
        bind-key \' select-window -t 4
        bind-key ( select-window -t 5
        bind-key - select-window -t 6
        bind-key è select-window -t 7
        bind-key _ select-window -t 8
        bind-key ç select-window -t 9

        # Open panes in current directory
        bind 'v' split-window -v -c "#{pane_current_path}"
        bind 'h' split-window -h -c "#{pane_current_path}"

        bind-key C-j display-popup -E "tms switch"
        bind-key C-o display-popup -E "tms"
      '';
    };
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
      initContent =
        "source ~/.config/zsh/init.sh;source <(kubectl completion zsh);compdef kubecolor=kubectl;source <(COMPLETE=zsh tms)";
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
        kubectl = "kubecolor";
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

  home.file.".config/dunst".source = ../home/dunst;
  # home.file.".config/hypr".source = ../home/hypr;
  home.file.".config/k9s".source = ../home/k9s;
  home.file.".config/kitty".source = ../home/kitty;
  home.file.".config/nvim".source = ../home/nvim;
  # home.file.".config/tmux".source = ../home/tmux;
  home.file.".config/waybar".source = ../home/waybar;
  home.file.".config/wofi".source = ../home/wofi;
  home.file.".config/yazi".source = ../home/yazi;
}
