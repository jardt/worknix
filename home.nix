{
  pkgs,
  config,
  inputs,
  lib,
  system,
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

  xdg.configFile."ghostty/config".text = ''
    shell-integration = zsh

    font-family = ${config.stylix.fonts.monospace.name}
    font-feature = ss01
    font-feature = ss02
    font-feature = ss03
    font-feature = ss04
    font-feature = ss05
    font-feature = ss06
    font-feature = ss07
    font-feature = ss09
    font-thicken = true

    copy-on-select = clipboard
    background-opacity-cells = true
    mouse-hide-while-typing = true
    macos-titlebar-proxy-icon = hidden
    macos-titlebar-style = hidden
    title =
    macos-non-native-fullscreen = true
    window-decoration = true
    background-opacity = 0.85
    background-blur = true
  '';

  programs.zsh.initContent = lib.mkAfter ''
    export XDG_DATA_HOME=$HOME/.local/state/
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
