# AbInitioVO and FastFloppyTail
 AbInitio Variable Order and FastFloppyTail Algorithms for Protein Structure Prediction from Sequence

## Algorithm Descritions
### AbInitioVO
The AbInitio Variable Order (AbInitioVO) PyRosetta algorithm is an improvement of the [AbInitio-Relax](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/abinitio-relax)
algorithm in Rosetta which features changes to the fragment selection process and structure scoring. Disordered probability predictions based on protein sequence are used as an additional inputs alongside secondary
structure predictions to influence 9-mer and 3-mer [fragment picking](https://www.rosettacommons.org/docs/latest/application_documentation/utilities/app-fragment-picker). Furthermore, by making improvements to the 
[centroid score terms](https://www.rosettacommons.org/docs/latest/rosetta_basics/scoring/centroid-score-terms), specifically the ""rg"" term, to accomadate disordered proteins this algorithm is able to accurately 
predict the structures of ordered domains, of both fully ordered and partially ordered proteins, as well as identifying disordered regions.

### FastFloppyTail
FastFloppyTail is an improved variant of the [FloppyTail](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/floppy-tail) Rosetta algorithm written for PyRosetta. The algorithm features 
a reduction in sidechain packing moves along with an increase in the fequency with which sampled structures are returned to their minima. Overall this algorithm boasts both a marked increase in accuracy compared to experimental 
data along with a 10-fold reduction in compute time compared to FloppyTail.

## Installation Guide
__Operating System:__ Linux (64-bit)

__Programming Langauge:__ Python
This code was specifically written and tested in Python3.6 (python3.6.8)
	
__Required Python Packages:__
- PyRosetta
	- This was specifically written and tested with PyRosetta 2019.17+release.2cb3f3a py36_0. Additional information can be found on the [PyRosetta](http://www.pyrosetta.org/) website. This specific PyRosetta build can be downloaded [here](http://www.pyrosetta.org/dow) after obtaining a [license](https://els.comotion.uw.edu/express_license_technologies/pyrosetta)
- biopython (1.73)
- numpy (1.14.5)
- scipy (1.1.0)

__Anaconda Environment:__
An anaconda environment containing all necessary packages can be found in the anaconda folder. Build time for this Anaconda environment takes on the order of mintues to hours depending on the number of processors used and is largely dependent on the PyRosetta build time.

__Additional Reccommended Software Packages:__
- Blast (blast-2.2.26)
- [DSSP](https://swift.cmbi.umcn.nl/gv/dssp/) (installed via [conda](https://anaconda.org/salilab/dssp)) 
- [Sparta+](https://spin.niddk.nih.gov/bax/software/SPARTA+/)
- [PALES](https://www3.mpibpc.mpg.de/groups/zweckstetter/_links/software_pales.htm#HuP)

## Running AbInitioVO

## Running FastFloppyTail

## Analysis
