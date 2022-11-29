#!/bin/bash
# This script will increse the size of the LVM disk partition so that you can take advantage of additional space after increasing the virtual
# disk size either through virtualbox, openstack, or some other virtualization tool

if [ -z "$1" ] ; then
  echo "You must specify the disk device being extended, eg: /dev/sda or /dev/vda";
  echo "Example Usage: ./extend-lvm.sh /dev/sda";
  echo "Run 'fdisk -l' to see the existing devices and partitions. If there are more than one, this will also give you a clue as to which one has grown and needs to be modified";
  exit 1
fi
device=$1;

# Part 1 - Get the LVM physical and volume group info as well as partition info
#------------------------------------------------------------------------------

# Get the physical volume device and the volume group device
pvdevice=$(pvs | grep $device | awk ' { print $1; } ' | xargs);
vgdevice=$(pvs | grep $device | awk ' { print $2; } ' | xargs);

# Check if it is GPT or other partition (DOS) and set the fdisk type accordingly
disklabel_type=$(fdisk -l $device | grep -i disklabel | awk -F ":" ' { print $2; } ' | xargs);

# Set the partition type to be the GUID for LVM: (This will work for MBR/GPT and in EFI or non-EFI scenarios
partition_type="E6D6D379-F507-44C2-A23C-238F2A3DF928";

# Get the partition number of the physical volume device so that we can update that one with sfdisk in Part 2
# This command uses the built in bash search and replace tool ${string_to_search_and_replace/$string_to_find/$string_to_replace}
#   In this case, we do not have a "$string_to_replace" variable at the end, so it will just remove the search string
#   Eg: pvdevice=/dev/vda2; partition=/dev/vda  Result: partition_number="2" (/dev/vda stripped away)
partition_number=${pvdevice/$device/}

# Part 2 - resize the disk partition
# ----------------------------------
# This script pipes commands into the interactive sfdisk command so you do not have to interact with it
#   The -N# option specifies the partition we want to modify (eg: -N2 is the 2nd partition on the given device
#   sfdisk takes a command of the format: <start>,<size>,<type>[,<bootable>]
#   We can use "-" to just use the default (which is the current values for the partition), "+" can be used to specify max-available, "lvm" is a short form for lvm

# First we write to the disk with no changes, to make sure any paritition table inconsistencies are addressed
sfdisk $device -N${partition_number} --force << EOF
-,-,-
EOF

# Next, we write to the disk and increase the <size> to the max availabe (using the "+" sign)
sfdisk $device -N${partition_number} --force << EOF
-,+,$partition_type
EOF

# Force the kernel to probe the size of the partition:
partprobe

# Part 3 - resize LVM logical volume
# ----------------------------------

# Resize the physical volume
pvresize $pvdevice

# Get the logical volume path
lvpath=$(lvdisplay $vgdevice | grep "LV Path" | awk ' { print $3; } ' | xargs);

# Extend the logical volume
lvextend -l +100%FREE $lvpath

# resize the file system on the logical volume
resize2fs $lvpath

echo "Finished!"

