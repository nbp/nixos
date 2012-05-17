{ config, pkgs, ... }:

with pkgs.lib;

{

  options = {
  
    system.nixosVersion = mkOption {
      default =
        builtins.readFile ../../.version
        + (if builtins.pathExists ../../.version-suffix then builtins.readFile ../../.version-suffix else "pre-svn");
      description = "NixOS version.";
    };

  };

  config = {

    # Generate /etc/os-release.  See
    # http://0pointer.de/public/systemd-man/os-release.html for the
    # format.
    environment.etc = singleton
      { source = pkgs.writeText "os-release"
          ''
            NAME=NixOS
            ID=nixos
            VERSION="${config.system.nixosVersion}"
            VERSION_ID="${config.system.nixosVersion}"
            PRETTY_NAME="NixOS ${config.system.nixosVersion}"
            HOME_URL="http://nixos.org/"
          '';
        target = "os-release";
      };
  
  };

}
