set shell := ["bash", "-euo", "pipefail", "-c"]

repo := justfile_directory()
default_host := "user"
default_user := "user"
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

eval-home user=default_user:
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#homeConfigurations.{{user}}.activationPackage.drvPath" >/dev/null
  @echo "eval ok: homeConfigurations.{{user}}.activationPackage"

build-home user=default_user vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && ( [ -L result ] && rm -f result || true )
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    {{nix_bin}} build ".#homeConfigurations.{{user}}.activationPackage" -L --no-link --override-input vars "path:{{vars}}"; \
  else \
    {{nix_bin}} build ".#homeConfigurations.{{user}}.activationPackage" -L --no-link; \
  fi

switch-home user=default_user vars="":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && if [ -n "{{vars}}" ]; then \
    home-manager switch --flake ".#{{user}}" --override-input vars "path:{{vars}}"; \
  else \
    home-manager switch --flake ".#{{user}}"; \
  fi

check:
  just --justfile "{{repo}}/Justfile" fmt-check
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" eval-darwin
  just --justfile "{{repo}}/Justfile" eval-home

ci-linux:
  just --justfile "{{repo}}/Justfile" fmt-check
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" eval-home
  just --justfile "{{repo}}/Justfile" build-home

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
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#homeConfigurations.{{default_user}}.activationPackage.drvPath" >/dev/null && echo "home target ok: {{default_user}}"
