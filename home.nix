{
  pkgs,
  username,
  ...
}: {
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
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    zoxide
    # telegram-desktop
    git
    gh
    brave
    raycast
    fzf
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack

    firefox
    insomnia
    postman
    zoom-us

    maccy
    rectangle
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

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 14;
      };
    };
  };

  # Hammerspoon app installed via Homebrew; we only manage the config.
  home.file.".hammerspoon/init.lua".text = ''
    -- Starter config: show a message when loaded
    hs.alert.show("Hammerspoon loaded from Home Manager!")

    -- Hotkey to open/activate Alacritty with Command+Ctrl+X
    hs.hotkey.bind({"cmd", "ctrl"}, "X", function() 
      hs.application.open("/Users/${username}/Applications/Home Manager Apps/Alacritty.app")
    end)
    
    -- Hotkey to open/activate Slack with Command+Ctrl+S
    hs.hotkey.bind({"cmd", "ctrl"}, "S", function() hs.application.launchOrFocus("Slack") end)
    
    -- Hotkey to open/activate Firefox with Command+Ctrl+F
    hs.hotkey.bind({"cmd", "ctrl"}, "F", function() 
      hs.application.open("/Users/${username}/Applications/Home Manager Apps/Firefox.app")
    end)
    
    -- Hotkey to open/activate Brave with Command+Ctrl+D (cycles through windows)
    local braveWindowIndex = 1
    hs.hotkey.bind({"cmd", "ctrl"}, "D", function() 
      local brave = hs.application.find("Brave Browser")
      if brave then
        local windows = brave:visibleWindows()
        if #windows > 0 then
          braveWindowIndex = (braveWindowIndex % #windows) + 1
          windows[braveWindowIndex]:focus()
        end
      else
        hs.application.open("/Users/${username}/Applications/Home Manager Apps/Brave Browser.app")
        braveWindowIndex = 1
      end
    end)
    
    -- Hotkey to open/activate Google Chrome with Command+Ctrl+G (cycles through windows)
    local chromeWindowIndex = 1
    hs.hotkey.bind({"cmd", "ctrl"}, "G", function() 
      local chrome = hs.application.find("Google Chrome")
      if chrome then
        local windows = chrome:visibleWindows()
        if #windows > 0 then
          chromeWindowIndex = (chromeWindowIndex % #windows) + 1
          windows[chromeWindowIndex]:focus()
        end
      else
        hs.application.launchOrFocus("Google Chrome")
        chromeWindowIndex = 1
      end
    end)
    
    -- Hotkey to open/activate Visual Studio Code with Command+Ctrl+C
    hs.hotkey.bind({"cmd", "ctrl"}, "C", function() hs.application.launchOrFocus("Visual Studio Code") end)
    
    -- Hotkey to open/activate Telegram with Command+Ctrl+T
    hs.hotkey.bind({"cmd", "ctrl"}, "T", function() 
      hs.application.launchOrFocus("Telegram")
    end)
    
    -- Hotkey to open/activate Postman with Command+Ctrl+P
    hs.hotkey.bind({"cmd", "ctrl"}, "P", function() 
      hs.application.open("/Users/${username}/Applications/Home Manager Apps/Postman.app")
    end)
    
    -- Hotkey to open/activate WhatsApp with Command+Ctrl+W
    hs.hotkey.bind({"cmd", "ctrl"}, "W", function() 
      hs.application.launchOrFocus("WhatsApp")
    end)
    
    -- Hotkey to open/activate Facebook Messenger with Command+Ctrl+M
    hs.hotkey.bind({"cmd", "ctrl"}, "M", function() 
      hs.application.launchOrFocus("Messenger")
    end)
    
    -- Hotkey to open/activate Strongbox with Command+Ctrl+K
    hs.hotkey.bind({"cmd", "ctrl"}, "K", function() hs.application.launchOrFocus("Strongbox") end)
  '';
}
