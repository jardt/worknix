{
  description = "Work flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mainConfig = {
      url = "git+ssh://git@github.com/jardt/nixconfig?ref=master";
    };
    sops-nix = {
      follows = "mainConfig/sops-nix";
    };
    firefox-addons = {
      follows = "mainConfig/firefox-addons";
    };
    stylix = {
      follows = "mainConfig/stylix";
    };
    nixCats = {
      url = "github:jardt/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox = {
      follows = "mainConfig/textfox";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixCats,
      nixGL,
      ...
    }@inputs:
    let
      inherit inputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      username = "jardar.ton";
    in
    {
      homeConfigurations = {
        "jardar.ton" = home-manager.lib.homeManagerConfiguration {

          inherit pkgs;
          extraSpecialArgs = {
            inherit
              inputs
              nixCats
              nixGL
              ;
            firefox-addons = inputs.firefox-addons.packages.${system};
            myvars = {
              username = username;
              server = false;
              laptop = true;
              desktop = true;
            };
          };
          modules = [
            ./home.nix
            inputs.stylix.homeModules.stylix
            inputs.sops-nix.homeManagerModules.sops
          ];
        };
      };
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.kubeconform
        ];
        shellHook = ''
                    echo test
          alias k="bat"
        '';
      };

    };
}
