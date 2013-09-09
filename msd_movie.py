from glob import glob
from pymol import cmd

file_list = glob("A/*")
designed_residues = [5,14,16,23,24,29,30,31,32,34,40,46,48,51,52,54,58,65,70,72,74,76,77,80,84,88,93,97,98]


for file in file_list:
	cmd.load(file,"A_movie")
	
util.color_chains()
cmd.show("cartoon")
cmd.hide("lines")
for resi in designed_residues:
	string = "chain H and resi " + str(resi)
	cmd.color("red",string)	
	cmd.show("sticks",string)
	

string ="1 x500 "
for g in designed_residues:
	for i in range(1,100):
		string += ("%s x5 ")%i
cmd.mset(string)
cmd.mview('store')

util.mroll(1,500,1)
frame=501
string=""
for resi in designed_residues:
	cmd.frame(frame)
	string = "chain H and resi " + str(resi)
	#cmd.color("blue", string)
	cmd.zoom(string,"7.5")
	frame += 500
	cmd.mview("store")
