{
  description = "Flake for seffs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
          };

          seffs = pkgs.writeShellScriptBin "seffs" (builtins.readFile ./seffs);

        in
        with pkgs;
        {
          devShells = {
            default = mkShell {
              buildInputs = [
                bashInteractive
                elvish
                nushell
              ];
            };
          };

          packages = {
            default = seffs;
          };

          apps = {
            default = {
              type = "app";
              program = "${seffs}/bin/seffs";
            };
          };
        }
      );
}
