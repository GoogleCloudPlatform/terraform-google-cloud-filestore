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

resource "google_filestore_instance" "active" {
  project  = var.project_id
  name     = var.instance_name
  location = var.active_location
  tier     = var.instance_tier

  file_shares {
    capacity_gb = var.instance_capacity_gb
    name        = var.share_name
  }

  networks {
    network = var.network
    modes   = ["MODE_IPV4"]
  }
}

resource "google_filestore_instance" "standby" {
  project  = var.project_id
  name     = "${var.instance_name}-standby"
  location = var.standby_location
  tier     = var.instance_tier

  file_shares {
    capacity_gb = var.instance_capacity_gb
    name        = var.share_name
  }

  networks {
    network = var.network
    modes   = ["MODE_IPV4"]
  }

  initial_replication {
    role = "STANDBY"
    replicas {
      # This establishes the link to the active source
      peer_instance = google_filestore_instance.active.id
    }
  }

  depends_on = [google_filestore_instance.active]
}
