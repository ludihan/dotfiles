{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
  ];
  # Replace the unwanted packages globally with an empty derivation
  nixpkgs.overlays = [
    (final: prev: {
      fooyin = prev.runCommand "empty" { } "mkdir $out";
      aseprite = prev.runCommand "empty" { } "mkdir $out";
      papers = prev.runCommand "empty" { } "mkdir $out";
      renoise = prev.runCommand "empty" { } "mkdir $out";
    })
  ];
  xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
    input {
        keyboard {
            xkb {
                layout "br"
                options "compose:caps"
            }

            repeat-delay 300
            repeat-rate 30
            numlock
        }

        touchpad {
            tap
            natural-scroll
            middle-emulation
            accel-profile "flat"
        }

        mouse {
            accel-profile "flat"
        }
        disable-power-key-handling
    }
  '';
}
