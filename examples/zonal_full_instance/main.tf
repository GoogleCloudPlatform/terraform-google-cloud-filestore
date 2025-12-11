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

module "google_filestore_instance" {
  source = "../.."

  project_id    = var.project_id
  instance_name = "terraform-blueprint-zonal-full-instance"
  location      = "us-central1-b"
  tier          = "ZONAL"
  capacity_gb   = 2560
  share_name    = "share1"
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
