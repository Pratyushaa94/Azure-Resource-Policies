# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true  # Skip automatic registration of resource providers
}