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
  value       = google_filestore_instance.default.id
}

output "instance_name" {
  description = "The name of the Filestore instance."
  value       = google_filestore_instance.default.name
}

output "instance_ip_address" {
  description = "The IP address of the Filestore instance."
  value       = google_filestore_instance.default.networks[0].ip_addresses[0]
}

output "kms_key_name" {
  description = "The name of the KMS key used to encrypt the Filestore instance."
  value       = var.kms_key_name
}

output "location" {
  description = "The location of the Filestore instance."
  value       = var.location
}

output "share_name" {
  description = "The name of the file share."
  value       = var.share_name
}

output "mount_point" {
  description = "The mount point of the Filestore instance."
  value       = format("%s:/%s", google_filestore_instance.default.networks[0].ip_addresses[0], var.share_name)
}
