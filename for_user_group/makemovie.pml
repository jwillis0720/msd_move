reinitialize
set matrix_mode, 1
set movie_panel, 1
set scene_buttons, 1
set cache_frames, 1
set movie_auto_interpolate, off
config_mouse three_button_motions, 1


python
import glob
path = "/Users/jordanwillis/workspace/specificaim3/msd_movie/files/"
l1 = glob.glob(path+"*A*.pdb")
l2 = glob.glob(path+"*B*.pdb")
l3 = glob.glob(path+"*C*.pdb")
for j in l1[:3]:
	cmd.load(j,"A1")
for g in l2[:3]:
	cmd.load(g,"B1")
for d in l3[:3]:
	cmd.load(d,"C1")
cmd.load(path+"2b1a.pdb", "A_bb")
cmd.load(path+"2xwt.pdb", "B_bb")
cmd.load(path+"3hmx.pdb", "C_bb")

try:
   from psico.querying import centerofmass
except ImportError:
   centerofmass = lambda s: [(a+b)/2 for (a,b) in zip(*cmd.get_extent(s))]

def my_rotate(angle, object, axis='y'):
   com = centerofmass(object)
   cmd.rotate(axis, angle, object=object, origin=com)

cmd.extend('my_rotate', my_rotate)

def store_all(string):
	objects = ["2b1a_h","2b1a_l","2xwt_ant","3hmx_ant","3hmx_l","3hmx_h","2b1a_ant","2xwt_h","2xwt_l"]
	for i in objects:
		cmd.mview(string, object=i)
	
cmd.extend("store_all",store_all)

def store_scene(number):
		cmd.scene(str(number),"store")
		cmd.mview("store",scene=number)	
cmd.extend("store_scene",store_scene)
python end




#object creators
create 2b1a_ant, A_bb and chain P
create 2xwt_ant, B_bb and chain C
create 3hmx_ant, C_bb and chain A
create 2b1a_l, A_bb and chain L
create 2xwt_l, B_bb and chain B
create 3hmx_l, C_bb and chain L
create 2b1a_h, A_bb and chain H
create 2xwt_h, B_bb and chain H
create 3hmx_h, C_bb and chain H

#create copyies of each objects as alignment reference points for later on
create 2b1a_ant_copy, 2b1a_ant 
create 2xwt_ant_copy, 2xwt_ant 
create 3hmx_ant_copy, 3hmx_ant 
create 2b1a_l_copy, 2b1a_l
create 2xwt_l_copy, 2xwt_l 
create 3hmx_l_copy, 3hmx_l
create 2b1a_h_copy, 2b1a_h
create 2xwt_h_copy, 2xwt_h
create 3hmx_h_copy, 3hmx_h

set_view (\
    -0.987339199,   -0.147254646,    0.058693748,\
    -0.130136862,    0.541538239,   -0.830523551,\
     0.090512969,   -0.827677608,   -0.553851545,\
     0.000551268,    0.000143198, -327.257324219,\
    21.386798859,  -23.021564484,   12.119427681,\
   176.506362915,  478.079681396,  -20.000000000 )
### cut above here and paste into script ###

#make some selections from objects we will use for coloring later
select antigens, chain C + chain A + chain P
select light, chain B + chain L
select msd_residues, A1 + B1 + C1
select heavy, not msd_residues and chain H
#remove the purple dots
deselect 

#set up our coloring scheme
bg white
hide lines
color grey20, heavy
color forest, antigens
color sand, light
spectrum b, blue_white_red, msd_residues
show surface, 2b1a_ant + 2xwt_ant + 3hmx_ant + 2b1a_l + 2xwt_l + 3hmx_l + 2b1a_h + 2xwt_h + 3hmx_H
show cartoon, 2b1a_h + 2xwt_h + 3hmx_h
#make the surface transparent
set transparency, .5



#set up intial global view with each object spaced 60 angstroms apart
translate [-60,0,0], object=2b1a_ant
translate [-60,0,0], object=2b1a_h
translate [-60,0,0], object=2b1a_l
translate [-60,0,0], object=2b1a_ant_copy
translate [-60,0,0], object=2b1a_h_copy
translate [-60,0,0], object=2b1a_l_copy

#and their copies
translate [60,0,0], object=3hmx_ant
translate [60,0,0], object=3hmx_l
translate [60,0,0], object=3hmx_h
translate [60,0,0], object=3hmx_ant_copy
translate [60,0,0], object=3hmx_l_copy
translate [60,0,0], object=3hmx_h_copy


#set up 300 frame movie using just state one
mset 1 x300

frame 1
#store_all is an extension command we using in pymol that saves mview stores all objects
store_all store
#storing_each representation as a scene so we can color it later
store_scene 001

frame 20
color magenta, antigens
store_all store
store_scene 002

frame 40
#antigen translate
translate [0,10,0], object=3hmx_ant
translate [0,10,0], object=2b1a_ant
translate [0,10,0], object=2xwt_ant
mview store, object=3hmx_ant
store_all store
store_scene 003

frame 60
#antigen rotate 180 degrees
#my_rotate is another extension command that translates around the y-axis from the objects center of mass
my_rotate 180, 3hmx_ant
my_rotate 180, 2b1a_ant
my_rotate 180, 2xwt_ant
store_all store
store_scene 004

frame 80
#antigen rotate another 180 degrees for a full representation
my_rotate 180, 3hmx_ant
my_rotate 180, 2b1a_ant
my_rotate 180, 2xwt_ant
store_all store
store_scene 005

frame 90
#easy way to get back to starting pose is aligning the moved antigens to their copy which stayed rigid
color forest, antigens
align 3hmx_ant,3hmx_ant_copy
align 2xwt_ant,2xwt_ant_copy
align 2b1a_ant,2b1a_ant_copy
store_all store
store_scene 006

frame 130
#doing the same with the l chain
translate [-10,0,0], object=3hmx_l
translate [-10,0,0], object=2b1a_l
translate [-10,0,0], object=2xwt_l
store_all store
store_scene 007

frame 150
my_rotate 180, 3hmx_l
my_rotate 180, 2b1a_l
my_rotate 180, 2xwt_l
store_all store
store_scene 008

frame 170
my_rotate 180, 3hmx_l
my_rotate 180, 2b1a_l
my_rotate 180, 2xwt_l
store_all store
store_scene 009

frame 180
align 3hmx_l,3hmx_l_copy
align 2xwt_l,2xwt_l_copy
align 2b1a_l,2b1a_l_copy
store_all store
store_scene 010

frame 220
#doing the same with the heavy chain
translate [10,0,0], object=3hmx_h
translate [10,0,0], object=2b1a_h
translate [10,0,0], object=2xwt_h
store_all store
store_scene 011

frame 240
my_rotate 180, 3hmx_h
my_rotate 180, 2b1a_h
my_rotate 180, 2xwt_h
store_all store
store_scene 012

frame 260
my_rotate 180, 3hmx_h
my_rotate 180, 2b1a_h
my_rotate 180, 2xwt_h
store_all store
store_scene 013

frame 270
align 3hmx_h,3hmx_h_copy
align 2xwt_h,2xwt_h_copy
align 2b1a_h,2b1a_h_copy
#hide everything but the heavy chain. The reason we stored everything as a scene
hide surface, light + antigens
store_all store
store_scene 014


frame 300
#this scene we are aligning the heavy chains to each other and I'm trying to get them to zoom and center 2xwt. 
#I can get the alignments to go through a smooth transition but not the heavy chains
align 2b1a_h, 2xwt_h
align 3hmx_h, 2xwt_h
#****here is the zooming, which is a camera view
zoom 2xwt_h
store_all store
#finally interpolate through all those scenes
store_all reinterpolate
store_scene 015





