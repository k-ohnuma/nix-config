set shell := ["bash", "-euo", "pipefail", "-c"]

repo := justfile_directory()
default_host := "user"
nix_bin := "/nix/var/nix/profiles/default/bin/nix"

default:
  @just --list

help:
  @just --list

fmt:
  cd "{{repo}}" && git ls-files '*.nix' | xargs -I{} nixfmt "{}"

test:
  cd "{{repo}}" && {{nix_bin}} eval .#evalTests --show-trace --print-build-logs --verbose

eval host=default_host:
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#darwinConfigurations.{{host}}.system" >/dev/null
  @echo "eval ok: darwinConfigurations.{{host}}.system"

build host=default_host:
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && ( [ -L result ] && rm -f result || true )
  cd "{{repo}}" && sudo {{nix_bin}} build ".#darwinConfigurations.{{host}}.system" -L --no-link

push host=default_host:
  just --justfile "{{repo}}/Justfile" test
  just --justfile "{{repo}}/Justfile" build "{{host}}"
  cd "{{repo}}" && branch=$(git rev-parse --abbrev-ref HEAD) && git push origin "$branch"

switch host=default_host:
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && sudo {{nix_bin}} run nix-darwin -- switch --flake ".#{{host}}"

switch-vars host=default_host vars_path="../nix-config-vars":
  cd "{{repo}}" && git status --short || true
  cd "{{repo}}" && sudo {{nix_bin}} run nix-darwin -- switch --flake ".#{{host}}" --override-input vars "path:{{vars_path}}"

switch-clean host=default_host:
  cd "{{repo}}" && test -z "$(git status --porcelain)" || (echo "working tree is dirty"; git status --short; exit 1)
  cd "{{repo}}" && sudo {{nix_bin}} run nix-darwin -- switch --flake ".#{{host}}"

generations host=default_host:
  cd "{{repo}}" && sudo {{nix_bin}} run nix-darwin -- --list-generations --flake ".#{{host}}"

history:
  {{nix_bin}} profile history --profile /nix/var/nix/profiles/system

gc:
  sudo /nix/var/nix/profiles/default/bin/nix-collect-garbage -d
  /nix/var/nix/profiles/default/bin/nix-collect-garbage -d

update:
  cd "{{repo}}" && {{nix_bin}} flake update

update-input input:
  cd "{{repo}}" && {{nix_bin}} flake update --update-input {{input}}

doctor host=default_host:
  @echo "repo: {{repo}}"
  @echo "nix: $$(command -v nix || true)"
  @echo "git: $$(command -v git || true)"
  @echo "fish: $$(command -v fish || true)"
  cd "{{repo}}" && {{nix_bin}} eval --raw ".#darwinConfigurations.{{host}}.system" >/dev/null && echo "darwin target ok: {{host}}"
