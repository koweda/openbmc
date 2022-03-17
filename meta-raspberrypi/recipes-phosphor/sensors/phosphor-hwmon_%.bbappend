FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

CHIPS = " \
        i2c@7e804000/bmp280@76 \
        "
        
ITEMSFMT = "soc/{0}.conf"
ITEMS = "${@compose_list(d, 'ITEMSFMT', 'CHIPS')}"

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE:${PN}:append = " ${@compose_list(d, 'ENVS', 'ITEMS')}"

