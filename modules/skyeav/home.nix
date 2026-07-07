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
        # Neovim configuration
        neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          withRuby = false;
          withPython3 = false;
        };
        # Kitty configuration
        kitty = {
          enable = true;
          shellIntegration.enableZshIntegration = true;
        };
        # Alacritty configuration
        alacritty.enable = true;
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
