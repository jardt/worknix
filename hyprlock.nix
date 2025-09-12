{
  pkgs,
  lib,
  ...
}:
{
  programs = {
    hyprlock = {
      enable = true;
      package = pkgs.hyprlock;

      settings = with lib; {

        auth = {
          pam = {
            enabled = true;
            module = "hyprlock";
          };
          fingerprint = {
            enabled = true;
          };
        };

        background = mkForce [
          {
            monitor = "";
            blur_passes = mkForce 2;
            blur_size = mkForce 2;
          }
        ];

        # input-field = [
        #   {
        #     size = "350, 50";
        #     outline_thickness = 4;
        #     dots_size = 0.1;
        #     dots_spacing = 0.5;
        #     # outer_color = "$entry_border_color";
        #     # inner_color = "$entry_background_color";
        #     # font_color = "$entry_color";
        #     fade_on_empty = true;
        #     position = "0, 20";
        #     halign = "center";
        #     valign = "center";
        #     # source = "~/.config/hypr/hyprlock_monitor.conf";
        #   }
        # ];

        label = [
          {
            # Clock
            monitor = "";
            text = "cmd[update:1000] date +'%d-%m-%Y %H:%M'";
            shadow_passes = 1;
            shadow_boost = 1;
            #color = "$text_color";
            font_size = 28;
            # font_family = "$font_family_clock";
            position = "-40, 80";
            halign = "right";
            valign = "bottom";
          }

          {
            # "Locked" text
            monitor = "";
            text = " Låst";
            shadow_passes = 1;
            shadow_boost = 1;
            font_size = 24;
            position = "80, 80";
            halign = "left";
            valign = "bottom";
          }
        ];
      };
    };
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mainMod, X, exec, hyprlock"
      ];
    };
  };
}
