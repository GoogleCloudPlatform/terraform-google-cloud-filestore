# Zonal Filestore Backup Example


This example illustrates how to create a Zonal Filestore instance and a backup for it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backup\_id | The fully qualified ID of the Filestore backup. |
| backup\_location | The location of the Filestore backup. |
| backup\_name | The name of the Filestore backup. |
| instance\_ip\_address | The IP address of the Filestore instance. |
| instance\_location | The location of the Filestore instance. |
| instance\_name | The name of the Filestore instance. |
| mount\_point | The mount point of the Filestore instance. |
| project\_id | The ID of the project in which the resource belongs. |
| share\_name | The name of the file share. |
| source\_file\_share | The name of the source file share for the backup. |
| source\_instance\_id | The ID of the source Filestore instance for the backup. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

To provision this example, run the following from within this directory:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
