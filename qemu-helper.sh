#!/bin/bash

echo "Do you want to Create or Launch a VM?"
read mode

echo "Image name"
read name

echo "Select VM RAM"
read ram

echo "Enter VM CPU cores"
read cores

if [ ! "$(which qemu-img)" ]; then
	echo -e "Qemu is not installed. Don't worry installing it now."
	#Installs qemu
  apt-get install qemu-kvm qemu -y
  echo "\nInstalled Qemu\n"
fi

if [[ $mode == "Launch" ]]; then
qemu-system-x86_64 -hda $name -m $ram -smp $cores

else 

echo "Seledct image type (.qcow or .img)"
read img_ty

echo "VM Storage in GB e.g. 20G WITH G"
read size


if [[ $img_ty == ".qcow" ]]; then
echo "Creating Image"
qemu-img create -f qcow2 $name $size
fi

if [[ $img_ty == ".img" ]]; then
echo "Created image"
qemu-img create $name $size
fi

echo ".iso name"
read iso_name

echo "Creating VM"
qemu-system-x86_64 -hda $name -boot d -cdrom $iso_name -m $ram -smp $cores

fi
