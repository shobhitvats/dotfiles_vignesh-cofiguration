{
  description = "nix flake environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          chromium
          chromedriver
          gobject-introspection
          (python311.withPackages (pypkgs: with pypkgs; [
            selenium
            keyring
            pydbus
            pygobject3
          ]))
        ];
      };
    };
}
