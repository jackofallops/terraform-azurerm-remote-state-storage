# azurerm-terraform-remote-state-storage
Terraform module to set up a storage account on Azure and prep it for use as remote state storage

This module makes up part of a quick-start set of modules.  This is intended to be used prior to a larger deployment to
provide remote state capability in the beginning of a project to help prevent isolation of work.

## Usage
```hcl-terraform
module "remote-state-storage"{
  source   = "sjones-sot/remote-state-storage/azurerm"
  name     = "myremotestorage"
  location = "westeurope"
}

```

This can later be used as follows:
```hcl-terraform
terraform{
  backend "azurerm" {
    storage_account_name = ""
    container_name       = ""
    key                  = ""
    resource_group_name  = ""
  }
}
```



## Limitations and Notes
Management locks - I'd recommend setting a delete lock on this storage account.  If you run your terraform client as an `owner` rather than `contributor` you can add something like the following to do this automatically:
```hcl-terraform
resource "azurerm_management_lock" "state_storage_delete_lock"{
  name       = "statefiles-nodelete-lock"
  scope      = "${module.remote_state_storage.storage_account_id}"
  lock_level = "CanNotDelete"
  notes      = "Some meaningful notes here"
}
```

NB: I do _not_ recommend running your terraform app as `owner`.

