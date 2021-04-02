# qemu-arm64-vm

This repository is a collection of scripts to create a debian 10 based aarch64 VM in qemu-system-aarch64. 

## Usage

- Run `build.sh` to download the debian image and the uefi firmware.

```bash
./build.sh
```

- Run `run.sh` to start the virtual machine.

```bash
./run.sh
```

- Now you can ssh into the virtual machine using the key generated by the `build.sh` script.

```bash
ssh -p2222 -i ./id_rsa root@localhost
```
