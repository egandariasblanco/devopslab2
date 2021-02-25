# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM" {
    for_each = var.lab2
    name                = "${each.key}-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = each.value.size
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic[each.key].id ]
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
        storage_account_uri = azurerm_storage_account.stAccount[each.key].primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown" {
    for_each = var.lab2
    virtual_machine_id = azurerm_linux_virtual_machine.myVM[each.key].id
    location           = azurerm_resource_group.rg.location
    enabled            = true

    daily_recurrence_time = "2200"
    timezone              = "Romance Standard Time"

    notification_settings {
        enabled         = false
    }
}