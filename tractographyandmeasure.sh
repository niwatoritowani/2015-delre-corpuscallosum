#!/bin/bash

case=$1


usage() {
    echo "Usage: $0 <case_ID>"
    echo "       in /projects/schiz/shiz/3Tdata/case<case_ID>/projects/2015-delre-corpuscallosum"
    exit 0
}

while getopts h OPTION; do
    case $OPTION in
        h) usage ;;
    esac
done

caseprojdir=/projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum
if [[ ! -d ${caseprojdir} ]]; then echo "${caseprojdir} does not exist"; exit 1; fi
cd ${caseprojdir}
if [[ -e ${case}-cc-roi.nrrd ]]; then echo "file already exists"; exit 1; fi
if [[ -e ${case}-cc-ukf.vtk ]]; then echo "file already exists"; exit 1; fi

cmd="

### create whole corpus callosum ROI
# create binary image data where greater than intensity 0 (any label has any intensity other than 0).
# and save by \"unu save\"

unu 2op gt ${case}-cc-div-roi.nrrd 0 | unu save -e gzip -f nrrd -o ${case}-cc-roi.nrrd

### create tractography

## with freeWater

# whole corpus callosum
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 1 --seedsFile ${case}-cc-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# division1
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-div1-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 241 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# division2
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-div2-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 242 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# division3
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-div3-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 243 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# division4
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-div4-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 244 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# division5
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts ${case}-cc-div5-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 245 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors --freeWater

# measure tracts
measureTracts.py -i ${case}-cc-ukf.vtk ${case}-cc-div1-ukf.vtk ${case}-cc-div2-ukf.vtk ${case}-cc-div3-ukf.vtk ${case}-cc-div4-ukf.vtk ${case}-cc-div5-ukf.vtk -o ${case}-cc-ukf-values.csv

### create tractography

## without freeWater
mkdir without-freeWater

# whole corpus callosum
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 1 --seedsFile ${case}-cc-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# division1
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-div1-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 241 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# division2
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-div2-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 242 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# division3
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-div3-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 243 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# division4
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-div4-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 244 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# division5
# /projects/schiz/3Tdata/case${case}/projects/2015-delre-corpuscallosum %
UKFTractography --tracts without-freeWater/${case}-cc-div5-ukf.vtk --maskFile /projects/schiz/3Tdata/case${case}/diff/Tensor_mask-${case}-dwi-filt-Ed_AvGradient-edited.nhdr --labels 245 --seedsFile ${case}-cc-div-roi.nrrd --dwiFile /projects/schiz/3Tdata/case${case}/diff/${case}-dwi-filt-Ed.nhdr --recordTensors

# measure tracts
measureTracts.py -i without-freeWater/${case}-cc-ukf.vtk without-freeWater/${case}-cc-div1-ukf.vtk without-freeWater/${case}-cc-div2-ukf.vtk without-freeWater/${case}-cc-div3-ukf.vtk without-freeWater/${case}-cc-div4-ukf.vtk without-freeWater/${case}-cc-div5-ukf.vtk -o without-freeWater/${case}-cc-ukf-values.csv
"

scriptname=$(basename $0)
logfilename=${scriptname}.log
echo "${cmd}" | tee ${logfilename}
eval "${cmd}" 2>&1 | tee -a ${logfilename}
