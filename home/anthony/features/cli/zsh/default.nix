{ pkgs, lib, config, ... }:
let inherit (config) isWorkstation;
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      ${lib.strings.fileContents ./env.zsh}
      ${lib.strings.fileContents ./aliases.zsh}
      ${if isWorkstation then lib.strings.fileContents ./init.zsh else ""}
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dotenv"
        "vi-mode"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
