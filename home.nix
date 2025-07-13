{pkgs, ...}: {
  targets.darwin.linkApps = {
    enable = true;
    directory = "Applications/Home Manager Apps";
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    zoxide
    telegram-desktop
    gh
    brave
    raycast
    fzf
  ];

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.sessionist
      tmuxPlugins.resurrect
      tmuxPlugins.pain-control
      tmuxPlugins.gruvbox
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
    ];
    extraConfig = ''
      setw -g mode-keys vi
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix
      bind-key C-a last-window
      set-option -sa terminal-features ',foot:RGB'
    '';
  };

  programs.git = {
    enable = true;
    userName = "Ildar Nasyrov";
    userEmail = "iledarnp@gmail.com";
    aliases = {
      co = "checkout";
      st = "status";
      hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
    };
  };

  programs.fzf.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
