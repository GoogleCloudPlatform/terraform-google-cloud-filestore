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
  description = "The name of the Filestore instance. The name must be unique within the specified instance."
  type        = string
}

variable "location" {
  description = "The location for the Filestore instance. Can be a zone or a region, depends on the tier."
  type        = string
}

variable "tier" {
  description = "The service tier of the instance. Examples include BASIC_HDD, BASIC_SSD, ZONAL, REGIONAL, ENTERPRISE."
  type        = string
  default     = "REGIONAL"
}

variable "capacity_gb" {
  description = "The capacity of the file share in gigabytes."
  type        = number
  default     = 1024
}

variable "share_name" {
  description = "The name of the file share."
  type        = string
  default     = "vol1"
}

variable "network" {
  description = "The name of the network to which the Filestore instance is connected."
  type        = string
  default     = "default"
}

variable "network_modes" {
  description = "The IP versions for the network. Examples include MODE_IPV4, MODE_IPV6."
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
  description = "The network connect mode of the Filestore instance."
  type        = string
  default     = "DIRECT_PEERING"
}

variable "kms_key_name" {
  description = "The resource name of the KMS key to be used for data encryption."
  type        = string
  default     = null
}

variable "protocol" {
  description = "The file protocol of the Filestore instance."
  type        = string
  default     = "NFS_V3"
}
