FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://bios-update"

PACKAGECONFIG:append = " eepromdevice-software-update"
PACKAGECONFIG:append = " i2cvr-software-update"
PACKAGECONFIG:append = " cpld-software-update"
PACKAGECONFIG:append = " bios-software-update"
RDEPENDS:${PN} += "bash"

do_install:append() {
    install -d ${D}/${sbindir}
    install -m 0755 ${UNPACKDIR}/bios-update ${D}/${sbindir}/
}
