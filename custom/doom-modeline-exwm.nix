{
  melpaBuild,
  fetchFromGitHub,
  exwm,
  doom-modeline,
}:

melpaBuild {
  pname = "doom-modeline-exwm";
  version = "0-unstable-2025-07-28";

  src = fetchFromGitHub {
    owner = "elken";
    repo = "doom-modeline-exwm";
    rev = "master";
    hash = "sha256-Xu15+PjW9PRqMfAJCGMXmvsNizPwsOP9sMR7MhY1EWU=";
  };

  packageRequires = [
    exwm
    doom-modeline
  ];
}
