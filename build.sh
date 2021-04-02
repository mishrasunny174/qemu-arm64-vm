#!/usr/bin/env bash

set -e

# generate the ssh key
if [ ! -f "./id_rsa" ]; then
  ssh-keygen -t rsa -f id_rsa -N ''
  cp id_rsa.pub authorized_keys
fi

# Download the debian 10 cloud image
if [ ! -f "./debian-10-arm64.qcow2" ]; then
  wget https://cdimage.debian.org/cdimage/openstack/current/debian-10-openstack-arm64.qcow2 -O debian10-arm64.qcow2
fi

# Download the qemu EFI firmware
if [ ! -f "./QEMU_EFI.fd" ]; then
  wget http://releases.linaro.org/components/kernel/uefi-linaro/16.02/release/qemu64/QEMU_EFI.fd -O QEMU_EFI.fd
fi

# copy ssh key inside the system image
tempdir=`mktemp -d`
qemu-img convert -O raw ./debian10-arm64.qcow2 debian10-arm64.raw
sudo mount -o loop,offset=106954752 ./debian10-arm64.raw $tempdir
sudo mkdir $tempdir/root/.ssh
sudo cp authorized_keys $tempdir/root/.ssh/
sudo umount $tempdir
qemu-img convert -O qcow2 debian10-arm64.raw ./debian-10-arm64.qcow2
qemu-img resize ./debian-10-arm64.qcow2 +10G
rm debian10-arm64.raw
rm debian10-arm64.qcow2
rmdir $tempdir
