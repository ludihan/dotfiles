{
  config,
  pkgs,
  flakeLocation,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./modules/niri
  ];

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
      (final: prev: {
        nautilus = prev.nautilus.overrideAttrs (nprev: {
          buildInputs =
            nprev.buildInputs
            ++ (with pkgs.gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
            ]);
        });
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ludihan";
    homeDirectory = "/home/ludihan";
    preferXdgDirectories = true;
    sessionVariables =
      let
        data = d: "${config.home.homeDirectory}/.local/share/${d}";
        cache = d: "${config.home.homeDirectory}/.cache/${d}";
        state = d: "${config.home.homeDirectory}/.local/state/${d}";
        configDir = d: "${config.home.homeDirectory}/.config/${d}";
      in
      {
        GOPATH = data "go";
        PYTHONUSERBASE = data "python";
        CARGO_HOME = data "cargo";
        RUSTUP_HOME = data "rustup";
        OPAMROOT = data "opam";

        CUDA_CACHE_PATH = cache "nv";
        PYTHONPYCACHEPREFIX = cache "python";
        NUGET_PACKAGES = cache "NuGetPackages";

        PYTHON_HISTORY = state "python_history";
        PSQL_HISTORY = state "psql_history";
        SQLITE_HISTORY = state "sqlite_history";
        NODE_REPL_HISTORY = state "node_repl_history";

        NPM_CONFIG_USERCONFIG = configDir "npm/npmrc";
        DOCKER_CONFIG = configDir "docker";
        OMNISHARPHOME = configDir "omnisharp";
        # _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.home.homeDirectory}/.config/java";

        GHCUP_USE_XDG_DIRS = "true";
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
  };

  programs.command-not-found.enable = false;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # Provide a nice prompt if the terminal supports it.
      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      fi
      export PATH=$PATH:$HOME/.local/bin
      export PATH=$PATH:$CARGO_HOME/bin
      export PATH=$PATH:$GOPATH/bin
    '';
  };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.LS_COLORS = (vivid generate gruvbox-dark)
      $env.config.edit_mode = 'vi'
      $env.config = {
          show_banner: false,
          table: {
              header_on_separator: true,
              mode: 'single'
          }
      }
    '';
  };
  # programs.carapace.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = config.gtk.theme;
    #iconTheme = {
    #name = "Obsidian-Sand";
    #};
    cursorTheme = {
      name = "Adwaita";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
  dconf = {
    enable = true;
    settings = {
      #"org/gnome/desktop/background" = {
      #picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      #};
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ### command line ###
    wget
    curl
    jq
    jo
    fd
    ripgrep
    bat
    grim
    slurp
    vivid
    wl-clipboard
    brightnessctl
    unzip
    unrar
    zip
    tree
    nvd
    wl-mirror
    # cmus
    ncdu
    file
    htop
    socat
    # quickemu
    tmux
    asciinema

    ### graphical ###
    discord
    godot
    material-maker
    blender
    # spotify
    hyprpicker
    imv
    papers
    # krita
    # mednafen
    # osu-lazer-bin
    pavucontrol
    networkmanagerapplet
    tuxpaint
    woomer
    fooyin
    nicotine-plus
    # mangohud
    foliate
    # vintagestory
    nautilus
    aseprite
    krita
    prismlauncher
    libnotify

    ### dev ###
    neovim
    bruno
    tree-sitter
    gcc
    gnumake
    nodejs
    (python3.withPackages (
      ppkgs: with ppkgs; [
        python-lsp-server
      ]
    ))
    uv
    go
    typst
    rustc
    cargo
    rustfmt
    clippy
    opencode
    zola
    nixfmt
    nixfmt-tree
    kdePackages.qtdeclarative
    nix-output-monitor
    nurl
    nix-init
    docker-compose
    docker-buildx
    ngrok
    xmake

    # jetbrains.idea
    # jdk
    # maven
    # gradle
    # scala
    # scala-cli
    # sbt
    # ammonite
    # scalafmt
    # coursier
    # metals
    beam29Packages.elixir_1_20
    beam29Packages.elixir-ls
    beam29Packages.erlang
    inotify-tools

    ### lsp servers ###
    # julials
    # hls
    nil
    clang-tools
    nixd
    rust-analyzer
    gopls
    kdePackages.qtlanguageserver
    tinymist
    vscode-langservers-extracted
    emmet-language-server
    lua-language-server
    taplo
    # templ
    vtsls
    # vue_ls
    # svelte
    # bashls
    # dockerls
    # docker_compose_language_service
    marksman
    yaml-language-server
    # omnisharp

    # misc
    xwayland-satellite

    # music
    # reaper
    # reaper-sws-extension
    # reaper-reapack-extension
    renoise
    vital
    dexed
    # qsampler
    # qsynth
    # polyphone
    # cardinal
    # openutau
    # airwindows
    surge-xt
    odin2
    # helm
    # lsp-plugins
    carla
    # calf
    # fluida-lv2
    # decent-sampler
    sfizz-ui
    distrho-ports
    # setbfree
    # x42-gmsynth
    # x42-avldrums
    # sunvox
    # musescore
    # muse-sounds-manager
  ];

  # home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so".source = "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";
  # home.file.".config/REAPER/UserPlugins/reaper_sws-x86_64.so".source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
  # home.file.".config/REAPER/Scripts/sws_python.py".source = "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
  # home.file.".config/REAPER/Scripts/sws_python64.py".source = "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";

  services.udiskie = {
    enable = true;
  };

  programs.firefox.enable = true;
  programs.quickshell.enable = true;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=12";
        resize-by-cells = false;
      };
      # gruvbox
      colors-dark = {
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "b8bb26";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
      };

      colors-light = {
        background = "fbf1c7";
        foreground = "3c3836";
        regular0 = "fbf1c7";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "7c6f64";
        bright0 = "928374";
        bright1 = "9d0006";
        bright2 = "79740e";
        bright3 = "b57614";
        bright4 = "076678";
        bright5 = "8f3f71";
        bright6 = "427b58";
        bright7 = "3c3836";
      };
    };
  };

  programs.zed-editor.enable = true;
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ludihan";
        email = "65617704+ludihan@users.noreply.github.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      core = {
        autocrlf = "input";
      };
    };
  };
  programs.discord.enable = true;
  programs.home-manager.enable = true;

  services.easyeffects.enable = true;

  programs.obs-studio = {
    enable = false;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      # obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.mpv = {
    enable = true;
    config = {
      keep-open = true;
    };
  };

  programs.nh = {
    enable = true;
    flake = flakeLocation;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableBashIntegration = false;
  };

  home.file.".clang-format".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeLocation}/config/clang-format";

  xdg = {
    enable = true;
    configFile =
      let
        link = name: config.lib.file.mkOutOfStoreSymlink "${flakeLocation}/config/${name}";
      in
      {
        nvim.source = link "nvim";
        quickshell.source = link "quickshell";
        tmux.source = link "tmux";
        "npm/npmrc".text = ''
          prefix=''${XDG_DATA_HOME}/npm
          cache=''${XDG_CACHE_HOME}/npm
          init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
          logs-dir=''${XDG_STATE_HOME}/npm/logs
        '';
      };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      publicShare = null;
      setSessionVariables = true;
    };
    mime.enable = true;
    mimeApps = {
      #enable = true;
      #defaultApplications = {
      #"inode/directory" = "org.gnome.Nautilus.desktop";
      #"application/pdf" = "org.gnome.Papers.desktop";
      #"application/epub+zip" = "foliate.desktop";
      #"application/epub" = "foliate.desktop";
      #"application/mobi" = "foliate.desktop";
      #"image/jpg" = "imv.desktop";
      #"image/jpeg" = "imv.desktop";
      #"image/png" = "imv.desktop";
      #"image/webp" = "imv.desktop";
      #"text/*" = "org.gnome.TextEditor.desktop";
      #"text/plain" = "org.gnome.TextEditor.desktop";
      #};
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}
