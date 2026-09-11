{ config, pkgs, ... }:

{
  # ---------------------------------------------------------
  # Home Manager
  # ---------------------------------------------------------

  home.username = "steles33";
  home.homeDirectory = "/home/steles33";

  home.stateVersion = "26.05";


  # ---------------------------------------------------------
  # Packages
  # ---------------------------------------------------------

  home.packages = with pkgs; [
    # Terminal
    foot

    # Launcher
    fuzzel

    # Wayland utilities
    wl-clipboard
    grim
    slurp

    # Screenshot / image tools
    flameshot

    # Notifications
    mako

    # Sway utilities
    swaylock
    swayidle

    # File manager / utilities
    file
    tree
  ];


  # ---------------------------------------------------------
  # Sway
  # ---------------------------------------------------------

  wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures = {
      gtk = true;
    };

    config = {
      # -----------------------------------------------------
      # Basic settings
      # -----------------------------------------------------

      modifier = "Mod4";

      terminal = "foot";

      menu = "fuzzel";


      # -----------------------------------------------------
      # Appearance
      # -----------------------------------------------------

      gaps = {
        inner = 6;
        outer = 4;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
      };

      colors = {
        focused = {
          border = "#89b4fa";
          background = "#1e1e2e";
          text = "#cdd6f4";
          indicator = "#89b4fa";
          childBorder = "#89b4fa";
        };

        focusedInactive = {
          border = "#45475a";
          background = "#181825";
          text = "#a6adc8";
          indicator = "#45475a";
          childBorder = "#45475a";
        };

        unfocused = {
          border = "#313244";
          background = "#181825";
          text = "#a6adc8";
          indicator = "#313244";
          childBorder = "#313244";
        };

        urgent = {
          border = "#f38ba8";
          background = "#1e1e2e";
          text = "#f38ba8";
          indicator = "#f38ba8";
          childBorder = "#f38ba8";
        };
      };


keybindings = {
  # -------------------------------------------------------
  # Applications
  # -------------------------------------------------------

  # Terminal
  "Mod4+Return" = "exec foot";

  # Application launcher
  "Mod4+d" = "exec fuzzel";


  # -------------------------------------------------------
  # Window management
  # -------------------------------------------------------

  # Close window
  "Mod4+q" = "kill";

  # Fullscreen
  "Mod4+f" = "fullscreen toggle";

  # Floating
  "Mod4+Shift+space" = "floating toggle";

  # Toggle focus between tiling/floating
  "Mod4+space" = "focus mode_toggle";


  # -------------------------------------------------------
  # Sway
  # -------------------------------------------------------

  # Reload configuration
  "Mod4+Shift+c" = "reload";

  # Restart Sway
  "Mod4+Shift+r" = "restart";

  # Lock screen
  "Mod4+l" = "exec swaylock -f -c 1e1e2e";

  # Exit Sway
  "Mod4+Shift+e" =
    "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";


  # -------------------------------------------------------
  # Focus
  # -------------------------------------------------------

  "Mod4+Left" = "focus left";
  "Mod4+Down" = "focus down";
  "Mod4+Up" = "focus up";
  "Mod4+Right" = "focus right";


  # -------------------------------------------------------
  # Move windows
  # -------------------------------------------------------

  "Mod4+Shift+Left" = "move left";
  "Mod4+Shift+Down" = "move down";
  "Mod4+Shift+Up" = "move up";
  "Mod4+Shift+Right" = "move right";


  # -------------------------------------------------------
  # Splitting
  # -------------------------------------------------------

  "Mod4+b" = "splith";
  "Mod4+v" = "splitv";


  # -------------------------------------------------------
  # Workspaces
  # -------------------------------------------------------

  "Mod4+1" = "workspace number 1";
  "Mod4+2" = "workspace number 2";
  "Mod4+3" = "workspace number 3";
  "Mod4+4" = "workspace number 4";
  "Mod4+5" = "workspace number 5";
  "Mod4+6" = "workspace number 6";
  "Mod4+7" = "workspace number 7";
  "Mod4+8" = "workspace number 8";
  "Mod4+9" = "workspace number 9";


  # -------------------------------------------------------
  # Move windows to workspaces
  # -------------------------------------------------------

  "Mod4+Shift+1" = "move container to workspace number 1";
  "Mod4+Shift+2" = "move container to workspace number 2";
  "Mod4+Shift+3" = "move container to workspace number 3";
  "Mod4+Shift+4" = "move container to workspace number 4";
  "Mod4+Shift+5" = "move container to workspace number 5";
  "Mod4+Shift+6" = "move container to workspace number 6";
  "Mod4+Shift+7" = "move container to workspace number 7";
  "Mod4+Shift+8" = "move container to workspace number 8";
  "Mod4+Shift+9" = "move container to workspace number 9";


  # -------------------------------------------------------
  # Screenshots
  # -------------------------------------------------------

  # Select an area
  "Print" =
    "exec grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png";

  # Full screen
  "Shift+Print" =
    "exec grim ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png";
};


      # -----------------------------------------------------
      # Startup applications
      # -----------------------------------------------------

      startup = [
        {
          command = "waybar";
          always = true;
        }

        {
          command = "mako";
          always = true;
        }
      ];


      # -----------------------------------------------------
      # Environment
      # -----------------------------------------------------

      bars = [
        {
          command = "waybar";
        }
      ];
    };
  };


  # ---------------------------------------------------------
  # Waybar
  # ---------------------------------------------------------

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;

        modules-left = [
          "sway/workspaces"
        ];

        modules-center = [
          "sway/window"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
        ];

        "clock" = {
          format = "{:%a %d.%m. %H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  {ipaddr}";
          format-disconnected = "󰖪";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 muted";

          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
        };

        "battery" = {
          format = "{capacity}% {icon}";

          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };
    };

    style = ''
      * {
        font-family: "Roboto", "Font Awesome 6 Free";
        font-size: 14px;
      }

      window#waybar {
        background: rgba(24, 24, 37, 0.95);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 8px;
        color: #a6adc8;
        background: transparent;
        border: none;
      }

      #workspaces button.focused {
        color: #89b4fa;
        background: #313244;
      }

      #clock,
      #network,
      #pulseaudio,
      #battery {
        padding: 0 10px;
      }
    '';
  };


  # ---------------------------------------------------------
  # Mako notifications
  # ---------------------------------------------------------

  services.mako = {
    enable = true;

    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#89b4fa";

      border-size = 2;
      border-radius = 8;

      default-timeout = 5000;

      width = 400;
      height = 150;

      margin = 10;
      padding = 15;
    };
  };


  # ---------------------------------------------------------
  # GTK
  # ---------------------------------------------------------

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
    };

    iconTheme = {
      name = "Papirus-Dark";
    };

    font = {
      name = "Roboto 10";
    };
  };


  # ---------------------------------------------------------
  # XDG directories
  # ---------------------------------------------------------

  xdg.userDirs = {
    enable = true;

    createDirectories = true;
  };
}
