# Creamos una máquina virtual. Por cada una de las entradas del diccionario se crea
# una máquina virtual accediendo a los componentes creados anteriormente. Además se 
# obtiene el tamaño del servidor a crear también del diccionario
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


# Configuración del apagado automático de las máquinas a las 22:00 de la noche
# para que el gasto no se dispare.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_test_global_vm_shutdown_schedule

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

# Creación de un disco estádar de 10 GB
resource "azurerm_managed_disk" "nfsdisk" {
  name                 = "nfs-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Se vincula el disco a la máquina master dándole permisos de lectura/escritura
resource "azurerm_virtual_machine_data_disk_attachment" "attachdisk" {

    managed_disk_id    = azurerm_managed_disk.nfsdisk.id
    virtual_machine_id = azurerm_linux_virtual_machine.myVM["master"].id
    lun                = "10"
    caching            = "ReadWrite"
}