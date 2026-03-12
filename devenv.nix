{ pkgs, ... }:

let
  vitaly = pkgs.rustPlatform.buildRustPackage {
    pname = "vitaly";
    version = "0.1.32";

    src = pkgs.fetchFromGitHub {
      owner = "bskaplou";
      repo = "vitaly";
      tag = "v0.1.32";
      hash = "sha256-u1OmH2AeskcjNB1ac6iSBaA0Xyea+tB8f5F/LCzafj4=";
    };

    cargoHash = "sha256-HBJFOi3KrjIepGaPwtv/39sQotvQPae9y2rdPJ/uQ8k=";

    nativeBuildInputs = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.pkg-config
    ];

    buildInputs = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.udev
    ] ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      pkgs.apple-sdk_15
    ];
  };
in
{
  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.jq pkgs.jsonnet pkgs.just vitaly ];

  devcontainer.enable = true;
  devcontainer.settings.customizations.vscode.extensions = [
    "jnoortheen.nix-ide"
    "mkhl.direnv"

    "eamodio.gitlens"
    "GitHub.copilot"

    "Grafana.vscode-jsonnet"
  ];

  languages.jsonnet.enable = true;
  env.JSONNET_PATH = "lib:vendor";
}
