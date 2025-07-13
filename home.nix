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
    tmux
    starship
    telegram-desktop
    git
    brave
    raycast
  ];
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
}
