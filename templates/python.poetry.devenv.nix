{ pkgs, lib, config, inputs, ... }:

{
  packages = [
    pkgs.pyright # python language server, required if you develop with an IDE that does not provide its own language server, like e.g. neovim
  ];

  languages = {
    python = {
      enable = true;
      version = "3.12.4";
      poetry.enable = true;
    };
  };

  scripts = {
    foobar.exec = "echo foobar";
  };
}
