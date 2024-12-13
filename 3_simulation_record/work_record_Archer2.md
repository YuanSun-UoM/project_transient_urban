# Log in

- 在vscode上可视化

```
ssh yuansun@login.archer2.ac.uk
SUn339YUan0051997
```

# Create_Input_data

### urban surface data

```
#1 degree urban surface data

/glade/p/cesm/cseg/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c190214.nc
```

- 变量‘ALB_ROOF_DIF‘ 取值在0.0-0.6之间，变量’ALB_ROOF_DIR‘取值相同；
- 变量’ALB_ROOF_DIF‘ 取值在numurbl 1,2,3 不同；
- 变量’ALB_ROOF_DIF‘ 取值在nurad 1和2 相同；

**区别coordinate 和dimension**

- dimension 定义数组的形状和大小，指定研数组每个轴的值的数量

- Coordinate 提供沿维度的值，表示沿着维度上每个点对应的数据值（value），可能是时间、经度、维度

- 3个coordinates: natpft, cft, time
  
  - Natpft: 15
    
    - ```
      array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14], dtype=int32)
      ```
    - long_name: indices of natural PFTs
    - units: index
  
  - cft: 64
    
    - ```
      array([15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
             33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
             51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,
             69, 70, 71, 72, 73, 74, 75, 76, 77, 78], dtype=int32)
      ```
    - Long_name: indices of natural PFTs
    - units: index
  
  - Time: 12
    
    - ```
      array([ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12], dtype=int32)
      ```
    - Long_name: Calendar month
    - Units: month

albedo 变量

- ALB_IMPROAD_DIF (numrad, numurbl, lsmlat, lsmlon) float64 ...
  
  - Long_name : diffuse albedo of impervious road
  
  - xarray.Variable
    
    - numrad: 2 (direct, diffuse)
    - numurbl: 3 （TBD, HD, MD）
    - lsmlat: 192
    - lsmlon: 288

- ALB_PERROAD_DIR (numrad, numurbl, lsmlat, lsmlon) float64 ...

- ALB_ROOF_DIR (numrad, numurbl, lsmlat, lsmlon) float64 ...

- ALB_ROOF_DIF (numrad, numurbl, lsmlat, lsmlon) float64 ...

- ALB_WALL_DIR (numrad, numurbl, lsmlat, lsmlon) float64 ...

- ALB_WALL_DIF (numrad, numurbl, lsmlat, lsmlon) float64 ...
  
  - integer, parameter, public :: numurbl = isturb_MAX - isturb_MIN + 1   ! number of urban landunits
  - Isturb_tbd = 7; isturb_hd = 8; isturb_md = 9

time 变量

### t_building_max

在UrbanTimeVarType.F90中，t_building_max是一个一维变量，由landunit index进行赋值。

![t_building_max](/Users/user/Dropbox (The University of Manchester)/CESM/pythonforCESM/project1/t_building_max.png)

```
#1 degree maximum building 

/glade/p/cesm/cseg/inputdata/lnd/clm2/urbandata/CLM50_tbuildmax_Oleson_2016_0.9x1.25_simyr1849-2106_c160923.nc

year：258 (1849-2106)
```

- Tbuildmax_TBD, tbuild_HD, tbuild_MD的取值是一样的

## wtroad_perv

wtroad_perv  (:) ! urban landunit weight of pervious road column to total road (-)

## wtlunit_roof

wtlunit_roof (:) ! weight of roof with respect to urban landunit (-)

# Case_Run_record

## Transfer_from_GLOBUS

- 从archer2上设置globus是Disconnected的，必须从别的地方传到archer2上

```
# install globus in my Archer2 directory
# https://help.jasmin.ac.uk/article/5041-data-transfer-tools-globus-connect-personal
mkdir globus
cd /work/n02/n02/yuansun/
cd globus
mkdir download
cd /work/n02/n02/yuansun/globus/download/globusconnectpersonal-3.2.3/
./globusconnectpersonal
./globusconnectpersonal -start &
./globusconnectpersonal -gui
./globusconnectpersonal -status
# Globus Online:   disconnected
# Transfer Status: idle

# my globus account
yuansun-uom@github.com

Input a value for the Endpoint Name: cmip6_coupler_history_data
registered new endpoint, id: 0eae0ff2-93a4-11ee-83db-d5484943e99a

# 除了安装globus软件，还可以在自己的conda环境中安装globus pythonpackage
# install globus-cli
# https://help.jasmin.ac.uk/article/4480-data-transfer-tools-globus-command-line-interface
source /work/n02/n02/yuansun/myvenv/bin/activate
pip install globus-cli
globus whoami
globus login --no-local-server
globus endpoint create Yuan_archer2
# Message:     Endpoint created successfully
# Endpoint ID: a485903e-943c-11ee-83dc-d5484943e99a
export from=49abef78-b70d-4d3b-9265-33b928e744f3
export to=a485903e-943c-11ee-83dc-d5484943e99a
globus endpoint activate $to

globus-url-copy https://app.globus.org/file-manager?origin_id=49abef78-b70d-4d3b-9265-33b928e744f3&origin_path=%2F 
```

## Data_Storage

- 区别与/work/n02/n02/yuansun，/mnt/lustre/a2fs-nvme/work/n02/n02/yuansun底下有较大存储容量；

```
cd /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun
export NVME = /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/project1/

# 移动文件
cp -r $CESM_ROOT/runs/20231119case2/ /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/project1/
# 这样子会把20231119case2文件夹中的文件复制到project1底下

cp -r $CESM_ROOT/runs/20231119case2 /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/project1/
# 这样子把20231119case2文件夹复制到project1底下

cp -r $CESM_ROOT/archive/20231120SpinUp /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/project1/archive/

# 检查solid state的配额
cd /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun
lfs quota -hp $(id -g) .

# 检查work direcyory 的配额
cd /work/n02/n02/yuansun
lfs quota -hu yuansun .
```



## Output_Setting

- [CLM Namelist Definitions](https://docs.cesm.ucar.edu/models/cesm2/settings/current/clm5_0_nml.html)

- [history_fields_nofates.rest](https://github.com/ESCOMP/CTSM/blob/d81bff255e387ffaa8adb1f2fed7e6da050c678f/doc/source/users_guide/setting-up-and-running-a-case/history_fields_nofates.rst#L32)
  
  [CTSM history fields](https://github.com/ESCOMP/CTSM/blob/d81bff255e387ffaa8adb1f2fed7e6da050c678f/doc/source/users_guide/setting-up-and-running-a-case/history_fields_fates.rst)

- 除了输出land的数据，不需要其他component的数据[ref](https://bb.cgd.ucar.edu/cesm/threads/question-about-cesm-output.4957/)
  
  - ISSP370Clm50Sp会在archive输出lnd, glc (CISM), rof (runoff, MOSART)
  
  ```
  echo "history_aerosol   = .true." >> user_nl_cam 
  echo "empty_htapes = .true." >> user_nl_cam 
  echo "hist_empty_htapes = .true." >> user_nl_clm
  echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
  echo "history_frequency = 100" >> user_nl_cism
  ```

### Atmosphere forcing

- With respect to output variables, you may also want to output the atmospheric forcing variables, which might help in your analysis. These would include FSDS, FLDS, QBOT, PBOT, TBOT, RAIN, SNOW.

| atmospheric forcing variables | Long Description                                             | Units | Active? |
| ----------------------------- | ------------------------------------------------------------ | ----- | ------- |
| FSDS                          | atmospheric incident solar radiation (short wave incident radiation), this%forc_solar_downscaled_col(begc:endc) = spval | W/m^2 | T       |
| FLDS                          | atmospheric longwave radiation (downscaled to columns in glacier regions) | W/m^2 | T       |
| QBOT                          | atmospheric specific humidity (downscaled to columns in glacier regions) | kg/kg | T       |
| PBOT                          | atmospheric pressure at surface (downscaled to columns in glacier regions) | Pa    | T       |
| TBOT                          | atmospheric air temperature (downscaled to columns in glacier regions) | K     | T       |
| RAIN                          | atmospheric rain, after rain/snow repartitioning based on temperature | mm/s  | T       |
| SNOW                          | atmospheric snow, after rain/snow repartitioning based on temperature | mm/s  | T       |
| U10                           | 10-m wind, this%u10_clm_patch(begp:endp) = spval, use this for wind | m/s   | T       |
| VA                            | atmospheric wind speed plus convective velocity, this%va_patch(begp:endp) = spval | m/s   | F       |
| WIND                          | atmospheric wind velocity magnitude, is **grid** level       | m/s   | T       |
| Wind                          |                                                              |       |         |

|        |                                                                           |       |     |
| ------ | ------------------------------------------------------------------------- | ----- | --- |
| SWdown | atmospheric incident solar radiation                                      | W/m^2 | F   |
| SWup   | upwelling shortwave radiation                                             | W/m^2 | F   |
| LWdown | atmospheric longwave radiation (downscaled to columns in glacier regions) | W/m^2 | F   |
| LWup   | upwelling longwave radiation                                              | W/m^2 | F   |

### Heat Stress

- calc_human_stress_indices = 'FAST'
- calc_human_stress_indices = 'ALL'

| Heat stress index                                     | HumanIndexMod-Fuction | Parameter                  | Output_Variable | Namelist                 | units |
| ----------------------------------------------------- | --------------------- | -------------------------- | --------------- | ------------------------ | ----- |
| the U.S. National Weather Service Heat Index (NWS HI) | HeatIndex             | nws_hi_ref2m_patch         | HIA             |                          | C     |
| Apparent Temperature (AT)                             | AppTemp               | appar_temp_ref2m_patch     | APPAR_TEMP      | all_human_stress_indices | C     |
| Simplified Wet-Bulb Globe Temperature (SWBGT)         | Swbgt                 | swbgt_ref2m_patch          | SWBGT           |                          | C     |
| Humidity Index(Humidex)                               | Hmdex                 | humidex_ref2m_patch        | HUMIDEX         |                          | C     |
| Discomfort index (DI)                                 | dis_coi               | discomf_index_ref2mS_patch | DISCOIS         | all_human_stress_indices | C     |

### Urban

- [How to simulating Urban Heat Island?](https://bb.cgd.ucar.edu/cesm/threads/how-to-simulating-urban-heat-island.5249/#post-36315)
  
  - urban air temperature (TSA_U) and the rural (vegetated+soil) air temperature (TSA_R);
  
  - use TG_R and TG_U for surface heat island;
    
    - These are the area weighted averages of the surface temperature of the individual urban surfaces (roof, sunwall, shadewall, pervious and impervious canyon floor).
  
  - For urban canopies, TAF (canopy air temperature) is equal to TSA_U. ref: [https://bb.cgd.ucar.edu/cesm/threads/interpreting-clm-temperature-variables.7938/#post-47739](https://bb.cgd.ucar.edu/cesm/threads/interpreting-clm-temperature-variables.7938/#post-47739)

| Output variables | Long Description                                                                                                                                                                                                                                                                                                                                                                       | Units    | Active |     |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------ | --- |
| APPAR_TEMP_U     | Urban 2 m apparent temperature                                                                                                                                                                                                                                                                                                                                                         | C        | T      |     |
| APPAR_TEMP_R     |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| APPAR_TEMP       |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| DISCOIS_U        | Urban 2 m Stull Discomfort Index                                                                                                                                                                                                                                                                                                                                                       | C        | T      |     |
| DISCOIS_R        |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| DISCOIS          |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| EFLX_LH_TOT_U    | Urban total evaporation (total latent heat flux [+ to atm])  总潜热通量, eflx_lh_tot_u_patch                                                                                                                                                                                                                                                                                                | W/m^2    | F      |     |
| EFLX_LH_TOT_R    | Rural total evaporation (total latent heat flux [+ to atm])                                                                                                                                                                                                                                                                                                                            |          |        |     |
| EFLX_LH_TOT      |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| EFLXBUILD        | building heat flux from change in interior building air temperature                                                                                                                                                                                                                                                                                                                    | W/m^2    | T      |     |
| FGR_U            | Urban heat flux into soil/snow including snow melt, urban storage, 进入土地的热量, eflx_soil_grnd_u_patch                                                                                                                                                                                                                                                                                     | W/m^2    | F      |     |
| EPT_U            | Urban 2 m Equiv Pot Temp                                                                                                                                                                                                                                                                                                                                                               | K        | T      |     |
| FIRA_R           | Rural net infrared (longwave) radiation                                                                                                                                                                                                                                                                                                                                                |          |        |     |
| FIRA_U           | Urban net infrared (longwave) radiation 城市净红外(长波)辐射, eflx_lwrad_net_u_patch                                                                                                                                                                                                                                                                                                            | W/m^2    | F      |     |
| FIRE_R           |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| FIRE_U           | Urban emitted infrared (longwave) radiation 城市发射红外线(长波)辐射, eflx_lwrad_out_u_patch                                                                                                                                                                                                                                                                                                      | W/m^2    | F      |     |
| FSA_R            |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| FSA_U            | Urban absorbed solar radiation 城市吸收太阳辐射                                                                                                                                                                                                                                                                                                                                                | W/m^2    | F      |     |
| FSH_U            | Urban sensible heat 城市感热, eflx_sh_tot_u_patch                                                                                                                                                                                                                                                                                                                                          | W/m^2    | F      |     |
| FSH_R            |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| FSM_R            |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| FSM_U            | Urban snow melt heat flux 在冬季考虑                                                                                                                                                                                                                                                                                                                                                        | W/m^2    | F      |     |
| HIA_U            | Urban 2 m NWS Heat Index                                                                                                                                                                                                                                                                                                                                                               | C        | T      |     |
| HUMIDEX_U        | Urban 2 m Humidex                                                                                                                                                                                                                                                                                                                                                                      | C        | T      |     |
| QRUNOFF_U        | Urban total runoff                                                                                                                                                                                                                                                                                                                                                                     | mm/s     | F      |     |
| RH2M_U           | Urban 2m relative humidity                                                                                                                                                                                                                                                                                                                                                             | %        | F      |     |
| SWBGT_U          | Urban 2 m Simplified Wetbulb Globe Temp                                                                                                                                                                                                                                                                                                                                                | C        | T      |     |
| SWMP65_U         | Urban 2 m Swamp Cooler Temp 65% Eff                                                                                                                                                                                                                                                                                                                                                    | C        | T      |     |
| SWMP80_U         | Urban 2 m Swamp Cooler Temp 80% Eff                                                                                                                                                                                                                                                                                                                                                    | C        | T      |     |
| SoilAlpha_U      | urban factor limiting ground evap                                                                                                                                                                                                                                                                                                                                                      | Unitless | F      |     |
| TBUILD           | internal urban building air temperature                                                                                                                                                                                                                                                                                                                                                | K        | T      |     |
| TBUILD_MAX       | prescribed maximum interior building temperature                                                                                                                                                                                                                                                                                                                                       | K        | F      |     |
| TEQ_U            | Urban 2 m Equiv Temp                                                                                                                                                                                                                                                                                                                                                                   | K        | T      |     |
| TG_R             |                                                                                                                                                                                                                                                                                                                                                                                        |          |        |     |
| TG_U             | Urban ground temperature                                                                                                                                                                                                                                                                                                                                                               | K        | F      |     |
| THIC_U           | Urban 2 m Temp Hum Index Comfort                                                                                                                                                                                                                                                                                                                                                       | C        | T      |     |
| THIP_U           | Urban 2 m Temp Hum Index Physiology                                                                                                                                                                                                                                                                                                                                                    | C        | T      |     |
| TREFMNAV_U       | Urban daily minimum of average 2-m temperature                                                                                                                                                                                                                                                                                                                                         | K        | F      |     |
| TREFMXAV_U       | Urban daily maximum of average 2-m temperature                                                                                                                                                                                                                                                                                                                                         | K        | F      |     |
| TSA_U            | Urban 2m air temperature                                                                                                                                                                                                                                                                                                                                                               | K        | F      |     |
| URBAN_AC         | urban air conditioning flux                                                                                                                                                                                                                                                                                                                                                            | W/m^2    | T      |     |
| URBAN_HEAT       | urban heating flux                                                                                                                                                                                                                                                                                                                                                                     | W/m^2    | T      |     |
| WASTEHEAT        | sensible heat flux from heating/cooling sources of urban waste heat                                                                                                                                                                                                                                                                                                                    | W/m^2    | T      |     |
| WBA_U            | Urban 2 m Wet Bulb                                                                                                                                                                                                                                                                                                                                                                     | C        | T      |     |
| WBT_U            | Urban 2 m Stull Wet Bulb                                                                                                                                                                                                                                                                                                                                                               | C        | T      |     |
| VENTILATION      | sensible heat flux from building ventilation                                                                                                                                                                                                                                                                                                                                           | W/m^2    | T      |     |
| TROOF_INNER      | roof inside surface temperature                                                                                                                                                                                                                                                                                                                                                        | K        | F      |     |
| TSHDW_INNER      | shadewall inside surface temperature                                                                                                                                                                                                                                                                                                                                                   | K        | F      |     |
| TSUNW_INNER      | sunwall inside surface temperature                                                                                                                                                                                                                                                                                                                                                     | K        | F      |     |
| ram1             | aerodynamical resistance (s/m) , use_cn, refer to : [https://bb.cgd.ucar.edu/cesm/threads/clm-output-variables-%EF%BC%88ctsm-history-fields%EF%BC%89.8013/#post-48122](https://bb.cgd.ucar.edu/cesm/threads/clm-output-variables-%EF%BC%88ctsm-history-fields%EF%BC%89.8013/#post-48122) 在src/biogeophys/FrictionVelocityMod.F90中， 注释掉ram1 所在的 if (use_cn) then 和end if , 否则无法直接输出ram1 |          |        |     |
| HEAT_FROM_AC     | sensible heat flux put into canyon due to heat removed from air conditioning                                                                                                                                                                                                                                                                                                           |          |        |     |
| urban_ac         | urban air conditioning flux                                                                                                                                                                                                                                                                                                                                                            |          |        |     |

- The longwave balances as FLDS(atmospheric longwave radiation )  + FIRA_U (Urban net infrared (longwave) radiation ) = FIRE_U (Urban emitted infrared (longwave) radiation). [ref](%5Bhttps://bb.cgd.ucar.edu/cesm/threads/calculate-effective-emissivity-of-urban-and-rural-area.5375/#post-37026%5D(https://bb.cgd.ucar.edu/cesm/threads/calculate-effective-emissivity-of-urban-and-rural-area.5375/#post-37026))
- energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - fgr_u + wasteheat + heat_from_ac + ventilation (ventilation is active in CLM5.1) [re'f](%5Bhttps://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/%5D(https://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/))
- FGR includes both heating and cooling fluxes
- since **urban_ac = heat_from_ac**, ref: [https://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/#post-40347](https://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/#post-40347)
- FGR includes both heating and cooling fluxes.The way I think of the energy balance for an urban area is::energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - fgr_u + wasteheat + heat_from_acor, since urban_ac = heat_from_ac:energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - fgr_u + wasteheat + urban_acThis can be re-written such that heating and cooling are removed from fgr_u (note that urban_ac and urban_heat have different signs because theyact in opposite directions with respect to the urban surface):energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - (fgr_u - urban_ac + urban_heat) + wasteheat + urban_heatYou are right that HEAT_FROM_AC is not additional energy into the climate system because heat is removed from the interior of the building into the urban canyon. The only part that is additional energy is the wasteheat associated with inefficiencies in the AC system and the power systems that generate the electricity that runs the AC.I guess you could consider HEAT_FROM_AC or URBAN_AC to be due to human activities from a philosophical viewpoint. （[https://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/#post-40339](https://bb.cgd.ucar.edu/cesm/threads/questions-about-anthropogenic-heat-flux-in-clm5.6158/#post-40339)）

## Urban Heat Issue

- A description of the building energy model in CLM5: Oleson, K.W., and J. Feddema, 2019: Parameterization and surface data improvements and new capabilities for the Community Land Model Urban (CLMU), *JAMES*, 11, doi:10.1029/2018MS001586.
  
  - anthropogenic heat flux (AHF) include human metabolism, vehicles, commercial and residential buildings, industry, and power plants；
  
  - The total anthropogenic heat flux released into the climate system due to space heating and air conditioning in CLMU5 is wasteheat + URBAN_HEAT(space heating)
    
    - AHF =  WASTEHEAT + URBAN_HEAT = 0.6*HEAT_FROM_AC + 0.2*URBAN_HEAT + URBAN_HEAT = 0.6*HEAT_FROM_AC + 1.2*URBAN_HEAT
  
  - wasteheat *H**wstht* is therefore derived as 0.2*F**heat* for heating (since one unit of energy was already used to heat the building interior) and 0.6*F**cool* for air conditioning (since the energy consumed is used to transfer heat from the building interior to the exterior).
    
    - WASTEHEAT = 0.6*HEAT_FROM_AC + 0.2*URBAN_HEAT
  
  - the energy balance for an urban area is: energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - fgr_u + wasteheat + heat_from_ac
    
    - since urban_ac = heat_from_ac:
      
      energy_balance_u = fsa_u - fira_u - eflx_lh_tot_u - fsh_u - fgr_u + wasteheat + urban_ac

### Other

- [hist_dov2xy(1) = .false.](https://bb.cgd.ucar.edu/cesm/threads/calculate-urban-energy-flux-from-its-pft-level-output.5577/)
  
  - hist_dov2xy: If TRUE, implies output data on a 2D latitude/longitude grid. False means  
    output in 1D vector format.  One setting per history tape series.

- hist_type1d_pertape
  
  - hist_dov2xy和hist_type1d_pertape配合使用
  - match any of the valid values: 'GRID', 'LAND', 'COLS', 'PFTS', ' '
  - ###### Averaging type of output for 1D vector output (when hist_dov2xy is false).
  - 'WIND','FSDS' 是grid level 的变量，无法输出landunit-level 的值。因此如果要输出landunit-levle的值，则需要对照源代码看是从哪个level输出的
  - ```
    hist_dov2xy = .true.,.false.
    hist_fincl2 = 'TG'
    hist_mfilt = 1
    hist_nhtfrq = 0,-24
    hist_type1d_pertape = ' ','PFTS'
    ```
  - ```
    GRID means average all land-units up to the grid-point level
    LAND means average all columns up to the land-unit level
    COLS means average all PFT's up to the column level
    PFTS means report everything on native PFT level
    ```

- spinup_state
  
  - ```
    THIS CAN ONLY BE SET TO NON-ZERO WHEN BGC_MODE IS NOT SATELITE PHENOLOGY (Sp)!
    ```

- [changing output](https://wiki.ucar.edu/display/camchem/Changing+Output:+Frequency,+Species+and+Regions)

- [Naming Conventions](https://www.cesm.ucar.edu/models/cesm2/naming-conventions)

```
# 参考
data2dptr => this%h2osoi_liq_col(begc:endc,1:nlevsoi) 
    call hist_addfld2d ( &
         fname=this%info%fname('SOILLIQ'),  &
         units='kg/m2', type2d='levsoi', &
         avgflag='A', &
         long_name=this%info%lname('soil liquid water (natural vegetated and crop landunits only)'), &
         ptr_col=data2dptr, l2g_scale_type='veg')

# Saving IC files
# You can save Initial Conditions (IC) files at any frequency for use in new cases.  The default is 'YEARLY'. Other choices include: '6-HOURLY', 'DAILY', 'MONTHLY', 'ENDOFRUN'.
inithist = 'MONTHLY'
```

### [1d_to_2d](https://github.com/zhonghua-zheng/CLM-1D-to-2D/blob/main/class_implementation.ipynb)

- [How to create a subgrid info file for CESM2’s CLM processing?](https://urbanclimateexplorer.readthedocs.io/en/latest/notebooks/CESM2_subgrid_info.html#How-to-create-a-subgrid-info-file-for-CESM2's-CLM-processing?)
- [CLM-1D-to2D](https://github.com/zhonghua-zheng/CLM-1D-to-2D/tree/main)
- 不能对restart文件进行转换，因为restart输出了一个grid中的所有pfts，而hist文件是取平均处理，因此1d_to_2d/3d应该基于h0文件

## Case: Spin-up[20231213SpinUp]

### IHistClm50Sp

- Keith said: "a compset with SP (satellite phenology) mode would potentially be better than one with BgcCrop. The SP simulation would be quite a bit less computationally expensive and the BgcCrop only affects vegetation/soil landunits and has no effect on urban landunits."

- change compset 'IHistClm50BgcCrop' to 'IHistClm50Sp'

- fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'

- maxpatch_pft = 17

- flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850-2015_c170824.nc'

- [Spinning up the Satellite Phenology Model](https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/running-special-cases/Spinning-up-the-Satellite-Phenology-Model-CLMSP-spinup.html?highlight=spin)
  
  - 50 years simulation
  - [https://bb.cgd.ucar.edu/cesm/threads/some-question-about-spin-up.8165/#post-48739](https://bb.cgd.ucar.edu/cesm/threads/some-question-about-spin-up.8165/#post-48739)

```
------------更新：预计跑50年，512核，3线程，花费12小时------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231213SpinUp --compset HIST_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231213SpinUp
./xmlchange RUN_STARTDATE=1965-01-01
./xmlchange NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=50
./xmlchange RESUBMIT=0
./xmlchange JOB_WALLCLOCK_TIME=24:00:00
./xmlchange NTHRDS=3
./case.setup
./preview_namelists

vim user_nl_clm
hist_empty_htapes = .true.

#vim user_nl_cism
#history_frequency = 100

vim user_nl_mosart
rtmhist_nhtfrq = -87600

./case.setup --reset
./case.build
./preview_run
./case.submit
```

### Error

[read_variable_2d ERROR: sum of PCT_NAT_PFT not 1.0](https://bb.cgd.ucar.edu/cesm/threads/sum-of-pct_nat_pft-not-1-0.6884/) at nl=

in the log:

```
 Attempting to read pft dynamic landuse data .....
 (GETFIL): attempting to find local file landuse.timeseries_0.9x1.25_hist_78pfts_CMIP6_simyr1850-2015_c170824.nc
 (GETFIL): using /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_hist_78pfts_CMIP6_simyr1850-2015_c170824.nc

 dynpft_consistency_checks settings:
&DYNPFT_CONSISTENCY_CHECKS
 CHECK_DYNPFT_CONSISTENCY=T,
 /

 Get data for variable PCT_NAT_PFT for year  -1140850688
 read_variable_2d ERROR: sum of PCT_NAT_PFT not 1.0 at nl=           1
 sum is:    1.1264696725180421E-321
 ENDRUN:
 ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/src/main/surfrdUtilsMod.F90 at line 70
```

**Solve**:

```
# 原本lnd_in 文件中
&dynamic_subgrid
 do_harvest = .true.
 do_transient_crops = .true.
 do_transient_pfts = .true.
 flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_hist_78pfts_CMIP6_simyr1850-2015_c170824.nc'
/

# 在user_nl_clm 中重新指定flanduse_timeseries为：/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_hist_78pfts_CMIP6_simyr1850-2015_c190214.nc

flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_hist_78pfts_CMIP6_simyr1850-2015_c190214.nc'
```

# [Data Atmosphere(DATM)](https://esmci.github.io/cime/versions/maint-5.6/html/data_models/data-atm.html)

### Method 1 [Atmospheric forcing from fully-coupled simulation](https://escomp.github.io/ctsm-docs/versions/master/html/users_guide/running-special-cases/Running-with-your-own-previous-simulation-as-atmospheric-forcing-to-spinup-the-model.html?highlight=datm_cplhist_case#example-simulation-forced-with-data-from-the-previous-simulation)

- [https://escomp.github.io/ctsm-docs/versions/master/html/users_guide/running-special-cases/Running-with-your-own-previous-simulation-as-atmospheric-forcing-to-spinup-the-model.html?highlight=datm_cplhist_case#example-simulation-forced-with-data-from-the-previous-simulation](https://escomp.github.io/ctsm-docs/versions/master/html/users_guide/running-special-cases/Running-with-your-own-previous-simulation-as-atmospheric-forcing-to-spinup-the-model.html?highlight=datm_cplhist_case#example-simulation-forced-with-data-from-the-previous-simulation)

- CPLHIST：Coupler history forcing data mode
  
  - streams: CPLHISTForcing.Solar,CPLHISTForcing.nonSolarFlux,
  
  - CPLHISTForcing.State3hr,CPLHISTForcing.State1hr
  
  - "Solar" variables will come from the **ha2x1hi** files (hourly instantaneous)
  
  - "nonSolarFlux" and "State3hr" and "topo" variables will come from the **ha2x3h** files (3-hourly).
    
    - nonSolarFlux
    - State3hr
    - topo
  
  - "State1hr" variables will come from the **ha2x1h** files (hourly)
  
  - ## The "presaero" variables will come from the **ha2x1d** files (daily average).

### Method 2: [Anomaly forcing](https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/running-special-cases/Running-with-anomaly-forcing.html)

- [https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/running-special-cases/Running-with-anomaly-forcing.html](https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/running-special-cases/Running-with-anomaly-forcing.html)
- [anomaly forcings derived from CMIP6 data](https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/atm/datm7/anomaly_forcing/)
- 注意官方教程中的引号复制下来有格式错误，需要修改
- [incorperate cmip6 ssp-based anomaly forcing](https://bb.cgd.ucar.edu/cesm/threads/how-to-incorporate-cmip6-climate-anomaly-in-issp-based-land-model-under-cesm2-2.8266/#post-49355)

```
vim user_nl_datm

# 官方：anomaly_forcing = 'Anomaly.Forcing.Precip','Anomaly.Forcing.Temperature','Anomaly.Forcing.Pressure','Anomaly.Forcing.Humidity','Anomaly.Forcing.Uwind','Anomaly.Forcing.Vwind','Anomaly.Forcing.Shortwave',’Anomaly.Forcing.Longwave’


anomaly_forcing ='Anomaly.Forcing.Precip','Anomaly.Forcing.Temperature','Anomaly.Forcing.Pressure','Anomaly.Forcing.Humidity','Anomaly.Forcing.Uwind','Anomaly.Forcing.Vwind','Anomaly.Forcing.Shortwave','Anomaly.Forcing.Longwave'

# 修改完之后再执行./preview_namelists，run文件夹中的文件会根据user_nl_*重新生成；

# 将anomaly_forcing指向SSP派生的驱动数据，https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/atm/datm7/anomaly_forcing/

cp datm.streams.txt.Anomaly.Forcing.Humidity user_datm.streams.txt.Anomaly.Forcing.*
vim user_datm.streams.txt.Anomaly.Forcing.*
```

```
# if use SSP370_DATM%GSWP3v1_CLM51%SP_SICE_SOCN_MOSART_SGLC_SWAV 
./xmlquery DATM_CLMNCEP_YR_ALIGN
# DATM_CLMNCEP_YR_ALIGN: 2001
./xmlquery DATM_CLMNCEP_YR_END
# DATM_CLMNCEP_YR_END: 2014

Since we are starting the model here at 2015, do this:
./xmlchange DATM_CLMNCEP_YR_ALIGN=2015
```

## Case0: CON

- default run with 512 cores

- The amount of anthropogenic heat flux (AHF) going into the climate system is URBAN_HEAT+WASTEHEAT (see equation 13 in Oleson&Feddema, 2019).

- ISSP370Clm50BgcCrop: SSP370_DATM%GSWP3v1_CLM50%BGC-CROP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV

- IHistClm50Sp: HIST_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV

- then : SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV
  
  - fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'
  - flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
  - maxpatch_pft = 17

- monthly contrast参考: Contrasts between Urban and Rural Climate in CCSM4 CMIP5 Climate Change Scenarios--》JJA (June, July, August)

```
cd /work/n02/n02/yuansun/shell_scripts/archive/project1
bash Case0.sh
bash Case0_1.sh

512个节点（128个核），跑10年花了3个小时
 ---------------------------------------------------
2023-12-20 02:40:31: case.run starting 
 ---------------------------------------------------
2023-12-20 02:40:36: model execution starting 
 ---------------------------------------------------
2023-12-20 05:19:43: model execution success 
 ---------------------------------------------------
2023-12-20 05:19:43: case.run success 
 ---------------------------------------------------
2023-12-20 05:20:06: st_archive starting 
 ---------------------------------------------------

---------------更新：之后都是用shell script脚本文件跑模型---------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231212Case0 --compset SSP370_DATM%CPLHIST_CLM50%SP_SICE_SOCN_MOSART_SGLC_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231212Case0
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=5
./xmlchange RESUBMIT=16
./xmlchange DATM_CPLHIST_CASE="b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102"
./xmlchange DATM_CPLHIST_DIR=$CESM_ROOT/cesm_inputdata/CPLHIST/SSP370
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange DATM_CPLHIST_YR_ALIGN=2015
./xmlchange DATM_CPLHIST_YR_START=2015
./xmlchange DATM_CPLHIST_YR_END=2100
./xmlchange NTHRDS=3
./case.setup
./preview_namelists
cd $CESM_ROOT/runs/20231212Case0/CaseDocs/
cp datm.streams.txt.CPLHISTForcing.nonSolarFlux user_datm.streams.txt.CPLHISTForcing.nonSolarFlux
cp datm.streams.txt.CPLHISTForcing.Solar user_datm.streams.txt.CPLHISTForcing.Solar
cp datm.streams.txt.CPLHISTForcing.State1hr user_datm.streams.txt.CPLHISTForcing.State1hr
cp datm.streams.txt.CPLHISTForcing.State3hr user_datm.streams.txt.CPLHISTForcing.State3hr
cp datm.streams.txt.presaero.cplhist user_datm.streams.txt.presaero.cplhist
cp datm.streams.txt.topo.cplhist user_datm.streams.txt.topo.cplhist
# Change the <fieldInfo> field <filePath> to point to the correct directory i.e.: /glade/home/achive/$USER/$DATM_CPLHIST_CASE/cpl/hist
# nonsolarFlux: ha2x3h
# Solar: ha2x1hi
# State1hr:ha2x1h
# State3hr:ha2x3h
# presaero:ha2x1d
# topo: ha2x3h
vim user_datm.streams.txt.CPLHISTForcing.nonSolarFlux

vim user_datm.streams.txt.CPLHISTForcing.Solar
vim user_datm.streams.txt.CPLHISTForcing.State1hr
vim user_datm.streams.txt.CPLHISTForcing.State3hr
vim user_datm.streams.txt.presaero.cplhist
vim user_datm.streams.txt.topo.cplhist

vim user_nl_clm

fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'
flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
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
# 修改user_namelist之后重新./preview_namelist确保修改无误
./preview_namelists
./case.setup --reset
cd $CESM_ROOT/runs/20231213SpinUp/run
cp 20231213SpinUp.clm2.r.2015-01-01-00000.nc 20231213SpinUp.cpl.r.2015-01-01-00000.nc 20231213SpinUp.mosart.r.2015-01-01-00000.nc 20231213SpinUp.mosart.rh0.2015-01-01-00000.nc 20231213SpinUp.mosart.h0.2015-01-01-00000.nc rpointer.atm rpointer.drv rpointer.lnd rpointer.rof $CESM_ROOT/runs/20231212Case0/run

./case.build
./preview_run
./case.submit
```

### 创建2015-2100年的文件名(py)

```
ha2x3h_filename = "b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x3h."
ha2x1h_filename = "b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1h."
ha2x1hi_filename = "b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1hi."
ha2x1d_filename = "b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1d."

# Assuming the years range from 2015 to 2100
start_year = 2015
end_year = 2100

# Generate file name list for each year and month
ha2x3h_names = [f"{ha2x3h_filename}{str(year)}-{str(month).zfill(2)}.nc" for year in range(start_year, end_year + 1) for month in range(1, 13)]
ha2x1h_names = [f"{ha2x1h_filename}{str(year)}-{str(month).zfill(2)}.nc" for year in range(start_year, end_year + 1) for month in range(1, 13)]
ha2x1hi_names = [f"{ha2x1hi_filename}{str(year)}-{str(month).zfill(2)}.nc" for year in range(start_year, end_year + 1) for month in range(1, 13)]
ha2x1d_names = [f"{ha2x1d_filename}{str(year)}-{str(month).zfill(2)}.nc" for year in range(start_year, end_year + 1) for month in range(1, 13)]

# Specify the file path for the text file
ha2x3h_path = "/Users/user/Desktop/file_names_ha2x3h.txt"
ha2x1h_path = "/Users/user/Desktop/file_names_ha2x1h.txt"
ha2x1hi_path = "/Users/user/Desktop/file_names_ha2x1hi.txt"
ha2x1d_path = "/Users/user/Desktop/file_names_ha2x1d.txt"

# Print the list of file names
with open(ha2x3h_path, 'w') as file:
    for ha2x3h_name in ha2x3h_names:
        file.write(f"{ha2x3h_name}\n")

with open(ha2x1hi_path, 'w') as file:
    for ha2x1hi_name in ha2x1hi_names:
        file.write(f"{ha2x1hi_name}\n")

with open(ha2x1h_path, 'w') as file:
    for ha2x1h_name in ha2x1h_names:
        file.write(f"{ha2x1h_name}\n")

with open(ha2x1d_path, 'w') as file:
    for ha2x1d_name in ha2x1d_names:
        file.write(f"{ha2x1d_name}\n")        
```

```
---------------------更新：DATM用了GSWP的大气驱动数据，导致跑出来的结果没有明显的变化，参考：https://bb.cgd.ucar.edu/cesm/threads/ssp370-compset-with-minimal-temperature-changes.9087/#post-52683---------------------------
---------------------更新: 不是所有的spin-up生成的文件都要拷贝，参考：https://bb.cgd.ucar.edu/cesm/threads/how-to-spin-up-a-transient-climate-simulation.5562/---------------------------
---------------------更新：跑到2035年停，archive中输出了clm, masart, glc文件---------------------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case0 --compset SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127Case0
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=5
./xmlchange RESUBMIT=16
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./case.setup
./preview_namelists
vim user_nl_clm

fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'
flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
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

./case.setup --reset
cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127Case0/run    
./case.build
./preview_run
./case.submit
```

- **`A`** **A** **A** **A** **A** **A** **A** **A** ==> Average
- **`B`** **B** **B** **B** **B** **B** **B** **B** ==> GMT 00:00:00 average
- **`I`** **I** **I** **I** **I** **I** **I** **I** ==> Instantaneous
- **`M`** **M** **M** **M** **M** **M** **M** **M** ==> Minimum
- **`X`** **X** **X** **X** **X** **X** **X** **X** ==> Maximum
- **`L`** **L** **L** **L** **L** **L** **L** **L** ==> Local-time
- **`S`** **S** **S** **S** **S** **S** **S** **S** ==> Standard deviation

### Test_case0

```
-----------------------更新：如果是夏季的时候urban_ac不是0；如果按年输出，得到的结果是12月份的urban_ac, 而不是累计的urban_ac-----------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case0test2 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127Case0test2

./xmlchange CLM_CONFIG_OPTS="-bgc sp" -append
./xmlchange RUN_STARTDATE=2015-07-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./case.setup
./preview_namelists
vim user_nl_clm

use_init_interp = .true.
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
hist_nhtfrq=0
hist_mfilt=1
hist_fincl1 = 'HIA','HIA_R','HIA_U','APPAR_TEMP','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT','SWBGT_U','SWBGT_R','HUMIDEX','HUMIDEX_U','HUMIDEX_R','DISCOIS','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT','EPT_U','EPT_R','FGR','FGR_U','FGR_R','FIRA','FIRA_R','FIRA_U','FIRE','FIRE_U','FIRE_R','FSA','FSA_U','FSA_R','FSH','FSH_U','FSH_R','FSM','FSM_U','FSM_R','QRUNOFF','QRUNOFF_U','QRUNOFF_R','RH2M','RH2M_U','RH2M_R','TBUILD','TEQ','TEQ_R','TEQ_U','TREFMNAV','TREFMNAV_U','TREFMNAV_R','TREFMXAV','TREFMXAV_U','TREFMXAV_R','TSA','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT','WBT_U','WBT_R','WBA','WBA_U','WBA_R','TG','TG_U','TG_R','FSDS','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'

cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127Case0test2/run    
./case.build
./preview_run
./case.submit
-----------------URBAN_AC=0可能是因为模拟的时间是冬天，没有开空调----------------
-----------------change urban_hac_on =  'ON_WASTEHEAT' to urban_hac_on =  'ON' 如果开‘ON_WASTEHEAT’的话只会计算waste heat, 而URBAN_AC=0---------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case0test --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127Case0test

./xmlquery CLM_BLDNML_OPTS
# CLM_BLDNML_OPTS: -bgc bgc -crop
# refer to: https://escomp.github.io/ctsm-docs/versions/master/html/users_guide/overview/getting-help.html
./xmlchange CLM_CONFIG_OPTS="-bgc sp" -append
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=ndays
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./case.setup
./preview_namelists
vim user_nl_clm

urban_hac = 'ON'
use_init_interp = .true.
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
hist_nhtfrq=-1
hist_mfilt=24
hist_fincl1 = 'HIA','HIA_R','HIA_U','APPAR_TEMP','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT','SWBGT_U','SWBGT_R','HUMIDEX','HUMIDEX_U','HUMIDEX_R','DISCOIS','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT','EPT_U','EPT_R','FGR','FGR_U','FGR_R','FIRA','FIRA_R','FIRA_U','FIRE','FIRE_U','FIRE_R','FSA','FSA_U','FSA_R','FSH','FSH_U','FSH_R','FSM','FSM_U','FSM_R','QRUNOFF','QRUNOFF_U','QRUNOFF_R','RH2M','RH2M_U','RH2M_R','TBUILD','TEQ','TEQ_R','TEQ_U','TREFMNAV','TREFMNAV_U','TREFMNAV_R','TREFMXAV','TREFMXAV_U','TREFMXAV_R','TSA','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT','WBT_U','WBT_R','WBA','WBA_U','WBA_R','TG','TG_U','TG_R','FSDS','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'

cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127Case0test/run    
./case.build
./preview_run
./case.submit
--------------更新：因为设置hist_dov2xy(1) = .false.，所以没有输出2d的数据--------------
--------------20231125更新：ISSP370Clm50BgcCrop在history模式下和SP有很大区别，但是在future模式下两者的namelist基本相同----------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231122Case0test2 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231122Case0test2

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange RUN_REFCASE=20231120SpinUp2
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE

./case.setup
./preview_namelists

vim user_nl_clm
calc_human_stress_indices = 'ALL'
hist_dov2xy(1) = .false.
hist_empty_htapes = .true.
hist_nhtfrq=0
hist_mfilt=12
hist_fincl1 = 'HIA','HIA_R','HIA_U','APPAR_TEMP','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT','SWBGT_U','SWBGT_R','HUMIDEX','HUMIDEX_U','HUMIDEX_R','DISCOIS','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT','EPT_U','EPT_R','FGR','FGR_U','FGR_R','FIRA','FIRA_R','FIRA_U','FIRE','FIRE_U','FIRE_R','FSA','FSA_U','FSA_R','FSH','FSH_U','FSH_R','FSM','FSM_U','FSM_R','QRUNOFF','QRUNOFF_U','QRUNOFF_R','RH2M','RH2M_U','RH2M_R','TBUILD','TEQ','TEQ_R','TEQ_U','TREFMNAV','TREFMNAV_U','TREFMNAV_R','TREFMXAV','TREFMXAV_U','TREFMXAV_R','TSA','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT','WBT_U','WBT_R','WBA','WBA_U','WBA_R','TG','TG_U','TG_R','FSDS','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW'



----------------------------------下面这样子太麻烦了----------------------------------
hist_fexcl1 = 'ACTUAL_IMMOB', 'AGNPP', 'ALT', 'ALTMAX', 'AR','ATM_TOPO','BAF_CROP','BAF_PEATF','BCDEP','BGNPP','BSW','BTRAN2','BTRANMN','CH4_SURF_AERE_SAT','CH4_SURF_AERE_UNSAT','CH4_SURF_DIFF_SAT','CH4_SURF_DIFF_UNSAT','CH4_SURF_EBUL_SAT','CH4_SURF_EBUL_UNSAT','CH4PROD','COL_FIRE_CLOSS','COL_FIRE_NLOSS','CONC_O2_SAT','CONC_O2_UNSAT','COST_NFIX','COST_NRETRANS','CPHASE','CPOOL','CROPPROD1C','CROPPROD1C_LOSS','CROPPROD1N','CROPPROD1N_LOSS','CROPSEEDC_DEFICIT','CWDC','CWDC_LOSS','CWDC_vr','CWDN','CWND_vr','DEADCROOTC','DEADCROOTN','DEADSTEMC','DEADSTEMN','DENIT','DISPVEGN','DISPVEGC','DSL','DSTDEP','DSTFLXT','DWT_CONV_CFLUX','DWT_CONV_CFLUX_DRIBBLED','DWT_CONV_NFLUX','DWT_CROPPROD1C_GAIN','DWT_CROPPROD1N_GAIN','DWT_SEEDN_TO_DEADSTEM','DWT_SEEDN_TO_LEAF','DWT_SLASH_CFLUX','DWT_WOODPRODC_GAIN','DWT_WOODPRODN_GAIN','DZLAKE','DZSOI','EFLX_DYNBAL','EFLX_GRND_LAKE','ELAI','ER','ERRH2O','ERRH2OSNO','ERRSEB','ERRSOI','ERRSOL','ESAI','F_DENIT','F_N2O_DENIT','F_N2O_NIT','F_NIT','FAREA_BURNED','FCEV','FCH4','FCH4_DFSAT','FCH4TOCO2','FCOV','FCTR','FFIX_TO_SMINN','FGEV','FGR12','FH2OSFC','FINUNDATED','FIRE','FIRE_R','FLDS','FPI','FPSN','FREE_PETRANSN_TO_NPOOL','FROOTC','FROOTC_ALLOC','FROOTC_LOSS','FROOTN','FSAT','FSDS','FSDSND','FSDSNDLN','FSDSNI','FSDSVD','FSDSVDLN','FSDSVI','FSDSVILN','FSH_G','FSH_PRECIP_CONVERSION','FSH_RUNOFF_ICE_TO_LIQ','FSH_TO_COUPLER','FSH_V','FSNO','FSNO_EFF','FSR','FSRND','FSRNDLN','FSRNI','FSRVD','FSRVDLN','FSRVI','FUELC','GPP','GR','GRAINC','GRAINC_TO_FOOD','GRAINC_TO_SEED','GRAINN','GROSS_NMIN','GSSHA','GSSHALN','GSSUN','GSSUNLN','H2OCAN','','','','','','','','','','','','','','','','','',''

# !!!需要再对照一下https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/setting-up-and-running-a-case/master_list_file.html，看看是否完整
cp -r $CESM_ROOT/archive/20231120SpinUp2/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231122Case0test/run

./case.build
./preview_run
./case.submit
```

### Error

Error1:

svn: E175013: Access to '/trunk/inputdata/lnd/clm2/ndepdata/fndep_clm_SSP370_b.e21.BWSSP370cmip6.f09_g17.CMIP6-SSP3-7.0-WACCM.002_1849-2101_monthly_0.9x1.25_c211216.nc' forbidden

**solve** use svn rather than ftp (the ftp files are less than svn),

[https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2](https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2)

Error2:

NetCDF: Not a valid ID  
pio_support::pio_die:: myrank=          -1 : ERROR: ionf_mod.F90:         235 : NetCDF: Not a valid ID

(CTSM History Fields)[[https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/setting-up-and-running-a-case/master_list_file.html](https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/setting-up-and-running-a-case/master_list_file.html)]

Error3:

Reading initial conditions from 20231126SpinUp.clm2.r.2015-01-01-00000.nc  
(GETFIL): attempting to find local file 20231126SpinUp.clm2.r.2015-01-01-00000.nc  
(GETFIL): using 20231126SpinUp.clm2.r.2015-01-01-00000.nc in current working directory  
Reading restart dataset  
check_dim ERROR: mismatch of input dimension       127738  with expected value       505972  for variable column  
Did you mean to set use_init_interp = .true. in user_nl_clm?  
(Setting use_init_interp = .true. is needed when doing a  
transient run using an initial conditions file from a non-transient run,  
or a non-transient run using an initial conditions file from a transient run,  
or when running a resolution or configuration that differs from the initial conditions.)  
ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/src/main/ncdio_pio.F90.in at line 368

**solve**: use_init_interp = .true.

Error4:

hist_htapes_build Initializing clm2 history files

htapes_fieldlist ERROR: VENTILATION in fincl(          80 ) for history tape            1  not found  
ENDRUN:  
ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/src/main/histFileMod.F90 at line 698

**solve**: 删掉ventilation

Error5:

ERROR: Unknown error submitted to shr_abort_abort.  
htapes_fieldlist ERROR: area                               in fexcl(           1 ) for history tape            1  not found

**solve**: 删掉‘rtmhist_fexcl1’ 中的‘area’

Error6:

ERROR: (shr_stream_verifyTCoord) ERROR: calendar dates must be increasing

查看atm.log和lnd.log 发现在atm.log中：

(shr_dmodel_readstrm) file ub: /mnt/lustre/a2fs-nvme/work/n02/n02/yuansun/CPLHIST/SSP370/b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.102.cpl.ha2x1hi.2034-02.nc     671  
(datm_comp_run) atm: model date 20340228   81000s  
(shr_stream_verifyTCoord) ERROR: calendar dates must be increasing

**solve**: 不知道哪一年的数据出了问题，逐年跑进行排除；

Error7:

srun: error: Task launch for StepId=5135238.0 failed on node nid003078: Communication connection failure  
srun: error: Application launch failed: Communication connection failure  
srun: Job step aborted: Waiting up to 32 seconds for job step to finish.  
srun: error: Timed out waiting for job step to complete

## Case1: 0.9 albedo / ROOF_0.9

- change constant albedo file

- [use spin-up file](https://bb.cgd.ucar.edu/cesm/threads/how-to-spin-up-a-transient-climate-simulation.5562/)
  
  - Should not be 'hybrid'

```
# check lnd_in
# 修改user_nl_clm
# 本来为：fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c190214.nc'
# 但是不需要78pfts

export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1

cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case1 --compset SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127Case1
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=5
./xmlchange RESUBMIT=16
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./case.setup
./preview_namelists

vim user_nl_clm

fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/project1/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc'
flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
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

cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127Case1/run
./case.setup --reset
./case.build
./preview_run
./case.submit
```

### Error

Error1:

Attempting to read surface boundary data .....  
(GETFIL): attempting to find local file surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc  
(GETFIL): using /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/project1/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc  
check_var: variable xc is not on dataset  
surfrd_get_data lon_var = LONGXY lat_var =LATIXY  
check_dim ERROR: mismatch of input dimension           79  with expected value           17  for variable lsmpft  
ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/src/main/ncdio_pio.F90.in at line 368

Error2:

urban net solar radiation balance error for ib=           1  err=    2.3954161057397894E-003

l=         3523  ib=            1

stot_dir        =    1.0000000000000000

stot_dif        =   0.99999999999999989

sabs_canyon_dir =   0.63051053943858482

sabs_canyon_dif =   0.63038536250201349

sref_canyon_dir =   0.36829161263261440

sref_canyon_dif =   0.36829161263261440

clm model is stopping

calling getglobalwrite with decomp_index=         3523  and clmlevel= landunit

local  landunit index =         3523

global landunit index =        38394

global gridcell index =        12870

gridcell longitude    =    127.50000000000000

gridcell latitude     =    36.282722513088991

landunit type         =            7

ENDRUN:

ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/components/clm/src/biogeophys/UrbanAlbedoMod.F90 at line 1256

**note**: in the standard clm: ' if (abs(err) > 0.001_r8 ) then', change to '0.0024'

## Case2: dynamic albedo / ROOF_TV

- f09_g17 scientifically supported 'IHistClm50BgcCrop'；

- when running 'ISSP370Clm50BgcCrop', the [anomaly forcing capability](https://bb.cgd.ucar.edu/cesm/threads/some-question-about-spin-up.8165/) is recommended.
  
  - [Running with anomaly forcing](https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/running-special-cases/Running-with-anomaly-forcing.html)
  
  ```
  anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
  ```

- change 'namelist_defaults_clm4_5.xml': <stream_fldfilename_urbanalbtvroof phys="clm5_0" hgrid="0.9x1.25" >lnd/clm2/urbandata/CLM50_DynUrbanAlbedoRoof_YuanSun_2023_0.9x1.25_simyr1849-2106_c20231005.nc</stream_fldfilename_urbanalbtvroof>

```
# RRcase2: add h0 variables and re-run simulations
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case2
bash Case2.sh
bash Case2_1.sh

# transfer data to csf3
scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RRCase2/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RRCase2/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RRCase2_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RRCase2/lnd_hist
-------------------------------------------------------------------------------------
echo "hist_dov2xy = .false.,.true." >> user_nl_clm
echo "hist_type1d_pertape = 'LAND',' '" >> user_nl_clm
echo "hist_nhtfrq= 0,0" >> user_nl_clm
echo "hist_mfilt= 12,12" >> user_nl_clm
echo "hist_fincl1 = 'URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW','TREFMXAV_U','TREFMNAV_U', 'TREFMXAV_R', 'TREFMNAV_R', 'WASTEHEAT', 'HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U'" >> user_nl_clm
echo "hist_fincl2 = 'WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'" >> user_nl_clm
echo "rtmhist_nhtfrq = -876000" >> user_nl_mosart
```

```
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127case2 --compset SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127case2
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=5
./xmlchange RESUBMIT=16
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./case.setup
./preview_namelists
vim user_nl_clm

fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_16pfts_Irrig_CMIP6_simyr1850_c190214.nc'
flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_16pfts_Irrig_CMIP6_simyr1850-2100_c190214.nc'
maxpatch_pft = 17
Dynamic_UrbanAlbedoRoof = .true.
use_init_interp = .true.
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
hist_dov2xy = .false.,.true.
hist_type1d_pertape = 'LAND',' '
hist_nhtfrq=0,0
hist_mfilt=12,12
hist_fincl1 = 'URBAN_AC','URBAN_HEAT','TBUILD_MAX','TBUILD','TSA_U','RAIN','FLDS','QBOT','PBOT','TBOT','SNOW'
hist_fincl2 = 'WIND','FSDS','HIA_R','HIA_U','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT_U','SWBGT_R','HUMIDEX_U','HUMIDEX_R','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT_U','EPT_R','FGR_U','FGR_R','FIRA_R','FIRA_U','FIRE_U','FIRE_R','FSA_U','FSA_R','FSH_U','FSH_R','FSM_U','FSM_R','QRUNOFF_U','QRUNOFF_R','RH2M_U','RH2M_R','TBUILD','TEQ_R','TEQ_U','TREFMNAV_U','TREFMNAV_R','TREFMXAV_U','TREFMXAV_R','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT_U','WBT_R','WBA_U','WBA_R','TG_U','TG_R','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX'

./case.setup --reset
./case.build
cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127case2/run
./case.submit

--------------------下面这个是测试用的case-------------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo
cd cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231117case2 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported

cd $CESM_ROOT/runs/20231117case2

./xmlquery RUN_STARTDATE
# RUN_STARTDATE: 2015-01-01
./xmlquery RESUBMIT
./xmlquery CONTINUE_RUN

./xmlchange ATM_NTASKS=128,CPL_NTASKS=128,GLC_NTASKS=128,ICE_NTASKS=128,LND_NTASKS=128,OCN_NTASKS=128,ROF_NTASKS=128,WAV_NTASKS=128
./xmlchange STOP_OPTION=nyears
./xmlchange RESUBMIT=1

./case.setup
./preview_namelists
vim user_nl_clm
Dynamic_UrbanAlbedoRoof = .true.
./case.build

./preview_run 
#查看case info: nodes，total tasks, tasks per node, thread count
./case.submit
# 在’ISSP370Clm50BgcCrop‘模式下只有clm运行，所以即便设置’‘
# 128个核，1个节点，跑2年，
2023-11-18 18:50:20: case.run starting；# 03:07:00
2023-11-18 21:57:02: case.run success；
2023-11-18 22:08:46: case.run starting；
2023-11-19 01:19:21: case.run success；
```

### Error

Error1:

***

glc aborting...  
ERROR reading time_manager_nml

***

ERROR: glc_communicate.F90: abort_message_environment

- The land ice component is [CISM](https://escomp.github.io/cism-docs/cism-in-cesm/versions/release-cesm2.0/html/running-and-modifying.html), the Community Ice Sheet Model
- 感觉像是模型的问题 ，因为cism_in 打不开

## Case3: IMPROAD_TV

```
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case3

# transfer case3 outputs to csf3

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case3/rest/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case3/restart

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case3/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case3/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case3_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case3/lnd_hist
```

### Error

ERROR: Command /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/bld/build-namelist failed rc=255  
out=  
err=File::Glob::glob() will disappear in perl 5.30. Use File::Glob::bsd_glob() instead. at /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/bld/CLMBuildNamelist.pm line 4353.  
ERROR : CLM build-namelist::CLMBuildNamelist::process_namelist_commandline_infile() : Invalid namelist variable in '-infile' /work/n02/n02/yuansun/cesm/runs/Case3/Buildconf/clmconf/namelist.  
ERROR: in _validate_pair (package Build::NamelistDefinition): Variable name dynamic_urbanalbedoimproad not found in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/bld/namelist_files/namelist_definition_drv.xml, /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/bld/namelist_files/namelist_definition_drv_flds.xml, /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4/components/clm/bld/namelist_files/namelist_definition_clm4_5.xml

**solev**: 得用dynamic albedo的代码跑，而不是用default 2.1.4的代码跑；

## Case4: ROOF_IMPROAD_TV

```
# transfer case4 outputs to csf3

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case4/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case4/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case4_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case4/lnd_hist
```

## Case5: WALL_TV

- time-varying wall albedo

```
# 漏了SWBGT_U
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case5
bash Rcase5.sh
bash Rcase5_1.sh

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RRCase5/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RRCase5/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RRCase5/rest/2100-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RRCase5/restart

------------------------------------------------------
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case5
bash case5.sh
# 补一年
bash case5_1.sh

# transfer outputs to csf3
scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RCase5/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RCase5/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/RCase5_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/RCase5/lnd_hist
```

## case6: ROOF_IMPROAD_WALL_TV

```
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/case6
bash case6.sh

# 因为error中断了一次
bash case6_1.sh

# data transfer to csf3
scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case6/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case6/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case6_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case6/lnd_hist
```

### Error

Error1:

urban net solar radiation balance error for ib=           1  err=    1.0033853350783772E-003  
l=        29809  ib=            1  
stot_dir        =    1.0000000000000000  
stot_dif        =    1.0000000000000000  
sabs_canyon_dir =   0.67356834762516238  
sabs_canyon_dif =   0.67685677488016349  
sref_canyon_dir =   0.32592731478200510  
sref_canyon_dif =   0.32592731478200510  
clm model is stopping  
calling getglobalwrite with decomp_index=        29809  and clmlevel= landunit  
local  landunit index =        29809  
global landunit index =        36439  
global gridcell index =        12296  
gridcell longitude    =    58.750000000000000  
gridcell latitude     =    32.513089005235592  
landunit type         =            7  
ENDRUN:  
ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/components/clm/src/biogeophys/UrbanAlbedoMod.F90 at line 1256

```
将if (abs(err) > 0.001_r8 ) then 改为if (abs(err) > 0.003_r8 )
```

## Computational Performance 2

```
# branch 1次
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/computation_performance2

bash con_n1.sh  #2015
bash con_n1_1.sh #2016
bash con_n1_2.sh #2017

bash dy_n1.sh # 2015-2017
```

## Computational Performance 1

- [TIMING PROFILE](https://esmci.github.io/cime/versions/cesm2.2/html/users_guide/timers.html)

- [How to evaluate computational performance](https://bb.cgd.ucar.edu/cesm/threads/how-to-evaluate-computational-performance-with-modified-code.9023/#post-52356)

- job nodes 根据NTASK的值自动生成

- 已知archer2上1个node=128 cores
  
  - if './xmlchange NTASK=128', 自动分配node=1
  - if './xmlchange NTASK=256', 自动分配node=2

- 分别测试small (1node, 128 cores), medium (4 nodes, 512 cores), and large (8 nodes, 1024 cores) task counts

- 应该是一次性跑完，没有resubmit以及重新排队的时间

```
cd /work/n02/n02/yuansun/shell_scripts/archive/project1/computation_performance
bash cp_dyn_n1.sh
bash cp_dyn_n4.sh
bash cp_dyn_n6.sh
bash cp_dyn_n8.sh
bash cp_dyn_n12.sh
bash cp_dyn_n16.sh

bash cp_con_n1.sh
bash cp_con_n4.sh
bash cp_con_n6.sh
bash cp_con_n8.sh
bash cp_con_n12.sh
bash cp_con_n16.sh
```

```
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts

# Case1-128
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance1 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance1

./xmlchange RUN_REFCASE=20231120SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=128
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/project1/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc'
Dynamic_UrbanAlbedoRoof = .false.
./case.build
./preview_run
./case.submit

# Case1-512
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance2 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance2

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/project1/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc'
Dynamic_UrbanAlbedoRoof = .false.
./case.build
./preview_run
./case.submit

# Case1-1024
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance3 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance3

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=1024
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/project1/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c231120_urbanalbedo0.9.nc'
Dynamic_UrbanAlbedoRoof = .false.
./case.build
./preview_run
./case.submit

# Case2-128
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicAlbedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance4 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance4

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=128
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
Dynamic_UrbanAlbedoRoof = .true.
./case.build
./preview_run
./case.submit

# Case1-512
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance2 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance2

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=512
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
Dynamic_UrbanAlbedoRoof = .true.
./case.build
./preview_run
./case.submit

# Case1-1024
./create_newcase --case $CESM_ROOT/runs/20231120ComputingPerformance3 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-DUICV --machine archer2 

cd $CESM_ROOT/runs/20231120ComputingPerformance3

./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange LND_NTASKS=1024
./xmlchange STOP_OPTION=nyears
./xmlchange STOP_N=8
./xmlchange RESUBMIT=10

./case.setup
./preview_namelists
vim user_nl_datm
anomaly_forcing = ‘Anomaly.Forcing.Precip’,’Anomaly.Forcing.Temperature’,’Anomaly.Forcing.Pressure’,’Anomaly.Forcing.Humidity’,’Anomaly.Forcing.Uwind’,’Anomaly.Forcing.Vwind’,’Anomaly.Forcing.Shortwave’,’Anomaly.Forcing.Longwave’
vim user_nl_clm
Dynamic_UrbanAlbedoRoof = .true.
./case.build
./preview_run
./case.submit
```

## Case7: DynamicUrban_Albedo

### compile dynamic_urban to clm50

```

```

- get_do_transient_urban
- tried to use 'sh'

```
touch 20231127Case7.sh
vim 20231127Case7.sh

chmod -x 20231127Case7.sh
./20231127Case7.sh
```

### Test_case7

```
export CESM_ROOT=/work/n02/n02/yuansun/cesm
module load cray-python/3.9.13.1
cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicUrban_Albedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case7test --compset SSP370_DATM%GSWP3v1_CLM50%SP_SICE_SOCN_MOSART_CISM2%NOEVOLVE_SWAV --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported
cd $CESM_ROOT/runs/20231127Case7test
./xmlchange RUN_STARTDATE=2015-01-01
./xmlchange NTASKS=1
./xmlchange STOP_OPTION=ndays
./xmlchange STOP_N=1
./xmlchange RESUBMIT=0
./xmlchange RUN_REFCASE=20231126SpinUp
./xmlchange RUN_REFDATE=2015-01-01
./xmlchange RUN_TYPE=hybrid
./xmlchange GET_REFCASE=FALSE
./xmlchange NTHRDS=3
./xmlchange DEBUG=TRUE
./case.setup
./preview_namelists
vim user_nl_clm

Dynamic_UrbanAlbedoRoof = .true.
do_transient_urban = .true.
use_init_interp = .true.
hist_empty_htapes = .true.
calc_human_stress_indices = 'ALL'
fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc'
flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_SSP3-7.0_78_CMIP6_1850-2100_c230517.nc'
hist_nhtfrq=-1
hist_mfilt=24
hist_fincl1 = 'HIA','HIA_R','HIA_U','APPAR_TEMP','APPAR_TEMP_U','APPAR_TEMP_R','SWBGT','SWBGT_U','SWBGT_R','HUMIDEX','HUMIDEX_U','HUMIDEX_R','DISCOIS','DISCOIS_R','DISCOIS_U','EFLX_LH_TOT','EFLX_LH_TOT_R','EFLX_LH_TOT_U','EPT','EPT_U','EPT_R','FGR','FGR_U','FGR_R','FIRA','FIRA_R','FIRA_U','FIRE','FIRE_U','FIRE_R','FSA','FSA_U','FSA_R','FSH','FSH_U','FSH_R','FSM','FSM_U','FSM_R','QRUNOFF','QRUNOFF_U','QRUNOFF_R','RH2M','RH2M_U','RH2M_R','TBUILD','TEQ','TEQ_R','TEQ_U','TREFMNAV','TREFMNAV_U','TREFMNAV_R','TREFMXAV','TREFMXAV_U','TREFMXAV_R','TSA','TSA_R','TSA_U','URBAN_AC','URBAN_HEAT','WASTEHEAT','WBT','WBT_U','WBT_R','WBA','WBA_U','WBA_R','TG','TG_U','TG_R','FSDS','FLDS','QBOT','PBOT','TBOT','RAIN','SNOW','EFLXBUILD','TBUILD_MAX','WIND'

cp -r $CESM_ROOT/archive/20231126SpinUp/rest/2015-01-01-00000/* $CESM_ROOT/runs/20231127Case7test/run   

./case.build
./preview_run
./case.submit

-------------------------更新：surface data with 'pct_urban_max'------------------------
export CESM_ROOT=/work/n02/n02/yuansun/cesm 
module load cray-python/3.9.13.1

cd /work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicUrban_Albedo/cime/scripts
./create_newcase --case $CESM_ROOT/runs/20231127Case7 --compset ISSP370Clm50BgcCrop --res f09_g17 --project n02-duicv --machine archer2 --run-unsupported

cd $CESM_ROOT/runs/20231127

./xmlchange LND_NTASKS=128
./xmlchange STOP_OPTION=ndays
./xmlchange STOP_N=1

./case.setup
./preview_namelists

vim user_nl_clm
Dynamic_UrbanAlbedoRoof = .true.
do_transient_urban = .true.
./case.build
./preview_run
./case.submit
```

### Error

Error1:

Symbol 'pct_urban_max' referenced at (1) not found in module 'clm_instur'

**Solved**: data from bowen: 'landuse.timeseries_0.9x1.25_SSP3-7.0_78_CMIP6_1850-2100_c230517.nc'

change flanduse_timeseries rather fsurdata

Error2:

Attempting to read landuse.timeseries data .....  
(GETFIL): attempting to find local file landuse.timeseries_0.9x1.25_SSP3-7.0_78pfts_CMIP6_simyr1850-2100_c190214.nc  
(GETFIL): using /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/landuse.timeseries_0.9x1.25_SSP3-7.0_78pfts_CMIP6_simyr1850-2100_c190214.nc  
ncd_inqvid: variable PCT_URBAN_MAX is not on dataset  
ENDRUN:  
ERROR:  ERROR: PCT_URBAN_MAX is not on landuse.timeseries fileERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicUrban_Albedo/components/clm/src/main/surfrdMod.F90 at line 856

- The two CESM-compatible transient urban land use time series 578 datasets (i.e., GO2020- and BNU-based) are available from the CESM input data repository on 579 NCAR’s Cheyenne cluster as an optional surface data input for CTSM/CLMU.

Error3:

Attempting to read GLACIER_REGION...  
(GETFIL): attempting to find local file landuse.timeseries_0.9x1.25_SSP3-7.0_78_CMIP6_1850-2100_c230517.nc  
(GETFIL): using /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_SSP3-7.0_78_CMIP6_1850-2100_c230517.nc  
ncd_inqvid: variable GLACIER_REGION is not on dataset  
ENDRUN:  
ERROR:  ERROR: GLACIER_REGION NOT on surfdata fileERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicUrban_Albedo/components/clm/src/main/glcBehaviorMod.F90 at line 662

**solved**: change flanduse_timeseries = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/landuse.timeseries_0.9x1.25_SSP3-7.0_78_CMIP6_1850-2100_c230517.nc' rather fsurdata = ''

Error4:

pio_support::pio_die:: myrank=          -1 : ERROR: box_rearrange.F90.in:         534 : box_rearrange_io2comp: size(compbuf)=           1  not equal to size(compdof)=         123

MPICH ERROR [Rank 504] [job id 4972440.0] [Tue Nov 28 20:29:29 2023] [nid006113] - Abort(1) (rank 504 in comm 0): application called MPI_Abort(MPI_COMM_WORLD, 1) - process 504

**Solved**: beside change flanduse_timeseries, the fsurdat should also be changed.

fsurdat = '/work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc'

Error5:

Reading in urban input data from fsurdat file ...  
(GETFIL): attempting to find local file surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc  
(GETFIL): using /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc  
Opened existing file /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc      458752  
UrbanInput                      /work/n02/n02/yuansun/cesm/cesm_inputdata/lnd/clm2/surfdata_map/surfdata_0.9x1.25_SSP5-8.5_78pfts_CMIP6_simyr2015_GaoUrbanveg2015_c230601.nc  
UrbanInput: parameter nlevurb=            5 does not equal input dataset nlevurb=           10  
ENDRUN:  
ERROR: ERROR in /mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/my_cesm_sandbox_2.1.4_DynamicUrban_Albedo/components/clm/src/biogeophys/UrbanParamsType.F90 at line 560

**solve**: [change nulevurb to 10](https://bb.cgd.ucar.edu/cesm/threads/questions-on-different-versions-of-urban-raw-data.6925/) in src/main/clm_varpar.F90;

# Python analysis

```
cd /work/n02/n02/yuansun/output_analysis/
module load cray-python
export PYTHONUSERBASE=/work/n02/n02/yuansun/.local
export PATH=$PYTHONUSERBASE/bin:$PATH
source /work/n02/n02/yuansun/myvenv/bin/activate
export JUPYTER_RUNTIME_DIR=$(pwd)
jupyter lab --ip=0.0.0.0 --no-browser
# jupyter lab 命令会自动生成一个网页链接，将网页链接复制到浏览器中打开

# 跑的很慢，把跑好的数据上传到csf3上进行分析
# case0:2015-2025
# 在pc terminal上：
scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/case0_1/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case0/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/case0_1/rest/2030-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case0/restart

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/case0_2/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case0/lnd_hist

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/case0_2/rest/2031-01-01-00000/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case0/restart

scp yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case0_5/lnd/hist/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/iusers01/fatpou01/sees01/a16404ys/scratch/Projects/archive/fromArcher2/project1/case0/lnd_hist
```

## Albedo_calculation

```
sbatch runPython.sh
```

## Case0 output

- land output 的经纬度是(lat=192, lon=288)
  
  - lat:
  
  ```
  <xarray.DataArray 'lat' (lat: 192)>
  array([-90.      , -89.057594, -88.11518 , -87.172775, -86.23037 , -85.28796 ,
         -84.34555 , -83.403145, -82.46073 , -81.518326, -80.57591 , -79.63351 ,
         -78.6911  , -77.74869 , -76.80628 , -75.86388 , -74.92146 , -73.97906 ,
         -73.03665 , -72.09424 , -71.15183 , -70.20943 , -69.26701 , -68.32461 ,
         -67.3822  , -66.43979 , -65.49738 , -64.55498 , -63.612564, -62.67016 ,
         -61.72775 , -60.78534 , -59.842934, -58.900524, -57.958115, -57.015705,
         -56.0733  , -55.13089 , -54.18848 , -53.246075, -52.303665, -51.361256,
         -50.41885 , -49.47644 , -48.53403 , -47.59162 , -46.649216, -45.706806,
         -44.764397, -43.82199 , -42.87958 , -41.937172, -40.994766, -40.052357,
         -39.109947, -38.167538, -37.225132, -36.282722, -35.340313, -34.397907,
         -33.455498, -32.51309 , -31.57068 , -30.628273, -29.685863, -28.743456,
         -27.801046, -26.858639, -25.916231, -24.973822, -24.031414, -23.089005,
         -22.146597, -21.20419 , -20.26178 , -19.319372, -18.376963, -17.434555,
         -16.492147, -15.549738, -14.607329, -13.664922, -12.722513, -11.780105,
         -10.837696,  -9.895288,  -8.95288 ,  -8.010471,  -7.068063,  -6.125654,
          -5.183246,  -4.240838,  -3.298429,  -2.356021,  -1.413613,  -0.471204,
           0.471204,   1.413613,   2.356021,   3.298429,   4.240838,   5.183246,
           6.125654,   7.068063,   8.010471,   8.95288 ,   9.895288,  10.837696,
          11.780105,  12.722513,  13.664922,  14.607329,  15.549738,  16.492147,
          17.434555,  18.376963,  19.319372,  20.26178 ,  21.20419 ,  22.146597,
          23.089005,  24.031414,  24.973822,  25.916231,  26.858639,  27.801046,
          28.743456,  29.685863,  30.628273,  31.57068 ,  32.51309 ,  33.455498,
          34.397907,  35.340313,  36.282722,  37.225132,  38.167538,  39.109947,
          40.052357,  40.994766,  41.937172,  42.87958 ,  43.82199 ,  44.764397,
          45.706806,  46.649216,  47.59162 ,  48.53403 ,  49.47644 ,  50.41885 ,
          51.361256,  52.303665,  53.246075,  54.18848 ,  55.13089 ,  56.0733  ,
          57.015705,  57.958115,  58.900524,  59.842934,  60.78534 ,  61.72775 ,
          62.67016 ,  63.612564,  64.55498 ,  65.49738 ,  66.43979 ,  67.3822  ,
          68.32461 ,  69.26701 ,  70.20943 ,  71.15183 ,  72.09424 ,  73.03665 ,
          73.97906 ,  74.92146 ,  75.86388 ,  76.80628 ,  77.74869 ,  78.6911  ,
          79.63351 ,  80.57591 ,  81.518326,  82.46073 ,  83.403145,  84.34555 ,
          85.28796 ,  86.23037 ,  87.172775,  88.11518 ,  89.057594,  90.      ],
        dtype=float32)
  ```
  
  - Lon: 从0°开始，往东经绕一圈
  
  ```
  <xarray.DataArray 'lon' (lon: 288)>
  array([  0.  ,   1.25,   2.5 , ..., 356.25, 357.5 , 358.75], dtype=float32)
  Coordinates:
    * lon      (lon) float32 0.0 1.25 2.5 3.75 5.0 ... 355.0 356.2 357.5 358.8
  Attributes:
      long_name:  coordinate longitude
      units:      degrees_east
  ```

## surface data

- surface data 的经纬度:
  
  - Lon:
  
  ```
  0,1,2,....,287
  ```
  
  - Lat:
  
  ```
  0, 1, ..., 287
  ```



# Data archive

```
export PATH="/work/n02/n02/yuansun/privatemodules_packages/rclone/rclone-v1.62.2-linux-amd64:$PATH"

rclone copy dropbox:Archer2/transient_albedo/archive /work/n02/n02/yuansun/archive
rclone copy dropbox:Archer2/transient_albedo/case /work/n02/n02/yuansun/case
rclone copy dropbox:Archer2/transient_albedo/input /work/n02/n02/yuansun/input
```

