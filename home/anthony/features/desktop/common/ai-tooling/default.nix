{ pkgs, inputs, config, ... }: {
  imports = [
    ./claude-desktop.nix
    ./cursor.nix
  ];

  home.packages = with pkgs; [
    aider-chat
    claude-code
    # chatgpt
    codex
    windsurf
  ];
}
