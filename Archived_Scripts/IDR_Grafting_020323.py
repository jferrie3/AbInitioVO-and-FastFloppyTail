from pyrosetta import *
init()

# Generate poses from the IDR sequence and Folded portion PDB
idr = pose_from_sequence('AAAAAAAAAAAAAAAAAKKKKKKAKAKAKAKAKAK')
folded = pose_from_pdb('../1tit_Titin_I27_Ig_Renumbered.pdb')

# Create a vector that matches the residues in the IDR
idealize_vector = pyrosetta.rosetta.utility.vector1_unsigned_long()

# For an N Terminal IDR
for resi in range(1, idr.total_residue()+2):
	idealize_vector.append(resi)
	
# For a C Terminal IDR
## for resi in range(folded.total_residue(), folded.total_residue() + idr.total_residue()+1):
##	idealize_vector.append(resi)


# Generate a single pose containing both proteins 
# N terminal IDR
idr = pyrosetta.rosetta.protocols.grafting.insert_pose_into_pose(idr, folded, idr.total_residue(), idr.total_residue())

# C terminal IDR
#folded = pyrosetta.rosetta.protocols.grafting.insert_pose_into_pose(folded, idr, folded.total_residue(), folded.total_residue())

# Create a fold tree for idealizing bonds
# N terminal IDR
ft = FoldTree()
ft.simple_tree(idr.total_residue())
idr.fold_tree(ft)

# C terminal IDR
#ft = FoldTree()
#ft.simple_tree(idr.total_residue())
#idr.fold_tree(ft)

# Create score function
SF2 = create_score_function("ref2015_cart")

# Idealize the bond angles
# N Terminal IDR
pyrosetta.rosetta.protocols.idealize.basic_idealize(idr, idealize_vector, SF2, 1)

# C Terminal IDR
#pyrosetta.rosetta.protocols.idealize.basic_idealize(folded, idealize_vector, SF2, 1)

# Output the structure
idr.dump_pdb('Test.pdb')