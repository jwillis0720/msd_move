from glob import glob
from pymol import cmd

file_list = glob("msd_output*H3*")
designed_residues = [28,29,30,31,32,53,54,56,57,74,75,76,77,101,102,103,104,105,106,107,108,109,110,111,112]


for file in file_list:
	cmd.load(file,"H3_movie")
	
util.color_chains()
cmd.show("cartoon")
cmd.hide("lines")
for resi in designed_residues:
	string = "chain A and resi " + str(resi)
	cmd.color("red",string)	
	cmd.show("sticks",string)
cmd.mclear()	

#cmd.mset("1 x500")
#util.mroll("1, 500, 1")


#string =""
#for i in range(1,101):
#	print string
#	string += ("%s x30 ")%i

#cmd.mset(string)









#frame_num = 1
#for resi in designed_residues:
#	resi_string = "chain H and resi "+ str(resi)
#	cmd.orient(resi_string, state="-1")
#	cmd.frame(frame_num)
#	cmd.mview( "store")
#	frame_num += 29
#cmd.mview("  reinterpolate")	

#for i in range(1,3001):
#	cmd.mdo("%s: turn x,5")%i
