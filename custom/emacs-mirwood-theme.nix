{
  melpaBuild,
  fetchFromGitHub,
  autothemer,
}:

melpaBuild {
  pname = "mirwood-theme"; # O nome do pacote que será usado no use-package (ex: (use-package mirwood-theme ...))
  version = "0-unstable-2025-07-28"; # Uma versão provisória ou a versão do seu tema

  src = fetchFromGitHub {
    owner = "b-coimbra";
    repo = "emacs-mirwood-theme";
    rev = "master"; # Use "main", uma tag (ex: "v1.0"), ou um commit hash específico
    hash = "sha256-ogqlsrkux84eo3NjuteyjMdcrTztQD2NZo8ATomOc5o=";
  };

  # elisp dependencies (dependências que o seu tema precisa)
  # Se o seu tema não tiver nenhuma dependência Emacs Lisp (a maioria dos temas simples não tem),
  # você pode remover esta linha.
  packageRequires = [
    autothemer
  ];
}
