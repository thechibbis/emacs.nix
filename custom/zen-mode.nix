{
  melpaBuild,
  fetchFromGitHub,
}:

melpaBuild {
  pname = "zen-mode";
  version = "0-unstable-2025-07-28";

  src = fetchFromGitHub {
    owner = "aki237";
    repo = "zen-mode";
    rev = "master";
    hash = "sha256-16Pp/PPw67l6a0PMaYGRvQRe2DJbtiO6TFeFtHiAax8=";
  };
}
