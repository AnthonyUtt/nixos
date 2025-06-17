{ pkgs, inputs, ... }:
let
  rubyDeps = pkgs.ruby_3_1.withPackages (p: with p; [
    solargraph
  ]);
in {
  home.packages = [
    # (inputs.cursor.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
    (inputs.cursor.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.neovim-unwrapped
      ];
    }))
    rubyDeps
    pkgs.sox
  ];
}
