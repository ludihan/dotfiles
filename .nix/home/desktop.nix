{ lib, ... }:
{
  imports = [
    ./default.nix
  ];
  xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
    input {
        keyboard {
            xkb {
                // layout "br"
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
