#!/bin/bash
# script name tractographyandmeasure3.sh
usage() {
    echo "Usage: $0 [case ID] [output directory name under case project directory]"
    exit 0
}

while getopts h OPTION; do
    case $OPTION in
        h) usage ;;
    esac
done

# set variables
caseid=$1
echo "set caseid ${caseid}"

# check whether case project directory exist
casedir=/projects/schiz/3Tdata/case${caseid}
echo "set casedir ${casedir}"
if [[ ! -d ${casedir} ]]; then echo "${casedir} does not exist"; exit 1; fi

caseprojdir=${casedir}/projects/2015-delre-corpuscallosum
echo "set caseprojdir ${caseprojdir}"
if [[ ! -d ${caseprojdir} ]]; then echo "${caseprojdir} does not exist"; exit 1; fi

# check and set dwi file name
if [[ -e ${casedir}/diff/${caseid}-dwi-filt-Ed.nhdr ]]; then
    dwifile="${casedir}/diff/${caseid}-dwi-filt-Ed.nhdr"
    echo "set dwifile ${dwifile}"
elif [[ -e ${casedir}/diff/${caseid}-dwi-Ed.nhdr ]]; then
    dwifile="${casedir}/diff/${caseid}-dwi-Ed.nhdr"
    echo "set dwifile ${dwifile}"
else
    echo "dwi file does not exist"; exit 1
fi

# check and set diffusion mask file name
if [[ -e ${casedir}/diff/Tensor_mask-${caseid}-dwi-filt-Ed_AvGradient-edited.nhdr ]]; then
    maskfile="${casedir}/diff/Tensor_mask-${caseid}-dwi-filt-Ed_AvGradient-edited.nhdr"
    echo "set maskfile ${maskfile}"
elif [[ -e ${casedir}/diff/Tensor_mask-${caseid}-dwi-Ed_AvGradient-edited.nhd ]]; then
    maskfile="${casedir}/diff/Tensor_mask-${caseid}-dwi-Ed_AvGradient-edited.nhd"
    echo "set maskfile ${maskfile}"
else
    echo "dwi file does not exist"; exit 1
fi

# create whole corpus callosum ROI if it does not exist
# create binary image data where greater than intensity 0 
# (any label has any intensity other than 0).
# and save by \"unu save\"
if [[ ! -e ${caseprojdir}/${caseid}-cc-roi.nrrd ]]; then
    unu 2op gt ${caseprojdir}/${caseid}-cc-div-roi.nrrd 0 | unu save -e gzip -f nrrd -o ${caseprojdir}/${caseid}-cc-roi.nrrd
    echo "create ${caseid}-cc-roi.nrrd"
fi

# create output directory if it does not exist and move to the directory
outputdir=${caseprojdir}/$2
if [[ ! -e ${outputdir} ]]; then
    mkdir ${outputdir}
    cd ${outputdir}
    echo "make directory ${outputdir} and move to the directory"
else
    cd ${outputdir}
    echo "output directory ${outputdir} already exist and move to the directory"
fi

# set tractgraphy option
tractographyoption="--recordTensors --freeWater --recordFreeWater"
echo "tractographyoption ${tractographyoption}"

# #--------Begin tractography
# # tractgraphy from whole corpus callosum
# seeedsfile=${caseprojdir}/${caseid}-cc-roi.nrrd
# labelnumber="1"
# outputtract=${outputdir}/${caseid}-cc-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"

# # tractography from divided corpus callosum
# seeedsfile=${caseprojdir}/${caseid}-cc-roi.nrrd

# # division1
# labelnumber="241"
# outputtract=${outputdir}/${caseid}-cc-div1-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"

# # division2
# labelnumber="242"
# outputtract=${outputdir}/${caseid}-cc-div2-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"

# # division3
# labelnumber="243"
# outputtract=${outputdir}/${caseid}-cc-div3-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"

# # division4
# labelnumber="244"
# outputtract=${outputdir}/${caseid}-cc-div4-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"

# # division5
# labelnumber="245"
# outputtract=${outputdir}/${caseid}-cc-div5-ukf.vtk
# if [[ -e ${outputtract} ]]; then echo "${outputtract} already exists"; exit 1; fi
# cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile ${seedsfile} --labels ${labelnumber} --tracts ${outputtract} ${tractographyoption}"
# echo "${cmdtractography}"
# eval "${cmdtractography}"
# #--------End tractography

functractography() {
    if [[ -e $3 ]]; then echo "$3 already exists"; exit 1; fi
    cmdtractography="UKFTractography --dwiFile ${dwifile} --maskFile ${maskfile} --seedsFile $1 --labels $2 --tracts $3 ${tractographyoption}"
    echo "${cmdtractography}"
    eval "${cmdtractography}"
    echo "done"
}

functractography ${caseprojdir}/${caseid}-cc-roi.nrrd 1 ${outputdir}/${caseid}-cc-ukf.vtk
functractography ${caseprojdir}/${caseid}-cc-div-roi.nrrd 241 ${outputdir}/${caseid}-cc-div1-ukf.vtk
functractography ${caseprojdir}/${caseid}-cc-div-roi.nrrd 242 ${outputdir}/${caseid}-cc-div2-ukf.vtk
functractography ${caseprojdir}/${caseid}-cc-div-roi.nrrd 243 ${outputdir}/${caseid}-cc-div3-ukf.vtk
functractography ${caseprojdir}/${caseid}-cc-div-roi.nrrd 244 ${outputdir}/${caseid}-cc-div4-ukf.vtk
functractography ${caseprojdir}/${caseid}-cc-div-roi.nrrd 245 ${outputdir}/${caseid}-cc-div5-ukf.vtk

# measure tracts
cmd="measureTracts.py -i ${caseid}-cc-ukf.vtk ${caseid}-cc-div1-ukf.vtk ${caseid}-cc-div2-ukf.vtk ${caseid}-cc-div3-ukf.vtk ${caseid}-cc-div4-ukf.vtk ${caseid}-cc-div5-ukf.vtk -o ${caseid}-cc-ukf-values.csv"
echo "${cmd}"
eval "${cmd}"
echo "done"

# # log
# scriptname=$(basename $0)
# logfilename=${scriptname}.log
# echo "${cmd}" | tee ${logfilename}
# eval "${cmd}" 2>&1 | tee -a ${logfilename}

