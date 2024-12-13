#!/bin/bash  --login
#$ -P hpc-zz-aerosol
#$ -pe hpc.pe 640
# Yuan Sun, 2024-03-20, Manchester, UK
# This script is used to check spinup stable status
# cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/project1/spinup
# qsub spinup.sh
export HOME="/mnt/iusers01/fatpou01/sees01/a16404ys"
export CASE_SCRIPT="/mnt/iusers01/fatpou01/sees01/a16404ys/CESM/my_cesm_sandbox_2.1.4/cime/scripts"
export CASE_NAME="/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/spinupcheck"
export COMPSET=HIST_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV
export RES=f09_g17
export MACH=csf3
export RESTART="/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/csf3/project1/spinup/restart/2005-01-01-00000"
if [ -d "${CASE_NAME}" ]; then
   rm -rf "${CASE_NAME}"
   echo "'${CASE_NAME}' exits but is deleted"
   echo "create a new case in '${CASE_NAME}'"
   cd ${CASE_SCRIPT}
   ./create_newcase --case ${CASE_NAME} --compset ${COMPSET} --res ${RES} --machine ${MACH}  --run-unsupported
else
   echo "create a new case in '${CASE_NAME}'"
   cd ${CASE_SCRIPT}
   ./create_newcase --case ${CASE_NAME} --compset ${COMPSET} --res ${RES} --machine ${MACH} --run-unsupported
fi

cd ${CASE_NAME}
./xmlchange RUN_STARTDATE=2005-01-01
./xmlchange NTASKS=640
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=10
./xmlchange RESUBMIT=0
./xmlchange NTHRDS=1
./xmlchange RUN_TYPE=branch
./xmlchange RUN_REFDIR=${RESTART}
./xmlchange RUN_REFDATE=2005-01-01
./xmlchange RUN_REFTOD=00000
./xmlchange GET_REFCASE=TRUE
./xmlchange RUN_REFCASE=20231212spinup
./case.setup
./preview_namelists

cd ${CASE_NAME}
cp ${RESTART}/* ${CASE_NAME}/run
echo "hist_empty_htapes = .true.">> user_nl_clm
echo "hist_dov2xy = .true." >> user_nl_clm
echo "hist_type1d_pertape = ' '" >> user_nl_clm
echo "hist_nhtfrq= 0" >> user_nl_clm
echo "hist_mfilt= 12" >> user_nl_clm
echo "hist_fincl1 = 'FSH_U','EFLX_LH_TOT_U', 'TWS', 'H2OSOI', 'TSOI'" >> user_nl_clm
echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
echo "history_frequency = 100" >> user_nl_cism
./preview_namelists
./case.setup --reset
./case.build
./preview_run
./case.submit