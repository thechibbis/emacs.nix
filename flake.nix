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
            mirwood-theme = pkgs.emacsPackages.callPackage ./custom/emacs-mirwood-theme.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild autothemer;
            };

            rose-pine-emacs = pkgs.emacsPackages.callPackage ./custom/rose-pine-emacs.nix {
              inherit (pkgs) fetchFromGitHub;
              inherit (epkgs) melpaBuild autothemer;
            };
          };

          extraEmacsPackages = epkgs: [
            # custom packages
            epkgs.mirwood-theme
            epkgs.rose-pine-emacs

            epkgs.vertico
            epkgs.emacs
            epkgs.orderless
            epkgs.company
            epkgs.vterm
            epkgs.rainbow-mode
            epkgs.indent-bars
            epkgs.direnv
            epkgs.projectile
            epkgs.dashboard
            epkgs.general
            epkgs.autothemer
            epkgs.smudge
            epkgs.ef-themes

            epkgs.org-modern
            epkgs.org-superstar
            epkgs.org-roam
            epkgs.ox-pandoc

            epkgs.treesit-auto
            epkgs.treesit-grammars.with-all-grammars

            epkgs.catppuccin-theme
            epkgs.doom-themes
            epkgs.doom-modeline

            epkgs.treemacs
            epkgs.treemacs-evil
            epkgs.treemacs-projectile
            epkgs.treemacs-icons-dired
            epkgs.treemacs-magit
            epkgs.treemacs-persp
            epkgs.treemacs-tab-bar
            epkgs.treemacs-all-the-icons
            epkgs.all-the-icons

            epkgs.evil
            epkgs.evil-collection

            epkgs.lsp-mode
	        epkgs.yasnippet
	        epkgs.yasnippet-snippets
            epkgs.flycheck

            epkgs.rust-mode
            epkgs.rustic
	        epkgs.nix-ts-mode
            epkgs.protobuf-mode

            # lsps
            pkgs.rust-analyzer
            pkgs.yaml-language-server
            pkgs.nixd
            pkgs.nixfmt
            pkgs.biome
            pkgs.gopls
            pkgs.buf

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

