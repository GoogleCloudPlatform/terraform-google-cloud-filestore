/**
 * Copyright 2019 Google LLC
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

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 17.0"

  name              = "ci-cloud-filestore"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "storage-api.googleapis.com",
    "serviceusage.googleapis.com",
    "file.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}

data "external" "network_exists" {
  program = ["bash", "-c", "gcloud compute networks describe default --project=${module.project.project_id} --format='value(selfLink)' 2>/dev/null || echo ''"]
}

resource "google_compute_network" "default" {
  # Create the default network if it doesn't exist.
  # Using an external data source to gracefully check for existence.
  lifecycle {
    create_before_destroy = true
  }
  count                   = data.external.network_exists.result.stdout == "" ? 1 : 0
  project                 = module.project.project_id
  name                    = "default"
  auto_create_subnetworks = false
}
