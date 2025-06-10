{ pkgs, inputs, ... }: {
  imports = [
    ./cursor-ide
  ];

  home.packages = with pkgs; [
    aider-chat
    claude-code
    codex
    windsurf
    inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-with-fhs
  ];

  home.activation.setupClaudeDesktop = config.lib.dag.entryAfter ["writeBoundary"] ''
    # Create local applications directory if it doesn't exist
    mkdir -p $HOME/.local/share/applications
    
    # Remove existing desktop file if it exists
    rm -f $HOME/.local/share/applications/claude-desktop.desktop
    
    # Copy the desktop file (instead of symlinking)
    cp -f $HOME/.nix-profile/share/applications/claude-desktop.desktop $HOME/.local/share/applications/
    
    # Ensure we have write permissions
    chmod u+w $HOME/.local/share/applications/claude-desktop.desktop
    
    # Update the Exec line to use the full path
    sed -i "s|^Exec=claude-desktop|Exec=$HOME/.nix-profile/bin/claude-desktop|g" $HOME/.local/share/applications/claude-desktop.desktop
    
    # Add StartupWMClass for better dock integration
    if ! grep -q "StartupWMClass" $HOME/.local/share/applications/claude-desktop.desktop; then
      echo "StartupWMClass=Claude" >> $HOME/.local/share/applications/claude-desktop.desktop
    fi
    
    # Update desktop database
    if command -v update-desktop-database &> /dev/null; then
      update-desktop-database $HOME/.local/share/applications
    fi
  '';

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/claude" = "claude-desktop.desktop";
  };
}
