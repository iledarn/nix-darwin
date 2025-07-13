{pkgs, ...}: {
  # Specify the version of Home Manager you are targeting.
  # Update this if you switch branches or after release upgrades.
  home.stateVersion = "25.05";

  # Packages that should be installed for your user. Feel free to extend.
  home.packages = with pkgs; [
    zoxide
    tmux
    starship
    telegram-desktop
    git
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
