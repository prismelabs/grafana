{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      outputsWithoutSystem = { };
      outputsWithSystem = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
          lib = pkgs.lib;
        in {
          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [ go nodejs gcc yarn wire ];
            };
          };
        });
    in outputsWithSystem // outputsWithoutSystem;
}
