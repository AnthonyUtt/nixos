{ pkgs, deps, ... }: {
  app = pkgs.rustPlatform.buildRustPackage {
    pname = "my-app";
    version = "0.0.1";
    src = ./.;
    cargoBuildFlags = "";

    cargoLock = {
      lockFile = ./Cargo.lock;
    };

    nativeBuildInputs = deps;
  };
}
