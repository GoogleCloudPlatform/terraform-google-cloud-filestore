/**
 * Copyright 2026 Google LLC
 * ... (License Header)
 */

output "instance_name" {
  description = "The name of the active Filestore instance."
  value       = google_filestore_instance.active.name
}

output "active_mount_point" {
  description = "The mount point for the active instance."
  value       = format("%s:/%s", google_filestore_instance.active.networks[0].ip_addresses[0], google_filestore_instance.active.file_shares[0].name)
}

output "replica_instance_name" {
  description = "The name of the standby Filestore instance."
  value       = google_filestore_instance.standby.name
}

output "standby_mount_point" {
  description = "The mount point for the standby instance."
  value       = format("%s:/%s", google_filestore_instance.standby.networks[0].ip_addresses[0], google_filestore_instance.standby.file_shares[0].name)
}

output "project_id" {
  description = "The Google Cloud project ID."
  value       = var.project_id
}
