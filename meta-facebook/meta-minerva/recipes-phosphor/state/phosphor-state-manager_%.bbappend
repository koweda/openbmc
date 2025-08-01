FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
PACKAGECONFIG:append = " host-gpio"

CHASSIS_DEFAULT_TARGETS:remove = " \
    obmc-chassis-powerreset@{}.target.requires/phosphor-reset-chassis-on@{}.service \
    obmc-chassis-powerreset@{}.target.requires/phosphor-reset-chassis-running@{}.service \
    obmc-chassis-poweroff@{}.target.requires/obmc-power-stop@{}.service \
    obmc-chassis-poweron@{}.target.requires/obmc-power-start@{}.service \
"

RDEPENDS:${PN}:append = " bash"

RRECOMMENDS:${PN}-chassis:remove = " ${PN}-chassis-poweron-log"

SRC_URI:append:minerva = " \
    file://chassis-powercycle \
    file://chassis-powercycle@.service \
    "

do_install:append:minerva() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/*.service ${D}${systemd_system_unitdir}/

    install -d ${D}${libexecdir}/${PN}
    install -m 0755 ${UNPACKDIR}/chassis-powercycle ${D}${libexecdir}/${PN}/
}
