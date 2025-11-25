{
  description = "nixwork";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-config = {
      url = "git+ssh://git@github.com/jardt/nixconfig?ref=master";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixCats = {
      url = "github:jardt/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        withSystem,
        ...
      }:
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
        ];

        flake = {
          homeConfigurations = {
            jdr = withSystem "x86_64-linux" (
              { system, ... }:
              inputs.home-manager.lib.homeManagerConfiguration {
                extraSpecialArgs = { inherit inputs; };
                pkgs = inputs.nixpkgs.legacyPackages.${system};
                modules = [ ./home.nix ];
              }
            );
          };
        };
        systems = [
          "x86_64-linux"
        ];
      }
    );
}
