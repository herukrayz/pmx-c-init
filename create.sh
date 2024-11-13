#!/bin/bash
# $1 = VM ID
# $2 = Image name
# $3 = Target Storage

qm create $1 --net0 virtio,bridge=vmbr0
qm importdisk $1 $2 $3
qm set $1 --scsihw virtio-scsi-pci --scsi0 $3:vm-$1-disk-0
qm set $1 --ide0 $3:cloudinit
qm set $1 --boot c --bootdisk scsi0
qm set $1 --serial0 socket --vga serial0
qm set $1 --ostype l26
qm set $1 --tablet 0
qm set $1 --agent enabled=1,fstrim_cloned_disks=1
qm template $1
