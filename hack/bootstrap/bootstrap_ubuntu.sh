#!/bin/bash

cleanup() {
    if [  -z "$TMP" ]; then
        echo "not mounted. No op"
    else
        if grep -qs "$TMP" /proc/mounts; then
           echo "unmount $TMP"
           sudo umount $TMP 
        fi
    fi
}

trap cleanup EXIT

if [ -f "./env" ]; then
     source ./env
else
    echo "./env file does not exists. create ./env file from env.example"
    exit 0
fi

if [ -f "$IMAGE" ]; then
    echo "Image to be used: " $IMAGE
else
    echo "$IMAGE variabe not set. Run 'make dowload-base' and export it for the script (add to ./env file)"
    exit 0
fi

CONFIG=$(pwd)/assets/cloud-init/60-synpse.cfg
if [ -f "$CONFIG" ]; then
    echo "config found. Using it"
else
    echo "$CONFIG file does not exists. create ./env file and run 'make generate'"
    exit 0
fi


TMP=$(mktemp -d -t image-XXXXXXXXXX)
echo mountpoint $TMP

OFFSET=$((`fdisk -lu $IMAGE 2> /dev/null | grep -P "2\s+\**\s+[0-9]+\s+[0-9]+\s+[0-9]+\s+[0-9]+" | sed 's/\*//g' | awk '{print $2}'`))
BLOCK=$((`fdisk -lu $IMAGE 2> /dev/null | grep "^Units" | awk -F"= " '{print $2}' | awk '{print $1}'`))

sudo mount -o loop,rw,sync,offset=$(($OFFSET * $BLOCK)) $IMAGE $TMP

cp ./assets/cloud-init/*.cfg $TMP/etc/cloud/cloud.cfg.d/

echo "Bootstrap success. Burn the image $IMAGE !"
