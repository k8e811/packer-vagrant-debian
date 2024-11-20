packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source = "github.com/hashicorp/virtualbox"
    }
    vmware = {
      version = "~> 1"
      source = "github.com/hashicorp/vmware"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}
