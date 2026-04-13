{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports =
    with inputs.home-config.homeModules;
    [
      television
      stylix
      default
      devops
      media
      btop
      bat
      zsh
      git
      eza
      tmux
      kitty
      yazi
      starship
      fzf
      cli-tools
      direnv
      catsvim
      fonts
      ai
      aerospace
      firefox
    ]
    ++ [
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  modules = {
    shared.stylix = {
      enable = true;
      monospaceFont = "Monaspace Neon";
      theme = "gruvbox-dark-hard";

    };
    home = {
      catsvim = {
        enable = true;
        theme = "gruvbox";
      };
      kitty = {

        enable = true;
        opacity = 0.9;
      };
      devops = {
        enableLima = true;
        enableK8sTools = true;
        enableDocker = true;
      };
      television.enable = true;
      aerospace.enable = true;
      firefox = {
        enable = true;
        profile = "jdr";
      };
    };
  };

  home.packages = with pkgs; [
    zsh-better-npm-completion
    inputs.nixCats.packages.${stdenv.hostPlatform.system}.cats_dotang_nvim
  ];

  lib.environment.enableAllTerminfo = true;

  home.username = "jardar.ton";
  home.homeDirectory = "/Users/jardar.ton";

  home = {
    shellAliases = {
      hr = "home-manager switch --flake ~/worknix/";
    };
  };

  programs.zsh.initExtra = lib.mkAfter ''
    export XDG_DATA_HOME=$HOME/.local/state/
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
