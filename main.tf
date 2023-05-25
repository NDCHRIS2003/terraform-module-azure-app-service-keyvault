data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

// App Service Plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.project}-plan"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "${var.project}-app"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2019"    
  }
  backup {
    name = "${var.project}"
    storage_account_url = "https://dotnetkeyvaultmanagement.blob.core.windows.net/${var.container_name}?sv=2022-11-02&ss=bfqt&srt=c&sp=rwdlacupiytfx&se=2023-05-24T10:44:39Z&st=2023-05-24T02:44:39Z&spr=https&sig=BENLg4A8j%2FM8WI%2BCJrnYuNXf21u4Ar3mW9Mvjywxwx8%3D&sr=b"
    schedule {
        frequency_interval = 30
        frequency_unit = "Day"
    }
    }
}

// Azure Key Vault 
resource "azurerm_key_vault" "azure_key_vault" {
  name                        = "${var.project}-kv"
  location                    = data.azurerm_resource_group.resource_group.location
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

// Azure Database for Postgresql
resource "azurerm_postgresql_server" "postgresql" {
  name                = "${var.project}-server"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "Admin222"
  administrator_login_password = "Admin1234@"
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "postgresql_database" {
  name                = "${var.project}-db"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}