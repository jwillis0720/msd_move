from glob import glob
from pymol import cmd

file_list = glob("B/*")
designed_residues = [5,32,34,40,46,48,51,52,54,58,65,70,72,74,76,77,98]


for file in file_list:
	cmd.load(file,"B_movie")
	
#util.color_chains()
cmd.color("cyan", "chain B")
cmd.color("green", "chain H")
cmd.color("pink", "chain C")
cmd.show("cartoon")
cmd.hide("lines")
for resi in designed_residues:
	string = "chain H and resi " + str(resi)
	cmd.color("red",string)	
	cmd.show("sticks",string)
	

string =""
for g in designed_residues:
	for i in range(1,101):
		string += ("%s x1 ")%i
cmd.mset(string)
cmd.frame("1")
cmd.orient()
cmd.mview("store")
#util.mroll(1,500,1)
string=""
frame=100
for resi in designed_residues:
	resi_behind = int(resi) -2
	resi_ahead = int(resi) + 2
	cmd.frame(frame)
	string = "chain H and resi "+str(resi_behind) + "+"+ str(resi)+ "+"+str(resi_ahead)
	print string
	cmd.orient(string) 
	cmd.mview("store")
	frame += 100
	#cmd.color("blue", string)
	#cmd.zoom(string,"7.5")
	#frame += 500
	
cmd.mview("reinterpolate")
