set shell := ["bash", "-euo", "pipefail", "-c"]

repo := justfile_directory()
default_host := "user"
default_nixos_host := "user"
nix_bin := `command -v nix`

[private]
default:
  @just --list

fmt:
  cd "{{repo}}" && git ls-files '*.nix' | xargs -I{} nixfmt "{}"

fmt-check:
  cd "{{repo}}" && git ls-files '*.nix' | xargs -I{} nixfmt --check "{}"

test:
  cd "{{repo}}" && {{nix_bin}} eval .#evalTests --show-trace --print-build-logs --verbose

eval-darwin host=default_host:
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#darwinConfigurations.{{host}}.system" >/dev/null
  @echo "eval ok: darwinConfigurations.{{host}}.system"

build-darwin host=default_host vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && ( [ -L result ] && rm -f result || true )
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    sudo {{nix_bin}} build ".#darwinConfigurations.{{host}}.system" -L --no-link --override-input vars "path:{{vars}}"; \
  else \
    sudo {{nix_bin}} build ".#darwinConfigurations.{{host}}.system" -L --no-link; \
  fi

switch-darwin host=default_host vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    sudo {{nix_bin}} run nix-darwin#darwin-rebuild -- switch --flake ".#{{host}}" --override-input vars "path:{{vars}}"; \
  else \
    sudo {{nix_bin}} run nix-darwin#darwin-rebuild -- switch --flake ".#{{host}}"; \
  fi

eval-nixos host=default_nixos_host:
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#nixosConfigurations.{{host}}.config.system.build.toplevel.drvPath" >/dev/null
  @echo "eval ok: nixosConfigurations.{{host}}.config.system.build.toplevel"

build-nixos host=default_nixos_host vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && ( [ -L result ] && rm -f result || true )
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    {{nix_bin}} build ".#nixosConfigurations.{{host}}.config.system.build.toplevel" -L --no-link --override-input vars "path:{{vars}}"; \
  else \
    {{nix_bin}} build ".#nixosConfigurations.{{host}}.config.system.build.toplevel" -L --no-link; \
  fi

switch-nixos host=default_nixos_host vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    sudo nixos-rebuild switch --flake ".#{{host}}" --override-input vars "path:{{vars}}"; \
  else \
    sudo nixos-rebuild switch --flake ".#{{host}}"; \
  fi

check:
  just --justfile "{{repo}}/Justfile" fmt-check
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" eval-darwin
  just --justfile "{{repo}}/Justfile" eval-nixos

ci-nixos:
  just --justfile "{{repo}}/Justfile" fmt-check
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" eval-nixos
  just --justfile "{{repo}}/Justfile" build-nixos

ci-darwin:
  just --justfile "{{repo}}/Justfile" fmt-check
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" eval-darwin
  just --justfile "{{repo}}/Justfile" build-darwin

push:
  just --justfile "{{repo}}/Justfile" check
  cd "{{repo}}" && branch=$(git rev-parse --abbrev-ref HEAD) && git push origin "$branch"

gc:
  sudo /nix/var/nix/profiles/default/bin/nix-collect-garbage -d
  /nix/var/nix/profiles/default/bin/nix-collect-garbage -d

update:
  cd "{{repo}}" && {{nix_bin}} flake update

update-input input:
  cd "{{repo}}" && {{nix_bin}} flake update {{input}}

doctor:
  @echo "repo: {{repo}}"
  @echo "nix: $$(command -v nix || true)"
  @echo "git: $$(command -v git || true)"
  @echo "home-manager: $$(command -v home-manager || true)"
  @echo "fish: $$(command -v fish || true)"
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#darwinConfigurations.{{default_host}}.system" >/dev/null && echo "darwin target ok: {{default_host}}"
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#nixosConfigurations.{{default_nixos_host}}.config.system.build.toplevel.drvPath" >/dev/null && echo "nixos target ok: {{default_nixos_host}}"
