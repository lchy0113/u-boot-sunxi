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

DEFCONFIG="Bananapi_M2_Ultra_defconfig"

ARCH=arm 

real_core=`cat /proc/cpuinfo | grep cores | wc -l`
let best_num=$real_core+$(printf %.0f `echo "$real_core*0.2"|bc`)

function func_clean()
{
	figlet -ct "clean code"
	make clean
	make distclean
}

function func_config()
{
	figlet -ct "config"
	make ARCH=${ARCH} ${DEFCONFIG}
}

function func_build()
{
	figlet -ct "build"
	if [ ! -f .config ]; then
		echo "....make ${DEFCONFIG}"
		make ARCh=${ARCH} ${DEFCONFIG}
	fi

	make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} -j${best_num}

}

function func_help()
{
	figlet -ct "help"
	echo "clean, build"
}

case $1 in
	clean)
		func_clean
		exit 0
		;;
	build)
		func_build
		exit 0
		;;
	*)
		func_help
		;;
esac

