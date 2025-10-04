{
  pkgs,
  username,
  ...
}: {
  system.primaryUser = username;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
  ids.gids.nixbld = 350;
  system.stateVersion = 4;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  homebrew = {
    enable = true;
    casks = [
      "hammerspoon"
      "amazon-q"
      "spotify"
    ];
  };

  users.users.${username} = {
    home = "/Users/${username}";
  };
}
