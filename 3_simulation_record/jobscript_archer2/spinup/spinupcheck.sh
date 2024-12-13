#!/bin/bash  --login
# Yuan Sun, 2024-03-20, Manchester, UK
# This script is used to check spinup stable status
# cd /work/n02/n02/yuansun/shell_scripts/archive/project1/spinup
# bash spinupcheck.sh
# squeue -u yuansun
module load cray-python/3.9.13.1
export CESM_ROOT="/work/n02/n02/yuansun/cesm"
export CASE_SCRIPT="/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_dyn_alb/cime/scripts"
export CASE_NAME="/work/n02/n02/yuansun/cesm/runs/spinupcheck"
export CASE_DOCS="CaseDocs"
export COMPSET=HIST_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV
export RES=f09_g17
export PROJECT=n02-duicv
export MACH=archer2
export RESTART="/work/n02/n02/yuansun/cesm/archive/csf3spinup/2005-01-01-00000"

if [ -d "${CASE_NAME}" ]; then
   rm -rf "${CASE_NAME}"
   echo "'${CASE_NAME}' exits but is deleted"
   echo "create a new case in '${CASE_NAME}'"
   cd ${CASE_SCRIPT}
   ./create_newcase --case ${CASE_NAME} --compset ${COMPSET} --res ${RES} --project ${PROJECT} --machine ${MACH}  --run-unsupported
else
   echo "create a new case in '${CASE_NAME}'"
   cd ${CASE_SCRIPT}
   ./create_newcase --case ${CASE_NAME} --compset ${COMPSET} --res ${RES} --project ${PROJECT} --machine ${MACH} --run-unsupported
fi

cd ${CASE_NAME}
./xmlchange RUN_STARTDATE=2005-01-01
./xmlchange NTASKS=256
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