// Copyright 2026 Google LLC
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

package replication_instance

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestReplicationInstance(t *testing.T) {
	example := tft.NewTFBlueprintTest(t)

	example.DefineVerify(func(assert *assert.Assertions) {
		example.DefaultVerify(assert)

		projectID := example.GetStringOutput("project_id")

		activeName := example.GetStringOutput("active_instance_name")
		activeLocation := example.GetStringOutput("active_instance_location")
		activeTier := example.GetStringOutput("active_instance_tier")
		activeRole := example.GetStringOutput("active_replication_role")

		standbyName := example.GetStringOutput("standby_instance_name")
		standbyLocation := example.GetStringOutput("standby_instance_location")
		standbyTier := example.GetStringOutput("standby_instance_tier")
		standbyRole := example.GetStringOutput("standby_replication_role")

		capacity := example.GetStringOutput("instance_capacity_gb")

		// Verify Active Instance
		assert.Equal("ACTIVE", activeRole, "Active instance role should be ACTIVE")
		activeInstance := gcloud.Run(t, "filestore instances describe", gcloud.WithCommonArgs([]string{activeName, "--project", projectID, "--location", activeLocation, "--format", "json"})).Array()
		assert.Equal(activeTier, activeInstance[0].Get("tier").String(), "Active instance tier should match")
		assert.Equal(capacity, activeInstance[0].Get("fileShares.0.capacityGb").String(), "Active instance capacity should match")
		assert.Equal("default", activeInstance[0].Get("networks.0.network").String(), "Active instance network should be default")
		assert.Equal("ACTIVE", activeInstance[0].Get("replication.role").String(), "gcloud active instance role should be ACTIVE")

		// Verify Standby Instance
		assert.Equal("STANDBY", standbyRole, "Standby instance role should be STANDBY")
		standbyInstance := gcloud.Run(t, "filestore instances describe", gcloud.WithCommonArgs([]string{standbyName, "--project", projectID, "--location", standbyLocation, "--format", "json"})).Array()
		assert.Equal(standbyTier, standbyInstance[0].Get("tier").String(), "Standby instance tier should match")
		assert.Equal(capacity, standbyInstance[0].Get("fileShares.0.capacityGb").String(), "Standby instance capacity should match")
		assert.Equal("default", standbyInstance[0].Get("networks.0.network").String(), "Standby instance network should be default")
		assert.Equal("STANDBY", standbyInstance[0].Get("replication.role").String(), "gcloud standby instance role should be STANDBY")

		// Verify Tier and Capacity Match
		assert.Equal(activeTier, standbyTier, "Active and Standby tiers must match")
		assert.Equal(activeInstance[0].Get("fileShares.0.capacityGb").String(), standbyInstance[0].Get("fileShares.0.capacityGb").String(), "Active and Standby capacities must match")

		// Verify Replication Link
		activeInstanceID := fmt.Sprintf("projects/%s/locations/%s/instances/%s", projectID, activeLocation, activeName)
		assert.Equal(activeInstanceID, standbyInstance[0].Get("replication.replicas.0.peerInstance").String(), "Standby should point to the active instance")
	})
	example.Test()
}
