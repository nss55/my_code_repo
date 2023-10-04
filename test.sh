#!/bin/bash

ssd_disk=("/dev/sdb" "/dev/sdc" "/dev/sdd")

mount_points=("/mnt/my_disk-1" "/mnt/my_disk-2" "/mnt/my_disk-3")

# Get array length
length=${#ssd_disk[@]}

for ((i=0;i<$length; i++))

do
  disk_name="${ssd_disk[i]}"
  mount_point="${mount_points[i]}"

#we should format the disk to ext4
 sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard "$disk_name"
#create the mount point 
  sudo mkdir -p "$mount_point"
# Mount the disk
  sudo mount -o discard,defaults "$disk_name" "$mount_point"
#give permission to the directory
 sudo chmod a+w "$mount_point"
# Add the disk to /etc/fstab for automatic mounting on boot
  echo UUID=$(sudo blkid -s UUID -o value "$disk_name") "$mount_point" ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab
done
