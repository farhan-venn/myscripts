#!/usr/bin/env bash
#
# Copyright (C) 2019 nysascape
#
# Licensed under the Raphielscape Public License, Version 1.d (the "License");
# you may not use this file except in compliance with the License.
#
# Probably the 3rd bad apple coming
# Enviroment variables

# Export KERNELDIR as en environment-wide thingy
# We start in scripts, so like, don't clone things
KERNELDIR="$(pwd)"
SCRIPTS=${KERNELDIR}/kernelscripts
OUTDIR=${KERNELDIR}/out
COMPILER_TYPES=clang

# Pick your poison
export PATH="$TC_DIR/bin:$PATH"

if ! [ -d "$TC_DIR" ]; then
	echo "Neutron Clang not found! Downloading to $TC_DIR..."
	mkdir -p "$TC_DIR" && cd "$TC_DIR"
	curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
	bash ./antman -S
	bash ./antman --patch=glibc
	cd ../..
	if ! [ -d "$TC_DIR" ]; then
		echo "Cloning failed! Aborting..."
		exit 1
	fi
fi

cd "$TC_DIR" && bash ./antman -U && cd ../..

export COMPILER_STRING COMPILER_TYPE KERNELDIR SCRIPTS OUTDIR

git clone https://github.com/fabianonline/telegram.sh/ telegram

# Export Telegram.sh
TELEGRAM=${KERNELDIR}/telegram/telegram

export TELEGRAM JOBS
