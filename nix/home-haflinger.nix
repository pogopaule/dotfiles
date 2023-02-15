{ pkgs, darkTheme, ... }:

{
  home = {
    packages = with pkgs; [
      wslu
      gnumake
      k9s
      kubectl
      awscli2
    ];

    sessionVariables.BROWSER = "wslview";
  };
}
