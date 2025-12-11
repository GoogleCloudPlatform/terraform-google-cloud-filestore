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

resource "google_filestore_instance" "default" {
  project      = var.project_id
  name         = var.instance_name
  location     = var.location
  tier         = var.tier
  protocol     = var.protocol
  kms_key_name = var.kms_key_name

  file_shares {
    capacity_gb = var.capacity_gb
    name        = var.share_name
    dynamic "nfs_export_options" {
      for_each = var.nfs_export_options
      content {
        ip_ranges   = nfs_export_options.value["ip_ranges"]
        access_mode = nfs_export_options.value["access_mode"]
        squash_mode = nfs_export_options.value["squash_mode"]
        anon_uid    = nfs_export_options.value["anon_uid"]
        anon_gid    = nfs_export_options.value["anon_gid"]
      }
    }
  }

  networks {
    network      = var.network
    modes        = var.network_modes
    connect_mode = var.connect_mode
  }
}
