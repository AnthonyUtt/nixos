{ stdenv, lib
, fetchzip
, autoPatchelfHook
, glibc
, libgcc
, libglibutil
, xorg
, dbus
, nss
, ffmpeg-full
, atkmm
, cups
, libdrm
, gtk3
, pango
, cairo
, libxkbcommon
, alsa-lib
, libgbm
}:

stdenv.mkDerivation rec {
  pname = "windsurf-editor";
  version = "1.6.2";

  src = fetchzip {
    url = "https://windsurf-stable.codeiumdata.com/linux-x64/stable/1eabbe10abd0f4843e53460086ba8422a1aebe02/Windsurf-linux-x64-${version}.tar.gz";
    sha256 = "sha256-AD3jivkSh5I41Uwz8i5iq9n+JTebPu3UcdZa1N1nogk=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    glibc
    libgcc
    libglibutil
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxkbfile
    dbus
    nss
    ffmpeg-full
    atkmm
    cups
    libdrm
    gtk3
    pango
    cairo
    libxkbcommon
    alsa-lib
    libgbm
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    install -m755 -D $src/windsurf $out/bin/windsurf
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "";
    description = "";
    platforms = [ "x86_64-linux" ];
  };
}
