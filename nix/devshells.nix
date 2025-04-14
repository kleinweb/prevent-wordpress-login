{
  perSystem =
    {
      config,
      inputs',
      pkgs,
      ...
    }:
    let
      commonPkgs = [
        pkgs.php
        pkgs.php.packages.composer
        inputs'.beams.packages.php-lint

        pkgs.biome
        pkgs.just
      ];
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        shellHook = ''
          : "''${PRJ_BIN_HOME:=''${PRJ_PATH:-''${PRJ_ROOT}/.bin}}"

          export PRJ_BIN_HOME

          ${config.pre-commit.installationScript}
        '';
        nativeBuildInputs = commonPkgs ++ [
          # TODO: Remove when available upstream: https://github.com/NixOS/nixpkgs/pull/344503
          inputs'.beams.packages.ddev

          config.pre-commit.settings.hooks.markdownlint.package
          config.pre-commit.settings.hooks.yamllint.package

          pkgs.dos2unix
          pkgs.nixfmt
          pkgs.nodePackages.prettier
          pkgs.taplo
          pkgs.treefmt
        ];
      };

      devShells.ci = pkgs.mkShellNoCC { nativeBuildInputs = commonPkgs; };
    };
}
