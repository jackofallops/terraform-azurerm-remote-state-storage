resource "azurerm_storage_account" "remote_state_sa" {
  name                     = "${var.name}remotestatesa"
  location                 = "${var.location}"
  account_tier             = "${var.storage_account_tier}"
  resource_group_name      = "${azurerm_resource_group.remote_state_rg.name}"
  account_replication_type = "${var.storage_account_replication_type}"

  lifecycle {
    prevent_destroy = true
  }

}
