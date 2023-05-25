terraform {
  required_providers{
    azurerm= {
         source  = "hashicorp/azurerm"
         version = "=2.85.0"
    }
  }

  backend "azurerm" {   
        use_msi = true 
        subscription_id      = "0f938566-66ed-4249-b81d-887dfefeaf4f"    
        # storage_account_name = "dotnetkeyvaultmanagement"
        # container_name       = "tfstatedev"
        # key                  = "vis.terraform.tfstate"
        # resource_group_name = "myAzureKeyVault"        
  }
}

provider "azurerm" {
  features {}
}