// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package full_snapshot

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestFullSnapshot(t *testing.T) {
	example := tft.NewTFBlueprintTest(t)

	example.DefineVerify(func(assert *assert.Assertions) {
		example.DefaultVerify(assert)

		projectID := example.GetStringOutput("project_id")
		snapshotName := example.GetStringOutput("snapshot_name")
		instanceName := example.GetStringOutput("source_instance_name")
		snapshotLocation := example.GetStringOutput("snapshot_location")
		instanceLocation := example.GetStringOutput("instance_location")
		instanceIP := example.GetStringOutput("instance_ip_address")
		shareName := example.GetStringOutput("share_name")
		mountPoint := example.GetStringOutput("mount_point")

		assert.Equal("us-central1", snapshotLocation, "The snapshot location should be us-central1")
		snapshot := gcloud.Run(t, "filestore instances snapshots describe", gcloud.WithCommonArgs([]string{snapshotName, "--project", projectID, "--instance", instanceName, "--instance-location", instanceLocation, "--format", "json"})).Array()
		assert.Equal("READY", snapshot[0].Get("state").String(), "The snapshot should be in the READY state")
		assert.Equal("This is a test snapshot.", snapshot[0].Get("description").String(), "The snapshot should have the correct description")
		assert.Equal("value", snapshot[0].Get("labels.my_label").String(), "The snapshot should have the 'my_label' label")

		assert.Equal("terraform-blueprint-full-snapshot-instance", instanceName, "The instance name should be terraform-blueprint-full-snapshot-instance")
		assert.Equal("us-central1", instanceLocation, "The instance location should be us-central1")
		instance := gcloud.Run(t, "filestore instances describe", gcloud.WithCommonArgs([]string{instanceName, "--project", projectID, "--location", instanceLocation, "--format", "json"})).Array()
		assert.Equal("REGIONAL", instance[0].Get("tier").String(), "The instance tier should be ZONAL")
		assert.Equal("1024", instance[0].Get("fileShares.0.capacityGb").String(), "The instance capacity should be 1024 GB")
		assert.Equal("share1", shareName, "The terraform output share name should be share1")
		assert.Equal("share1", instance[0].Get("fileShares.0.name").String(), "The gcloud instance share name should be share1")
		assert.Equal("default", instance[0].Get("networks.0.network").String(), "The instance should be attached to the default network")
		assert.Equal("MODE_IPV4", instance[0].Get("networks.0.modes.0").String(), "The instance should have MODE_IPV4 network mode")
		assert.Equal(fmt.Sprintf("%s:/%s", instanceIP, shareName), mountPoint, "The mount point should be correctly formatted.")
	})
	example.Test()
}
