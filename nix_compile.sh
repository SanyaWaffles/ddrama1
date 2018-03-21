#!/bin/bash

if [ -f ddrama.ipk3 ]; then
	rm ddrama.ipk3
fi

gdcc-acc cookbook.acs cookbook.o --error-file error_acs.log

gdcc-acc cutscene.acs cutscene.o --error-file error_acs.log

7z a -r -tzip -mx9 -xr!unused -x!*.bat -x!*.dbs -x!*.wad.backup? ddrama.ipk3 ./ddrama/*

if [ -f ddrama.ipk3 ]; then
	echo ddrama.ipk3 successfully created.
else
	echo ddrama.ipk3 not created. Do you have p7zip installed?
fi
