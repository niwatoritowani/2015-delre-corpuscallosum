# workflow
    - 
    - 
    - 


# data description

- project directory : /projects/schiz/3Tprojects/2015-delre-corpuscallosum
- case list         : caselist_FESZ_jun.txt
- case list blind   : caselist_FESZ_jun_blind.txt 

- T1                 :  /projects/schiz/3Tdata/case<subjID>/strct/orig-space/<subjID>-t1w.nrrd
- T2                 :  /projects/schiz/3Tdata/case<subjID>/strct/orig-space/<subjID>-t2w.nrrd 
- ac-pc realigned T1 : /projects/schiz/3Tdata/case<subjID>/strct/align-space/<subjID>-t1w-realign.nrrd

## atlasmsks are created by "redo <sunjID>" in /projects/schiz/3Tprojects/2014-delre-masking

- atlasmask        : /projects/schiz/3Tprojects/2014-delre-masking/<subjID>/<subjID>.atlaslabelmap.nrrd
- atlasmask copied : /projects/schiz/3Tprojects/2014-delre-masking/masks-fromcluster/<subjID>.atlasmask.thresh50.nrrd
- atlasmask edited : /projects/pnl/3Tprojects/2014-delre-masking/masks-fromcluster/<subjID>.atlasmask.thresh50-edr.nrrd 

## FreeSurfer pipipeline is excuted by "redo <subjID>" in /projects/pnl/3Tdata/freesurfer-pipeline/

- freeusrfer     : /projects/pnl/3Tdata/freesurfer-pipeline/<subjID>.freesurfer
- realign xfm    : /projects/schiz/3Tprojects/2014-delre-masking/pipelines/realign-pipeline/<subjID>.xfm
- realigned T2   : /projects/schiz/3Tprojects/2014-delre-masking/pipelines/realign-pipeline/<subjID>-t2w-realign.nrrd
- realigned mask : /projects/schiz/3Tprojects/2014-delre-masking/pipelines/realign-edrmasks-pipeline/<subjID>.mask-realign.nrrd
- masked T1      : /projects/schiz/3Tprojects/2014-delre-masking/pipelines/realign-edrmasks-pipeline/<subjID>.t1-realign-masked.nrrd

## difusion

- input dwi directory           : /projects/schiz/3Tdata/case<subjID>/diff
- input dwi                     : <subjID>-dwi-filt-Ed.nhdr
- input dwi after 01422         : <subjID>-dwi-Ed.nhdr
- input diffusion mask          : Tensor_mask-<subjID>-dwi-filt-Ed_AvGradient-edited.nhdr
- output dti directory          : /projects/schiz/3Tdata/case<subjID>/projects/2015-delre-corpuscallosum
- output dti                    : <subjID>-dwi-filt-Ed-dti.nhdr
- output dti baseline           : <subjID>-dwi-filt-Ed_Baseline.nhdr
- divided corpus callosum label : <subjID>-cc-div-roi.nrrd
- whole corpus callosum label   : <subjID>-cc-roi.nrrd 
- Label Number: 
    - label240: whole corpus callosum
    - label241: division1
    - label242: division2
    - label243: division3
    - label244: division4
    - label245: division5
    - label246: negative ROI

## tractography

- tract data by UKFTractography with free water :
    - directory     : /projects/schiz/3Tdata/case<subjID>/projects/2015-delre-corpuscallosum
    - data          : <subjID>-cc-ukf.vtk, <subjID>-cc-div1-ukf.vtk, ..., 
    - measured data : <subjID>-cc-ukf-values.csv
- tract data by UKFTractography whitout free water :
    - directory     : /projects/schiz/3Tdata/case<subjID>/projects/2015-delre-corpuscallosum/without-freeWater
    - data          : <subjID>-cc-ukf.vtk, <subjID>-cc-div1-ukf.vtk, ..., 
    - measured data : <subjID>-cc-ukf-values.csv

## other tractography

- trial to create tract from 2 tensor whole brain tract (by Amanda) and our cc ROI in case 01269
    - directory     : /projects/schiz/3Tprojects/2015-delre-corpuscallosum/testdir_fslabel
- tract data by 3DSlicer  : 
    - data          : <subjID>-cc.vtk, <subjID>-cc-div1.vtk, ..., 
    - measured data : <subjID>-cc-values.csv
- tract data by WMQL      : 
    - data          : <subjID>-cc-wmql.vtk, <subjID>-cc-div1-wmql.vtk, ...
    - measured data : <subjID>-cc-wmql-values.csv

## references

- 2 tensor whole brain tractography (by Amanda)
    - /rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/UKF_FE_Caselist.txt
    - /rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/<subjID>.ukf_2T_FW.vtk


# step by step 

...

## summarize the measured data

* extract from files of each cases 
    * inputfilepattern=/projects/schiz/3Tdata/case\${case}/projects/2015-delre-corpuscallosum/\${case}-cc-ukf-values.csv










