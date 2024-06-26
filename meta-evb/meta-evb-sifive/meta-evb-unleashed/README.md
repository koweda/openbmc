Convenience layer for building OpenBMC on SiFive HiFive Unleashed Board
================

This layer allows you to build OpenBMC for Unleashed in the SiFive BSP layer 
without having to manually configure bblayers.conf and local.conf.   

The Unleashed is a RISC-V Board made by SiFive. More information 
about the Unleashed can be found
[here](https://www.sifive.com/boards/hifive-unleashed).

## Build

Clone and Build the OpenBMC Image   
   ```
   git clone https://github.com/koweda/openbmc.git -b dev_scarthgap-unleashed 
   . setup evb-unleashed 
   bitbake obmc-phosphor-image 
   ```   
The Unleashed image is now located in   
`build/tmp/deploy/images/evb-unleashed/obmc-phosphor-image-evb-unleashed.rootfs.wic.xz`   
relative to your current directory.   

## QEMU

Run image on QEMU   
   ```
   #Create img file
   xzcat ./tmp/deploy/images/evb-unleashed/obmc-phosphor-image-evb-unleashed.rootfs.wic.xz | dd of=./obmc-phosphor-image-evb-unleashed.img bs=512K iflag=fullblock oflag=direct conv=fsync status=progress

   #Resize image 
   qemu-img resize obmc-phosphor-image-evb-unleashed.img 2G

   #Run 
   qemu-system-riscv64 -M sifive_u,msel=11 -smp 5 -m 8G \
   -display none -serial mon:stdio \
   -bios ./tmp/deploy/images/evb-unleashed/u-boot-spl.bin-evb-unleashed-2024.01-r0 \
   -drive file=./obmc-phosphor-image-evb-unleashed.img,format=raw,if=sd \
   -net nic \
   -net user,hostfwd=:127.0.0.1:2222-:22,hostfwd=:127.0.0.1:2443-:443,hostfwd=udp:127.0.0.1:2623-:623,hostname=qemu

   ```
It's will hang on the u-boot
   ```
U-Boot SPL 2024.01 (Jan 08 2024 - 15:37:48 +0000)
Trying to boot from MMC1


U-Boot 2024.01 (Jan 08 2024 - 15:37:48 +0000)

CPU:   rv64imafdc
Model: SiFive HiFive Unleashed A00
DRAM:  8 GiB
Core:  35 devices, 22 uclasses, devicetree: separate
MMC:   spi@10050000:mmc@0: 0
Loading Environment from SPIFlash... SF: Detected is25wp256 with page size 256 Bytes, erase size 4 KiB, total 32 MiB
*** Warning - bad CRC, using default environment

In:    serial@10010000
Out:   serial@10010000
Err:   serial@10010000
Net:   sifive-reset reset: failed to get cltx_reset reset
eth0: ethernet@10090000
Working FDT set to ff74a9c0
Hit any key to stop autoboot:  0
SF: Detected is25wp256 with page size 256 Bytes, erase size 4 KiB, total 32 MiB
device 0 offset 0x1fff000, size 0x1000
SF: 4096 bytes @ 0x1fff000 Read: OK
## Executing script at 8c100000
Wrong image format for "source" command
SCRIPT FAILED: continuing...
ethernet@10090000: PHY present at 0
ethernet@10090000: link up, 1000Mbps full-duplex (lpa: 0x7c00)
BOOTP broadcast 1
DHCP client bound to address 10.0.2.15 (1 ms)
Using ethernet@10090000 device
TFTP from server 10.0.2.2; our IP address is 10.0.2.15
Filename 'boot.scr.uimg'.
Load address: 0x8c100000
Loading: *
TFTP error: 'Access violation' (2)
Not retrying...
ethernet@10090000: PHY present at 0
ethernet@10090000: link up, 1000Mbps full-duplex (lpa: 0x7c00)
BOOTP broadcast 1
DHCP client bound to address 10.0.2.15 (0 ms)
Using ethernet@10090000 device
TFTP from server 10.0.2.2; our IP address is 10.0.2.15
Filename 'boot.scr.uimg'.
Load address: 0x84000000
Loading: *
TFTP error: 'Access violation' (2)
Not retrying...
=>

   ```
We need manual boot from mmc
   ```
   run mmc_boot
   ```
Now we can see openbmc is running on HiFive Unleashed QEMU!
   ```
Not retrying...
=> run mmc_boot
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:3...
Found /extlinux/extlinux.conf
Retrieving file: /extlinux/extlinux.conf
1:      OpenEmbedded-SiFive-HiFive-Unleashed
Retrieving file: /Image.gz
append: root=/dev/mmcblk0p4 rootfstype=ext4 rootwait console=ttySIF0,115200 earlycon
Retrieving file: /hifive-unleashed-a00.dtb
   Uncompressing Kernel Image
Moving Image from 0x84000000 to 0x80200000, end=8177c000
## Flattened Device Tree blob at 8c000000
   Booting using the fdt blob at 0x8c000000
Working FDT set to 8c000000
   Using Device Tree in place at 000000008c000000, end 000000008c004ee6
Working FDT set to 8c000000

Starting kernel ...

[    0.000000] Linux version 6.6.21-dirty-62e5ae5 (oe-user@oe-host) (riscv64-openbmc-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.42.0.20240216) #1 SMP Wed Mar  6 14:48:45 UTC 2024

.
.
.
[  OK  ] Started Fru Device.
         Starting Phosphor Inventory Manager...
         Starting Phosphor LED Group Management Daemon...
         Starting Phosphor Log Manager...
         Starting Phosphor Network Manager...
         Starting Phosphor DBus Service Discovery Manager...
         Starting Phosphor Settings Daemon...
         Starting OpenBMC Software Update Manager...
         Starting Phosphor Download Manager...
         Starting Phosphor Chassis0 State Manager...
         Starting Rsyslog config updater...
         Starting Telemetry...
         Starting Phosphor User Manager...
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started Name Service Cache Daemon.
[  OK  ] Started Getty on tty1.
[  OK  ] Started Serial Getty on ttySIF0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Finished Convert PAM config files.
[  OK  ] Started Fru Device.
[FAILED] Failed to start Enable Linux trace events in the boot loader.
See 'systemctl status trace-enable.service' for details.

Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) nodistro.0 evb-unleashed ttySIF0

evb-unleashed login: [   47.346237] audit: type=1334 audit(1709054805.960:8): prog-id=12 op=LOAD
[   47.350256] audit: type=1334 audit(1709054805.964:9): prog-id=13 op=LOAD
[   47.350561] audit: type=1334 audit(1709054805.968:10): prog-id=14 op=LOAD
[   51.690661] audit: type=1334 audit(1709054810.308:11): prog-id=15 op=LOAD
[   51.692396] audit: type=1334 audit(1709054810.312:12): prog-id=16 op=LOAD
[   51.697549] audit: type=1334 audit(1709054810.312:13): prog-id=17 op=LOAD
[   59.502520] audit: type=1334 audit(1719381057.815:14): prog-id=18 op=LOAD
[   61.411800] audit: type=1334 audit(1719381059.731:15): prog-id=18 op=UNLOAD
[   80.355201] audit: type=1334 audit(1719381078.675:16): prog-id=14 op=UNLOAD
[   80.355501] audit: type=1334 audit(1719381078.675:17): prog-id=13 op=UNLOAD
[   80.355748] audit: type=1334 audit(1719381078.675:18): prog-id=12 op=UNLOAD
[   89.751022] audit: type=1334 audit(1719381088.071:19): prog-id=15 op=UNLOAD
[   89.754064] audit: type=1334 audit(1719381088.071:20): prog-id=17 op=UNLOAD
[   89.754661] audit: type=1334 audit(1719381088.071:21): prog-id=16 op=UNLOAD

   ```