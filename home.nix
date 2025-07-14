{pkgs, username, ...}: {
  targets.darwin.linkApps = {
    enable = true;
    directory = "Applications/Home Manager Apps";
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  home.username = username;

  imports = [
    ./neovim.nix
    ./vscode.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    zoxide
    telegram-desktop
    git
    gh
    brave
    raycast
    fzf
    nerd-fonts.jetbrains-mono
    iterm2
  ];

  fonts.fontconfig.enable = true;

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    shell = "${pkgs.zsh}/bin/zsh";
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
      # Work-around the tmux-sensible regression
      set -gu default-command
      set -g  default-shell "${pkgs.zsh}/bin/zsh"
      set -g  default-command "${pkgs.zsh}/bin/zsh -l"
      # Good defaults
      set -g  default-terminal "screen-256color"
      set -as terminal-overrides ',*:RGB'
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

  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    exness-github = {
      hostname = "github.com";
      user = "git";
      identityFile = "/Users/${username}/.ssh/id_ed25519exness-github";
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
