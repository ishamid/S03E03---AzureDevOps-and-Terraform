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

resource "azurerm_resource_group" "tf_test" {
    name = "rgish12012021"
    location = "eastus2"

}


resource "azurerm_container_group" "tfcg" {
    name                 = "weatherapi"
    location             = azurerm_resource_group.tf_test.location
    resource_group_name  = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label  = "ish12012021"
    os_type         = "linux"

    container {
        name            = "weatherapi"
        image           = "ishamid/weatherapi"
            cpu             = "1"
            memory          = "1"

            ports {
                port        = 80
                protocol    = "TCP"
            }
    }
}




