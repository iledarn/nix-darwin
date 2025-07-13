{
description = "Ildar's macOS configuration (nix-darwin + Home Manager)";

inputs = {
nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

home-manager.url = "github:nix-community/home-manager/release-25.05";
home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

outputs = {self, nixpkgs, nix-darwin, home-manager}:
let
system = "aarch64-darwin";
pkgs = import nixpkgs {inherit system;};
alejandra = pkgs.alejandra;
username = "ildar.nasyrov";
hostname = "Exness-THG030JJTW";
in {
formatter.${system} = alejandra;
darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
inherit system pkgs;
modules = [ ./darwin-configuration.nix
home-manager.darwinModules.home-manager
{
home-manager.users.${username} = import ./home.nix;
}
];
specialArgs = {inherit username; };
};

};
}
