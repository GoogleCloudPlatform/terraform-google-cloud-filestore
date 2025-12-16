// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law-or-agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package basic_backup

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestBasicBackup(t *testing.T) {
	example := tft.NewTFBlueprintTest(t,
		tft.WithSetupPath("../setup"),
	)

	example.DefineVerify(func(assert *assert.Assertions) {
		example.DefaultVerify(assert)

		projectID := example.GetStringOutput("project_id")
		backupName := example.GetStringOutput("backup_name")
		instanceName := example.GetStringOutput("instance_name")
		backupLocation := example.GetStringOutput("backup_location")
		instanceLocation := example.GetStringOutput("instance_location")
		instanceIP := example.GetStringOutput("instance_ip_address")
		shareName := example.GetStringOutput("share_name")
		mountPoint := example.GetStringOutput("mount_point")

		assert.Equal("us-central1", backupLocation, "The snapshot location should be us-central1")
		backup := gcloud.Run(t, "filestore backups describe", gcloud.WithCommonArgs([]string{backupName, "--project", projectID, "--region", backupLocation, "--format", "json"})).Array()
		assert.Equal("share1", backup[0].Get("sourceFileShare").String(), "The backup source file share should be share1")
		assert.Equal("label1", backup[0].Get("labels.files").String(), "The backup should have the 'files' label")

		assert.Equal("terraform-blueprint-zonal-backup-instance", instanceName, "The instance name should be terraform-blueprint-zonal-backup-instance")
		assert.Equal("us-central1-b", instanceLocation, "The instance location should be us-central1-b")
		instance := gcloud.Run(t, "filestore instances describe", gcloud.WithCommonArgs([]string{instanceName, "--project", projectID, "--location", instanceLocation, "--format", "json"})).Array()
		assert.Equal("ZONAL", instance[0].Get("tier").String(), "The instance tier should be ZONAL")
		assert.Equal("1024", instance[0].Get("fileShares.0.capacityGb").String(), "The instance capacity should be 1024 GB")
		assert.Equal("share1", shareName, "The terraform output share name should be share1")
		assert.Equal("share1", instance[0].Get("fileShares.0.name").String(), "The gcloud instance share name should be share1")
		assert.Equal("default", instance[0].Get("networks.0.network").String(), "The instance should be attached to the default network")
		assert.Equal("MODE_IPV4", instance[0].Get("networks.0.modes.0").String(), "The instance should have MODE_IPV4 network mode")
		assert.Equal(fmt.Sprintf("%s:/%s", instanceIP, shareName), mountPoint, "The mount point should be correctly formatted.")
	})
	example.Test()
}
