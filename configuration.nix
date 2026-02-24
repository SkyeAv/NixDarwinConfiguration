{pkgs, inputs, lib, config, ...}:
let
  code-extensions = pkgs.vscode-extensions;
  py = pkgs.python313Packages;
  np = pkgs.nodePackages;
in {
  # ENABLE SUBSITUTERS
  nix.settings = {
    max-jobs = "auto";
    cores = 0;
    download-buffer-size = 4294967296;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
      "https://cache.nixos-cuda.org"
      "https://cache.flox.dev"
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = [
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs"
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
  # OPTIMIZE
  nix.optimise.automatic = true;
  # GARBAGE COLLECTOR
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };
  # HOMEBREW
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "yakitrak/yakitrak"
      "steipete/tap"
    ];
    brews = [
      "obsidian-cli"
      "gogcli"
    ];
    casks = [
      "visual-studio-code"
      "bitwarden"
      "obsidian"
    ];
  };
  # SYSTEM SETTINGS
  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXEnableExtensionChangeWarning = false;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
    };
    stateVersion = 6;
  };
  # ALLOW UNFREE PACKAGES
  nixpkgs.config.allowUnfree = true;
  # USER CONFIGURATION
  users.users.skyeav = {
    name = "skyeav";
    home = "/Users/skyeav";
  };
  # PRIMARY USER
  system.primaryUser = "skyeav";
  # SYSTEM PACKAGES
  environment.systemPackages = (with pkgs; [
    podman-compose
    podman-desktop
    antigravity
    claude-code
    fastfetch
    opencode
    nix-diff
    ripgrep
    pyright
    podman
    zoxide
    neovim
    ffmpeg
    libzip
    rsync
    unzip
    cmake
    ninja
    macpm
    file
    dust
    tmux
    htop
    curl
    wget
    gawk
    btop
    tree
    duf
    fzf
    zip
    gcc
    git
    eza
    bat
    bun
    lua
    fd
    go
    gh
    jq
    uv
  ]) ++ [(pkgs.python313.withPackages (ps: with ps; [
    setuptools
    playwright
    wheel
    pipx
    pip
  ]))] ++ (with np; [
    nodejs
  ]) ++ [(pkgs.writeShellScriptBin "opencode" ''
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    exec ${pkgs.opencode}/bin/opencode "$@"
  '')];
  # DIRENV ENABLE
  programs.direnv.enable = true;
  # HOME MANAGER
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.skyeav = {
      home.stateVersion = "24.11";
      # ZSH CONFIG
      programs.zsh = {
        enable = true;
        shellAliases = {
          os-rebuild = "sudo darwin-rebuild switch --flake /etc/nix-darwin#skyeav";
          ssh-skyetop = "ssh skyeav@192.168.1.13";
          docker = "podman";
          top = "htop";
          vim = "nvim";
          du = "dust";
          vi = "nvim";
          df = "duf";
          ls = "eza";
          cd = "z";
        };
        initContent = ''
          # Add Homebrew to PATH
          export PATH="/opt/homebrew/bin:$PATH"
        '';
      };
      # ZOXIDE
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}