# workflow

## structural

- already T2 and realigned T1 exists
- edit masks for trainig masks in T2
- atlasmasking in T2
- edit mask manually in T2
- freesurfer-pipeline

## diffusion

- DWI -> DTI by 3D slicer4
- create corpus callosum ROI using DTI
- create tracts from DWI and corpus callosum ROI
- measure tract

## statistics


# data description

- project directory : /projects/schiz/3Tprojects/2015-delre-corpuscallosum
- data directory    : /projects/schiz/3Tdata
- case directory    : /projects/schiz/3Tdata/case${caseid}
- case list         : ${projectdir}/caselist_FESZ_jun.txt
- case list blind   : ${projectdir}/caselist_FESZ_jun_blind.txt 

## strcturals

- structral directory :  ${casedir}/strct
    - T1                  :  orig-space/${caseid}-t1w.nrrd
    - T2                  :  orig-space/${caseid}-t2w.nrrd 
    - ac-pc realigned T1  :  align-space/${caseid}-t1w-realign.nrrd

## atlasmsks

- atlasmask directory : /projects/schiz/3Tprojects/2014-delre-masking
    - trainig T2             : t2s.txt
    - training masks         : masks.txt
    - caselist for atlasmask : caselist
    - atlasmask              : ${caseid}/${caseid}.atlaslabelmap.nrrd
    - atlasmask copied       : masks-fromcluster/${caseid}.atlasmask.thresh50.nrrd
    - atlasmask edited       : masks-fromcluster/${caseid}.atlasmask.thresh50-edr.nrrd 

## FreeSurfer pipipeline products

- freeusrfer     : /projects/pnl/3Tdata/freesurfer-pipeline/${caseid}.freesurfer
- realign xfm    : ${atlasmaskdir}/pipelines/realign-pipeline/${caseid}.xfm
- realigned T2   : ${atlasmaskdir}/pipelines/realign-pipeline/${caseid}-t2w-realign.nrrd
- realigned mask : ${atlasmaskdir}/pipelines/realign-edrmasks-pipeline/${caseid}.mask-realign.nrrd
- masked T1      : ${atlasmaskdir}/pipelines/realign-edrmasks-pipeline/${caseid}.t1-realign-masked.nrrd

## difusion

- input dwi directory           : ${casedir}/diff
    - input dwi                     : ${caseid}-dwi-filt-Ed.nhdr
    - input dwi after 01422         : ${caseid}-dwi-Ed.nhdr
    - input diffusion mask          : Tensor_mask-${caseid}-dwi-filt-Ed_AvGradient-edited.nhdr
- output dti directory          : ${casedir}/projects/2015-delre-corpuscallosum
    - output dti                    : ${caseid}-dwi-filt-Ed-dti.nhdr
    - output dti baseline           : ${caseid}-dwi-filt-Ed_Baseline.nhdr
    - divided corpus callosum label : ${caseid}-cc-div-roi.nrrd
    - whole corpus callosum label   : ${caseid}-cc-roi.nrrd 
- Label Number in ${caseid}-cc-div-roi.nrrd : 
    - label240: whole corpus callosum
    - label241: division1
    - label242: division2
    - label243: division3
    - label244: division4
    - label245: division5
    - label246: negative ROI
- Label Number in ${caseid}-cc-roi.nrrd : 
    - label1  : corpus callosum

## tractography

- tract data by UKFTractography with free water :
    - directory     : ${casedir}/projects/2015-delre-corpuscallosum
        - data          : ${caseid}-cc-ukf.vtk, ${caseid}-cc-div1-ukf.vtk, ..., 
        - measured data : ${caseid}-cc-ukf-values.csv
- tract data by UKFTractography whitout free water :
    - directory     : ${casedir}/projects/2015-delre-corpuscallosum/without-freeWater
        - data          : ${caseid}-cc-ukf.vtk, ${caseid}-cc-div1-ukf.vtk, ..., 
        - measured data : ${caseid}-cc-ukf-values.csv
- tract values summary
    - directory   :  ${projectdir}

## other tractography

- trial to create tract from 2 tensor whole brain tract (by Amanda) and our cc ROI in case 01269
    - directory     : ${projectdir}/testdir_fslabel
- tract data by 3DSlicer  : 
    - data          : ${caseid}-cc.vtk, ${caseid}-cc-div1.vtk, ..., 
    - measured data : ${caseid}-cc-values.csv
- tract data by WMQL      : 
    - data          : ${caseid}-cc-wmql.vtk, ${caseid}-cc-div1-wmql.vtk, ...
    - measured data : ${caseid}-cc-wmql-values.csv

## references

- 2 tensor whole brain tractography (by Amanda)
    - /rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/UKF_FE_Caselist.txt
    - /rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/${caseid}.ukf_2T_FW.vtk


# step by step 

## structural

### preprocessing

- realigned T1 and T2 in NRRD format already exist

### atlasmsks are 
- created by "redo" 
- for the cases of caselist
- in atlasmask directory : /projects/schiz/3Tprojects/2014-delre-masking
    - trainig T2             : t2s.txt
    - training masks         : masks.txt
    - caselist for atlasmask : caselist
    - output atlasmask       : ${caseid}/${caseid}.atlaslabelmap.nrrd
    - atlasmask copied       : masks-fromcluster/${caseid}.atlasmask.thresh50.nrrd
    - atlasmask edited       : masks-fromcluster/${caseid}.atlasmask.thresh50-edr.nrrd 

### FreeSurfer pipipeline

- excuted by "redo ${caseid}" 
- in /projects/pnl/3Tdata/freesurfer-pipeline
- input
    - ac-pc realigned T1  :  ${casedir}/strct/align-space/${caseid}-t1w-realign.nrrd
    - T2                  :  ${casedir}/strct/orig-space/${caseid}-t2w.nrrd 
    - atlasmask edited    :  ${atlasmaskdir}/masks-fromcluster/${caseid}.atlasmask.thresh50-edr.nrrd 
- output
    - freeusrfer     : /projects/pnl/3Tdata/freesurfer-pipeline/${caseid}.freesurfer
    - realign xfm    : ${atlasmaskdir}/pipelines/realign-pipeline/${caseid}.xfm
    - realigned T2   : ${atlasmaskdir}/pipelines/realign-pipeline/${caseid}-t2w-realign.nrrd
    - realigned mask : ${atlasmaskdir}/pipelines/realign-edrmasks-pipeline/${caseid}.mask-realign.nrrd
    - masked T1      : ${atlasmaskdir}/pipelines/realign-edrmasks-pipeline/${caseid}.t1-realign-masked.nrrd


## diffusion

### creating corpus callosum ROI

- DWI to DTI by 3D slicer
- create and edit manually corpus callosum ROI

### tractography

- UKFTractography with considering free water
    - UKFTractography --tracts ${case}-cc-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 1 --seedsFile ${case}-cc-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater
    - UKFTractography --tracts ${case}-cc-div1-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 241 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater
    - ...
- measure tracts (with free water)
    - measureTracts.py -i ${case}-cc-ukf.vtk ${case}-cc-div1-ukf.vtk ${case}-cc-div2-ukf.vtk ${case}-cc-div3-ukf.vtk ${case}-cc-div4-ukf.vtk ${case}-cc-div5-ukf.vtk -o ${case}-cc-ukf-values.csv
- UKFTractography without considering free water
    - UKFTractography --tracts without-freeWater/${case}-cc-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 1 --seedsFile ${case}-cc-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors
    - UKFTractography --tracts without-freeWater/${case}-cc-div1-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 241 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors
    - ...
- measure tracts (without free water)
    - measureTracts.py -i without-freeWater/${case}-cc-ukf.vtk without-freeWater/${case}-cc-div1-ukf.vtk without-freeWater/${case}-cc-div2-ukf.vtk without-freeWater/${case}-cc-div3-ukf.vtk without-freeWater/${case}-cc-div4-ukf.vtk without-freeWater/${case}-cc-div5-ukf.vtk -o without-freeWater/${case}-cc-ukf-values.csv 

### summarize the measured data

- extract from files of each cases 
    - inputfilepattern=${casedir}/projects/2015-delre-corpuscallosum/\${case}-cc-ukf-values.csv

## statistics

- ANCOVA? MANOVA? 
    - group  : between-subjects factor, level 2, 
    - gender : between-subjects factor, level 2, 
    - group x gender interraction 
    - time points : within-subjects factor, level 2, 
    - intracranial content volume : nuisance variable


