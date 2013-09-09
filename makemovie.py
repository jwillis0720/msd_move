#PML
reintialize
python
import glob
path = "/Users/jordanwillis/thorium/msd/multistate_all_differences/ig515/movie/noncrap/specific/"
l1 = glob.glob(path+"*A*.pdb")
l2 = glob.glob(path+"*B*.pdb")
l3 = glob.glob(path+"*C*.pdb")
for j in l1:
	cmd.load(j,"2b1a")
for g in l2:
	cmd.load(g,"2xwt")
for d in l3:
	cmd.load(d,"3hmx")
cmd.load(path+"2b1a.pdb", "2b1abb")
cmd.load(path+"2xwt.pdb", "2xwtbb")
cmd.load(path+"3hmx.pdb", "3hmxbb")
python end

