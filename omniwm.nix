{ ... }:
{
  # OmniWM itself and skhd-zig are installed with Homebrew, not Nix.
  # See ./README-omniwm-skhd.md for install/service commands.

  launchd.agents.omniwm = {
    enable = true;
    config = {
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "OmniWM"
      ];
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "/tmp/omniwm-launchd.out.log";
      StandardErrorPath = "/tmp/omniwm-launchd.err.log";
    };
  };

  xdg.configFile."omniwm/settings.toml".source = ./omniwm/settings.toml;

  xdg.configFile."skhd/skhdrc".source = ./skhd/skhdrc;

  xdg.configFile."skhd/omni-find-window" = {
    source = ./skhd/omni-find-window;
    executable = true;
  };

  xdg.configFile."skhd/omni-focus-or-open" = {
    source = ./skhd/omni-focus-or-open;
    executable = true;
  };

  xdg.configFile."skhd/omni-move-column-to-workspace" = {
    source = ./skhd/omni-move-column-to-workspace;
    executable = true;
  };

  xdg.configFile."skhd/omni-move-column-to-other-monitor" = {
    source = ./skhd/omni-move-column-to-other-monitor;
    executable = true;
  };
}
