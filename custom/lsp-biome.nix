{
  melpaBuild,
  fetchFromGitHub,
  lsp-mode,
}:

melpaBuild {
  pname = "lsp-biome";
  version = "0-unstable-2025-07-28";

  src = fetchFromGitHub {
    owner = "cxa";
    repo = "lsp-biome";
    rev = "22afd7b98b7c1ec54b193c49a489a60241863870";
    hash = "sha256-4eC9XhC0J5NQfRv2xa/qrgyVp2adMbLtkm2TXL/47s8=";
  };

  packageRequires = [
    lsp-mode
  ];
}
