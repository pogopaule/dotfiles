{ pkgs, lib, config, inputs, ... }:

{
  packages = [
  ];

  languages.python = {
    enable = true;
    venv = {
      enable = true;
      requirements = ''
        requests
      '';
    };
  };

  scripts = {

  };
}
