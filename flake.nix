{
  description = "Hell, for the cmake things to do";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";

    # Fetch the NJOY2016 source code for your sake purpose:
    njoy-src = {
      url = "github:njoy/NJOY2016";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, njoy-src }@inputs:
    utils.lib.eachDefaultSystem ( system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        
        # NJOY requires GCC 7+ for Fortran 2003 compliance.
        # Choosing recent GCC,
        stdenv_fortran = pkgs.gcc15Stdenv;
      in
      rec {
        # Package definition
        packages.default = stdenv_fortran.mkDerivation {
          name =  "NJOY2016";
          version = "2016.78";
          src = njoy-src;
          nativeBuildInputs = with pkgs; [ 
            cmake
            python3
            gfortran15
            git
          ];
          buildInputs = [];
          cmakeFlags = [ 
            "-DCMAKE_BUILD_TYPE=Release"
            ];
          # Try to running test that NJOY uses ctest.
          doCheck = true;
          checkPhase = ''
            ctest --output-on-failure
          '';
        
          meta = {
            description = "NJOY Nuclear Data Processing System, bro";
            homepage = "https://github.com/njoy/NJOY2016";
            license = "Lanl Public License";
            platforms = pkgs.lib.platforms.linux;
          };
        };
        # Development Shell --A convenient shell for working on the source code manually.
        devShells.default = pkgs.mkShell {
          name = "njoy-dev-shell";
          # Using inputsFrom to automatically inherit the dependencies from the package
          inputsFrom = [ self.packages.${system}.default ];
        };
      }
    );
}
