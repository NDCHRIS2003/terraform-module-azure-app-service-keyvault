terraform {
  required_providers{
    azurerm= {
         source  = "hashicorp/azurerm"
         version = "=2.85.0"
    }
  }

  backend "azurerm" {
        # use_msi = true
        storage_account_name = "dotnetkeyvaultmanagement"
        container_name       = "tfstatedev"
        key                  = "vis.terraform.tfstate"
        resource_group_name = "myAzureKeyVault"
        # subscription_id      = "6fb71c3b-6ae2-4dcf-988d-5f2373f73bb0"
        # tenant_id            = "130d9288-fc95-48d4-abff-2cf11f91951f"
        # access_key           = "nikv3Cmsq3q2cNsElrKQ9fi8SPJlb0JEhWeuFMVe6lbwpnngMr+OXg4bqH3tKQiZIXtuNv31aG+ZsHON3t1E8w=="
  }
}

provider "azurerm" {
  features {}
}