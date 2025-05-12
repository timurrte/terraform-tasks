# Static time (for consistent timestamps across resources)
resource "time_static" "now" {}

# Offset time to generate expiry time for SAS token
resource "time_offset" "sas_expiry" {
  base_rfc3339 = time_static.now.rfc3339
  offset_hours = 24
}

# Data source to archive the application directory
data "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = var.app_dir
  output_path = "${path.module}/app.tar.gz"
}

# Azure Storage Account
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg.name
  location                 = var.rg.location
  account_tier             = "Standard"
  account_replication_type = var.sa_replication_type
  tags = {
    Creator = var.common_tag
  }
}

# Azure Storage Container
resource "azurerm_storage_container" "this" {
  name                  = var.sa_container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.sa_container_access_type
}

# Blob within the Storage Container (upload the zip archive)
resource "azurerm_storage_blob" "app_archive" {
  name                   = "app.tar.gz"
  type                   = "Block"
  source                 = data.archive_file.app.output_path
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
}

# Shared Access Signature (SAS Token) for Container
data "azurerm_storage_account_sas" "sas" {
  connection_string = azurerm_storage_account.this.primary_connection_string

  https_only = true
  start      = time_static.now.rfc3339
  expiry     = time_offset.sas_expiry.rfc3339

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}
