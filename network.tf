resource "azurerm_virtual_network" "vm-net" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.geotrace.location
  resource_group_name = azurerm_resource_group.geotrace.name
}

resource "azurerm_subnet" "ubuntu-subnet" {
  name                 = "vm-subnet"
  resource_group_name  = azurerm_resource_group.geotrace.name
  virtual_network_name = azurerm_virtual_network.vm-net.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "IP_publique" {
  name                = "IP_publique"
  resource_group_name = azurerm_resource_group.geotrace.name
  location            = azurerm_resource_group.geotrace.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "ubuntu-nic" {
  name                = "ubuntu-nic"
  location            = azurerm_resource_group.geotrace.location
  resource_group_name = azurerm_resource_group.geotrace.name

  ip_configuration {
    name                          = "ip-config"
    subnet_id                     = azurerm_subnet.ubuntu-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.IP_publique.id
  }
}

resource "azurerm_network_security_group" "secugroup-geotrace" {
  name                = "secugroup-geotrace"
  location            = azurerm_resource_group.geotrace.location
  resource_group_name = azurerm_resource_group.geotrace.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 111
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet_network_security_group_association" "association_SG" {
  subnet_id                 = azurerm_subnet.ubuntu-subnet.id
  network_interface_id      = azurerm_network_interface.ubuntu-nic.id
  network_security_group_id = azurerm_network_security_group.secugroup-geotrace.id
}
