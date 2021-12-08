terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_rg_blobstorage"
    storage_account_name = "tfstorageaccount120821"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

variable "imagebuild" {
  type = string
  description = "Latest Image Build "
}

resource "azurerm_resource_group" "tf_test" {
    name = "rgish12012021"
    location = "eastus2"

}


resource "azurerm_container_group" "tfcg_test" {
    name                 = "weatherapi"
    location             = azurerm_resource_group.tf_test.location
    resource_group_name  = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label  = "ish12012021"
    os_type         = "linux"

    container {
        name            = "weatherapi"
        image           = "ishamid/weatherapi:${var.imagebuild}"
            cpu             = "1"
            memory          = "1"

            ports {
                port        = 80
                protocol    = "TCP"
            }
    }
}





