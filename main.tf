resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.tfstate.name
  location                 = data.azurerm_resource_group.tfstate.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  # Explicit defaults
  access_tier  = "Hot"
  account_kind = "StorageV2"

  # This is necessary to access Key Vault
  identity {
    type = "SystemAssigned"
  }

  # Secure Defaults
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  lifecycle {
    ignore_changes = [customer_managed_key]
  }

  # TODO: Add tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}


resource "azurerm_key_vault" "tfstate" {
  name                       = var.key_vault_name
  location                   = data.azurerm_resource_group.tfstate.location
  resource_group_name        = data.azurerm_resource_group.tfstate.name
  tenant_id                  = data.azuread_client_config.current.tenant_id
  sku_name                   = var.key_vault_sku_name
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  enable_rbac_authorization = false

  # Disable certificate lifecycle contact checks
  lifecycle {
    ignore_changes = [contact]
  }

  network_acls {
    bypass = "AzureServices"
    # I have no VPN/subnets configured for the moment, so we'll allow external traffic.
    default_action = "Allow"
    # If you did have subnets, configure them here and make sure the agents running your
    # Terraform operations have access to these subnets.
    # virtual_network_subnet_ids = [data.azurerm_subnet.v-subnet.id]
  }
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = azurerm_key_vault.tfstate.id
  tenant_id    = data.azuread_client_config.current.tenant_id
  object_id    = azurerm_storage_account.tfstate.identity.0.principal_id

  key_permissions    = ["Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.tfstate.id
  tenant_id    = data.azuread_client_config.current.tenant_id
  object_id    = data.azuread_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "tfstate" {
  name         = var.key_vault_name
  key_vault_id = azurerm_key_vault.tfstate.id
  key_type     = var.key_vault_key_type # RSA or RSA-HSM
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage,
  ]
  expiration_date = var.key_vault_key_expiration_date
  # TODO: Add tags
}

resource "azurerm_storage_account_customer_managed_key" "tfstate" {
  storage_account_id = azurerm_storage_account.tfstate.id
  key_vault_id       = azurerm_key_vault.tfstate.id
  key_name           = azurerm_key_vault_key.tfstate.name
  key_version        = null # null enables automatic key rotation
}
