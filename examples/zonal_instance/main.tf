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
  instance_name = "terraform-blueprint-zonal-instance"
  location      = "us-central1-b"
  tier          = "ZONAL"
  capacity_gb   = 1024
  share_name    = "share1"
}
