FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:raspberrypi2 = " \
    file://raspberrypi2.cfg \
    file://0001-Add-bmp280-i2c-sensor.patch \
    file://0002-Add-GPIO-led.patch \
    "
