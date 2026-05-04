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
      bun
    ]
    ++ [
      ./omniwm.nix
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
      bun.enable = true;
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

    file.".local/scripts/stop-web" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        port=8010

        if command -v docker >/dev/null 2>&1; then
          containers="$(docker ps --filter "publish=$port" --format '{{.ID}} {{.Names}}')"
          if [ -n "$containers" ]; then
            while IFS= read -r container; do
              [ -n "$container" ] || continue
              id="''${container%% *}"
              name="''${container#* }"
              echo "Stopping Docker container $name ($id) exposing port $port"
              docker stop "$id"
            done <<EOF
        $containers
        EOF
            exit 0
          fi
        fi

        pids="$(lsof -nP -tiTCP:"$port" -sTCP:LISTEN || true)"

        if [ -z "$pids" ]; then
          echo "Nothing is listening on port $port"
          exit 0
        fi

        echo "Killing process(es) listening on port $port: $(printf '%s ' $pids)"
        printf '%s\n' "$pids" | xargs kill
      '';
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
    export PATH="/Users/jardar.ton/.bun/bin:$PATH"
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
