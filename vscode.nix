{pkgs, ...}: {
  programs.vscode = {
    enable = false;
    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
          brettm12345.nixfmt-vscode
          mkhl.direnv
          dracula-theme.theme-dracula
          vscodevim.vim
          yzhang.markdown-all-in-one
          bbenoist.nix
          ms-azuretools.vscode-docker
          ms-python.black-formatter
          ms-python.python
          ms-python.isort
          xyz.local-history
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vsc-invoke";
            publisher = "dchanco";
            version = "0.0.12";
            sha256 = "sha256-+YpNftJ9qIfZqGQXZAb4+E0V8/aa8zWTjRSphddQw68=";
          }
          {
            name = "tasks";
            publisher = "actboy168";
            version = "0.16.0";
            sha256 = "sha256-btYWdOuxqSBclBHKyICo2yNmTjB7tOpiKNFNASPgihU=";
          }
          {
            name = "aws-toolkit-vscode";
            publisher = "AmazonWebServices";
            version = "3.12.0";
            sha256 = "sha256-110Hn80Nll8vO8EgeQ7coKyspjUR6TyyCTmdIdkzHZ4=";
          }
          {
            name = "amazon-q-vscode";
            publisher = "AmazonWebServices";
            version = "1.11.0";
            sha256 = "sha256-5Op1ivgeVzPvIuT5qeY67Oe8xm1wWWIaSgp4jzDBau0=";
          }
          {
            name = "prettier-vscode";
            publisher = "esbenp";
            version = "10.4.0";
            sha256 = "sha256-8+90cZpqyH+wBgPFaX5GaU6E02yBWUoB+T9C2z2Ix8c=";
          }
        ];
    };
  };
}
