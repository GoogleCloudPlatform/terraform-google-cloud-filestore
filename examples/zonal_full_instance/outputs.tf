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

output "instance_id" {
  description = "The fully qualified ID of the Filestore instance."
  value       = module.google_filestore_instance.instance_id
}

output "instance_name" {
  description = "The name of the Filestore instance."
  value       = module.google_filestore_instance.instance_name
}

output "instance_ip_address" {
  description = "The IP address of the Filestore instance."
  value       = module.google_filestore_instance.instance_ip_address
}

output "project_id" {
  description = "The ID of the project in which the resource belongs."
  value       = var.project_id
}

output "instance_location" {
  description = "The location of the Filestore instance."
  value       = module.google_filestore_instance.location
}

output "share_name" {
  description = "The name of the file share."
  value       = module.google_filestore_instance.share_name
}

output "mount_point" {
  description = "The mount point of the Filestore instance."
  value       = module.google_filestore_instance.mount_point
}
