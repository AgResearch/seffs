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

          seffs = pkgs.stdenv.mkDerivation {
            name = "seffs";

            src = ./seffs;

            buildInputs = with pkgs; [ elvish nushell ];
            nativeBuildInputs = [ pkgs.makeWrapper ];

            dontUnpack = true;
            dontBuild = true;

            installPhase = ''
              mkdir -p $out/bin
              runHook preInstall
              cp $src $out/bin/seffs
              chmod 755 $out/bin/seffs
              runHook postInstall
            '';

            postFixup = with pkgs; ''
              wrapProgram $out/bin/seffs --set PATH ${lib.makeBinPath [
                coreutils
                elvish
                nushell
              ]}:/usr/bin
            '';
          };

          eri-install = pkgs.writeShellScriptBin "seffs-eri-install" (builtins.readFile ./eri/install);

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

            eri-install = {
              type = "app";
              program = "${eri-install}/bin/seffs-eri-install";
            };
          };
        }
      );
}
