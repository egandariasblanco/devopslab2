# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "${var.nombre}-vnet"
    address_space       = ["10.0.0.0/8"]
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
    address_prefixes       = ["10.0.0.0/8"]

}

# Create NICs. Se utiliza la instrucción for_each para iterar sobre
# el diccionario creado como variable y poder poner un nombre relacionado 
# a la máquina tanto a los NIC como a las configuraciones 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic" {
  for_each = var.lab2
  name                = "${each.key}-vnic"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                           = "${each.key}-ipconf"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = each.value.privip
    public_ip_address_id           = azurerm_public_ip.myPublicIp[each.key].id
  }

    tags = {
        environment = "CP2"
    }

}


# IP pública. Se utiliza el for_each para nombrar cada una de las ips públicas. Además se le 
# da un nombre de dominio para que sea más fácil acceder a los servidores y no tener que 
# hacerlo mediante IP. 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp" {
  for_each = var.lab2
  name                = "${each.key}-vmip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = format("%s%s", var.nombre, each.key) # Concatenación de la variable nombre con el diccionario
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
