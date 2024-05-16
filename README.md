# terraform-azurerm-tfstate-backend

Terraform module that provisions an Azure Storage account to store the `terraform.tfstate` file, and a Key Vault to store the customer-managed encryption key.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.client](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/key_vault_key) | resource |
| [azurerm_resource_group.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/storage_account_customer_managed_key) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/storage_container) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default billing tags to be applied across all resources | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location for these resources, such as East US. | `string` | `"East US"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Specify the type of environment(dev, demo, prod) in which the storage account will be created. | `string` | `""` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium | `string` | `"Standard"` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `"GRS"` | no |
| <a name="input_key_vault_key_type"></a> [key\_vault\_key\_type](#input\_key\_vault\_key\_type) | Specifies the Key Type to use for this Key Vault Key. For Terraform state, supply RSA or RSA-HSM. | `string` | `"RSA"` | no |
| <a name="input_key_vault_sku_name"></a> [key\_vault\_sku\_name](#input\_key\_vault\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_key_vault_key_expiration_date"></a> [key\_vault\_key\_expiration\_date](#input\_key\_vault\_key\_expiration\_date) | Expiration of the Key Vault Key, in UTC datetime (Y-m-d'T'H:M:S'Z'). | `string` | `"2022-12-30T20:00:00Z"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name | `string` | `""` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Storage account name | `string` | `""` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Storage container name | `string` | `""` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Key Vault account name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the Resource Group. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Storage Account |
| <a name="output_storage_account_primary_location"></a> [storage\_account\_primary\_location](#output\_storage\_account\_primary\_location) | The primary location of the storage account. |
| <a name="output_storage_account_primary_blob_endpoint"></a> [storage\_account\_primary\_blob\_endpoint](#output\_storage\_account\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_account_primary_access_key"></a> [storage\_account\_primary\_access\_key](#output\_storage\_account\_primary\_access\_key) | The primary access key for the storage account. This value is sensitive and masked from Terraform output. |
| <a name="output_storage_container_id"></a> [storage\_container\_id](#output\_storage\_container\_id) | The ID of the Storage Container. |
| <a name="output_storage_container_has_immutability_policy"></a> [storage\_container\_has\_immutability\_policy](#output\_storage\_container\_has\_immutability\_policy) | Is there an Immutability Policy configured on this Storage Container? |
| <a name="output_storage_container_has_legal_hold"></a> [storage\_container\_has\_legal\_hold](#output\_storage\_container\_has\_legal\_hold) | Is there a Legal Hold configured on this Storage Container? |
| <a name="output_storage_container_resource_manager_id"></a> [storage\_container\_resource\_manager\_id](#output\_storage\_container\_resource\_manager\_id) | The Resource Manager ID of this Storage Container. |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | --------------------------------------------------------------------------------------------------------------------- Key Vault Attributes https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key#attributes-reference --------------------------------------------------------------------------------------------------------------------- ## The Key Vault ### |
| <a name="output_key_vault_key_id"></a> [key\_vault\_key\_id](#output\_key\_vault\_key\_id) | The Key Vault Key ID |
| <a name="output_key_vault_key_version"></a> [key\_vault\_key\_version](#output\_key\_vault\_key\_version) | The current version of the Key Vault Key. |
| <a name="output_z_instructions"></a> [z\_instructions](#output\_z\_instructions) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
