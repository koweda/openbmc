# Ventura Image configuration

# Enable mdio-tools for communication with the PHY chip
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    mdio-tools \
"

# Enable for run-time configurate the LT4232
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    ftdi-eeprom \
"

# Enable mbpoll for communicate with smart valve by modbus command
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    mbpoll \
"
# Monitor the GPIO on the system and take action.
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    phosphor-gpio-monitor \
"

# Enable for debug card function
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    phosphor-ipmi-ipmb \
    fb-ipmi-oem \
    obmc-phosphor-buttons-signals \
    obmc-phosphor-buttons-handler \
"

# Enable logger for sensor threshold event monitor
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    phosphor-sel-logger \
"

# Temporarily add plat-svc for gpio initialization
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    plat-svc \
"

OBMC_IMAGE_EXTRA_INSTALL:append = " \
    phosphor-state-manager \
"

# Create udev symbolic links for each Modbus device
OBMC_IMAGE_EXTRA_INSTALL:append = " \
    persistent-rs485-port-mapping \
"
