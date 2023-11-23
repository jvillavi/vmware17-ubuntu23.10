#!/bin/bash

cd /usr/lib/vmware/modules/source/
sudo rm -rf vmmon-only
sudo rm -rf vmnet-only

sudo tar xvf vmmon.tar
sudo tar xvf vmnet.tar

cd vmmon-only/include
sudo sed -i 's/pte_offset_map/pte_offset_kernel/g' pgtbl.h
cd ..
sudo make clean
sudo make
cd ..
cd vmnet-only
sudo sed -i '/#include <net\/ipv6.h>/a #include <net\/gso.h>' bridge.c
sudo make clean
sudo make

cd /usr/lib/vmware/modules/source/
sudo cp vmmon.o /lib/modules/`uname -r`/kernel/drivers/misc/vmmon.ko
sudo cp vmnet.o /lib/modules/`uname -r`/kernel/drivers/misc/vmnet.ko
sudo depmod -a
sudo systemctl restart vmware.service

