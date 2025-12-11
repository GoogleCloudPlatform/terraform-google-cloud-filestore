# Basic Filestore Snapshot Example

This example illustrates how to create a Filestore Regional instance and a basic snapshot for it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ip\_address | The IP address of the Filestore instance. |
| instance\_location | The location of the Filestore instance. |
| mount\_point | The mount point of the Filestore instance. |
| project\_id | The ID of the project in which the resource belongs. |
| share\_name | The name of the file share. |
| snapshot\_id | The fully qualified ID of the Filestore snapshot. |
| snapshot\_location | The location of the Filestore snapshot. |
| snapshot\_name | The name of the Filestore snapshot. |
| source\_instance\_name | The name of the source Filestore instance for the snapshot. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

To provision this example, run the following from within this directory:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
