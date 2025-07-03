variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
}

variable "account_tier" {
  description = "Performance tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Type of replication for the storage account"
  type        = string
  default     = "LRS"
}

variable "container_access_type" {
  description = "Access type for the container"
  type        = string
  default     = "private"
}

variable "cool_tier_days" {
  description = "Days after which to move blobs to cool tier"
  type        = number
  default     = 30
}

variable "archive_tier_days" {
  description = "Days after which to move blobs to archive tier"
  type        = number
  default     = 90
}

variable "delete_days" {
  description = "Days after which to delete blobs"
  type        = number
  default     = 365
}

variable "snapshot_delete_days" {
  description = "Days after which to delete snapshots"
  type        = number
  default     = 30
}

variable "version_delete_days" {
  description = "Days after which to delete versions"
  type        = number
  default     = 90
}