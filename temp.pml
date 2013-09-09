# setup PyMOL for movies
reinitialize
set matrix_mode, 1
set movie_panel, 1
set scene_buttons, 1
set cache_frames, 1
config_mouse three_button_motions, 1
 
fetch 1te1, async=0
extract AA, c. A
extract BB, c. B
color marine, AA
color grey, BB
as surface, BB
as cartoon, AA
 
mset 1 x620
 
orient
 
wizard message, "Can you see the blue protein inhibiting the gray protein?"
 
frame 1
mview store
frame 30
mview store
 
### cut below here and paste into script ###
set_view (\
     0.307660401,    0.011366921,    0.951428533,\
     0.930296898,   -0.213488042,   -0.298277378,\
     0.199727684,    0.976880252,   -0.076255992,\
     0.000000000,    0.000000000, -196.781448364,\
    27.129878998,   68.309677124,   51.827075958,\
   155.143981934,  238.418914795,  -20.000000000 )
### cut above here and paste into script ###
 
# slowly show the inhibition
frame 120
mview store
 
# wait 3 seconds
frame 180
mview store
 
# define the inhib as the binding loop
select inhib, AA and i. 148-155
select (none)
 
# slowly zoom in
frame 300
zoom inhib
mview store
 
# stop a second
frame 330
mview store
 
# look around the binding pocket
frame 390
turn y, 150
mview store
 
# wrap back more quickly...
frame 420
turn y, -150
mview store
 
# one more gratuitous view
frame 500
### cut below here and paste into script ###
set_view (\
     0.943371952,    0.309539229,   -0.119302809,\
    -0.044248745,   -0.239008784,   -0.970008850,\
    -0.328769624,    0.920357347,   -0.211777285,\
     0.000000000,    0.000000000,  -30.773454666,\
    35.418403625,   72.805625916,   52.437019348,\
    20.233829498,   41.313076019,  -20.000000000 )
### cut above here and paste into script ###
mview store
 
frame 560
mview store
 
mview reinterpolate
mplay