{
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "lua"
      "basher"
      "Catppuccin"
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      vim_mode = true;
      vim = {
        enable_vim_sneak = true;
      };
      theme = "Catppuccin Mocha";
      # had to force here due to conflicts
      ui_font_size = lib.mkForce 12;
      buffer_font_size = lib.mkForce 14;
      relative_line_numbers = true;
      file_finder = {
        modal_width = "medium";
      };
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      # centered_layout = {
      #   left_padding = "0.15";
      #   right_padding = "0.15";
      # };
      inlay_hints = {
        enabled = true;
      };
      inactive_opacity = "0.5";
      auto_install_extensions = true;
      outline_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "left";
      };
      notification_panel = {
        dock = "left";
      };
      chat_panel = {
        dock = "left";
      };

      assistant = {
        enabled = true;
        version = "2";
        default_open_ai_model = "4o";

        #default_model = {
        #  provider = "zed.dev";
        #  model = "gpt-4o";
        #};
      };

      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          EDITOR = "zed --wait";
          TERM = "kitty"; # or kitty etc
        };
        font_family = "Hack Nerd Font";
        font_features = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      # File syntax highlighting
      file_types = {
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };
      languages = {
        Markdown = {
          formatter = "prettier";
        };
        JSON = {
          formatter = "prettier";
        };
        TOML = {
          formatter = "taplo";
        };
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };

        "rust-analyzer" = {
          # Quote the LSP name
          binary = {  # run `which rust-analyzer`
            path = "/etc/profiles/per-user/vlad/bin/rust-analyzer";
          };
          settings = {
            diagnostics = {
              enable = true;
              styleLints = {
                enable = true;
              }; # Corrected styleLints access
            };
            checkOnSave = true;
            check = {
              command = "clippy";
              features = "all";
            };
            cargo = {
              buildScripts = {
                enable = true;
              }; # Corrected buildScripts access
              features = "all";
            };
            inlayHints = {
              bindingModeHints = {
                enable = true;
              }; # Corrected access
              closureStyle = "rust_analyzer";
              closureReturnTypeHints = {
                enable = "always";
              }; # Corrected access
              discriminantHints = {
                enable = "always";
              }; # Corrected access
              expressionAdjustmentHints = {
                enable = "always";
              }; # Corrected access
              implicitDrops = {
                enable = true;
              };
              lifetimeElisionHints = {
                enable = "always";
              }; # Corrected access
              rangeExclusiveHints = {
                enable = true;
              };
            };
            procMacro = {
              enable = true;
            };
            rustc = {
              source = "discover";
            };
            files = {
              excludeDirs = [
                ".cargo"
                ".direnv"
                ".git"
                "node_modules"
                "target"
              ];
            };
          };
        };

        settings = {
          # This is for other LSP servers, keep it separate
          dialyzerEnabled = true;
        };
      };
    };

  };
}
