#!/bin/bash  --login
# Yuan Sun, 2024-1-1, Manchester, UK
# This script is used to project1 case5 with with time-varying urban wall albedo
# cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case5
# bash case5_1.sh
# squeue -u yuansun
module load cray-python/3.9.13.1
export CESM_ROOT="/work/n02/n02/yuansun/cesm"
export CASE_SCRIPT="/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts"
export CASE_NAME="/work/n02/n02/yuansun/cesm/runs/RCase5_1"
export CASE_DOCS="CaseDocs"
export COMPSET=SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV
export RES=f09_g17
export PROJECT=n02-duicv
export MACH=archer2
export RESTART="/work/n02/n02/yuansun/cesm/archive/RCase5/rest/2100-01-01-00000"

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
./xmlchange RUN_STARTDATE=2100-01-01
./xmlchange NTASKS=256
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange DATM_CPLHIST_CASE="b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102"
./xmlchange DATM_CPLHIST_YR_ALIGN=2100
./xmlchange DATM_CPLHIST_YR_START=2100
./xmlchange DATM_CPLHIST_YR_END=2100
./xmlchange DATM_CPLHIST_DIR=/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370
./xmlchange NTHRDS=1
./case.setup
./preview_namelists

cd ${CASE_NAME}
cp ${RESTART}/* ${CASE_NAME}/run
echo "Dynamic_UrbanAlbedoWall = .true.">> user_nl_clm
echo "fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc' " >> user_nl_clm
echo "flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'" >> user_nl_clm
echo "maxpatch_pft = 17" >> user_nl_clm
echo "hist_empty_htapes = .true." >> user_nl_clm
echo "calc_human_stress_indices = 'ALL'" >> user_nl_clm
echo "hist_dov2xy = .false.,.true." >> user_nl_clm
echo "hist_type1d_pertape = 'LAND',' '" >> user_nl_clm
echo "hist_nhtfrq= 0,0" >> user_nl_clm
echo "hist_mfilt= 12,12" >> user_nl_clm
echo "hist_fincl1 = 'SWBGT_U','TSA_R', 'TG_U', 'TG_R', 'EFLX_LH_TOT_U', 'EFLX_LH_TOT_R', 'EFLXBUILD', 'FIRA_R','FIRA_U', 'FIRE_R', 'FIRE_U', 'FSA_R', 'FSA_U', 'FSH_U', 'FSH_R', 'FSM_R', 'FSM_U', 'TROOF_INNER', 'TSHDW_INNER', 'TSUNW_INNER','URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW','TREFMXAV_U','TREFMNAV_U', 'TREFMXAV_R', 'TREFMNAV_R', 'WASTEHEAT', " >> user_nl_clm
echo "hist_fincl2 = 'TROOF_INNER', 'TSHDW_INNER', 'TSUNW_INNER','WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'" >> user_nl_clm
echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
./preview_namelists
./case.setup --reset
./case.build
./preview_run
./case.submit