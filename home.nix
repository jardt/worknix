{
  pkgs,
  config,
  myvars,
  inputs,
  nixGL,
  lib,
  ...
}:
{
  imports = [
    inputs.mainConfig.stylixModule
    inputs.mainConfig.homeManagerModules
    ./hyprland.nix
    ./hyprlock.nix
    ./podman.nix
  ];

  nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
    defaultWrapper = "mesaPrime"; # choose from nixGL options depending on GPU
    prime.card = "0x10de:0x25bc";
  };

  wayland.windowManager.hyprland = {
    systemd.enable = lib.mkForce true;
  };

  modules = {
    shared.stylix = {
      enable = true;
      monospaceFont = "Monaspace Radon Var";
      wallpaper = ./kanagawa.jpg;
    };
    home = {
      hypr = {
        enable = true;
        package = config.lib.nixGL.wrap pkgs.hyprland;
        launcher = "fuzzel";
        cmdMod = "SUPER";
        hyprlock = false;
        hyprpaper = true;
        hyprsunset = false;
      };
      catsvim.enable = true;
      vscode.enable = true;
      taskwarrior.enable = true;
      ghostty.enable = true; # broken
      firefox = {
        enable = true;
        profile = "jdr";
      };
      devops = {
        enableLima = true;
        enableK8sTools = true;
        enableDocker = true;
      };
    };
  };

  stylix.polarity = "dark";

  home.packages = [
    pkgs.nodePackages_latest.nodejs
    pkgs.zsh-better-npm-completion
    pkgs.rsync
    pkgs.neovim
    pkgs.wget
    pkgs.azure-cli
    pkgs.curl
    pkgs.egl-wayland
    # pkgs.xorg.xorgserver
    # pkgs.xorg.xinit
    pkgs.dmenu
    pkgs.dwm
    pkgs.st
    pkgs.uwsm
    pkgs.htop
    pkgs.adw-gtk3
    pkgs.figma-linux
  ];

  services = {
    polkit-gnome.enable = true;
    hyprpolkitagent.enable = true;
  };

  programs = {
    git.userName = "Jardar";
    fuzzel = {
      enable = true;
      settings = {
        main = {
          prompt = "-> ";
          terminal = "${pkgs.kitty}/bin/kitty";
          launch-prefix = "uwsm app -- ";
        };
      };
    };
    kitty.package = config.lib.nixGL.wrap pkgs.kitty;
    firefox.package = config.lib.nixGL.wrap pkgs.firefox-wayland;
  };

  lib.environment.enableAllTerminfo = true;

  home.username = myvars.username;
  home.homeDirectory = "/home/${myvars.username}";

  home.shellAliases = {
    hr = "home-manager switch --flake ~/worknix/";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
