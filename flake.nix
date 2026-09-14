{
  description = "Jsonnet-based VIA / Keychron Launcher keymap generator";

  nixConfig = {
    extra-substituters = [ "https://firefly-toolbox.cachix.org" ];
    extra-trusted-public-keys = [
      "firefly-toolbox.cachix.org-1:4RgCoc0+CS7QhRarG109VmWlnlYi+rQ5JYrCsRP5aK8="
    ];
  };

  inputs = {
    nix-pins.url = "github:firefly-engineering/nix-pins";
    nixpkgs.follows = "nix-pins/nixpkgs";
    toolbox.url = "github:firefly-engineering/toolbox";
    toolbox.inputs.nix-pins.follows = "nix-pins";
  };

  outputs =
    { nixpkgs, toolbox, ... }:
    let
      # Same set as toolbox advertises; x86_64-darwin is gone from nixpkgs.
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          reg = toolbox.registry.${system};
          tool = name: reg.${name}.versions.${reg.${name}.default};
        in
        {
          default = pkgs.mkShell {
            packages = [
              (tool "jq")
              (tool "jrsonnet")
              (tool "just")
              (tool "vitaly")
              # docs -> PDF; typst is pandoc's PDF engine (no TeX needed)
              pkgs.pandoc
              pkgs.typst
            ];

            JSONNET_PATH = "lib:vendor";
          };
        }
      );
    };
}
