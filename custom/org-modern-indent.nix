
{
  melpaBuild,
  fetchFromGitHub,
  org-modern
}:

melpaBuild {
  pname = "org-modern-indent"; # O nome do pacote que será usado no use-package (ex: (use-package mirwood-theme ...))
  version = "0-unstable-2025-07-28"; # Uma versão provisória ou a versão do seu tema

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "org-modern-indent";
    rev = "master"; # Use "main", uma tag (ex: "v1.0"), ou um commit hash específico
    hash = "sha256-st3338Jk9kZ5BLEPRJZhjqdncMpLoWNwp60ZwKEObyU=";
  };

  packageRequires = [
    org-modern
  ];
}
