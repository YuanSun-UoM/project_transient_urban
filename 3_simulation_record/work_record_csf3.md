## Log in

```
ssh a16404ys@csf3.itservices.manchester.ac.uk
Sunyuan531521!

# hpc pool:https://ri.itservices.manchester.ac.uk/csf3/hpc-pool/jobs/
A job should request between 128 and 1024 cores (inclusive) in multiples of 32.
A compute node has 32 cores (2 x 16-core sockets), 192GB RAM giving 6GB per core. However, only the the total memory usage is limited – your app may allocate memory as it sees fit (e.g., MPI rank 0 may allocate a lot more than other worker ranks), up to the 192GB per-node limit.
The maximum job runtime in the HPC Pool is 4 days.
```

## Data transfer

### Upload from PC to csf3

- input data
- Restart data

```
# PC terminal
scp -r ~/Desktop/2035-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231127Case0_3/run
```

### Downlod from csf3 to PC

```
# PC terminal
scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231203Case1/run/20231203Case1.clm2.h1.2062-02-01-00000.nc ~/Desktop/CaseOutput
```

### Transfer from csf3 to archer2

- /work/n02/n02/yuansun/ 的存储容量有限，大型数据应下载到/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun （RDS）

```
# PC terminal中输入以下命令，因为mac已经在archer2的账户中验证了秘钥；
scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/case/lnd/hist/20231203Case1.clm2.h1.2064-02-01-00000.nc yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/project1/

# 将文件传输到/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370
# scp 类似于下载的速度 10MB/s

scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/initializationfromBowen/hist.mon/b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1hi.2088-01.nc yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370

# 将已经下载到/work/n02/n02/yuansun/cesm/cesm_inputdata/CPLHIST/SSP370/中的文件复制到/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370
# 复制还是蛮快的
cp /work/n02/n02/yuansun/cesm/cesm_inputdata/CPLHIST/SSP370/* /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370/ 

-----------更新：/work/n02/n02/yuansun/上的存储空间不够，会报错scp fail；通过df命令查看磁盘空间-----------
df -h /work/n02/n02/yuansun/
Filesystem                                       Size  Used Avail Use% Mounted on
10.253.102.2@o2ib1:10.253.102.3@o2ib1:/cls01097  806T  806T     0 100% /mnt/lustre/a2fs-work2

-----------更新：并非直接在csf3上操作，而是在pc上操作-------------------
# 将csf3上的atm驱动数据传到archer2
# 需要输入csf3的密码和2-factor 验证
# csf3 terminal
qrsh -l short -l mem512
scp /mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/initializationfromBowen/hist.mon/b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1d.2015-01.nc yuansun@login.archer2.ac.uk:/work/n02/n02/yuansun/cesm/cesm_inputdata/CPLHIST/SSP370
# return error:
Warning: Permanently added 'login.archer2.ac.uk,193.62.216.44' (ECDSA) to the list of known hosts.
Permission denied (publickey).
```

### Download from Globus

```
--------------更新:并非直接在csf3上建立endpoint,而是将软件装在linux系统上并mount csf3的文件目录，详见workstation_record--------------
--------------更新:以下方式没有先安装Globus所以无法运行; 安装方式：https://docs.globus.org/globus-connect-personal/install/linux/--------------
module load apps/binapps/anaconda3/2023.09
source activate yuanenv
pip install --isolated --log pip.log globus-cli
source deactivate yuanenv

globus endpoint create Yuan_csf3
# Message:     Endpoint created successfully
# Endpoint ID: c3f2713c-943a-11ee-8c89-fd88ce9321ad


globus endpoint search "SSP370MonthlyCouplerHistoryFiles"
# Endpoiny ID: 49abef78-b70d-4d3b-9265-33b928e744f3

export from=49abef78-b70d-4d3b-9265-33b928e744f3
export to=c3f2713c-943a-11ee-8c89-fd88ce9321ad
globus endpoint activate --web $to
cd /mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/
mkdir initializationfromBowen
globus transfer $from:/hist.mon/ $to:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/initializationfromBowen

# not work yet 
# download all files to the dropbox and set them only access only(仅在线访问，避免离线模式占用电脑内存)
# 在dropbox的网页端选择所有文件并且创建共享链接
cd /mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/initializationfromBowen
wget 
```

## 20231212spin-up

- use 'EVOLVE_SWAV' rather than 'NOEVOLVE_SWAV';
- use 'SP' rather than 'BGC crop' ;

```
cd $HOME/CESM/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $HOME/scratch/Projects/scratch/20231212spinup --compset HIST_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV --res f09_g17 --machine csf3 --run-unsupported
cd ~/scratch/Projects/scratch/20231212spinup

# IHIST do not need to change DATM, which all set before hand;
./xmlquery DATM_CLMNCEP_YR_END
# DATM_CLMNCEP_YR_END: 1920
./xmlquery DATM_CLMNCEP_YR_ALIGN
# DATM_CLMNCEP_YR_ALIGN: 1901
./xmlquery DATM_CLMNCEP_YR_START
# DATM_CLMNCEP_YR_ALIGN: 1901

./xmlchange RUN_STARTDATE=1965-01-01
./xmlchange NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=10
./xmlchange RESUBMIT=4
./xmlchange JOB_WALLCLOCK_TIME=96:00:00
./case.setup
./preview_namelists

vim user_nl_clm
hist_empty_htapes = .true.

vim user_nl_mosart
rtmhist_nhtfrq = -87600

./case.setup --reset
./case.build
./preview_run


touch myjobscript1212.sh
vim myjobscript1212.sh

#!/bin/bash --login
#$ -cwd
#$ -P hpc-zz-aerosol
#$ -pe hpc.pe 512
./case.submit

chmod -x myjobscript1212.sh
qsub myjobscript1212.sh
qstat
cat CaseStatus
```

## Case0: default urban albedo

- case0_20231218.sh (csf3上提交的脚本文件须以字母开头，不能以字母开头)

```
# 在archer2上跑了一半总是出error，因此换到csf3上接着跑
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/case0
qsub case0.sh
```

```
cd $HOME/CESM/my_cesm_sandbox_2.1.4/cime/scripts
# 参考from bowen
./create_newcase --compset SSP370_DATM%GSWP3v1_CLM51%SP_SICE_SOCN_MOSART_SGLC_SWAV --res hcru_hcru --case ctsm51sp_ctsm51d029_hcru_GSWP3V1_SSP3-7_Anomaly --run-unsupported

./create_newcase --case $HOME/scratch/Projects/scratch/20231205Case0 --compset SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --machine csf3 --run-unsupported

cd ~/scratch/Projects/scratch/20231205Case0
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=17
./xmlchange RESUBMIT=4
./xmlchange RUN_TYPE=startup
./xmlchange GET_REFCASE=FALSE
./xmlchange JOB_WALLCLOCK_TIME=96:00:00
./xmlchange DATM_CLMNCEP_YR_ALIGN=2015
./xmlchange DATM_CLMNCEP_YR_START=2015
./xmlchange DATM_CLMNCEP_YR_END=2100
./case.setup
./preview_namelists

vim user_nl_clm
fsurdat = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'
flanduse_timeseries = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
finidat = '20231126SpinUp.clm2.r.2015-01-01-00000.nc'
maxpatch_pft = 17
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
hist_dov2xy = .false.,.true.
hist_type1d_pertape = 'LAND',' '
hist_nhtfrq= 0,0
hist_mfilt= 12,12
hist_fincl1 = 'URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW'
hist_fincl2 = 'WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'

vim user_nl_datm
anomaly_forcing = 'Anomaly.Forcing.Precip','Anomaly.Forcing.Temperature','Anomaly.Forcing.Pressure','Anomaly.Forcing.Humidity','Anomaly.Forcing.Uwind','Anomaly.Forcing.Vwind','Anomaly.Forcing.Shortwave','Anomaly.Forcing.Longwave'

vim user_nl_cism
history_frequency = 100
finidat = '20231126SpinUp.cism.r.2015-01-01-00000.nc'

vim user_nl_mosart
rtmhist_nhtfrq = -87600
finidat_rtm = '20231126SpinUp.mosart.r.2015-01-01-00000.nc'

./preview_namelists


./case.setup --reset

# 从本地电脑上传
scp -r ~/Desktop/2015-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231205Case0/run

./case.build
./preview_run

touch myjobscript1202.sh
vim myjobscript1202.sh

#!/bin/bash --login
#$ -cwd
#$ -P hpc-zz-aerosol
#$ -pe hpc.pe 512
./case.submit

q myjobscript1202.sh
./preview_run
qsub myjobscript1202.sh
qstat
cat CaseStatus

# if cancel
qdel 
```

### Error

Error1:

If you are seeing this message at the beginning of a run with  
use_init_interp = .true. and init_interp_method = "use_finidat_areas",  
and you are seeing weights less than 1, then a likely cause is:  
For the above-mentioned grid cell(s):  
The matching input gr        12818 total col weight is    0.0000000000000000      active_only =  F

[check_weights](https://bb.cgd.ucar.edu/cesm/threads/check_weights-error.7540/)

```
./xmlchange CLM_NAMELIST_OPTS="use_init_interp=.true. init_interp_method='general'"
```

**unsolved**

Error2: when add anomaly_forcing to user_nl_datm

Creating component namelists  
Calling /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/my_cesm_sandbox_2.1.4/cime/src/components/data_comps/datm/cime_config/buildnml  
ERROR: Error in parsing namelist: expected literal value, but got '\xe2\x80\x99Anomaly.Forcing.Longwave\xe2\x80\x99'

[ref](https://bb.cgd.ucar.edu/cesm/threads/rcp-atmospheric-forcing-for-clm5-projections.7506/)

```
# check coupler in env_build.xml
<entry id="COMP_INTERFACE" value="mct">
<type>char</type>
<valid_values>mct,nuopc,moab</valid_values>
<desc>use MCT component interface</desc>
</entry>
```

Reference about how to create a new case with anomaly_forcing

```
./create_newcase --compset SSP370_DATM%GSWP3v1_CLM51%SP_SICE_SOCN_MOSART_SGLC_SWAV --res hcru_hcru --case ctsm51sp_ctsm51d029_hcru_GSWP3V1_SSP3-7_Anomaly --run-unsupported
```

Error3:

./submit.sh return: Permission denied

```
chmod +777 submit.sh
```

Error4:

***

There are not enough slots available in the system to satisfy the 512  
slots that were requested by the application:

/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/test/bld/cesm.exe

**solve**: in csf， use 'qsub' 提交文件，而不是./submit.sh 来提交文件，因为没有在csf3上configure cesm batch.xml；

Erro5:

Pseudo-terminal will not be allocated because stdin is not a terminal.  
Warning: Permanently added '[node1119.pri.csf3.alces.network]:37178,[10.10.195.119]:37178' (ECDSA) to the list of known hosts.

上面两句不算错误，下面才是：

[node1109:195138] *** An error occurred in MPI_Init

You may wish to try to narrow down the problem;

- Check the output of ompi_info to see which BTL/MTL plugins are  
  available.
- Run your application with MPI_THREAD_SINGLE.
- Set the MCA parameter btl_base_verbose to 100 (or mtl_base_verbose,  
  if using MTL-based communications) to see exactly which  
  communication plugins were considered and/or discarded.

**solve** ：在script 中加#$ -cwd; 如果已经加了cwd但是仍然报这个错误，可以重新提交job再跑一下；

```
#$ -cwd
```



Error5:

***

ORTE has lost communication with a remote daemon.

HNP daemon   : [[17757,0],0] on node node1088  
Remote daemon: [[17757,0],13] on node node1001

This is usually due to either a failure of the TCP network  
connection to the node, or possibly an internal failure of  
the daemon itself. We cannot recover from this failure, and

therefore will terminate the job.



Error6:

***

ORTE was unable to reliably start one or more daemons.  
This usually is caused by:

- not finding the required libraries and/or binaries on  
  one or more nodes. Please check your PATH and LD_LIBRARY_PATH  
  settings, or configure OMPI with --enable-orterun-prefix-by-default
- lack of authority to execute on one or more specified nodes.  
  Please verify your allocation and authorities.
- the inability to write startup files into /tmp (--tmpdir/orte_tmpdir_base).  
  Please check with your sys admin to determine the correct location to use.
- compilation of the orted with dynamic libraries when static are required  
  (e.g., on Cray). Please check your configure cmd line and consider using  
  one of the contrib/platform definitions for your system type.
- an inability to create a connection back to mpirun due to a  
  lack of common network interfaces and/or no route found between  
  them. Please check network connectivity (including firewalls  
  and network routing requirements).

***

***

ORTE does not know how to route a message to the specified daemon  
located on the indicated node:

my node:   node1091  
target node:  node1029

This is usually an internal programming error that should be  
reported to the developers. In the meantime, a workaround may  
be to set the MCA param routed=direct on the command line or

in your environment. We apologize for the problem.

[node1091.pri.csf3.alces.network:261350] 13 more processes have sent help message help-errmgr-base.txt / no-path  
[node1091.pri.csf3.alces.network:261350] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages  
Permission denied, please try again.  
Permission denied, please try again.  
Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).  
Permission denied, please try again.  
Permission denied, please try again.  
Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).

**solve**: 可能是因为在家里，没有连接vpn; 重新连接vpn(重新刷新vpn);

## Case1: 0.9 roof albedo

```
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/project1/case1
qsub case1.sh
--------------------------跑错了，只需要roof albedo = 0.9即可，剩下的应该保持为defualt--------------------------
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript
qusb case1_20231220.sh
# 中断了一次
qsub case1_1_20231220.sh
#发现跑出来的文件居然是从2月份开始的,原因是02-01-00:00 当做1月份的值
# 补一年2100-02-00, 用于计算DJF
qsub case1_2_20231220.sh

# 将文件名从Case1_1改为Case1
import os

# Set the directory path where your netcdf files are located
directory_path = "/path/to/your/files"

# Iterate through files in the directory
for filename in os.listdir(directory_path):
    # Check if the filename starts with "Case1_1.clm2.h0."
    if filename.startswith("Case1_1.clm2.h0."):
        # Create the new filename by replacing "Case1_1" with "Case1"
        new_filename = filename.replace("Case1_1", "Case1")

        # Construct the full paths for the old and new filenames
        old_filepath = os.path.join(directory_path, filename)
        new_filepath = os.path.join(directory_path, new_filename)

        # Rename the file
        os.rename(old_filepath, new_filepath)

print("File renaming completed.")
```

```
cd $HOME/CESM/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $HOME/scratch/Projects/scratch/20231203Case1 --compset SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --machine csf3 --run-unsupported
cd ~/scratch/Projects/scratch/20231203Case1
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=10
./xmlchange RESUBMIT=8
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange JOB_WALLCLOCK_TIME=96:00:00
./xmlchange MAX_MPITASKS_PER_NODE=32
./xmlchange MAX_TASKS_PER_NODE=32
./case.setup
./preview_namelists

vim user_nl_clm
fsurdat = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/project1/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc'
flanduse_timeseries = '/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
maxpatch_pft = 17
use_init_interp = .true.
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
hist_dov2xy = .false.,.true.
hist_type1d_pertape = 'LAND',' '
hist_nhtfrq= 0,0
hist_mfilt= 12,12
hist_fincl1 = 'URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW'
hist_fincl2 = 'WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'

vim user_nl_cism
history_frequency = 100

vim user_nl_mosart
rtmhist_nhtfrq = -87600

./case.setup --reset

# 从本地电脑上传
scp -r ~/Desktop/2015-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231203Case1/run

cd ~/Desktop/Yuan_phdrecord/project1/inputdata/constantAlbedo0.9
scp surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/inputdata/project1

./case.build
./preview_run
touch myjobscript1203.sh
vim myjobscript1203.sh

#!/bin/bash --login
#$ -cwd
#$ -P hpc-zz-aerosol
#$ -pe hpc.pe 512
./case.submit

chmod -x myjobscript1203.sh
qsub myjobscript1203.sh
qstat
cat CaseStatus
```

```
scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231203Case1/run/20231203Case1.clm2.h1.2062-02-01-00000.nc ~/Desktop/CaseOutput

scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231203Case1/run/cesm.log.231203-155948 ~/Desktop
```

### Error

Error1:

ENDRUN:  
ERROR: ERROR in /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/my_cesm_sandbox_2.1.4/components/clm/src/biogeophys/UrbanAlbedoMod.F90 at line 1256  
urban net solar radiation balance error for ib=           1  err=    2.3954287085894421E-003

```
scp a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/scratch/20231203Case1/run/cesm.log.231203-114531 ~/Desktop
```

**solve**:  change 'if (abs(err) > 0.001_r8 ) then' to 'if (abs(err) > 0.003_r8 ) then'

Error2:

max rss=240.2 MB

**solve**: in HPC Pool, 1 node has 32 cores not 128 cores.

## Case2 Dynmic roof alb

```
qsub Rcase2.sh
# Rcase2 补充了h0 数据
--------------------------跑错了，surface data应该保持为defualt--------------------------
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/case2
qsub case2.sh

# 打断后重跑
qsub case2_1.sh

# 补2100年
qsub case2_2.sh
```

### Error

ENDRUN:  
ERROR: ERROR in /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/my_cesm_sandbox_2.1.4_dyn_alb/components/clm/src/biogeophys/UrbanAlbedoMod.F90 at line 1256  
clm model is stopping  
calling getglobalwrite with decomp_index=        42180  and clmlevel= landunit  
local  landunit index =        42180  
urban net solar radiation balance error for ib=           1  err=    1.0712159812515942E-003  
l=          819  ib=            1  
stot_dir        =    1.0000000000000000  
stot_dif        =    1.0000000000000000  
sabs_canyon_dir =   0.47671248278317557  
sabs_canyon_dif =   0.47644547281614902  
sref_canyon_dir =   0.52275172406240078  
sref_canyon_dif =   0.52275172406240078  
clm model is stopping

```
               if (abs(err) > 0.001_r8 ) then
                  write(iulog,*)'urban net solar radiation balance error for ib=',ib,' err= ',err
                  write(iulog,*)' l= ',l,' ib= ',ib 
                  write(iulog,*)' stot_dir        = ',stot_dir(l)
                  write(iulog,*)' stot_dif        = ',stot_dif(l)
                  write(iulog,*)' sabs_canyon_dir = ',sabs_canyon_dir(l)
                  write(iulog,*)' sabs_canyon_dif = ',sabs_canyon_dif(l)
                  write(iulog,*)' sref_canyon_dir = ',sref_canyon_dir(l)
                  write(iulog,*)' sref_canyon_dif = ',sref_canyon_dir(l)
                  write(iulog,*) 'clm model is stopping'
                  call endrun(decomp_index=l, clmlevel=namel, msg=errmsg(sourcefile, __LINE__))
               endif
```

**solve**: change 0.001_r8 to 0.003_r8

[ref](https://bb.cgd.ucar.edu/cesm/threads/change-albedo-error-imbalance.1993/#post-8700), [ref2](https://bb.cgd.ucar.edu/cesm/threads/how-to-modify-the-albedo-data-in-a-latitude-and-longitude-range.8933/)

## Case_add all true

- add a case that 3 time varying

```
# first run in archer2 for the first 85 year
# data transfer to csf3
# in my mac pc terminal 

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case_add/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case_add/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case_add/rest/2085-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case_add/restart/2085-01-01-00000

# continue run
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/case_add
```

## Case7 DynUrb_DynAlb

```
cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/case7
qsub case7.sh

cd /mnt/iusers01/fatpou01/sees01/a16404ys/CESM/jobscript/case_add
qsub case_add.sh
```

## Data Analysis

### Conda environment in csf3

- 要在联网模式下进行，qrsh -l short

```
qrsh -l short
module load apps/binapps/anaconda3/2023.09
source activate yuanenv
pip install --isolated --log pip.log globus-cli
pip install --isolated --log pip.log seaborn
pip install --isolated --log pip.log statsmodels
pip install --isolated --log pip.log linearmodels
pip install --isolated --log pip.log scipy
pip install --isolated --log pip.log scikit-learn
pip install --isolated --log pip.log rasterio
pip install --isolated --log pip.log osgeo
pip install --isolated --log pip.log gdal
pip install --upgrade pip
source deactivate yuanenv
```

### Case1

```
# create directory
cd $HOME/scratch
mkdir output_analysis
cd output_analysis
mkdir project1
-----------------------normal use below-----------------------
module load apps/binapps/anaconda3/2023.09
module load apps/binapps/jupyter-notebook/6.0.0
source activate yuanenv
cd $HOME/scratch/output_analysis
jupyter-notebook-csf -p 8 -m 32
---------------------------------------------------------------
# run 'ssh -L 8888:hnode002:8888 a16404ys@csf3.itservices.manchester.ac.uk' in my pc terminal
# after authenrized
# run 'jupyter-notebook-csf -t 4656752'liked command
# copy http://localhost:8888/?token=2c78f70f7074310554f21d280ba5a7222fa07c1436477ff0 into a new brower
```

Error

Error1:

```
OSError: Could not load libspatialindex_c library
```

**solve**: creat my own conda environment where pip install packages;



## Figure