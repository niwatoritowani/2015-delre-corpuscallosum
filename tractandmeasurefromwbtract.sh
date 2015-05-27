#!/bin/bash

outputdir=originmoved_refbse

usage() {
    echo "Usage: $0 <case_ID>"
    echo "move to /projects/schiz/shiz/3Tdata/case<case_ID>/projects/2015-delre-corpuscallosum"
    echo "create output directory: ${outputdir}"
    echo "move origin <case_ID>-cc-div-roi.nrrd refered to <case_ID>-base.nrrd"
    echo "run tract_queier, activate_tensors.py, measureTracts.py"
    exit 0
}

while getopts h OPTION; do
    case $OPTION in
        h) usage ;;
    esac
done

projectdir=/projects/schiz/3Tprojects/2015-delre-corpuscallosum
caseid=$1
casedir=/projects/schiz/3Tdata/case${caseid}/projects/2015-delre-corpuscallosum
dwibase=/rfanfs/pnl-zorro/projects/Cidar_johanna/Registration/output_folder${caseid}/$caseid-bse.nrrd
# fsatlas=/rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/FS2BSE_FES/$caseid.nii.gz
# fsatlasn=/tmp/$caseid.nrrd
### ###wbtract=/rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/VTKs_FES/$caseid.vtk
wbtract=/rfanfs/pnl-zorro/projects/3Tdata-ukf/${caseid}/${caseid}.ukf_2T_FW.vtk
# intrustquery=/projects/schiz/software/LabPython/tract_querier/queries/intrust_query.qry
projectquery=${projectdir}/2015-delre-corpuscallosum.qry

echo "cd ${casedir}"
cd ${casedir}
echo "pwd:"
pwd

#if [[ -e "${outputdir}" ]]; then
#    echo "output directory '${outputdir}' exists and is out of date, delete it if you want to recompute it."
#    exit 0
#fi

#echo "mkdir ${outputdir}"
#mkdir ${outputdir}
echo "cd ${outputdir}"
cd ${outputdir}
echo "pwd:"
pwd

#/projects/schiz/3Tprojects/2015-delre-corpuscallosum/changeorigin.py \
#    -i ${casedir}/${caseid}-cc-div-roi.nrrd \
#    -o ${caseid}-cc-div-roi-originmoved.nrrd \
#    -r ${dwibase}
#ConvertBetweenFileFormats ${caseid}-cc-div-roi-originmoved.nrrd ${caseid}-cc-div-roi-originmoved.nii.gz
tract_querier \
    -t ${wbtract} \
    -a ${caseid}-cc-div-roi-originmoved.nii.gz \
    -q ${projectquery} \
    -o ${caseid}                    # or set output directory? 
activate_tensors.py ${caseid}_cc_wholeorgmv.vtk ${caseid}_cc_wholeorgmv.vtk
activate_tensors.py ${caseid}_cc_div1orgmv.vtk ${caseid}_cc_div1orgmv.vtk
activate_tensors.py ${caseid}_cc_div2orgmv.vtk ${caseid}_cc_div2orgmv.vtk
activate_tensors.py ${caseid}_cc_div3orgmv.vtk ${caseid}_cc_div3orgmv.vtk
activate_tensors.py ${caseid}_cc_div4orgmv.vtk ${caseid}_cc_div4orgmv.vtk
activate_tensors.py ${caseid}_cc_div5orgmv.vtk ${caseid}_cc_div5orgmv.vtk
measureTracts.py \
    -i ${caseid}_cc_wholeorgmv.vtk \
    ${caseid}_cc_div1orgmv.vtk \
    ${caseid}_cc_div2orgmv.vtk \
    ${caseid}_cc_div3orgmv.vtk \
    ${caseid}_cc_div4orgmv.vtk \
    ${caseid}_cc_div5orgmv.vtk \
    -o ${caseid}-cc-orgmv-values.csv

