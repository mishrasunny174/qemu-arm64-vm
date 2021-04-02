#!/usr/bin/env bash

set -e

qemu-system-aarch64 -m 2G -M virt -cpu max \
  -bios ./QEMU_EFI.fd \
  -drive if=none,file=debian-10-arm64.qcow2,id=hd0 -device virtio-blk-device,drive=hd0 \
  -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
  -nographic
