SUMMARY = "XDMCP: X Display Manager Control Protocol library"

DESCRIPTION = "The purpose of the X Display Manager Control Protocol \
(XDMCP) is to provide a uniform mechanism for an autonomous display to \
request login service from a remote host. An X terminal (screen, \
keyboard, mouse, processor, network interface) is a prime example of an \
autonomous display."

require xorg-lib-common.inc

inherit gettext

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=d559fb26e129626022e052a5e6e0e123"

DEPENDS += "xorgproto"
PROVIDES = "xdmcp"

PE = "1"

XORG_PN = "libXdmcp"

BBCLASSEXTEND = "native nativesdk"

SRC_URI[sha256sum] = "d8a5222828c3adab70adf69a5583f1d32eb5ece04304f7f8392b6a353aa2228c"

PACKAGECONFIG ??= ""
PACKAGECONFIG[arc4] = "ac_cv_lib_bsd_arc4random_buf=yes,ac_cv_lib_bsd_arc4random_buf=no,libbsd"
