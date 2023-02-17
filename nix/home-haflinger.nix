{ pkgs, darkTheme, ... }:

{
  home = {
    packages = with pkgs; [
      wslu
      k9s
      kubectl
      awscli2
    ];

    sessionVariables.BROWSER = "wslview";
  };
}
