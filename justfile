#!/usr/bin/env just --justfile

set windows-shell := ["pwsh", "-NoLogo", "-NoProfileLoadTime", "-Command"]

default:
  just --list

# This is necessary since terraform does not allow any type of interpolation
# within the top level `terraform` section, preventing use of the `sops`
# provider for backend connection secrets.
# https://github.com/hashicorp/terraform/issues/13022
[doc('Run `terraform init` with SOPS-decrypted backend config')]
init *args:
  sops exec-file --filename backend.json --no-fifo backend.json 'terraform init -backend-config {}{{ if args != "" { " " } else { "" } }}{{ args }}'
