#!/bin/bash

# set environment
#RAMDISK="../ramdisk/"
#RAMDISK="/home/royk/KernelDev/output/voodoo-initramfs/full-uncompressed/"
#RAMDISK="/home/royk/KernelDev/samsung_initramfs/froyo-t959uvjl5"
#CCTC="/home/royk/devlib/arm-2009q3/bin/arm-none-linux-gnueabi-"

. ~/KernelDev/Vibrant4G/devscripts/local_lib

# start off clean
echo "++++ Performing source code cleanup ++++"
make ARCH=arm clean

# Clean old modules
#echo "++++ Clean modules from ramdisk ${RAMDISK} ++++"
#rm ${RAMDISK}/lib/modules/*.ko
#echo "++++ RAMDisk size after modules clean up ++++"
#du -hs ${RAMDISK}

# Copy original modules
#echo "++++ Copy original modules ++++"
#cp -r ${ORIGINALMOD}/lib/modules/*.ko ${RAMDISK}/lib/modules/
#echo "++++ RAMDisk size after restoring original modules ++++"
#du -hs ${RAMDISK}

# prepare source to allow us building of modules first
echo "++++ Prepare to build modules ++++"
make -j8 ARCH=arm CROSS_COMPILE=$CCTC prepare

# build modules before kernel
echo "++++ Building modules ++++"
make -j8 ARCH=arm CROSS_COMPILE=$CCTC modules

# copy ready modules into ramdisk
#echo "++++ Copy modules to ramdisk ++++"
#find -name *.ko -exec cp -v {} $RAMDISK/lib/modules/ \;

# rebuild voodoo initramfs
#echo "++++ Rebuild initramfs ++++"
#../scripts/run_generate_initramfs.sh

#exit

# build kernel
#echo "++++ Build kernel ++++"
#make -j8 ARCH=arm CROSS_COMPILE=$CCTC 

# verify kernel is ready and of good size
#echo "++++ Verify zImage size ++++"
#ls -alh arch/arm/boot/zImage

# copy to update zip
#echo "++++ Copy zImage for flash update zip file ++++"
#cp arch/arm/boot/zImage /home/royk/KernelDev/update_zip/template/kernel_update/
