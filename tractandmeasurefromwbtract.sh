#!/bin/bash

usage() {
    echo "Usage: $0 <case_ID>"
    echo "move to /projects/schiz/shiz/3Tdata/case<case_ID>/projects/2015-delre-corpuscallosum"
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
caseid=$2
casedir=case${caseid}/projects/2015-delre-corpuscallosum
dwibase=/rfanfs/pnl-zorro/projects/Cidar_johanna/Registration/output_folder${caseid}/$caseid-bse.nrrd
# fsatlas=/rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/FS2BSE_FES/$caseid.nii.gz
# fsatlasn=/tmp/$caseid.nrrd
wbtract=/rfanfs/pnl-zorro/projects/Kubicki_SCZ_R01/FE_MI_Analysis/VTKs_FES/$caseid.vtk
# intrustquery=/projects/schiz/software/LabPython/tract_querier/queries/intrust_query.qry
projectquery=$[projectdir}/2015-delre-callosum.qry

if [[ -f "${caseid}-cc-div-roi-originmoved.nrrd" ]]; then
    echo "'${caseid}-cc-div-roi-originmoved.nrrd' exists and is out of date, delete it if you want to recompute it."
    exit 0
fi

cd ${casedir}
/projects/schiz/3Tprojects/2015-delre-corpuscallosum/changeorigin.py \
    -i ${caseid}-cc-div-roi.nrrd \
    -o ${caseid}-cc-div-roi-originmoved.nrrd \
    -r ${dwibase}
ConvertBetweenFileFormats ${caseid}-cc-div-roi-originmoved.nrrd ${caseid}-cc-div-roi-originmoved.nii.gz
tract_querier \
    -t ${wbtract} \
    -a ${caseid}-cc-div-roi-originmoved.nii.gz \
    -q ${projectquery} \
    -o ${caseid}                    # or set output directory? 
activate_tensors.py ${caseid}_cc_wholeorgmv.vtk ${caseid}_cc_wholeorgmv.vtk
activate_tensors.py ${case}_cc_div1orgmv.vtk ${case}_cc_div1orgmv.vtk
activate_tensors.py ${case}_cc_div2orgmv.vtk ${case}_cc_div2orgmv.vtk
activate_tensors.py ${case}_cc_div3orgmv.vtk ${case}_cc_div3orgmv.vtk
activate_tensors.py ${case}_cc_div4orgmv.vtk ${case}_cc_div4orgmv.vtk
activate_tensors.py ${case}_cc_div5orgmv.vtk ${case}_cc_div5orgmv.vtk
measureTracts.py \
    -i ${caseid}_cc_wholeorgmv.vtk \
    ${case}_cc_div1orgmv.vtk \
    ${case}_cc_div2orgmv.vtk \
    ${case}_cc_div3orgmv.vtk \
    ${case}_cc_div4orgmv.vtk \
    ${case}_cc_div5orgmv.vtk \
    -o ${case}-cc-orgmv-values.csv
