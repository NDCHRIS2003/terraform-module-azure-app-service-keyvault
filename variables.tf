variable "resource_group_name" { 
    default = "myAzureKeyVault"
    description = "Azure Resource group name"
    type = string
}

variable "app_service" {
  default = "myAzureKeyVault"
}

variable "project" {
  default = "secret-mgmt-dotnet"
}

# variable "storage_account_url" {
#   type = string
# }

variable "container_name" {
  default = "appservicebackup"
  type = string
}