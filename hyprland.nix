{
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      dim_inactive = lib.mkForce true;
    };
    exec = [
      #for libadwaita gtk4 apps you can use this command:
      ''gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"''
      #for gtk3 apps you need to install adw-gtk3 theme (in arch linux sudo pacman -S adw-gtk-theme)
      ''gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"''
    ];
    bind = lib.mkForce [
      "$mainMod, RETURN, fullscreenstate, 1, 1"
      "$command, RETURN, fullscreen"

      "$mainMod, SPACE, exec, run_or_raise $terminal"
      "$mainMod, E, exec, run_or_raise firefox"
      "$command, Q, killactive,"
      "$mainMod, ESCAPE, exit,"
      "$mainMod, F, exec, $fileManager"
      "$mainMod, V, togglefloating,"
      "$command, SPACE, exec, $menu"
      "$command, U, exec, bemenu-run"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, c, togglesplit, # dwindle"

      "$mainMod, A, focuscurrentorlast"

      #focus with mainMod + arrow keys
      "$mainMod, l, movefocus, l"
      "$mainMod, h, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"

      #Switch workspaces with mainMod + [0-9]
      "$mainMod, 0, workspace, 0"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"

      #Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SUPER, 0, movetoworkspace, 0"
      "$mainMod SUPER, 1, movetoworkspace, 1"
      "$mainMod SUPER, 2, movetoworkspace, 2"
      "$mainMod SUPER, 3, movetoworkspace, 3"
      "$mainMod SUPER, 4, movetoworkspace, 4"
      "$mainMod SUPER, 5, movetoworkspace, 5"
      "$mainMod SUPER, 6, movetoworkspace, 6"
      "$mainMod SUPER, 7, movetoworkspace, 7"
      "$mainMod SUPER, 8, movetoworkspace, 8"
      "$mainMod SUPER, 9, movetoworkspace, 9"

      # Example special workspace (scratchpad)
      # bind = $mainMod, S, togglespecialworkspace, magic
      # bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "bind = $mainMod, mouse_up, workspace, e-1"

    ];
  };
}
