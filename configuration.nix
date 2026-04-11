{
  pkgs,
  lib,
  ...
}:
{
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
      "https://cache.flox.dev"
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = [
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs"
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
    casks = [
      "bitwarden"
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
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
    claude-code
    alacritty
    fastfetch
    python314
    nodejs_24
    opencode
    nix-diff
    ripgrep
    pyright
    podman
    zoxide
    neovim
    ffmpeg
    libzip
    kitty
    rsync
    unzip
    cmake
    ninja
    macpm
    file
    dust
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
  ];
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
          rebuild = "sudo darwin-rebuild switch --flake /etc/nix-darwin#skyeav";
          skyetop = "ssh skyeav@192.168.1.13";
          docker = "podman";
          top = "htop";
          vim = "nvim";
          du = "dust";
          vi = "nvim";
          df = "duf";
          ls = "eza";
          cd = "z";
        };
        initContent = lib.mkBefore ''
          export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
          export PATH="/users/skyeav/.local/bin:$PATH"
          export PATH="/users/skyeav/go/bin:$PATH"
          export PATH="/opt/homebrew/bin:$PATH"
        '';
        # Oh my zsh configuration
        oh-my-zsh = {
          enable = true;
          plugins = [
            "extract"
            "git"
          ];
          theme = "eastwood";
        };
        history.size = 100;
      };
      # Zoxide
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      # Direnv integration
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };
      # Tmux configuration
      programs.tmux = {
        enable = true;
        baseIndex = 1;
        historyLimit = 10000;
        mouse = true;
        keyMode = "vi";
        plugins = with pkgs.tmuxPlugins; [
          catppuccin
          sensible
          yank
        ];
        extraConfig = ''
          setw -g mode-keys vi
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
          bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
        '';
      };
    };
  };
}
