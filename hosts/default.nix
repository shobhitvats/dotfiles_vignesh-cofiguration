{ lib, inputs, mypkgs, system, ... }:
{
  nixos =
    let
      hostname = "nixos";
      username = "shobhit";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };

            master = import inputs.nixpkgs-master {
              inherit system;
              config.allowUnfree = true;
            };

            riseup = import inputs.nixpkgs-riseup {
              inherit system;
              config.allowUnfree = true;
            };

            inherit mypkgs;
          })
        ];
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username hostname pkgs;
      };

      modules = [
        ./${hostname}/configuration.nix
      ];
    };
}
