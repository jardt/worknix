# OmniWM + skhd setup

This Home Manager config writes the OmniWM and skhd config files, but the apps are installed with Homebrew.

## Install

```sh
brew install --cask omniwm
brew install jackielii/tap/skhd-zig
```

If OmniWM is not available as a cask on your machine, install it from its upstream release/app distribution, then keep using the Home Manager-managed config at `~/.config/omniwm/settings.toml`.

## Apply Home Manager config

```sh
home-manager switch --flake ~/worknix/
```

This writes:

```text
~/.config/omniwm/settings.toml
~/.config/skhd/skhdrc
~/.config/skhd/omni-find-window
~/.config/skhd/omni-focus-or-open
~/.config/skhd/omni-move-column-to-workspace
~/.config/skhd/omni-move-column-to-other-monitor
```

## Start services

Home Manager installs a user LaunchAgent that starts OmniWM at login:

```text
launchd.agents.omniwm
```

Install/start skhd separately:

```sh
skhd --install-service
skhd --start-service
```

After config changes:

```sh
skhd --restart-service
```

Restart OmniWM if `~/.config/omniwm/settings.toml` changed.

## macOS permissions

Grant Accessibility to both apps:

```text
System Settings → Privacy & Security → Accessibility
```

Add/toggle:

```text
/Applications/OmniWM.app
/opt/homebrew/opt/skhd-zig/skhd.app
```

Check skhd:

```sh
skhd --status
```

Expected:

```text
Hotkeys functional: Yes
```

## Important bindings

- `Ctrl+Shift+Alt+A`: workspace back-and-forth
- `Ctrl+Shift+Alt+Tab`: focus next monitor
- `Ctrl+Shift+Alt+Cmd+Tab`: move current Niri column to the other monitor and follow it
- `Ctrl+Shift+Alt+Cmd+1..9`: move current Niri column to workspace and follow it
- app hotkeys use skhd helper scripts to focus existing app workspace or open the app on its assigned workspace
