{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = {
          opentypesvg = with pkgs.python3Packages; buildPythonApplication rec {
            pname = "opentypesvg";
            version = "1.1.2";

            src = fetchPypi {
              inherit pname version;
              sha256 = "eNggfQ+ee/tlMoCBnTcLfTwZZC5tQlTmXsN5q7xYyWI=";
            };

            nativeBuildInputs = [ setuptools_scm ];
            propagatedBuildInputs = [ fonttools zopfli brotli ];
          };
        };

        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ packages.opentypesvg svgcleaner libxslt ];
        };
      }
    );
}
