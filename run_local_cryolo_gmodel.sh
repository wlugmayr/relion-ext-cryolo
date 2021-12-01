#!/bin/bash
#
# Written by Wolfgang Lugmayr <w.lugmayr@uke.de>
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
    echo "  --mdir          the original movie folder name (e.g. Movies or Micrographs)"
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
        -i | --mdir) MDIR="$2" ;;
        -t | --threshold) CRYOLO_THRES="$2" ;;
        -h | --help) HELP=1 ;;
        -v | --version) echo "$(basename $0) 1.3"; exit 4 ;;
    esac
    shift
done
if [ ${HELP} -eq 1 ]; then
    print_help $0
    exit 4
fi
# check gmodel files
check_file ${REC_CRYOLO_JSON}
check_file ${REC_CRYOLO_H5}

# run the job
echo "### start : $(date)  ###"

# run cryolo
${CRYOLOPATH}/bin/python \
    -u ${CRYOLOPATH}/bin/cryolo_gui.py \
    --ignore-gooey predict -c ${REC_CRYOLO_JSON} -w ${REC_CRYOLO_H5} \
    -i $(pwd)/${MDIR} -o 'predict_gmodel' \
    -t ${CRYOLO_THRES} -pbs '3' --gpu_fraction '1.0' -nc '-1' -mw '100' -sr '1.41'

# prepare for relion import
cp predict_gmodel/STAR/*.star ${MDIR}
echo "import in relion: ${DIR}${MDIR}/*.star" >>note.txt
echo " ++++" >>note.txt
echo "import in relion: ${DIR}${MDIR}/*.star"

touch RELION_JOB_EXIT_SUCCESS

echo "### end: $(date)  ###"

