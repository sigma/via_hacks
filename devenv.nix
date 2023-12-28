{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.jsonnet ];

  devcontainer.enable = true;
  devcontainer.settings.customizations.vscode.extensions = [
    "jnoortheen.nix-ide"
    "mkhl.direnv"
    
    "eamodio.gitlens"
    "GitHub.copilot"

    "Grafana.vscode-jsonnet"
  ];

  languages.jsonnet.enable = true;
}
