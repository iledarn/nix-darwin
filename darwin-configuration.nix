{
  pkgs,
  username,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
  ids.gids.nixbld = 350;
  system.stateVersion = 4;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  users.users.${username} = {
    home = "/Users/${username}";
  };

  home-manager.users.${username} = {pkgs, ...}: {
    home.stateVersion = "25.05";
    home.packages = with pkgs; [zoxide tmux starship];
  };
}
