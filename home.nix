{
  pkgs,
  config,
  inputs,
  nixGL,
  lib,
  ...
}:
{
  imports =
    with inputs.home-config.homeModules;
    [
      default
      devops
      media
      firefox
      vscode
      btop
      bat
      zsh
      ghostty
      zathura
      lazygit
      eza
      tmux
      kitty
      yazi
      starship
      fzf
      cli-tools
      direnv
      catsvim
      mango
      fsel
      hyprland
      taskwarrior
      screenshot
      xdg
      waybar
      stylix
    ]
    ++ [
      ./hyprland.nix
      ./work.nix
    ];

  nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
    defaultWrapper = "mesaPrime"; # choose from nixGL options depending on GPU
    prime.card = "0x10de:0x25bc";
  };

  modules = {
    shared.stylix = {
      enable = true;
      monospaceFont = "Monaspace Neon";
      wallpaper = ./nord-mountain.png;
      theme = "nord";
    };
    home = {
      mango = {
        enable = true;
        blur = true;
        terminal = "kitty";
        extraSettings = ''
          bind=CTRL+SHIFT+SUPER+ALT,w,spawn,kitty --title launcher -e bash -c work-dmenu
        '';
        extraAutoStart = ''
          wlr-randr --output eDP-1 --scale 1.4 &
          waybar &
        '';
      };
      hypr = {
        enable = true;
        package = pkgs.hyprland;
        launcher = "rofi -show drun";
        cmdMod = "SUPER";
        hyprlock = true;
        hyprpaper = true;
        hyprsunset = false;
      };
      catsvim = {
        enable = true;
        theme = "nord";
      };
      vscode.enable = true;
      taskwarrior.enable = false;
      ghostty = {
        enable = true;
        package = pkgs.ghostty;
        custom-shader = [ "shaders/cursor_smear_fade.glsl" ];
      };
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

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home.packages = with pkgs; [
    nodePackages_latest.nodejs
    zsh-better-npm-completion
    (pkgs.azure-cli.withExtensions [
      pkgs.azure-cli.extensions.virtual-wan
    ])
    egl-wayland
    dmenu
    dwm
    st
    uwsm
    adw-gtk3
    cloudflare-warp
    dotnet-sdk_9
    powershell
    wl-clipboard
    prusa-slicer
    slack
    figma-linux
    keyd
    spotify
    google-chrome
    chromium
    inputs.nixCats.packages.${stdenv.hostPlatform.system}.cats_dotang_nvim
    nerd-fonts.monaspace
    youtube-tui
  ];

  services = {
    polkit-gnome.enable = true;
    hyprpolkitagent.enable = true;
    podman.enable = true;
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
    firefox.package = config.lib.nixGL.wrap pkgs.firefox;
  };

  lib.environment.enableAllTerminfo = true;

  home.username = "jdr";
  home.homeDirectory = "/home/jdr";

  home.shellAliases = {
    hr = "home-manager switch --flake ~/worknix/";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
