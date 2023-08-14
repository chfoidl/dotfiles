{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        bright = {
          black = "#3B4252";
          blue = "#569CD6";
          cyan = "#29B8DB";
          green = "#23D18B";
          magenta = "#C586C0";
          red = "#D54646";
          white = "#ECEFF4";
          yellow = "#D7BA7D";
        };
        normal = {
          black = "#3B4252";
          blue = "#569CD6";
          cyan = "#29B8DB";
          green = "#23D18B";
          magenta = "#C586C0";
          red = "#D54646";
          white = "#abb2bf";
          yellow = "#D7BA7D";
        };
        primary = {
          background = "#1E1E1E";
          foreground = "#D8DEE9";
        };
      };
      env = {
        TERM = "xterm-256color";
        WINIT_X11_SCALE_FACTOR = "1";
      };
      font = {
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        offset = {
          x = 0;
          y = 0;
        };
        size = 12.6;
      };
      key_bindings = [
        {
          action = "Paste";
          key = "V";
          mods = "Alt";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Alt";
        }
        {
          action = "ResetFontSize";
          key = "Key0";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Equals";
          mods = "Control";
        }
        {
          action = "DecreaseFontSize";
          key = "Minus";
          mods = "Control";
        }
      ];
      window = {
        decorations = "none";
        dynamic_title = true;
        live_config_reload = true;
        opacity = 0.95;
        padding = {
          x = 0;
          y = 0;
        };
        save_to_clipboard = true;
        semantic_escape_chars = '',│`|:"' ()[]{}<>'';
      };
    };
  };
}
