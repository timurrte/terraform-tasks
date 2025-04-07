# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Network/networkInterfaces/module7-vm-restored-nic-12cd860cb2dc4ca0967fa761c1e62937"
resource "azurerm_network_interface" "restored_nic" {
  accelerated_networking_enabled = false
  auxiliary_mode                 = null
  auxiliary_sku                  = null
  dns_servers                    = []
  edge_zone                      = null
  internal_dns_name_label        = null
  ip_forwarding_enabled          = false
  location                       = "westeurope"
  name                           = "module7-vm-restored-nic-12cd860cb2dc4ca0967fa761c1e62937"
  resource_group_name            = "epm-lab-module7-rg"
  tags                           = {}
  ip_configuration {
    gateway_load_balancer_frontend_ip_configuration_id = null
    name                                               = "7efae6ea9d034855bf483de06aa09f89"
    primary                                            = true
    private_ip_address                                 = "10.0.1.5"
    private_ip_address_allocation                      = "Dynamic"
    private_ip_address_version                         = "IPv4"
    public_ip_address_id                               = null
    subnet_id                                          = "/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Network/virtualNetworks/vm-network/subnets/internal"
  }
}

# __generated__ by Terraform from "/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Compute/virtualMachines/module7-vm-restored"
resource "azurerm_virtual_machine" "restored_vm" {
  availability_set_id              = null
  delete_data_disks_on_termination = null
  delete_os_disk_on_termination    = null
  license_type                     = null
  location                         = "westeurope"
  name                             = "module7-vm-restored"
  network_interface_ids            = ["/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Network/networkInterfaces/module7-vm-restored-nic-12cd860cb2dc4ca0967fa761c1e62937"]
  primary_network_interface_id     = "/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Network/networkInterfaces/module7-vm-restored-nic-12cd860cb2dc4ca0967fa761c1e62937"
  proximity_placement_group_id     = null
  resource_group_name              = "epm-lab-module7-rg"
  tags                             = {}
  vm_size                          = "Standard_F2"
  zones                            = []
  storage_os_disk {
    caching                   = "ReadWrite"
    create_option             = "Attach"
    disk_size_gb              = 30
    image_uri                 = null
    managed_disk_id           = "/subscriptions/6a92e0c5-43d8-4d28-9003-9775227a1e46/resourceGroups/epm-lab-module7-rg/providers/Microsoft.Compute/disks/module7vmrestored-osdisk-20250402-215619"
    managed_disk_type         = "Standard_LRS"
    name                      = "module7vmrestored-osdisk-20250402-215619"
    os_type                   = "Linux"
    vhd_uri                   = null
    write_accelerator_enabled = false
  }
}
