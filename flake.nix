{
  description = "A flake for a custom Emacs package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, emacs-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ emacs-overlay.overlay ];
        };

        emacs-custom = (pkgs.emacsWithPackagesFromUsePackage {
          config = ./emacs.org;
          defaultInitFile = true;

          package = pkgs.emacs-pgtk;

          alwaysEnsure = true;
          alwaysTangle = true;

          override = epkgs: epkgs // {
            org-modern-indent = pkgs.emacsPackages.callPackage ./custom/org-modern-indent.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild org-modern;
            };

            ultra-scroll = pkgs.emacsPackages.callPackage ./custom/ultra-scroll.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild;
            };

            zen-mode = pkgs.emacsPackages.callPackage ./custom/zen-mode.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild;
            };

            lsp-biome = pkgs.emacsPackages.callPackage ./custom/lsp-biome.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild lsp-mode;
            };

            # lsp-mode = epkgs.lsp-mode.overrideAttrs (old: {
            #   buildPhase = ''
            #     export LSP_USE_PLISTS=true
            #   '' + (old.buildPhase or "");
            # });
          };

          extraEmacsPackages = epkgs: [
            # custom packages
            epkgs.org-modern-indent
            epkgs.ultra-scroll
            epkgs.lsp-mode
            epkgs.zen-mode
            epkgs.lsp-biome

            epkgs.treesit-grammars.with-all-grammars
            epkgs.vterm

            pkgs.emacs-lsp-booster
            pkgs.rust-analyzer
            pkgs.yaml-language-server
            pkgs.nixd
            pkgs.nixfmt
            pkgs.gopls
            pkgs.buf
            pkgs.docker-language-server
            pkgs.nodePackages.vscode-json-languageserver

            # export pdf
            pkgs.pandoc
            pkgs.python313Packages.weasyprint
          ];
        });
      in
        {
          # --- FLAKE OUTPUTS ---
          packages = {
            emacs-custom = emacs-custom;
            default = emacs-custom;
          };

          overlay = final: prev: {
            emacs-custom = self.packages.${system}.emacs-custom;
          };

          apps.default = {
            type = "app";
            program = "${emacs-custom}/bin/emacs";
          };
        }
    );
}

