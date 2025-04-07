resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.rg.location
  resource_group_name = var.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                            = "linux-vm1"
  resource_group_name             = var.rg.name
  location                        = var.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "Test1234"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("blobfuse_mount.tftpl",
    {
      account_name   = var.storage_account_name,
      container_name = var.container_name,
      sas_token      = var.sas_token
  }))
}