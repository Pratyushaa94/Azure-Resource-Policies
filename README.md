# Azure Storage Lifecycle Management with Terraform

This repository demonstrates the implementation of Azure Storage Account lifecycle management policies using Terraform. The solution automatically manages data lifecycle in Azure Blob Storage, similar to AWS S3 lifecycle policies.

## Overview

The project implements automated storage management policies that:
- Move infrequently accessed data to cooler storage tiers
- Archive old data
- Delete outdated data and snapshots
- Manage blob versions

## Architecture

![Azure Storage Lifecycle](https://learn.microsoft.com/en-us/azure/storage/blobs/media/storage-lifecycle-management-concepts/lifecycle-management.png)

### Components:
- Azure Resource Group
- Azure Storage Account
- Storage Container
- Lifecycle Management Policies

## Prerequisites

- Azure Subscription
- Terraform (version >= 1.0.0)
- Azure CLI
- GitHub Account (for CI/CD)

## Project Structure

```
Azure-Resource-Policies/
│
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions workflow
│
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Variable definitions
├── terraform.tfvars        # Variable values
├── outputs.tf              # Output definitions
└── providers.tf            # Provider configuration
```

## Lifecycle Rules Implementation

### Rule 1: Modification-based Lifecycle
- Moves blobs to cool tier after 30 days of last modification
- Moves to archive tier after 90 days
- Deletes blobs after 365 days
- Deletes snapshots after 30 days
- Deletes versions after 90 days

### Rule 2: Access-based Lifecycle
- Moves blobs to cool tier after 30 days of last access
- Moves to archive tier after 90 days
- Deletes after specified period

## Configuration Details

### Storage Account
```hcl
resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  blob_properties {
    last_access_time_enabled = true
  }
}
```

### Lifecycle Policy
```hcl
resource "azurerm_storage_management_policy" "example" {
  storage_account_id = azurerm_storage_account.example.id
  
  rule {
    name    = "rule1"
    enabled = true
    # ... rule configuration
  }
}
```

## Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/Pratyushaa94/Azure-Resource-Policies.git
cd Azure-Resource-Policies
```

2. Initialize Terraform:
```bash
terraform init
```

3. Configure Azure credentials:
```bash
az login
```

4. Update terraform.tfvars with your values:
```hcl
resource_group_name = "your-rg-name"
storage_account_name = "yourstorageaccount"
container_name = "your-container"
```

5. Apply the configuration:
```bash
terraform plan
terraform apply
```

## CI/CD Pipeline

The repository includes GitHub Actions workflow that:
1. Authenticates with Azure
2. Initializes Terraform
3. Plans changes
4. Applies changes on merge to main

### Setting up GitHub Actions:

1. Create Azure Service Principal:
```bash
az ad sp create-for-rbac --name "GitHubActions" --role contributor --output json
```

2. Add the output as a GitHub secret named `AZURE_CREDENTIALS`

## Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| resource_group_name | Name of the resource group | - |
| storage_account_name | Name of the storage account | - |
| container_name | Name of the storage container | - |
| location | Azure region | "East US" |
| account_tier | Storage account performance tier | "Standard" |
| cool_tier_days | Days before moving to cool tier | 30 |
| archive_tier_days | Days before moving to archive tier | 90 |

## Best Practices Implemented

1. **Tiered Storage Management**: Automated movement between hot, cool, and archive tiers
2. **Cost Optimization**: Automatic cleanup of unused resources
3. **Security**: Proper access controls and private container access
4. **Infrastructure as Code**: Complete Terraform implementation
5. **CI/CD**: Automated deployment through GitHub Actions
6. **Variable Management**: Separation of configuration from code

## Maintenance and Monitoring

- Monitor blob access patterns in Azure Portal
- Review lifecycle policy effectiveness
- Adjust timing parameters in terraform.tfvars as needed
- Check Azure Storage metrics for tier transitions

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License

## Support

For issues and questions, please open an issue in the GitHub repository.