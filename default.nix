{ pkgs, ... }: 

{ 
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
     };

  statusline.lualine.enable = true;
  clipboard = {
    enable = true;
    providers.wl-copy.enable = true;
    registers = "unnamedplus";
  };

  utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      animate = { enable = true; };
      bigfile = { enable = true; };
      picker = { enable = true; };
      indent = { enable = true; };
      # dashboard = { enable = true; };
    };
  };
    
  languages = {
    enableLSP = true;
    enableTreesitter = true;

    nix.enable = true;
    ts.enable = true;
    rust.enable = true;
    clang.enable = true;
    lua.enable = true;
   };
};
  
 #   config.vim.lazy.plugins = {
 #     package = 
 # }; 
}

