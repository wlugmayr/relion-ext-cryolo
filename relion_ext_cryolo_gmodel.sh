#!/bin/bash
#
# Written by Wolfgang Lugmayr <wolfgang.lugmayr@cssb-hamburg.de>
#
# You may use this software as allowed by the 2-Clause BSD License
# https://opensource.org/licenses/BSD-2-Clause
#

#-----------------------------------------------------------
print_help() {
    echo
    echo "$(basename $1) - Relion crYOLO external job wrapper"
    echo
    echo "usage: $(basename $1) args"
    echo "  --o             jobdir"
    echo "  --in_mics       MotionCorr/job???/corrected_micrographs.star"
    echo "  --threshold     crYOLO threshold (default 0.3)"
    echo "  --help          give this help"
    echo "  --version       show version number"
    echo
}

#-----------------------------------------------------------
check_file() {
    if [ ! -f ${1} ]; then
        echo "ERROR: ${1} does not exist"
        exit 1
    fi
}

# default values
HELP=0
CRYOLO_THRES='0.3'

# print help
if [ $# -eq 0 ]; then
    HELP=1
fi
# parse args
while [ $# -gt 0 ] ; do
    case $1 in
        -o | --o) DIR="$2" ;;
        -i | --in_mics) IN_MICS_STAR="$2" ;;
        -t | --threshold) CRYOLO_THRES="$2" ;;
        -h | --help) HELP=1 ;;
        -v | --version) echo "$(basename $0) 1.5"; exit 4 ;;
    esac
    shift
done
if [ ${HELP} -eq 1 ]; then
    print_help $0
    exit 4
fi

# prepare job
echo "preparing input movies"
cd ${DIR}
PREFIX=../..
relion_star_printtable ${PREFIX}/${IN_MICS_STAR} data_micrographs _rlnMicrographName >micnames.txt
MDIR=$(basename $(dirname $(head -1 micnames.txt)))
mkdir -p ${MDIR}
cd ${MDIR}
for f in $(cat ../micnames.txt); do
    cp -sn ${PREFIX}/../$f .
done
cd ..

# prepare, document and run job
echo "checking file REC_CRYOLO_SCRIPT"
check_file $REC_CRYOLO_SCRIPT

echo "$REC_CRYOLO_SCRIPT --o ${DIR} --mdir ${MDIR} --threshold ${CRYOLO_THRES}" >>note.txt
sbatch $REC_CRYOLO_SCRIPT --o ${DIR} --mdir ${MDIR} --threshold ${CRYOLO_THRES}

