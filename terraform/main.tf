terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "welend_challenge_sre_rg" {
  name     = var.rg_name
  location = var.location
  tags = var.tags
}

resource "azurerm_virtual_network" "welend_challenge_sre_vpc" {
  name                = var.vpc_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.welend_challenge_sre_rg.location
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
  tags = var.tags
}

resource "azurerm_subnet" "welend_challenge_sre_subnet" {
  name                 = var.subnet_name
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
  virtual_network_name = azurerm_virtual_network.welend_challenge_sre_vpc.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "welend_challenge_sre_vm_public_ip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
  location            = azurerm_resource_group.welend_challenge_sre_rg.location
  domain_name_label = var.vm_domain_name
  allocation_method = "Static"
  tags = var.tags

}

resource "azurerm_network_interface" "welend_challenge_sre_vm_interface" {
  name                = var.vm_interface_name
  location            = azurerm_resource_group.welend_challenge_sre_rg.location
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
  tags = var.tags

  ip_configuration {
    name                          = azurerm_subnet.welend_challenge_sre_subnet.name
    subnet_id                     = azurerm_subnet.welend_challenge_sre_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.welend_challenge_sre_vm_public_ip.id
  }
}



resource "azurerm_linux_virtual_machine" "welend_challenge_sre_linux_vm" {
  name                = var.vm_name
  location            = azurerm_resource_group.welend_challenge_sre_rg.location
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
  size                = "Standard_B1ls"
  admin_username      = "azureuser"
  tags = var.tags
  network_interface_ids = [
    azurerm_network_interface.welend_challenge_sre_vm_interface.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("../id_rsa_2048.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

data "azurerm_public_ip" "welend_challenge_sre_vm_public_ip" {
  name = azurerm_public_ip.welend_challenge_sre_vm_public_ip.name
  resource_group_name = azurerm_resource_group.welend_challenge_sre_rg.name
}

output "vm_public_ip_address" {
    value = data.azurerm_public_ip.welend_challenge_sre_vm_public_ip.ip_address  
}

output "vm_fqdn" {
    value = data.azurerm_public_ip.welend_challenge_sre_vm_public_ip.fqdn
}