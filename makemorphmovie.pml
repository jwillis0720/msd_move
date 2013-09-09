#!/usr/bin/env python
# encoding: utf-8

"""
makemorphmovie.py

Created by Jordan  Willis on 2012-11-25.
Copyright (c) 2012 __MyCompanyName__. All rights reserved.
"""

#setupt
reinitialize
load 2b1a_germline.pdb 
load 2xwt_germline.pdb
load 3hmx_germline.pdb
show cartoon
bg white
hide lines


#align
create 2b1a_vh, 2b1a and chain A and resi 1-98
create 2xwt_vh, 2xwt and chain A and resi 1-98
create 3hmx_vh, 3hmx and chain B and resi 1-98

align 2b1a_vh, 2xwt_vh
align 3hmx_vh, 2xwt_vh
hide

show cartoon, 3hmx_vh
show cartoon, 2b1a_vh
show cartoon, 2xwt_vh
color wheat, 3hmx_vh
color forest, 2b1a_vh
color grey, 2xwt_vh

set_view (\
    -0.714825332,   -0.269820541,    0.645154774,\
    -0.315770298,    0.947698057,    0.046479166,\
    -0.623951018,   -0.170495152,   -0.762638032,\
    -0.000005363,   -0.000068210, -110.455459595,\
     5.317028522,  -20.026384354,    6.850549221,\
    89.422668457,  131.492187500,  -20.000000000 )
### cut above here and paste into script ###
### cut above here and paste into script ###

#make morph
import psico.fullinit
morpheasy 3hmx_vh, 2xwt_vh
mstop; mset
morpheasy 2xwt_vh, 2b1a_vh
mstop; mset
morpheasy 2b1a_vh, 3hmx_vh
mstop; mset

create morph01, morph02, 0, 31
create morph01, morph03, 0, 61
delete morph02 morph03

#color salmon, 2b1a_germline and chain C
#color salmon,  
color grey90, morph01
color orange, morph01 and resi 26-32
color wheat, morph01 and resi 51-58
mset 1 1x30 1-30 30x30 30-60 60x30 60-90 
util.mrock(1,182,30,1,1)
frame 1
mplay