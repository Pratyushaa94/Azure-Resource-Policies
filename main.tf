# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Enable last access time tracking
  blob_properties {
    last_access_time_enabled = true
  }
}

# Create a container
resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = var.container_access_type
}

# Create management policy for the storage account
resource "azurerm_storage_management_policy" "example" {
  storage_account_id = azurerm_storage_account.example.id

  rule {
    name    = "rule1"
    enabled = true
    filters {
      prefix_match = ["container1/prefix1"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.cool_tier_days
        tier_to_archive_after_days_since_modification_greater_than = var.archive_tier_days
        delete_after_days_since_modification_greater_than          = var.delete_days
      }
      snapshot {
        delete_after_days_since_creation_greater_than = var.snapshot_delete_days
      }
      version {
        delete_after_days_since_creation = var.version_delete_days
      }
    }
  }

  rule {
    name    = "rule2"
    enabled = true
    filters {
      prefix_match = ["container2/prefix2"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_last_access_time_greater_than    = var.cool_tier_days
        tier_to_archive_after_days_since_last_access_time_greater_than = var.archive_tier_days
        delete_after_days_since_last_access_time_greater_than          = var.delete_days
      }
    }
  }
}