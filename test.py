#!/usr/bin/env python
'''Example of generating two sets of LUTs and comparisons
for validation.'''
import os
import sys

RUNS = [sys.argv[4], sys.argv[1]]
CONDITIONS = ["ChannelQuality", "Pedestals", "Gains", "RespCorrs", 
              "ElectronicsMap", "TPParameters", "TPChannelParameters", 
              "LUTCorrs", "QIEData", "QIETypes", "LutMetadata"]
TAGS = {sys.argv[4] : [sys.argv[5], sys.argv[6]], sys.argv[1] : [sys.argv[2], sys.argv[3]]}
COMMENT = "validation"

# dump conditions; used for inputs to LUT generation
# and for comparisons of gain*resp_corr versus LUT slope
for run in RUNS:
    for condition in CONDITIONS:
        dump_cmd = "./genLUT.sh dump "
        dump_cmd += "record=" + condition + " Run=" + run + " GlobalTag=" + TAGS[run][1]
        os.system(dump_cmd)
        #print(dump_cmd)

# generate LUTs. Two sets of LUTs are generated here so that the comparison 
# tests can be run. This will create two new sets of files 
# in the "conditions" directory.
os.system("./genLUT.sh generate card=cardPhysics.sh")
os.system("./genLUT.sh generate card=cardPhysics_gen_old.sh")

# run validation
os.system("./genLUT.sh validate card=cardPhysics.sh")
