
{
  melpaBuild,
  fetchFromGitHub,
}:

melpaBuild {
  pname = "ultra-scroll"; # O nome do pacote que será usado no use-package (ex: (use-package mirwood-theme ...))
  version = "0-unstable-2025-07-28"; # Uma versão provisória ou a versão do seu tema

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "ultra-scroll";
    rev = "master"; # Use "main", uma tag (ex: "v1.0"), ou um commit hash específico
    hash = "sha256-UzFH+LXZ1ui9Wh9mlRYcZcpLBx0nSzNTtKGB8JI0r9Q=";
  };
}
