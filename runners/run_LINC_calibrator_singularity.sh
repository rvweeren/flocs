# Update these variables to reflect your environment.
TMPDIR=$PWD
## WORKDIR is where all the other directories will be stored.
WORKDIR=$(mktemp -d -p "$TMPDIR")
echo $WORKDIR
## Location of LINC. This must be a user-writable location for this wrapper script.
## If it does not exist, this script will attempt to clone the LINC repository to the given path.
LINC_DATA_ROOT=$WORKDIR/LINC
#LINC_DATA_ROOT=/data2/sweijen/Quasar_Anniek/LINC_calibrator/LINC

DATADIR=/path/to/data

# Add any directory that should be accessible during the run here as a comma-separated list.
BINDPATHS=/data1,/data2,$PWD

## Final results will be copied here.
RESULTSDIR=$WORKDIR/results_LINC_calibrator/
## Logs of the various steps will be put here.
LOGSDIR=$WORKDIR/logs_LINC_calibrator/
## Temporary files are stored here.
## The trailing slash is important here.
TMPDIR=$WORKDIR/tmpdir_LINC_calibrator/

#SIMG=/net/lofar1/data1/sweijen/software/LOFAR/singularity/lofar_sksp_v4.0.0_cascadelake_cascadelake_avx512_mkl_cuda_ddf.sif
SIMG=/path/to/singularity/container.sif

# Update these variables to tune performance.
## Limit the number of DP3 processes running simultaneously to this amount.
MAX_DP3_PROCS=8

CORES_MACHINE=`nproc`
CORES_CALIBCAL=$(($CORES_MACHINE/$MAX_DP3_PROCS))
CORES_PREDICT=$(($CORES_MACHINE/$MAX_DP3_PROCS))

#
# Do not update below this line
#
export LINC_DATA_ROOT
# Check if LINC directory exists or is valid.
if [ ! -d $LINC_DATA_ROOT ]; then
    echo $LINC_DATA_ROOT does not exist and will be created. Cloning LINC...
    mkdir -p $LINC_DATA_ROOT
    git clone https://git.astron.nl/RD/LINC.git $LINC_DATA_ROOT
    cd $LINC_DATA_ROOT && git checkout d4741f0
    cd $WORKDIR
fi
# If the directory exists, check if it is empty.
if [ -d $LINC_DATA_ROOT ] && [ ! -d $LINC_DATA_ROOT/steps ]; then
    echo $LINC_DATA_ROOT exists, but is empty. Cloning LINC...
    git clone https://git.astron.nl/RD/LINC.git $LINC_DATA_ROOT
    cd $LINC_DATA_ROOT && git checkout d4741f0
    cd $WORKDIR
fi
# If the directory is not empty, check if it contains LINC
if [ -d $LINC_DATA_ROOT ] && [ ! -d $LINC_DATA_ROOT/steps ]; then
    echo WARNING: $LINC_DATA_ROOT is not empty, but required LINC folders are not found.
    exit 1
elif [ -d $LINC_DATA_ROOT ] && [ -d $LINC_DATA_ROOT/steps ]; then
    echo $LINC_DATA_ROOT exists and seems to contain LINC. Continueing...
fi

# Prepare workflow files.
echo Overriding workflow core requirements with user settings.
#sed -i "s/coresMin: [0-9]*/coresMin: $CORES_CALIBCAL/" $LINC_DATA_ROOT/steps/ddecal.cwl
#sed -i "s/coresMin: [0-9]*/coresMin: $CORES_PREDICT/" $LINC_DATA_ROOT/steps/predict.cwl
echo Making sure all scripts are executable
chmod 755 $LINC_DATA_ROOT/scripts/*.py
echo Making sure all shebang lines use /usr/bin/env python instead of /usr/bin/env
for f in $LINC_DATA_ROOT/scripts/*.py; do
    sed -i "s?\#\!/usr/bin/python?\#\!/usr/bin/env python?" $f
done

# Pass along necessary variables to the container.
export APPTAINERENV_LINC_DATA_ROOT=$LINC_DATA_ROOT
export APPTAINERENV_RESULTSDIR=$WORKDIR/results_LINC_calibrator/
export APPTAINERENV_LOGSDIR=$WORKDIR/logs_LINC_calibrator/
export APPTAINERENV_TMPDIR=$WORKDIR/tmpdir_LINC_calibrator/
export APPTAINERENV_PREPEND_PATH=$LINC_DATA_ROOT/scripts

mkdir -p $RESULTSDIR
mkdir -p $LOGSDIR
mkdir -p $TMPDIR
cd $WORKDIR

wget https://raw.githubusercontent.com/tikk3r/lofar-grid-hpccloud/fedora-py3/runners/create_ms_list.py
singularity exec -B $PWD,$BINDPATHS $SIMG python create_ms_list.py $DATADIR

echo LINC starting
# Singularity doesn't seem to pass this along through APPTAINERENV_PREPEND, so create another little wrapper here to ensure it gets added.
echo export PYTHONPATH=\$LINC_DATA_ROOT/scripts:\$PYTHONPATH > tmprunner.sh
echo cwltool --parallel --preserve-entire-environment --no-container --tmpdir-prefix=$TMPDIR --outdir=$RESULTSDIR --log-dir=$LOGSDIR $LINC_DATA_ROOT/workflows/HBA_calibrator.cwl mslist.json >> tmprunner.sh
time singularity exec -B $PWD,$BINDPATHS $SIMG bash tmprunner.sh
echo LINC ended