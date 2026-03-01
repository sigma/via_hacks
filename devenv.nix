{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.jsonnet pkgs.just ];

  devcontainer.enable = true;
  devcontainer.settings.customizations.vscode.extensions = [
    "jnoortheen.nix-ide"
    "mkhl.direnv"
    
    "eamodio.gitlens"
    "GitHub.copilot"

    "Grafana.vscode-jsonnet"
  ];

  languages.jsonnet.enable = true;
  env.JSONNET_PATH = "vendor";
}
