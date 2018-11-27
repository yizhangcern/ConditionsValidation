#!/bin/bash

file="NewValidation.txt"
validate=`grep "validate" $file | awk '{print $2}'`
if [ $validate = "yes" ]; 
then

export year=`grep "year" $file | awk '{print $2}'`
export week=`grep "week" $file | awk '{print $2}'`
export LUTname=`grep "LUTname" $file | awk '{print $2}'`
export TAGname=`grep "TAGname" $file | awk '{print $2}'`
export run=`grep "run" $file | awk '{print $2}'`
export lumi_start=`grep "lumi_start" $file | awk '{print $2}'`
export lumi_end=`grep "lumi_end" $file | awk '{print $2}'`

export release_LUT=`grep "release_LUT" $file | awk '{print $2}'`
export arch_LUT=`grep "arch_LUT" $file | awk '{print $2}'`

export release_L1=`grep "release_L1" $file | awk '{print $2}'`
export arch_L1=`grep "arch_L1" $file | awk '{print $2}'`
export dataset=`grep "dataset" $file | awk '{print $2}'`
export tier2=`grep "tier2" $file | awk '{print $2}'`

> lumimask.json
echo {'"322113"': [[$lumi_start, $lumi_end]]} > lumimask.json

echo "==============================================="
echo "run          " $run
echo "lumi_section " [$lumi_start,$lumi_end]
echo "LUTname      " $LUTname
echo "TAGname      " $TAGname
echo "release_LUT  " $release_LUT
echo "arch_LUT     " $arch_LUT
echo "release_L1   " $release_L1
echo "arch_L1      " $arch_L1
echo "dataset      " $dataset
echo "tier2        " $tier2
echo "==============================================="

###L1T###
#./runL1THcalConditionValidation.sh 

mv $file RunFiles/Validation_${year}_${week}.txt
cp RunFiles/DefaultValidation.txt NewValidation.txt
git add RunFiles/Validation_${year}_${week}.txt
git commit -a -m "clean validation inputs"
git push -u origin HEAD:master


else
echo "Not validate"
fi
