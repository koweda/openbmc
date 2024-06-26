FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KBRANCH:evb-unleashed ?= "linux-6.6.y"

SRCREV_machine:evb-unleashed ?= "62e5ae5007ef14cf9b12da6520d50fe90079d8d4"

KBUILD_DEFCONFIG:evb-unleashed ?= "defconfig"

COMPATIBLE_MACHINE = "(freedom-u540|qemuriscv64|unmatched|evb-unleashed)"
