# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "${var.nombre}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
    name                   = "${var.nombre}-vsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Create NIC 1 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic1" {
  name                = "${var.nombre}-vnic1"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.myPublicIp1.id
  }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_network_interface" "myNic2" {
  name                = "${var.nombre}-vnic2"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration2"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.11"
    public_ip_address_id           = azurerm_public_ip.myPublicIp2.id
  }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_network_interface" "myNic3" {
  name                = "${var.nombre}-vnic3"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration3"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.12"
    public_ip_address_id           = azurerm_public_ip.myPublicIp3.id
  }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_network_interface" "myNic4" {
  name                = "${var.nombre}-vnic4"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration4"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.13"
    public_ip_address_id           = azurerm_public_ip.myPublicIp4.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp1" {
  name                = "${var.nombre}-vmip1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.nombre}master"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_public_ip" "myPublicIp2" {
  name                = "${var.nombre}-vmip2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.nombre}worker1"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_public_ip" "myPublicIp3" {
  name                = "${var.nombre}-vmip3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.nombre}worker2"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_public_ip" "myPublicIp4" {
  name                = "${var.nombre}-vmip4"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.nombre}nfs"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
