reinitialize

mset 1 -10 

python
import glob
path = "/Users/jordanwillis/workspace/specificaim3/msd_movie/files/"
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
python end