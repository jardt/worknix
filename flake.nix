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

        perSystem =
          { system, ... }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };
          };

        flake = {
          homeConfigurations = {
            "jardar.ton" = withSystem "aarch64-darwin" (
              { system, pkgs, ... }:
              inputs.home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit inputs system; };
                modules = [ ./home.nix ];
              }
            );
          };
        };
        systems = [
          "aarch64-darwin"
        ];
      }
    );
}
