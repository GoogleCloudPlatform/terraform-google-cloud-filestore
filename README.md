# terraform-google-cloud-filestore

## Description

The Terraform module handles the creation of [Cloud Filestore](https://cloud.google.com/filestore?hl=en) on Google Cloud.

## Assumptions and prerequisites
This module assumes that below mentioned prerequisites are in place before consuming the module.

- To deploy this blueprint you must have an active billing account and billing permissions.
- APIs are enabled.
- Permissions are available.

## Documentation
- [Cloud Filestore](https://cloud.google.com/filestore)

## Usage

Basic usage of this module is as follows:

# Define a variable for the GCP project ID

```hcl
variable "gcp_project_id" {
  description = "The GCP project id to deploy resources into."
  type        = string
}

module "google_filestore_instance" {
  source  = "GoogleCloudPlatform/filestore/google"
  version = "~> 0.1"

  project       = var.gcp_project_id
  name          = "my-filestore-regional-instance"
  location      = "us-central1"
  tier          = "REGIONAL"
  protocol      = "NFS_V3"
  kms_key_name  = google_kms_crypto_key.filestore_key.id

  file_shares {
    capacity_gb        = 1024
    name               = "share1"
    nfs_export_options = [
      {
        ip_ranges   = ["10.0.0.0/24"]
        access_mode = "READ_WRITE"
        squash_mode = "NO_ROOT_SQUASH"
        anon_uid    = null
        anon_gid    = null
      },
      {
        ip_ranges   = ["10.10.0.0/24"]
        access_mode = "READ_ONLY"
        squash_mode = "ROOT_SQUASH"
        anon_uid    = 123
        anon_gid    = 456
      }
    ]
  }

  networks {
    network      = "default"
    modes        = ["MODE_IPV4"]
    connect_mode = "DIRECT_PEERING"
  }
}

resource "google_filestore_backup" "default" {
  project           = var.gcp_project_id
  name              = "terraform-blueprint-backup"
  location          = "us-central1"
  source_instance   = module.google_filestore_instance.instance_id
  source_file_share = "share1"
  description       = "This is a filestore backup for the test instance."
  labels = {
    "files"       = "label1"
    "other-label" = "label2"
  }
}

resource "google_filestore_snapshot" "default" {
  project  = var.gcp_project_id
  name     = "terraform-blueprint-basic-snapshot"
  instance = module.google_filestore_instance.instance_name
  location = "us-central1"
}

resource "google_kms_key_ring" "filestore_keyring" {
  project  = var.gcp_project_id
  name     = "filestore-keyring"
  location = "us-central1"
}

resource "google_kms_crypto_key" "filestore_key" {
  project  = var.gcp_project_id
  name     = "filestore-key"
  key_ring = google_kms_key_ring.filestore_keyring.id
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| capacity\_gb | The capacity of the file share in gigabytes. | `number` | `1024` | no |
| connect\_mode | The network connect mode of the Filestore instance. | `string` | `"DIRECT_PEERING"` | no |
| instance\_name | The name of the Filestore instance. The name must be unique within the specified instance. | `string` | n/a | yes |
| kms\_key\_name | The resource name of the KMS key to be used for data encryption. | `string` | `null` | no |
| location | The location for the Filestore instance. Can be a zone or a region, depends on the tier. | `string` | n/a | yes |
| network | The name of the network to which the Filestore instance is connected. | `string` | `"default"` | no |
| network\_modes | The IP versions for the network. Examples include MODE\_IPV4, MODE\_IPV6. | `list(string)` | <pre>[<br>  "MODE_IPV4"<br>]</pre> | no |
| nfs\_export\_options | NFS export options for the file share. | <pre>list(object({<br>    ip_ranges   = list(string)<br>    access_mode = string<br>    squash_mode = string<br>    anon_uid    = number<br>    anon_gid    = number<br>  }))</pre> | `[]` | no |
| project\_id | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| protocol | The file protocol of the Filestore instance. | `string` | `"NFS_V3"` | no |
| share\_name | The name of the file share. | `string` | `"vol1"` | no |
| tier | The service tier of the instance. Examples include ZONAL, REGIONAL, BASIC\_HDD, BASIC\_SSD, ENTERPRISE. | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | The fully qualified ID of the Filestore instance. |
| instance\_ip\_address | The IP address of the Filestore instance. |
| instance\_name | The name of the Filestore instance. |
| kms\_key\_name | The name of the KMS key used to encrypt the Filestore instance. |
| location | The location of the Filestore instance. |
| mount\_point | The mount point of the Filestore instance in the form of <ip\_address>:/<share\_name> |
| share\_name | The name of the file share. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform](https://www.terraform.io/downloads.html) v0.13
- [Terraform Provider for GCP](https://www.terraform.io/docs/providers/google/index.html) plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- `roles/file.editor`
- `roles/cloudkms.admin`
- `roles/iam.serviceAccountAdmin`
- `roles/serviceusage.serviceUsageAdmin`
- `roles/resourcemanager.projectIamAdmin`

The [Project Factory module](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google) and the
[IAM module](https://registry.terraform.io/modules/terraform-google-modules/iam/google) may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Filestore API: `file.googleapis.com`
- Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`
- Cloud IAM API: `iam.googleapis.com`
- Cloud Billing API: `cloudbilling.googleapis.com`
- Cloud Key Management Service (KMS) API: `cloudkms.googleapis.com`

The [Project Factory module](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google) can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
