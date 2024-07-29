{ python311Packages, fetchFromGitHub, ...}:
python311Packages.buildPythonPackage {
  pname = "pywalfox";
  version = "2.8.0rc1";

  src = fetchFromGitHub {
    owner = "Frewacom";
    repo = "pywalfox-native";
    rev = "7ecbbb193e6a7dab424bf3128adfa7e2d0fa6ff9";
    hash = "sha256-i1DgdYmNVvG+mZiFiBmVHsQnFvfDFOFTGf0GEy81lpE=";
  };
}
