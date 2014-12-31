#!/bin/bash
cd "$(dirname "$0")/.."
root=$PWD
. environ
cd  build
SYSTEM="$(uname -s)"
case $SYSTEM in
Darwin)
	DEF_CONSTS="OSX_BLD,OSX_USB_BLD"
	export OSX_BLD="TRUE"
	export OSX_USB_BLD="TRUE";;
Linux)
	DEF_CONSTS="Linux";;	
*)
	DEF_CONSTS="OTHER";;
esac		
xbuild "/target:${2:-Clean;Compile}" /p:Configuration="${1:-Debug}" /p:RootDir=$root  /p:BUILD_NUMBER="0.0.1.abcd" /p:DefineConstants=$DEF_CONSTS build.mono.proj
