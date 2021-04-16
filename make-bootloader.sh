#!/bin/bash
:<<'RICHGOLD'
if [ -z "${ANDROID_BUILD_PATHS}" ]
then
	echo "Check environment variables..."
	exit 1
else
	figlet -ct "A40i:  Build bootloader."
fi
RICHGOLD


real_core=`cat /proc/cpuinfo | grep cores | wc -l`
let best_num=$real_core+$(printf %.0f `echo "$real_core*0.2"|bc`)

function clean_code()
{
	echo "---------------"
	echo "| clean code. |"
	echo "---------------"
	make distclean
}


DEFCONFIG="Bananapi_M2_Ultra_defconfig"

ARCH=arm 


if [ "$1" = "clean" ]; then
	clean_code
	exit 0
fi

if [ "$1" = "config" ]; then
	make ${DEFCONFIG}
	exit 0
fi

make -j${best_num}
