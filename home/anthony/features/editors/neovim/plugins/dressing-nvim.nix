{ pkgs, lib }: {
  plugin = pkgs.vimPlugins.dressing-nvim;
  type = "lua";
  config = ''
    require("dressing").setup()
  '';
}
