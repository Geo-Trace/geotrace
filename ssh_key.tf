resource "tls_private_key" "SSH_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# resource "azurerm_ssh_public_key" "SSH_key" {
#   name                = "SSH_key"
#   resource_group_name = "formation"
#   location            = "France Central"  
#   public_key          = file("~/.ssh/SSH_key")
# }

