terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            # le ~> permet de prendre au moins cette version
            version = "~> 3.24.0"
        }
    }
}

provider "azurerm" {
    features {}
    }
    
resource "azurerm_resource_group" "geotrace" {
    name = "geotrace"
    location = "France Central"   
}
    
# output "imagedata" {
#      value = data.azurerm_shared_image.image
# }
# resource "azurerm_network_interface_security_group_association" "firewall" {
#          network_interface_id = azurerm_network_interface.windows-nic
#          network_security_group_id = azurerm_network_security_group.secugroup-phil
# }

# output "public-ip" {
#          value = azurerm_windows_virtual_machine.vm-windows.public_ip_address
# }