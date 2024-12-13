#!/bin/bash  --login
# Yuan Sun, 2024-3-10, Manchester, UK
# This script is used to project1 case0 with defualt urban albedo using 1 node
# cd /work/n02/n02/yuansun/shell_scripts/archive/project1/computation_performance
# bash cp_con_n1.sh
# squeue -u yuansun
module load cray-python/3.9.13.1
export CESM_ROOT="/work/n02/n02/yuansun/cesm"
export CASE_SCRIPT="/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_dyn_alb/cime/scripts"
export CASE_NAME="/work/n02/n02/yuansun/cesm/runs/cp_con_n1"
export CASE_DOCS="CaseDocs"
export COMPSET=SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV
export RES=f09_g17
export PROJECT=n02-duicv
export MACH=archer2
export RESTART="/work/n02/n02/yuansun/cesm/archive/20231213SpinUp/rest/2015-01-01-00000"

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
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange NTASKS=128
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=20
./xmlchange RESUBMIT=0
./xmlchange DATM_CPLHIST_CASE="b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102"
./xmlchange DATM_CPLHIST_YR_ALIGN=2015
./xmlchange DATM_CPLHIST_YR_START=2015
./xmlchange DATM_CPLHIST_YR_END=2035
./xmlchange DATM_CPLHIST_DIR=/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370
./xmlchange NTHRDS=1
./xmlchange RUN_TYPE=hybrid
./xmlchange RUN_REFDIR=${RESTART}
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_REFTOD=00000
./xmlchange GET_REFCASE=TRUE
./xmlchange RUN_REFCASE=20231213SpinUp
./case.setup
./preview_namelists

cd ${CASE_NAME}
echo "fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc' " >> user_nl_clm
echo "flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'" >> user_nl_clm
echo "maxpatch_pft = 17" >> user_nl_clm
echo "hist_empty_htapes = .true." >> user_nl_clm
echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
./preview_namelists
./case.setup --reset
./case.build
./preview_run
./case.submit