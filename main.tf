# Terraform plan to create azure virtual machine

locals {
    admin_ssh_key = file(var.admin_ssh_key)
}

resource "random_pet" "main" {
  length    = 2
  prefix    = "vm-"
  separator = "-"

  keepers = {
    id = var.resource_name
  }
}

resource "azurerm_virtual_network" "main" {
	name                = "${random_pet.main.id}-vnet"
	address_space       = [var.vpc_cidr_block]
	location            = var.location
	resource_group_name = var.resource_name
}

resource "azurerm_subnet" "main" {
	name                 = "${random_pet.main.id}-subnet"
	resource_group_name  = var.resource_name
	virtual_network_name = azurerm_virtual_network.main.name
	address_prefixes     = [cidrsubnet(var.vpc_cidr_block, 8, 1)]
}

resource "azurerm_public_ip" "main" {
	name                = "${random_pet.main.id}-public-ip"
	location            = var.location
	resource_group_name = var.resource_name
	allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
	name                = "${random_pet.main.id}-nic"
	location            = var.location
	resource_group_name = var.resource_name

	ip_configuration {
		name                          = "internal"
		subnet_id                     = azurerm_subnet.main.id
		private_ip_address_allocation = "Dynamic"
		public_ip_address_id          = azurerm_public_ip.main.id
	}
}

resource "azurerm_linux_virtual_machine" "main" {
	name                = "${random_pet.main.id}-box"
	resource_group_name = var.resource_name
	location            = var.location
	size                = var.vm_size
	admin_username      = var.admin_username
	network_interface_ids = [azurerm_network_interface.main.id]
	
    os_disk {
		caching              = "ReadWrite"
		storage_account_type = "Premium_LRS"
		name                 = "${random_pet.main.id}-osdisk"
        disk_size_gb         = 128
	}
	
    source_image_reference {
		publisher = "Canonical"
		offer     = "ubuntu-24_04-lts"
		sku       = "server"
		version   = "latest"
	}


    admin_ssh_key {
        username   = var.admin_username
        public_key = local.admin_ssh_key
    }

    secure_boot_enabled = false

    tags = {
        IaC = "true"
    }
}


