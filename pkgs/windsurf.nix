{ stdenv, lib
, fetchzip
, autoPatchelfHook
, wrapGAppsHook3
, alsa-lib
, at-spi2-atk
, cups
, libdrm
, libgbm
, nss_latest
, udev
, xorg
}:

stdenv.mkDerivation rec {
  pname = "windsurf-editor";
  version = "1.6.5";

  src = builtins.fetchTarball {
    url = "https://windsurf-stable.codeiumdata.com/linux-x64/stable/d87e525d4461b610eeaba26cba66153dd120ef47/Windsurf-linux-x64-${version}.tar.gz";
    sha256 = "sha256-AD3jivkSh5I41Uwz8i5iq9n+JTebPu3UcdZa1N1nogk=";
  };

  nativeBuildInputs = [
    alsa-lib
    at-spi2-atk
    xorg.libxcb
    libdrm
    nss_latest
    cups
    wrapGAppsHook3
    libgbm
    xorg.libxkbfile
    autoPatchelfHook
  ];
  runtimeDependencies = [ (lib.getLib udev) ];

  postUnpack = "cp -r $src $out";

  meta = with lib; {
    homepage = "";
    description = "";
    platforms = [ "x86_64-linux" ];
  };
}
