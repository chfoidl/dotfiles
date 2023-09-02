{ inputs, hostname, ... }:
let
  monitorConfigSet = {
    chf-workstation = ''
      monitor=DP-3,preferred,0x860,1
      monitor=DP-1,preferred,1280x660,1
      monitor=DP-2,preferred,4720x0,1,transform,3
    '';
    tp-p14s = ''
      monitor=eDP-1,preferred,0x0,1
    '';
    wunder-workstation = ''
      monitor=DP-3,preferred,0x860,1
      monitor=DP-1,preferred,1680x660,1
      monitor=DP-2,preferred,5520x660,1
    '';
  };
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  # Reference: https://github.com/hyprwm/Hyprland/blob/main/nix/hm-module.nix

  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    xwayland.enable = true;
    recommendedEnvironment = true;
    extraConfig = monitorConfigSet."${hostname}" + ''
input {
    kb_layout = de
    kb_variant =
    kb_model =
    kb_options = caps:escape
    kb_rules =

    repeat_rate=50
    repeat_delay=300

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(5DDCE8ff) rgba(F0A959ff) 140deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 6
    #blur = yes
    #blur_size = 6
    #blur_passes = 1
    #blur_new_optimizations = on

    drop_shadow = yes
    shadow_range = 6
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = zoomin, 0, 0, 0.58, 1.2
    bezier = ease, 0, 0, 0.58, 1

    animation = windows, 1, 2, zoomin
    animation = windowsOut, 1, 2, ease, popin 80%
    animation = border, 1, 2, ease
    animation = fade, 1, 2, ease
    animation = workspaces, 1, 2, ease
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

# Syncthingtray
windowrulev2 = float,class:(syncthingtray),title:(Syncthing Tray)
windowrulev2 = center,class:(syncthingtray),title:(Syncthing Tray)



# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Return, exec, alacritty
bind = $mainMod SHIFT, C, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating, 
bind = $mainMod, F, fullscreen, 
bind = $mainMod, R, exec, wofi --show=drun --style ~/.config/wofi/wofi.css

bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, comma, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, H, movefocus, l
bind = $mainMod, L, movefocus, r
bind = $mainMod, K, movefocus, u
bind = $mainMod, J, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Lock Screen
bind = $mainMod, Delete, exec, loginctl lock-session
    '';
  };
}
