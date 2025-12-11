# Regional Filestore Instance Example

This example demonstrates how to create a Google Cloud Filestore Regional instance with a KMS key.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | The fully qualified ID of the Filestore instance. |
| instance\_ip\_address | The IP address of the Filestore instance. |
| instance\_location | The location of the Filestore instance. |
| instance\_name | The name of the Filestore instance. |
| kms\_key\_name | The KMS key used for the Filestore instance. |
| mount\_point | The mount point of the Filestore instance. |
| project\_id | The ID of the project in which the resource belongs. |
| share\_name | The name of the file share. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
