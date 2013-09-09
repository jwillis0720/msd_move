reinitialize
set surface_quality, 0
set matrix_mode, 1
set movie_panel, 1
set scene_buttons, 1
set cache_frames, 1
set movie_auto_interpolate, 0
config_mouse three_button_motions, 1


python
import glob
path = "/Users/jordanwillis/workspace/specificaim3/msd_movie/files/"
#these pdbs only have the designed residues in them so it saves a lot of memory
l1 = glob.glob(path+"*A*.pdb")
l2 = glob.glob(path+"*B*.pdb")
l3 = glob.glob(path+"*C*.pdb")
for j in l1[:10]:
	cmd.load(j,"A1")
for g in l2[:10]:
	cmd.load(g,"B1")
for d in l3[:10]:
	cmd.load(d,"C1")
cmd.load(path+"2b1a.pdb", "A_bb")
cmd.load(path+"2xwt.pdb", "B_bb")
cmd.load(path+"3hmx.pdb", "C_bb")

try:
   from psico.querying import centerofmass
except ImportError:
   centerofmass = lambda s: [(a+b)/2 for (a,b) in zip(*cmd.get_extent(s))]

def my_rotate(angle, object, axis='y',center=""):
	if center: 
		com = centerofmass(center)
	else:
		com = centerofmass(object)
	cmd.rotate(axis, angle, object=object, origin=com)

cmd.extend('my_rotate', my_rotate)

def store_all(string):
	objects = ["2b1a_gl","3hmx_gl","2xwt_gl","2b1a_h","2b1a_l","2xwt_ant","3hmx_ant","3hmx_l","3hmx_h","2b1a_ant","2xwt_h","2xwt_l"
                ,"2b1a_ant_copy","2xwt_ant_copy","3hmx_ant_copy","2b1a_l_copy","2xwt_l_copy","3hmx_l_copy","2b1a_h_copy",
                "2xwt_h_copy","3hmx_h_copy","com","A1","B1","C1"]
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
create com, 3hmx_ant within 25 of (3hmx_l)
deselect com

delete A_bb + B_bb + C_bb




#make some selections from objects we will use for coloring later
select antigens, chain C + chain A + chain P
select light, chain B + chain L
select msd_residues, A1 + B1 + C1
select heavy, not msd_residues and chain H 


create 2b1a_gl, 2b1a_h and resi 1-98
create 2xwt_gl, 2xwt_h and resi 1-98
create 3hmx_gl, 3hmx_h and resi 1-98
select vh551, (2b1a_h and resi 1-98) + (2xwt_h and resi 1-98) + (3hmx_h and resi 1-98)
#remove the purple dots
deselect 

#set up our coloring scheme
bg white
hide lines
color grey20, heavy
color forest, antigens
color sand, light
spectrum b, blue_white_red, msd_residues

#show cartoon, 2b1a_h + 2xwt_h + 3hmx_h
#make the surface transparent
set transparency, .5

set_view (\
    -0.992779553,   -0.119716585,    0.004772634,\
    -0.055808492,    0.426833898,   -0.902588844,\
     0.106016770,   -0.896369994,   -0.430436313,\
     0.000422392,    0.000034600, -437.847869873,\
    12.127141953,  -11.969411850,   -6.307948589,\
   287.027618408,  588.601257324,  -20.000000000 )




pseudoatom title
pseudoatom title_2
pseudoatom title_3
pseudoatom title_4


pseudoatom 2xwt_ant_title, 2xwt_ant
pseudoatom 2b1a_ant_title, 2xwt_ant_title
pseudoatom 3hmx_ant_title, 2xwt_ant_title
pseudoatom 2xwt_l_title, 2xwt_l
pseudoatom 2b1a_l_title, 2xwt_l_title
pseudoatom 3hmx_l_title, 2xwt_l_title


pseudoatom 2xwt_gl_title, 2xwt_gl 
pseudoatom 2b1a_gl_title, 2xwt_gl_title
pseudoatom 3hmx_gl_title, 2xwt_gl_title

pseudoatom complex_title, 2xwt_gl


label complex_title, "Structural variations across frameworks and CDRs"

label 2b1a_ant_title, "UG1033 peptide"
label 2xwt_ant_title, "Thyrotropin receptor"
label 3hmx_ant_title, "IL-12A"

label 2b1a_gl_title, "IGHV5-51"
label 2xwt_gl_title, "IGHV5-51"
label 3hmx_gl_title, "IGHV5-51"

label 2b1a_l_title, "IGLV1-47"
label 2xwt_l_title, "IGLV1-51"
label 3hmx_l_title, "IGKV1D-16"

label title, "Multi-State design of three antibody-antigen complexes"
label title_2, "Each complex binding a distinct antigen"
label title_3, "With a unique light chain"
label title_4, "However each share a common heavy varible chain gene, IGVH5-51"


set label_size, 30


hide

# # #set up frame movie using just state one
mset 1 x460
# #SCENE 1 - Showcasing antigens
# 
# #store_all is an extension command we using in pymol that saves mview stores all objects
# #set up intial global view with each object spaced 60 angstroms apart
# #2b1a will go on the left, 3hmx on the right

frame 1
translate [-80,0,0], object=2b1a_ant
translate [-80,0,0], object=2b1a_h
translate [-80,0,0], object=2b1a_l
translate [-80,0,0], object=2b1a_ant_copy
translate [-80,0,0], object=2b1a_h_copy
translate [-80,0,0], object=2b1a_l_copy
translate [-80,0,0], object=A1
translate [-80,0,0], object=2b1a_ant_title
translate [-80,0,0], object=2b1a_l_title
translate [-80,0,0], object=2b1a_gl_title
translate [-80,0,0], object=2b1a_gl
translate [0,0,30], object=2b1a_gl_title
translate [0,20,0], object=complex_title

#3hmx needs a center of mass too
translate [80,0,0], object=3hmx_ant
translate [80,0,0], object=com
translate [80,0,0], object=3hmx_l
translate [80,0,0], object=3hmx_h
translate [80,0,0], object=3hmx_ant_copy
translate [80,0,0], object=3hmx_l_copy
translate [80,0,0], object=3hmx_h_copy
translate [80,0,0], object=C1
translate [80,0,0], object=3hmx_ant_title
translate [80,0,0], object=3hmx_l_title
translate [80,0,0], object=3hmx_gl_title
translate [80,0,0], object=3hmx_gl
translate [0,0,30], object=3hmx_gl_title

translate [0,0,30], object=2xwt_gl_title

#translate main title
translate [0,70,0], object=title
translate [0,70,0], object=title_2
translate [0,70,0], object=title_3
translate [0,70,0], object=title_4

mview store, 1,object=title
mview store, 1,object=title_2
mview store, 1,object=title_3
mview store, 1,object=title_4
mview store, 1,object=title_5
mview store, 1,object=2b1a_ant
mview store, 1,object=2b1a_h 
mview store, 1,object=2b1a_l
mview store, 1,object=2b1a_ant_copy
mview store, 1,object=2b1a_h_copy
mview store, 1,object=2b1a_l_copy
mview store, 1,object=A1
mview store, 1,object=2b1a_ant_title
mview store, 1,object=2b1a_l_title
mview store, 1,object=2b1a_gl_title
mview store, 1,object=3hmx_ant
mview store, 1,object=3hmx_h 
mview store, 1,object=3hmx_l
mview store, 1,object=3hmx_ant_copy
mview store, 1,object=3hmx_h_copy
mview store, 1,object=3hmx_l_copy
mview store, 1,object=B1
mview store, 1,object=3hmx_ant_title
mview store, 1,object=3hmx_l_title
mview store, 1,object=3hmx_gl_title
mview store, 1,object=2xwt_ant
mview store, 1,object=2xwt_h 
mview store, 1,object=2xwt_l
mview store, 1,object=2xwt_ant_copy
mview store, 1,object=2xwt_h_copy
mview store, 1,object=2xwt_l_copy
mview store, 1,object=1
mview store, 1,object=2xwt_ant_title
mview store, 1,object=2xwt_l_title
mview store, 1,object=2xwt_gl_title
mview store, 1,object=2xwt_gl
mview store, 1,object=complex_title
show surface, antigens + light + heavy
show cartoon, heavy
show labels, title 
hide everything, *copy*
hide everything, com
scene 001, store
mview store, 1, scene=001


frame 50
hide labels,title
show labels,title_2
show labels, 2b1a_ant_title
show labels, 2xwt_ant_title
show labels, 3hmx_ant_title
color magenta, antigens
mview store, 50,object=2b1a_ant
mview store, 50,object=2xwt_ant
mview store, 50,object=3hmx_ant
mview store, 50,object=title
mview store, 50,object=title_2
mview store, 50,object=2b1a_ant_title
mview store, 50,object=2xwt_ant_title
mview store, 50,object=3hmx_ant_title
mview store, 50,object=antigens
scene 002, store 
mview store, 50, scene=002


frame 70
# #antigen translate
translate [0,30,0], object=3hmx_ant
translate [0,30,0], object=2b1a_ant
translate [0,30,0], object=2xwt_ant
mview store, 70,object=3hmx_ant
mview store, 70,object=2b1a_ant
mview store, 70,object=2xwt_ant
mview interpolate, object=3hmx_ant
mview interpolate, object=2b1a_ant
mview interpolate, object=2xwt_ant
scene 003, store
mview store, 70, scene=003

frame 100
# # #antigen rotate 180 degrees
# # #my_rotate is another extension command that translates around the y-axis from the objects center of mass
my_rotate 180, 3hmx_ant, center=com
my_rotate 180, 2b1a_ant
my_rotate 180, 2xwt_ant
mview store, 100,object=3hmx_ant
mview store, 100,object=2b1a_ant
mview store, 100,object=2xwt_ant
mview reinterpolate, object=3hmx_ant
mview reinterpolate, object=2b1a_ant
mview reinterpolate, object=2xwt_ant
scene 004, store
mview store, 100, scene=004


frame 130
scene 005, store
# #antigen rotate another 180 degrees for a full representation
my_rotate 180, 3hmx_ant, center=com
my_rotate 180, 2b1a_ant
my_rotate 180, 2xwt_ant
mview store, 135,object=3hmx_ant
mview store, 135,object=2b1a_ant
mview store, 135,object=2xwt_ant
mview reinterpolate, object=3hmx_ant
mview reinterpolate, object=2b1a_ant
mview reinterpolate, object=2xwt_ant
scene 005, store
mview store, 130, scene=005

frame 160
scene 006, store
hide labels, title_2 + 2b1a_ant_title + 2xwt_ant_title + 3hmx_ant_title
show labels, title_3 + 2b1a_l_title + 2xwt_l_title + 3hmx_l_title
color forest, antigens
color magenta, light
super 3hmx_ant, 3hmx_ant_copy
super 2xwt_ant, 2xwt_ant_copy
super 2b1a_ant, 2b1a_ant_copy
mview store, 160,object=3hmx_ant
mview store, 160,object=2b1a_ant_copy
mview store, 160,object=2xwt_ant_copy
mview store, 160,object=3hmx_l
mview store, 160,object=2b1a_l
mview store, 160,object=2xwt_l
mview reinterpolate, object=3hmx_ant
mview reinterpolate, object=2b1a_ant
mview reinterpolate, object=2xwt_ant
scene 006, store 
mview store, 160, scene=006



####SCENE 02, rotate light chains
frame 190
translate [-15,0,0], object=3hmx_l
translate [-15,0,0], object=2b1a_l
translate [-15,0,0], object=2xwt_l
mview store, 190,object=3hmx_l
mview store, 190,object=2b1a_l
mview store, 190,object=2xwt_l
mview interpolate, object=3hmx_l
mview interpolate, object=2b1a_l
mview interpolate, object=2xwt_l
scene 007, store
mview store, 190, scene=007


frame 220
my_rotate 180, 3hmx_l
my_rotate 180, 2b1a_l
my_rotate 180, 2xwt_l
mview store, 220,object=3hmx_l
mview store, 220,object=2b1a_l
mview store, 220,object=2xwt_l
mview reinterpolate, object=3hmx_l
mview reinterpolate, object=2b1a_l
mview reinterpolate, object=2xwt_l
scene 008, store
mview store, 220, scene=008


frame 250
my_rotate 180, 3hmx_l
my_rotate 180, 2b1a_l
my_rotate 180, 2xwt_l
mview store, 250,object=3hmx_l
mview store, 250,object=2b1a_l
mview store, 250,object=2xwt_l
mview reinterpolate, object=3hmx_l
mview reinterpolate, object=2b1a_l
mview reinterpolate, object=2xwt_l
scene 009, store
mview store, 250, scene=009

frame 280
hide everything, 2b1a_l + 3hmx_l + 2xwt_l + 3hmx_ant + 2b1a_ant + 2xwt_ant + title_3 + 2xwt_l_title + 3hmx_l_title + 2b1a_l_title
show labels, title_4 + 2b1a_gl_title + 2xwt_gl_title + 3hmx_gl_title
color sand, light
super 3hmx_l, 3hmx_l_copy
super 2xwt_l, 2xwt_l_copy
super 2b1a_l, 2b1a_l_copy
mview store, 280,object=3hmx_l
mview store, 280,object=2b1a_l
mview store, 280,object=2xwt_l
mview store, 280,object=3hmx_h
mview store, 280,object=2b1a_h
mview store, 280,object=2xwt_h
color magenta, vh551
mview reinterpolate, object=3hmx_l
mview reinterpolate, object=2b1a_l
mview reinterpolate, object=2xwt_l
scene 010, store
mview store, 280, scene=010


frame 330
mview store, 330,object=3hmx_h
mview store, 330,object=2b1a_h
mview store, 330,object=2xwt_h
mview store, 330,object=A1
mview store, 330,object=B1
mview store, 330,object=C1
hide everything, not vh551
scene 011, store 
mview store, 330, scene=011

frame 400
super 2b1a_h and resi 1-98, 2xwt_h and resi 1-98
super 3hmx_h and resi 1-98, 2xwt_h and resi 1-98
super A1, 2b1a_h and resi 1-98
super B1, 2xwt_h and resi 1-98
super C1, 3hmx_h and resi 1-98
pseudoatom title_5, 2xwt_h
hide nonbonded, title_5
translate [0,40,0], object=title_5
label title_5, "With unique somatic mutations that altered framework and CDR3 structure"
show labels, title_5
set_view (\
    -0.992779553,   -0.119716585,    0.004772634,\
    -0.055808492,    0.426833898,   -0.902588844,\
     0.106016770,   -0.896369994,   -0.430436313,\
     0.000191912,    0.000052718, -182.240753174,\
     7.153404236,  -15.651230812,    4.890758514,\
   133.269271851,  231.092132568,  -20.000000000 )
mview store, 400, object=3hmx_h
mview store, 400, object=2b1a_h
mview store, 400, object=2xwt_h
mview store, 400, object=A1
mview store, 400, object=B1
mview store, 400, object=C1
mview reinterpolate, object=3hmx_h
mview reinterpolate, object=2b1a_h
mview reinterpolate, object=2xwt_h
scene 012, store 
mview store, 400, scene=012
#broken line
mview reinterpolate, scene=012

frame 430
hide surface, *_h
mview store, 430,object=3hmx_h
mview store, 430,object=2b1a_h
mview store, 430,object=2xwt_h
mview reinterpolate, object=3hmx_h
mview reinterpolate, object=2b1a_h
mview reinterpolate, object=2xwt_h
scene 013, store
mview store, 430, scene=013

frame 460
show sticks, A1
mview store, 460,object=3hmx_h
mview store, 460,object=2b1a_h
mview store, 460,object=2xwt_h
mview reinterpolate, object=3hmx_h
mview reinterpolate, object=2b1a_h
mview reinterpolate, object=2xwt_h 
mview store, object=A1
mview reinterpolate, object=A1
scene 014, store
mview store, 460, scene=014







