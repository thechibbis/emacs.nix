{
  melpaBuild,
  fetchFromGitHub,
  org-modern
}:

melpaBuild {
  pname = "org-modern-indent";
  version = "0-unstable-2025-07-28";

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "org-modern-indent";
    rev = "master";
    hash = "sha256-st3338Jk9kZ5BLEPRJZhjqdncMpLoWNwp60ZwKEObyU=";
  };

  packageRequires = [
    org-modern
  ];
}
