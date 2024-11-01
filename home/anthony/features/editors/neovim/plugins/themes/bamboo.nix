{ pkgs, lib }:
{
  plugin = pkgs.vimPlugins.bamboo-nvim;
  type = "lua";
  config = ''
    if vim.fn.has('termguicolors') == 1 then
      vim.opt.termguicolors = true
    end
    
    require('bamboo').setup()
    require('bamboo').load()
  '';
}
