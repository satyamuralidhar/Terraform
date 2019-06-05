
#execute the below steps

# az login
# # az login
# az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
# az account show --query "{ subscription_id: id }"
# az account show --query "{ subscription_id: id }"

provider "azurerm" {

    subscription_id = "${var.subscription}"
    client_id = "${var.client_id}"
    client_secret = "${var.client_secret}"
    tenant_id = "${var.tenant_id}"  
}

resource "azurerm_resource_group" "resource" {
  name     = "satya"
  location = "West US 2"
  tags {
      environment = "Dev"
  }
}
resource "azurerm_storage_account" "storage" {
  name                     = "satyastoragespace"
  resource_group_name      = "${azurerm_resource_group.resource.name}"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_virtual_network" "satya-vnet" {
    name                = "satya-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus2"
    resource_group_name = "${azurerm_resource_group.resource.name}"

    tags {
        environment = "Dev"
    }
}
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "satya-sub1"
    resource_group_name  = "${azurerm_resource_group.resource.name}"
    virtual_network_name = "${azurerm_virtual_network.satya-vnet.name}"
    address_prefix       = "10.0.2.0/24"
}
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = "westus2"
    resource_group_name          = "${azurerm_resource_group.resource.name}"
    allocation_method            = "Dynamic"

    tags {
        environment = "Dev"
    }
}
resource "azurerm_network_security_group" "nsg" {
    name                = "terraform"
    location            = "westus2"
    resource_group_name = "${azurerm_resource_group.resource.name}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
    resource "azurerm_network_interface" "satyanic" {
    name                = "satya"
    location            = "westus2"
    resource_group_name = "${azurerm_resource_group.resource.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.myterraformpublicip.id}"
    }
    }

resource "azurerm_virtual_machine" "main" {
  name                  = "satya"
  location              = "westus2"
  resource_group_name   = "${azurerm_resource_group.resource.name}"
  network_interface_ids = ["${azurerm_network_interface.satyanic.id}"]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "satya"
    admin_username = "murali"
    admin_password = "${var.passwd}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Dev"
  }
}