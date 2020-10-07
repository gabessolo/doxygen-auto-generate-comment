#!/bin/sh
# make_docu.sh - script to generate doxygen documentation

CURDIR=../../doxyfile
LOG_FILE=$CURDIR/doxyblock.log 
log()
{
	echo "===> $@" | tee -a ${LOGFILE}
}
log "clean previous results : *.001 , *.002 , undocumented.txt"
. ./clean.sh

CONFIG_FILE=$CURDIR/config.doxygen 
log "doxyfile started OK."
DOXYGEN_INPUT_DIRECTORY=/home/gaetana/firmware
#DOXYGEN_INPUT_DIRECTORY=/home/gaetana/doxygen-auto-generate-comment/doxygen/build/generated_src
#DOXYGEN_INPUT_FILE=$CURDIR/../../firmware/src/clamavd/clamavd.c
#DOXYGEN_INPUT_DIRECTORY=/home/gaetana/firmware/crossplatform/lib/libncore++/
DOXYGEN_INPUT_FILE=/home/gaetana/firmware/crossplatform/lib/libncore++/
DOXYGEN_OUTPUT_DIRECTORY=$CURDIR
DOXYGEN_SCRIPT_DIR=$CURDIR/../doxygen/script
DOXYGEN_OUTPUT_AUTO_GENERATE_DIR=$CURDIR
DOXYGEN_OUTPUT_UNDOCUMENTED_DIR=$CURDIR
DOXYGEN_EXCLUDE_PATTERNS=*/contrib/* 
DOXYGEN_EXCLUDE=/home/gaetana/firmware/crossplatform/lib/libncore++/

OUTPUT_AUTO_GENERATE_DIR=$DOXYGEN_OUTPUT_AUTO_GENERATE_DIR OUTPUT_DIRECTORY=$DOXYGEN_OUTPUT_DIRECTORY INPUT=$DOXYGEN_INPUT_DIRECTORY  OUTPUT_UNDOCUMENTED_DIR=$DOXYGEN_OUTPUT_UNDOCUMENTED_DIR \
       	EXCLUDE_PATTERNS=$DOXYGEN_EXCLUDE_PATTERNS   EXCLUDE=$DOXYGEN_EXCLUDE\
	doxygen  $CONFIG_FILE 


if [ "$?" -eq "0" ];then
	cp $CURDIR/config.doxygen $DOXYGEN_SCRIPT_DIR
	cp $CURDIR/make_docu2.sh   $DOXYGEN_SCRIPT_DIR
	log "copy make_docu.sh  config.doxygen into "$DOXYGEN_SCRIPT_DIR
	log "doxygen done."
        . ./rename.sh
else
	log "doxygen error."
fi
