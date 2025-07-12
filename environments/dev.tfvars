# Resource Group and Location
resource_group_name = "elizbith-rg"
location           = "East US"

# Storage Account Configuration
storage_account_name      = "elizbithhh"
account_tier             = "Standard"
account_replication_type = "LRS"

# Container Configuration
container_name        = "lifecycle-container"
container_access_type = "private"

# Lifecycle Policy Timings
cool_tier_days       = 30
archive_tier_days    = 90
delete_days          = 365
snapshot_delete_days = 30
version_delete_days  = 90