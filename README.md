# Make VMWare 17 Workstation Pro work on Ubuntu 23.10

Either run the script "compile_modules.sh" or follow this guide step by step:

Feel free to improve my script if you want to do so

1.- Navigate to the directory /usr/lib/vmware/modules/source/
```
cd /usr/lib/vmware/modules/source/
```
2.- Uncompress VMWare modules as listed:
```
sudo tar xvf vmmon.tar
sudo tar xvf vmnet.tar
```
3.- Get inside the folder vmmon-only:
```
cd vmmon-only
cd include
```
4.- Open the file pgtbl.h and replace all the occurrences of pte_offset_map to pte_offset_kernel

5.- Get back to the main directory of vmmon-only and compile:
```
cd ..
sudo make
```
6.- Return to the main directory (/usr/lib/vmware/modules/source/)
```
cd ..
```
7.- Get inside the folder vmnet-only:
```
cd vmnet-only
```
8.- Open the file bridge.c and add the include "#include <net/gso.h>" bellow line 46

9.- Compile vmnet module:
```
sudo make
```
10.- Return to the main directory (/usr/lib/vmware/modules/source/) and execute:
```
cd ..
sudo cp vmmon.o /lib/modules/`uname -r`/kernel/drivers/misc/vmmon.ko
sudo cp vmnet.o /lib/modules/`uname -r`/kernel/drivers/misc/vmnet.ko
sudo depmod -a
sudo systemctl restart vmware.service
```
___
Sources:

https://communities.vmware.com/t5/VMware-Workstation-Pro/Cannot-compile-vmnet-kernel-module-on-kernel-6-4-10/td-p/2982156
https://communities.vmware.com/t5/Workstation-2023-Tech-Preview/Linux-Kernel-6-5-rc-vmmon-compile-fails/td-p/2981003
