#!/bin/bash  --login
#$ -cwd
#$ -P hpc-zz-aerosol
#$ -pe hpc.pe 128
# Yuan Sun, 2023-12-18, Manchester, UK
# This script is used to project1 case0 with default urban albedo in csf3
# case1: roof albedo 0.9
# fault: the surface data is not true, should not all urban abledo is 0.9 but only roof albedo is 0.9 
# cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/project1/case1
# qsub case1_test.sh

export HOME="/mnt/iusers01/fatpou01/sees01/a16404ys"
export CASE_SCRIPT="/mnt/iusers01/fatpou01/sees01/a16404ys/CESM/my_cesm_sandbox_2.1.4/cime/scripts"
export CASE_NAME="/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/case1_test"
#export COMPSET=SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV
export COMPSET=SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV
export RES=f09_g17
export MACH=csf3
export RESTART="/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231212spinup/run"
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
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange NTASKS=128
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange DATM_CPLHIST_CASE="b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102"
./xmlchange DATM_CPLHIST_YR_ALIGN=2015
./xmlchange DATM_CPLHIST_YR_START=2015
./xmlchange DATM_CPLHIST_YR_END=2100
./xmlchange DATM_CPLHIST_DIR=/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/initializationfromBowen/hist.mon
./xmlchange NTHRDS=1
./xmlchange JOB_WALLCLOCK_TIME=96:00:00
./case.setup
./preview_namelists

cd ${CASE_NAME}
cp ${RESTART}/* ${CASE_NAME}/run
echo "fsurdat = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/project1/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c231229_roofalbedo0.9.nc' " >> user_nl_clm
echo "flanduse_timeseries = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'" >> user_nl_clm
echo "maxpatch_pft = 17" >> user_nl_clm
echo "hist_empty_htapes = .true." >> user_nl_clm
echo "calc_human_stress_indices = 'ALL'" >> user_nl_clm
echo "hist_dov2xy = .false.,.true." >> user_nl_clm
echo "hist_type1d_pertape = 'LAND',' '" >> user_nl_clm
echo "hist_nhtfrq= 0,0" >> user_nl_clm
echo "hist_mfilt= 12,12" >> user_nl_clm
echo "hist_fincl1 = 'URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW','TREFMXAV_U','TREFMNAV_U', 'TREFMXAV_R', 'TREFMNAV_R', 'WASTEHEAT', 'HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U'" >> user_nl_clm
echo "hist_fincl2 = 'WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'" >> user_nl_clm
echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
./preview_namelists
./case.setup --reset
./case.build
./preview_run
./case.submit