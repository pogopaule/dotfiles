{ pkgs, lib, config, inputs, ... }:

{
  packages = [
    pkgs.pyright
  ];

  languages.python = {
    enable = true;
    version = "3.12.4";
    venv = {
      enable = true;
      requirements = ''
        requests
      '';
    };
  };

  scripts = {
    foobar.exec = "echo foobar";
  };
}
