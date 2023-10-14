#!/bin/bash

# Set your GCP project and instance group name
PROJECT_ID="noble-hydra-398406"
INSTANCE_GROUP_NAME="instance-group-1"

# Get the current number of instances in the instance group
current_instance_count=$(gcloud compute instance-groups list-instances $INSTANCE_GROUP_NAME --project $PROJECT_ID --format="value(NAME)" 2>/dev/null | wc -l)

# Check the current instance count
if [ $current_instance_count -eq 0 ]; then
  # If there are no instances, add instances to the instance group
  gcloud compute instance-groups managed update-autoscaling instance-group-1 --max-num-replicas=8 --min-num-replicas=3
  echo "Instances added to the instance group."
else
  # If there are already instances, set the instance group size to zero
  gcloud compute instance-groups managed update-autoscaling instance-group-1 --max-num-replicas=0 --min-num-replicas=0
  echo "Instances removed from the instance group."
fi
