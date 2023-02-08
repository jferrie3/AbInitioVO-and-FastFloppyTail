from pyrosetta import *
init()
from pyrosetta.rosetta.protocols.simple_moves import *
from pyrosetta.rosetta.protocols.moves import *
from pyrosetta.rosetta.protocols.minimization_packing import *

import argparse


parser = argparse.ArgumentParser(description='Program')
parser.add_argument('-in', '--Input_FASTA_File', action='store', type=str, required=True,
	help='Name of the text file containing the FASTA sequence of the IDR. Carot should not be in same line as sequence, UniProt format preferred.')
parser.add_argument('-inpdb', '--Input_PDB_File', action='store', type=str, required=True,
	help='Name of the text file containing the PDB structure of the folded portion. All residues are required, missing residues are not constructed')
parser.add_argument('-term', '--IDR_Terminus', action='store', type=str, required=True,
	help='Specify N or C to indicate which terminus contains the IDR')
parser.add_argument('-clash', '--Remove_Clashes', action='store_true', required=False,
	help='Remove clashes from structure via VDW sampling of IDR')
parser.add_argument('-out', '--Output_PDB', action='store', type=str, required=True,
	help='Name of the output PDB file')
args = parser.parse_args()

## PyRosetta Setup
SF2 = create_score_function("ref2015_cart")
sf_stage_0 = create_score_function('score0')
switch = SwitchResidueTypeSetMover('fa_standard')
switch_cen = SwitchResidueTypeSetMover('centroid')

# Importing sequence from FASTA
idr = Pose()
if args.Input_FASTA_File:
	fasta_file = open(args.Input_FASTA_File, 'r')
	fasta_lines = fasta_file.readlines()
	fasta_counter = 0
	fasta_sequence = ' '
	for fasta_line in fasta_lines:
		if '>' not in fasta_line:
			if fasta_counter == 0:
				if '\n' in fasta_line:
					fasta_sequence = fasta_line.split('\n')[0]
				else:
					fasta_sequence = fasta_line
				fasta_counter = 1	
			else:
				if '\n' in fasta_line:
					fasta_sequence = fasta_sequence + fasta_line.split('\n')[0]
				else:
					fasta_sequence = fasta_sequence + fasta_line
idr = pose_from_sequence(fasta_sequence, "fa_standard")

# Importing the structure from the PDB
folded = Pose()
if args.Input_PDB_File:
	folded = pose_from_pdb(str(args.Input_PDB_File))

# Create a vector and MoveMap that matches the residues in the IDR
idealize_vector = pyrosetta.rosetta.utility.vector1_unsigned_long()
cenmap = MoveMap()
cenmap.set_bb(False)

if args.IDR_Terminus == 'N':
	for res_idx in range(1, idr.total_residue()+2):
		idealize_vector.append(res_idx)
		cenmap.set_bb(res_idx, True)
	## Generate a single pose containing both proteins 
	idr = pyrosetta.rosetta.protocols.grafting.insert_pose_into_pose(idr, folded, idr.total_residue(), idr.total_residue())
	
if args.IDR_Terminus == 'C':
	for res_idx in range(folded.total_residue(), folded.total_residue() + idr.total_residue()+1):
		idealize_vector.append(res_idx)
		cenmap.set_bb(res_idx, True)
	## Generate a single pose containing both proteins 
	folded = pyrosetta.rosetta.protocols.grafting.insert_pose_into_pose(folded, idr, folded.total_residue(), folded.total_residue())

# Assign Pose
p = Pose()
if args.IDR_Terminus == 'N':
	p.assign(idr)
if args.IDR_Terminus == 'C':
	p.assign(folded)
	
# Create a fold tree for idealizing bonds
ft = FoldTree()
ft.simple_tree(p.total_residue())
p.fold_tree(ft)

# Fix connection point
pyrosetta.rosetta.protocols.idealize.basic_idealize(p, idealize_vector, SF2, 1)
if args.Remove_Clashes:
	
	# Switch to centroid
	switch_cen.apply(p)
	
	# Remove clashes
	## Sampling Scheme
	vdw_small_mover = SmallMover(cenmap, 1.0, 1)
	vdw_shear_mover = ShearMover(cenmap, 1.0, 1)
	vdw_small_mover.angle_max(180)
	vdw_small_mover.angle_max("H", 180)
	vdw_small_mover.angle_max("E", 180)
	vdw_small_mover.angle_max("L", 180)
	vdw_shear_mover.angle_max(180)
	vdw_shear_mover.angle_max("H", 180)
	vdw_shear_mover.angle_max("E", 180)
	vdw_shear_mover.angle_max("L", 180)
	random_stage_0 = RandomMover()
	random_stage_0.add_mover(vdw_small_mover)
	random_stage_0.add_mover(vdw_shear_mover)
	vdwrepeat = RepeatMover(random_stage_0, 7)
	
	## Sample
	mc_stage_0 = MonteCarlo(p, sf_stage_0, 10.0)
	trial_stage_0 = TrialMover(vdwrepeat, mc_stage_0)
	trial_stage_0.keep_stats_type(pyrosetta.rosetta.protocols.moves.StatsType.no_stats)
	stage_0 = RepeatMover(trial_stage_0, 1000)
	stage_0.apply(p)
	mc_stage_0.reset(p)
	stage_0.apply(p)
	stage_0.apply(p)
	mc_stage_0.recover_low(p)
	
	## Back to all atom
	switch.apply(p)
	fulltask = standard_packer_task(p)
	fulltask.restrict_to_repacking()
	
	fullpack = PackRotamersMover(SF2, fulltask)
	fullpack.apply(p)

## Ouput
p.dump_pdb(args.Output_PDB)

'''
# Generate poses from the IDR sequence and Folded portion PDB
idr = pose_from_sequence('AAAAAAAAAAAAAAAAAKKKKKKAKAKAKAKAKAK')
folded = pose_from_pdb('../1tit_Titin_I27_Ig_Renumbered.pdb')
'''