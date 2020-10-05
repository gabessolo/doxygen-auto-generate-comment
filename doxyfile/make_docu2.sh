#!/bin/sh
# make_docu.sh - script to generate doxygen documentation
CURDIR=../../doxyfile
CONFIG_FILE=$CURDIR/config.doxygen 
log()
{
	echo "===> $@" | tee -a ${LOGFILE}
}
log "doxyfile started OK."
DOXYGEN_INPUT_DIRECTORY=$CURDIR/../../firmware
#DOXYGEN_INPUT_DIRECTORY=/home/gaetana/doxygen-auto-generate-comment/doxygen/build/generated_src
#DOXYGEN_INPUT_FILE=$CURDIR/../../firmware/src/clamavd/clamavd.c
DOXYGEN_INPUT_FILE=/home/gaetana/doxygen-auto-generate-comment/doxygen/build/generated_src/code.cpp
DOXYGEN_OUTPUT_DIRECTORY=$CURDIR
DOXYGEN_SCRIPT_DIR=$CURDIR/../doxygen/script
DOXYGEN_OUTPUT_AUTO_GENERATE_DIR=$CURDIR
DOXYGEN_OUTPUT_UNDOCUMENTED_DIR=$CURDIR
EXCLUDE=/home/gaetana/firmware/contrib/ 
EXCLUDE+= /home/gaetana/firmware/crossplatform/contrib/cunit/patches/ 
EXCLUDE+= /home/gaetana/firmware/crossplatform/contrib/cunit/templates/


log "clean  previous undocumented.txt file"
rm  $DOXYGEN_OUTPUT_AUTO_GENERATE_DIR/undocumented.txt
OUTPUT_AUTO_GENERATE_DIR=$DOXYGEN_OUTPUT_AUTO_GENERATE_DIR OUTPUT_DIRECTORY=$DOXYGEN_OUTPUT_DIRECTORY \
	INPUT=$DOXYGEN_INPUT_DIRECTORY  OUTPUT_UNDOCUMENTED_DIR=$DOXYGEN_OUTPUT_UNDOCUMENTED_DIR  
	EXCLUDE=$(EXCLUDE) doxygen  $CONFIG_FILE 

#log "copy previous results"
#cp  $DOXYGEN_INPUT_DIRECTORY/*.c  $DOXYGEN_OUTPUT_AUTO_GENERATE_DIR
#cp  $DOXYGEN_INPUT_DIRECTORY/*.h  $DOXYGEN_OUTPUT_AUTO_GENERATE_DIR
#cp  $DOXYGEN_INPUT_DIRECTORY/*.001  $DOXYGEN_OUTPUT_AUTO_GENERATE_DIR
#cp  $DOXYGEN_INPUT_DIRECTORY/*.002  $DOXYGEN_OUTPUT_AUTO_GENERATE_DIR

#log "clean  results in input directory"
#rm  $DOXYGEN_INPUT_DIRECTORY/*.001
#rm  $DOXYGEN_INPUT_DIRECTORY/*.002

if [ "$?" -eq "0" ];then
	cp $CURDIR/config.doxygen $DOXYGEN_SCRIPT_DIR
	cp $CURDIR/make_docu2.sh   $DOXYGEN_SCRIPT_DIR
	log "copy make_docu.sh  config.doxygen into "$DOXYGEN_SCRIPT_DIR
	log "doxygen done."

else
	log "doxygen error."
fi
