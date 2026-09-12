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
    kdePackages.konsole

    # Launcher
    fuzzel

    # Wayland utilities
    wl-clipboard
    grim
    slurp
    swappy

    # Screenshot / image tools
    flameshot

    # Notifications
    swaynotificationcenter

    # Sway utilities
    swaylock
    swayidle
    swaybg

    # File manager / utilities
    mc
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
      terminal = "konsole";
      menu = "fuzzel";
      # menu = "wofi --show drun --columns 3";

    input."*" = {
      xkb_layout = "de";
      xkb_variant = "nodeadkeys";
      xkb_numlock = "enabled";
    };
    #output."*" = {
    #  bg = "~/Pictures/Sway_Wallpaper_Blue_1920x1080.png fill";
    #};

      # -----------------------------------------------------
      # Appearance
      # -----------------------------------------------------

      gaps = {
        inner = 5;
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
  # Terminal
  # -------------------------------------------------------
  "Mod4+Return" = "exec konsole --profile nixos";
  # -------------------------------------------------------
  # Kill
  # -------------------------------------------------------
  "Mod4+Shift+q" = "kill";
  # -------------------------------------------------------
  # Launcher
  # -------------------------------------------------------
  "Mod4+d" = "exec fuzzel";
  "Mod4+Shift+d" = "xfce4-appfinder";
  # -------------------------------------------------------
  # Apps
  # -------------------------------------------------------
  "Mod4+i" = "exec firefox";
  "Mod4+c" = "exec thunderbird";
  "Mod4+n" = "exec signal-desktop";
  "Mod4+o" = "exec dolphin";
  "Mod4+k" = "exec krusader";
  "Mod4+e" = "exec elisa";
  # -------------------------------------------------------
  # Screenshots
  # -------------------------------------------------------
  # -> Using swappy
  "Mod4+p" = "exec grim -g \"$(slurp)\" - | swappy -f -";
  # -------------------------------------------------------
  # Notifications
  # -------------------------------------------------------
  "Mod4+Shift+n"= "exec swaync-client -t -sw";

  "Mod4+f" = "fullscreen toggle";
  "Mod4+Shift+space" = "floating toggle";
  "Mod4+space" = "focus mode_toggle";
  "Mod4+Shift+c" = "reload";
  "Mod4+Shift+r" = "restart";
  "Mod4+l" = "exec swaylock -f -c 1e1e2e";
  "Mod4+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";


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

  "Mod4+h" = "splith";
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

};

      # -----------------------------------------------------
      # Startup applications
      # -----------------------------------------------------

      startup = [
        {
          command = "swaybg -i ~/Pictures/Sway_Wallpaper_Blue_1920x1080.png -m fill";
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
          "sway/mode"
          "network"
        ];

        modules-center = [
          "sway/workspaces"
          "wlr/taskbar"
          "clock"
          "mpd"
        ];

        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "disk"
          "battery"
          "tray"
        ];

        "clock" = {
          format = "{:%a %d.%m. %H:%M:%S}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        "network" = {
          interval = 1;
          format-wifi = "{signalStrength}%   |  {bandwidthDownBits}   |  {bandwidthUpBits} ";
          format-ethernet = " LAN  |  {bandwidthDownBits}   |  {bandwidthUpBits} ";
          tooltip-format = "{essid} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰖪";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
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
        font-family: "Roboto", "Font Awesome";
        font-size: 20px;
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

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Roboto:size=18";
        lines = 15;
        auto-select = true;
      };
      colors = {
        background = "14161Be5";
        text = "F5F5F5FF";
        selection-match = "A2D6F9ff";
        match = "A2D6F9ff";
        selection = "4F5258ff";
        selection-text = "F5F5F5FF";
        border = "A1A1A1FF";
      };
      border = {
        radius = 5;
        width = 4;
      };
    };
  };

  programs.swaylock = {
    enable = true;

    settings = {
      color = "1e1e2e";
      inside-color = "313244";
      ring-color = "89b4fa";
      text-color = "cdd6f4";
      key-hl-color = "f38ba8";
      bs-hl-color = "eba0ac";

      indicator = true;
      clock = true;
      timestr = "%H:%M";
      datestr = "%A, %B %-d";

      ignore-empty-password = true;
      show-failed-attempts = true;
    };
  };

  # ---------------------------------------------------------
  # SwayNotificationCenter - swaync notifications
  # ---------------------------------------------------------

  services.swaync = {
    enable = true;

    # Custom CSS for the notification center
    style = ''
      .notification-row {
        outline: none;
      }
      .notification {
        border-radius: 12px;
        margin: 6px 12px;
        padding: 0;
      }
    '';

    # JSON configuration for layout and behavior
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      notification-icon-size = 64;
      notification-inline-replies = false;
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
