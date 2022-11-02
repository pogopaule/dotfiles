{ pkgs, darkTheme, ... }:

{
  home = {
    packages = with pkgs; [
      wslu
      gnumake
    ];

    sessionVariables.BROWSER = "wslview";
  };
}
