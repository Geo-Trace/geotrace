resource "azurerm_linux_virtual_machine" "ubuntu-vm" {
  name                = "ubuntu-vm"
  resource_group_name = azurerm_resource_group.geotrace.name
  location            = azurerm_resource_group.geotrace.location
  size                = "Standard_B1s"
  admin_username      = "admin"
  disable_password_authentication = true
  network_interface_ids = [
    #nom de l'interface déclarée ligne 15 dans network.tf
    azurerm_network_interface.ubuntu-nic.id,
  ]

  admin_ssh_key {
    username = "admin"
    # si on met public_key = file(~/.ssh)
    public_key = tls_private_key.SSH_key.public_key_openssh #The magic here
  }

  os_disk {
    caching              = "None"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-confidential-vm-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202107090"
  }
}
