terraform {
  required_providers{
    azurerm= {
         source  = "hashicorp/azurerm"
         version = "=2.85.0"
    }
  }

  backend "azurerm" {        
        # storage_account_name = "dotnetkeyvaultmanagement"
        # container_name       = "tfstatedev"
        # key                  = "vis.terraform.tfstate"
        # resource_group_name = "myAzureKeyVault"        
  }
}

provider "azurerm" {
  features {}
}