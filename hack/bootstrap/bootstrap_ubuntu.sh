#!/bin/bash

cleanup() {
    sudo umount $TMP
}
trap cleanup EXIT

TMP=$(mktemp -d -t image-XXXXXXXXXX)
echo mountpoint $TMP

source ./env

if [[ -z "${IMAGE}" ]]; then
    echo "IMAGE not set"
    exit 1
fi
echo "Image: " $IMAGE

OFFSET=$((`fdisk -lu $IMAGE 2> /dev/null | grep -P "2\s+\**\s+[0-9]+\s+[0-9]+\s+[0-9]+\s+[0-9]+" | sed 's/\*//g' | awk '{print $2}'`))
BLOCK=$((`fdisk -lu $IMAGE 2> /dev/null | grep "^Units" | awk -F"= " '{print $2}' | awk '{print $1}'`))

sudo mount -o loop,rw,sync,offset=$(($OFFSET * $BLOCK)) $(pwd)/$IMAGE $TMP

echo $TMP

cp ./assets/cloud-init/*.cfg $TMP/etc/cloud/cloud.cfg.d/

echo "Bootstrap success. Burn the image!"
