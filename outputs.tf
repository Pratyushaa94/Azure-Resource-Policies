# Resource Group Outputs
output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.example.id
}

# Storage Account Outputs
output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.example.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.example.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = azurerm_storage_account.example.primary_blob_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.example.primary_access_key
  sensitive   = true
}

# Container Outputs
output "container_id" {
  description = "The ID of the storage container"
  value       = azurerm_storage_container.example.id
}

output "container_name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.example.name
}

# Lifecycle Policy Outputs
output "management_policy_id" {
  description = "The ID of the storage management policy"
  value       = azurerm_storage_management_policy.example.id
}

output "lifecycle_rules" {
  description = "Summary of lifecycle rules"
  value = {
    rule1 = {
      name    = azurerm_storage_management_policy.example.rule[0].name
      enabled = azurerm_storage_management_policy.example.rule[0].enabled
      filters = azurerm_storage_management_policy.example.rule[0].filters
    }
    rule2 = {
      name    = azurerm_storage_management_policy.example.rule[1].name
      enabled = azurerm_storage_management_policy.example.rule[1].enabled
      filters = azurerm_storage_management_policy.example.rule[1].filters
    }
  }
}