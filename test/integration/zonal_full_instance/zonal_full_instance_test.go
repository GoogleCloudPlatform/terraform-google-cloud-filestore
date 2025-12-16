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

package zonal_full_instance

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestZonalFullInstance(t *testing.T) {
	example := tft.NewTFBlueprintTest(t)

	example.DefineVerify(func(assert *assert.Assertions) {
		example.DefaultVerify(assert)

		projectID := example.GetStringOutput("project_id")
		instanceName := example.GetStringOutput("instance_name")
		instanceLocation := example.GetStringOutput("instance_location")
		instanceIP := example.GetStringOutput("instance_ip_address")
		shareName := example.GetStringOutput("share_name")
		mountPoint := example.GetStringOutput("mount_point")

		assert.Equal("terraform-blueprint-zonal-full-instance", instanceName, "The instance name should be terraform-blueprint-zonal-full-instance")
		assert.Equal("us-central1-b", instanceLocation, "The instance location should be us-central1-b")
		instance := gcloud.Run(t, "filestore instances describe", gcloud.WithCommonArgs([]string{instanceName, "--project", projectID, "--location", instanceLocation, "--format", "json"})).Array()
		assert.Equal("2560", instance[0].Get("fileShares.0.capacityGb").String(), "The instance capacity should be 2560 GB")
		assert.Equal("share1", shareName, "The terraform output share name should be share1")
		assert.Equal("READ_WRITE", instance[0].Get("fileShares.0.nfsExportOptions.0.accessMode").String(), "The first NFS export option should have READ_WRITE access mode")
		assert.Equal("NO_ROOT_SQUASH", instance[0].Get("fileShares.0.nfsExportOptions.0.squashMode").String(), "The first NFS export option should have NO_ROOT_SQUASH squash mode")
		assert.Equal("10.0.0.0/24", instance[0].Get("fileShares.0.nfsExportOptions.0.ipRanges.0").String(), "The first NFS export option should have the correct IP range")
		assert.Equal("READ_ONLY", instance[0].Get("fileShares.0.nfsExportOptions.1.accessMode").String(), "The second NFS export option should have READ_ONLY access mode")
		assert.Equal("ROOT_SQUASH", instance[0].Get("fileShares.0.nfsExportOptions.1.squashMode").String(), "The second NFS export option should have ROOT_SQUASH squash mode")
		assert.Equal("10.10.0.0/24", instance[0].Get("fileShares.0.nfsExportOptions.1.ipRanges.0").String(), "The second NFS export option should have the correct IP range")
		assert.Equal("MODE_IPV4", instance[0].Get("networks.0.modes.0").String(), "The instance should have MODE_IPV4 network mode")
		assert.Equal(fmt.Sprintf("%s:/%s", instanceIP, shareName), mountPoint, "The mount point should be correctly formatted.")
	})
	example.Test()
}
