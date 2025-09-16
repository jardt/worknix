{
  pkgs,
  lib,
  ...
}:
{
  services.podman = {
    enable = true;
  };
}
