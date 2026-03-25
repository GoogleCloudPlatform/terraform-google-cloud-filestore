# Filestore Instance Replication Example

This example demonstrates how to create a pair of Google Cloud Filestore instances (one active, one standby) with replication configured between them using Terraform.

The instances share a common capacity, defined by the `instance_capacity_gb` variable. Updating this variable will affect both instances.

**Important:** Active and Standby instances must be in different zones within the same region.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| active\_location | The region (e.g.,us-central1) or zone (e.g.,us-central1-c) for the active Filestore instance . | `string` | `"us-central1"` | no |
| instance\_capacity\_gb | The capacity for both active and standby Filestore instances in GB. | `number` | `1024` | no |
| instance\_name | Prefix for the Filestore instance names. | `string` | `"fs-repl"` | no |
| instance\_tier | The service tier for both active and standby Filestore instances. Must be the same for both instances. Supported tiers for replication are ZONAL, REGIONAL, and ENTERPRISE. | `string` | `"REGIONAL"` | no |
| network | The name of the network to which the instances will be connected. | `string` | `"default"` | no |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| share\_name | The name of the file share. | `string` | `"vol1"` | no |
| standby\_location | The region (e.g.,us-east1) or zone (e.g.,us-east1-f) for the standby Filestore instance . | `string` | `"us-east1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| active\_mount\_point | The mount point for the active instance. |
| instance\_name | The name of the active Filestore instance. |
| project\_id | The Google Cloud project ID. |
| replica\_instance\_name | The name of the standby Filestore instance. |
| standby\_mount\_point | The mount point for the standby instance. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

To provision this example, run the following from within this directory:

1.  Create a `terraform.tfvars` file and add your project ID:
    ```terraform
    project_id = "YOUR_PROJECT_ID"
    # Optional overrides:
    # active_location  = "us-central1-c"
    # standby_location = "us-central1-f"
    # instance_capacity_gb = 1024
    # network = "default"
    # instance_name = "fs-repl"
    # share_name = "vol1"
    ```
    Replace `YOUR_PROJECT_ID` with your actual Google Cloud project ID.

2.  Run the following commands:
    - `terraform init` to get the plugins
    - `terraform plan` to see the infrastructure plan
    - `terraform apply` to apply the infrastructure build
    - `terraform destroy` to destroy the built infrastructure
