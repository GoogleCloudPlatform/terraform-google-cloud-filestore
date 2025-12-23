/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "instance_name" {
  description = "The name of the Filestore instance. Instance name must start with a lowercase letter, followed by up to 62 lowercase letters, numbers, or hyphens, and cannot end with a hyphen."
  type        = string
}

variable "location" {
  description = "The GCP zone for zonal instances or region for regional instances."
  type        = string
}

variable "tier" {
  description = "The service tier of the instance. Possible values are BASIC_HDD, BASIC_SSD, ENTERPRISE, ZONAL, and REGIONAL."
  type        = string
  default     = "REGIONAL"
}

variable "capacity_gb" {
  description = <<-EOT
    The desired capacity of the volume in GB. Acceptable instance capacities vary by tier:

    - BASIC_HDD: 1TB - 63.9TB in 1GB increments.
    - BASIC_SSD: 2.5TB - 63.9TB in 1GB increments.
    - ZONAL: 1TB-9.75TB in 256GB increments, or 10TB-100TB in 2.5TB increments.
    - ENTERPRISE: 1TB - 10TB in 256GB increments.
    - REGIONAL: 1TB-9.75TB in 256GB increments, or 10TB-100TB in 2.5TB increments.

    Learn more at: https://docs.cloud.google.com/filestore/docs/creating-instances#allocate_capacity
    EOT
  type        = number
  default     = 1024
}

variable "share_name" {
  description = "The name of the file share. Must use 1-16 characters for the basic service tier and 1-63 characters for all other service tiers. Must use lowercase letters, numbers, or underscores [a-z0-9_]. Must start with a letter."
  type        = string
  default     = "vol1"
}

variable "network" {
  description = "The name of the GCE VPC network to which the Filestore instance is connected."
  type        = string
  default     = "default"
}

variable "network_modes" {
  description = "IP versions for which the instance has IP addresses assigned. Each value may be one of: ADDRESS_MODE_UNSPECIFIED, MODE_IPV4, MODE_IPV6."
  type        = list(string)
  default     = ["MODE_IPV4"]
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "nfs_export_options" {
  description = "NFS export options for the file share."
  type = list(object({
    ip_ranges   = list(string)
    access_mode = string
    squash_mode = string
    anon_uid    = number
    anon_gid    = number
  }))
  default = []
}

variable "connect_mode" {
  description = "The network connect mode of the Filestore instance. Possible values are DIRECT_PEERING, PRIVATE_SERVICE_ACCESS, and PRIVATE_SERVICE_CONNECT."
  type        = string
  default     = "DIRECT_PEERING"
}

variable "kms_key_name" {
  description = "The resource name of the KMS key to be used for data encryption."
  type        = string
  default     = null
}

variable "protocol" {
  description = "File sharing protocol. Possible values are NFS_V3 (NFSv3) and NFS_V4_1 (NFSv4.1). NFSv4.1 can be used with ZONAL, REGIONAL and ENTERPRISE. The default is NFSv3."
  type        = string
  default     = "NFS_V3"
}
