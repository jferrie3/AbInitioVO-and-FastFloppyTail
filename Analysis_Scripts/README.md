# Analysis Scripts for FastFloppyTail Structural Ensembles
These scripts allow various parameters to be computed from structural ensembles generated from FastFloppyTail.

## Script List
 
#### Distance_Extraction.py
_Requires pdb_assembler.py and polymer_analysis runs._ This script takes an interresidue average/standard deviation distance maps and isolated the values
for residues of interest (example INPUT_RESIDUE_PAIR_SET.cst found in Data_Compiled/asyn_distance.cst)
```run Distance_Extraction.py INPUT_RESIDUE_PAIR_SET.cst DISTANCES.out COMPILED.dm COMPILED.std```

#### dssp_output_analysis.py
What does this do
```how to run```

#### EFRETs_from_Ensembles.py
This script takes a set of outputs from FastFloppyTail and computes the average FRET for given FRET pairs (example FRET_SET.txt found in Data_Compiled/asyn_efret.txt)
```run EFRETs_from_Ensembles.py FRET_SET.txt FASTFLOPPYTAIL_OUTPUTS_*.pdb```

#### Full_IDP_Analysis_Script_FastFloppyTail.py
What does this do
```how to run```

#### J_Couplings.py
What does this do
```how to run```

#### make_PALES_input.py
What does this do
```how to run```

#### PALES_Analysis_Parallel_bestFit.py
What does this do
```how to run```

#### pdb_assembler.py
This script takes a set of PBDs (generally with the same base name) and compiles them into a single PDB file
```run pdb_assembler.py OUTPUT_COMPILED.pdb INPUT_PDB_NAME_*.pdb```

#### polymer_analysis.py
This scripts takes an input compiled PDB files (obtained from _pdb_assembler.py_) and generates an interresidue contact probability map(.cm, cutoff distance specified in line 12, Default 25 Angstroms), 
an interresidue average distance map (.dm) and associated standard deviations (.std), a polymer scaling plot (.nu) and associated standard deviation (.nus) and computes the radius of gyration (.rg) for 
the set of structures.
```run polymer_analysis.py COMPILED.pdb```

#### PRE_Data_Comparison.py
This script takes the output from _PREs_from_Ensembles.py_ and compares the simulated values to input experiments (example PRE_DATA.pre found in Data_Compiled/asyn.pre).
```run PRE_Data_Comparison.py PRE_DATA.pre```

#### PREs_from_Ensembles.py
This script takes a set of outputs from FastFloppyTail and computes the average I/Io for given PRE probe sites (example PRE_DATA.pre found in Data_Compiled/asyn.pre).
```run PREs_from_Ensembles.py PRE_DATA.pre FASTFLOPPYTAIL_OUTPUTS_*.pdb```

#### Process_DSSP.py
What does this do
```how to run```

#### Process_PALES_bestFit.py
What does this do
```how to run```

#### Process_SPARTA_Parallel.py
What does this do
```how to run```

#### Sparta_Analysis_Post_Process_2.py
What does this do
```how to run```