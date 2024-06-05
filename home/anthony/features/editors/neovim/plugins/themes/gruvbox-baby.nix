{ pkgs, lib }:
{
  plugin = pkgs.vimPlugins.gruvbox-baby;
  type = "lua";
  config = ''
    if vim.fn.has('termguicolors') == 1 then
      vim.opt.termguicolors = true
    end
    
    vim.opt.background = 'dark'

    vim.g.gruvbox_baby_function_style = "NONE"
    vim.g.gruvbox_baby_keyword_style = "italic"

    vim.g.gruvbox_baby_telescope_theme = 1
    vim.g.gruvbox_baby_transparent_mode = 1

    vim.cmd [[
      syntax enable
      colorscheme gruvbox-baby
    ]]
  '';
}
