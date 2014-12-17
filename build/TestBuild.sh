#!/bin/bash
cd "$(dirname "$0")/.."
root=$PWD
cd build
SYSTEM="$(uname -s)"
case $SYSTEM in
Darwin)
	DEF_CONSTS="OSX_USB_BLD,OSX_KBD_BLD,STRONG_NAME,MONO"
	export OSX_USB_BLD="TRUE"
	export OSX_KBD_BLD;;
Linux)
	DEF_CONSTS="Linux";;	
*)
	DEF_CONSTS="OTHER";;
esac		
#If a parameter is defined, then it will be used as the Configuration (defaulting to DebugMono)
xbuild "/target:${2-Clean;Compile}" /property:Configuration="${1-Debug}Mono" /property:RootDir=$root /property:BUILD_NUMBER="0.0.0.abcd" /p:DefineConstants=$DEF_CONSTS build.mono.proj
