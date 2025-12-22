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
  instance_name = "terraform-blueprint-regional-kms-instance"
  location      = "us-central1"
  tier          = "REGIONAL"
  kms_key_name  = google_kms_crypto_key.filestore_key.id
  capacity_gb   = 1024
  share_name    = "share1"
  depends_on    = [google_kms_crypto_key_iam_member.filestore_key_iam]
}

resource "random_id" "keyring_suffix" {
  byte_length = 4
}

resource "google_kms_key_ring" "filestore_keyring" {
  project  = var.project_id
  name     = "filestore-keyring-${random_id.keyring_suffix.hex}"
  location = "us-central1"
}

resource "google_kms_crypto_key" "filestore_key" {
  name     = "filestore-key"
  key_ring = google_kms_key_ring.filestore_keyring.id
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_kms_crypto_key_iam_member" "filestore_key_iam" {
  crypto_key_id = google_kms_crypto_key.filestore_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@cloud-filer.iam.gserviceaccount.com"
}
