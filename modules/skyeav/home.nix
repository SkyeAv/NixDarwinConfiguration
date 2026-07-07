{
  pkgs,
  ...
}:
{
  # Home manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.skyeav = {
      home = {
        # Do not modify this
        stateVersion = "25.11";
        # Append vars to path
        sessionPath = [
          "/opt/homebrew/bin"
          "$HOME/.local/bin"
          "$HOME/go/bin"
        ];
      };
      programs = {
        # Zsh configuration
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          # Zsh aliases
          shellAliases = {
            amphetamine = ''systemd-inhibit --what=idle:sleep --why="Presentation" sleep infinity'';
            rebuild = "sudo darwin-rebuild switch --flake /etc/nix-darwin#skyeav";
            docker = "podman";
            zed = "zeditor";
            ps = "procs";
            top = "htop";
            du = "dust";
            ls = "eza";
            df = "duf";
            cd = "z";
          };
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
        # Zoxide integration
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
        # Direnv integration
        direnv = {
          enable = true;
          enableZshIntegration = true;
        };
        # Carapace integration
        carapace = {
          enable = true;
          enableZshIntegration = true;
        };
        # Nushell integration
        nushell = {
          enable = true;
        };
        # Zed configuration
        zed-editor = {
          enable = true;
          extensions = [
            "material-icon-theme"
            "docker-compose"
            "github-actions"
            "git-firefly"
            "ayu-darker"
            "dockerfile"
            "elixir"
            "julia"
            "latex"
            "perl"
            "make"
            "toml"
            "ruff"
            "log"
            "nim"
            "nix"
          ];
          installRemoteServer = true;
          userSettings = {
            theme = {
              mode = "dark";
              dark = "Ayu Darker";
              light = "Ayu Darker";
            };
            terminal = {
              shell = "system";
            };
            base_keymap = "VSCode";
          };
        };
        # Kitty configuration
        kitty = {
          enable = true;
          shellIntegration.enableZshIntegration = true;
        };
        # Alacritty configuration
        alacritty.enable = true;
        # Neovim integration
        neovim.enable = true;
        # Tmux configuration
        tmux = {
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
  };
}
