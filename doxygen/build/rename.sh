CURDIR=~/firmware
LOG_FILE=$CURDIR/doxyblock.log 
log()
{
	echo "===> $@" | tee -a ${LOGFILE}
}
INPUT=$CURDIR
for  zerozerodeux in $(find $INPUT -type f -name "*.002");do
	f=$(echo $zerozerodeux | sed 's/.002//')
	p=$(echo $zerozerodeux | sed 's!\(.*\)/.*!\1!')
        cp $zerozerodeux  $f	
done

log  "renaming done."
