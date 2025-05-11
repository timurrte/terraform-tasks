resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg.name
  location            = var.rg.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags = {
    Creator = var.common_tag
  }
}
resource "azurerm_container_registry_task" "acr_task" {
  name                  = "app-task"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path = "Dockerfile"
    context_path    = var.app_archive_context_url
    image_names     = [var.image_name]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "task_schedule" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}
