{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--gpu"
      "--use-vulkan"
      "--enable-features=VaapiVideoEncoder,VaapiVideoDecoder,WebUIDarkMode,CanvasOopRasterization"
      "--enable-oop-rasterization"
      "--enable-raw-draw"
      "--force-dark-mode"
      #"--disable-reading-from-canvas"
    ];
  };
}
