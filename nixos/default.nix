{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    # ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      iosevka
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-lgc-plus
      noto-fonts-emoji-blob-bin
      noto-fonts-monochrome-emoji
      font-misc-misc
    ];
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = (lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs) // {
        # add nixpkgs alias for nix run n#something
        n.flake = flakeInputs.nixpkgs;
      };
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  networking.hostName = "nixos";
  networking.firewall.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  environment.localBinInPath = true;

  # Set your time zone.
  # time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "C.UTF-8";

  i18n.inputMethod = {
    type = "fcitx5";
    enable = false;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  users.users.ludihan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
    shell = pkgs.bash;
  };

  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        session_log = ".local/state/ly-session.log";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    automatic-timezoned.enable = true;
    gnome.gnome-keyring.enable = true;
  };
  security.polkit.enable = true;

  programs.command-not-found.enable = false;

  programs.nix-index = {
    enable = true;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableBashIntegration = false;
  };

  programs.nix-ld = {
    enable = true;
    libraries =
      (pkgs.steam-run.args.multiPkgs pkgs)
      ++ (with pkgs; [
        fontconfig
        freetype
        expat

        wayland
        libxkbcommon

        libX11
        libXcursor
        libXi
        libXrandr
        libXrender
        libXext
        libXfixes
        libXinerama
        libXxf86vm
        libxcb
      ]);
  };

  # not present in home manager
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  xdg.menus.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true;
    # gamescopeSession.enable = true;
  };
  # programs.gamescope.enable = true;
  # programs.gamemode.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = [
    pkgs.libheif
    pkgs.libheif.out
  ];
  environment.pathsToLink = [ "share/thumbnailers" ];

  console.earlySetup = true;

  musnix.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
