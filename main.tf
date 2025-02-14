terraform {
  required_providers {
    sops = {
      source = "nobbs/sops"
      version = "~> 0.2.0"
    }
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }

  backend "s3" {
    bucket = "tfstate"
    key = "deploy-talos.tfstate"

    # For use with MinIO
    region = "us-east-1"
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_metadata_api_check = true
    skip_region_validation = true
    use_path_style = true

    insecure = true
  }
}
