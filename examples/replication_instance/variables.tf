/**
 * Copyright 2026 Google LLC
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

variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "instance_name" {
  description = "Prefix for the Filestore instance names."
  type        = string
  default     = "fs-repl"
}

variable "active_location" {
  description = "The region (e.g.,us-central1) or zone (e.g.,us-central1-c) for the active Filestore instance ."
  type        = string
  default     = "us-central1"
}

variable "standby_location" {
  description = "The region (e.g.,us-east1) or zone (e.g.,us-east1-f) for the standby Filestore instance ."
  type        = string
  default     = "us-east1"
}

variable "instance_capacity_gb" {
  description = "The capacity for both active and standby Filestore instances in GB."
  type        = number
  default     = 1024
}

variable "instance_tier" {
  description = "The service tier for both active and standby Filestore instances. Must be the same for both instances. Supported tiers for replication are ZONAL, REGIONAL, and ENTERPRISE."
  type        = string
  default     = "REGIONAL"
}

variable "share_name" {
  description = "The name of the file share."
  type        = string
  default     = "vol1"
}

variable "network" {
  description = "The name of the network to which the instances will be connected."
  type        = string
  default     = "default"
}
