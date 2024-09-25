# project_transient_albedo

- The repo is used to store materials for developing transient albedo in CESM.

```
# link to the manuscript code repo
git init /Users/user/Desktop/YuanSun-UoM/project_transient_albedo
cd /Users/user/Desktop/YuanSun-UoM/project_transient_albedo
git submodule add https://github.com/envdes/code_DynamicUrbanAlbedo.git 1_code_DynamicUrbanAlbedo

# link to the CTSM code repo
git submodule add https://github.com/YuanSun-UoM/ctsm_DynamicUrbanAlbedo.git 2_ctsm_DynamicUrbanAlbedo
```

## [1_code_DynamicUrbanAlbedo](./1_code_DynamicUrbanAlbedo)



## [2_ctsm_DynamicUrbanAlbedo](./2_ctsm_DynamicUrbanAlbedo)

- This repo is used as the CTSM source code.
- The standard CLM version is clm5.0.30, used as the default version in CESM2.1.3.
- The JAMES simulations are run in the modified clm5.0.30 with transient albedo.

```
# download the standard 'release-clm5.0.30' code from CTSM repo: https://github.com/ESCOMP/CTSM
# upload the standard code to this repo, taged 'release-clm5.0.30'

# upload the modified code, taged 'release-clm5.0.30_transient_albedo'


```



## [3_simulation_record](./3_simulation_record)

- [jobscript_archer2](./3_simulation_record/jobscript_archer2)
- [notes.md](2_model_DynamicUrbanAlbedo/notes.md)