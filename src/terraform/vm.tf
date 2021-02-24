# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM1" {
    name                = "master-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic1.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount1.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM2" {
    name                = "worker1-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic2.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount2.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM3" {
    name                = "worker2-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic3.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount3.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM4" {
    name                = "nfs-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic4.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount4.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown1" {
  virtual_machine_id = azurerm_linux_virtual_machine.myVM1.id
  location           = azurerm_resource_group.rg.location
  enabled            = true

  daily_recurrence_time = "2200"
  timezone              = "Romance Standard Time"

  notification_settings {
    enabled         = false
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown2" {
  virtual_machine_id = azurerm_linux_virtual_machine.myVM2.id
  location           = azurerm_resource_group.rg.location
  enabled            = true

  daily_recurrence_time = "2200"
  timezone              = "Romance Standard Time"

  notification_settings {
    enabled         = false
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown3" {
  virtual_machine_id = azurerm_linux_virtual_machine.myVM3.id
  location           = azurerm_resource_group.rg.location
  enabled            = true

  daily_recurrence_time = "2200"
  timezone              = "Romance Standard Time"

  notification_settings {
    enabled         = false
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown4" {
  virtual_machine_id = azurerm_linux_virtual_machine.myVM4.id
  location           = azurerm_resource_group.rg.location
  enabled            = true

  daily_recurrence_time = "2200"
  timezone              = "Romance Standard Time"

  notification_settings {
    enabled         = false
  }
}