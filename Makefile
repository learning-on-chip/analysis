cpu2006 := \
	GemsFDTD calculix gromacs leslie3d omnetpp sphinx3 astar dealII h264ref \
	libquantum perlbench wrf bwaves gamess hmmer mcf povray xalancbmk bzip2 \
	gcc lbm milc sjeng zeusmp cactusADM gobmk lbm_mcf namd soplex

parsec := \
	blackscholes bodytrack canneal dedup facesim ferret fluidanimate freqmine \
	raytrace streamcluster swaptions vips x264

all: parsec-small

cpu2006-%:
	./bin/display.py $(addprefix cpu2006/$*/,$(cpu2006))

parsec-%:
	./bin/display.py $(addprefix parsec/$*/,$(parsec))

.PHONY: all cpu2006-* parsec-*
