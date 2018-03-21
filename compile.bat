@ECHO OFF
SET _complog=%cd%\ddcompile.log

IF EXIST %_complog% (
	DEL %_complog%
)

TYPE nul > %_complog%


ECHO Compiling ACS>> %_complog%
CD ddrama\acs


IF EXIST error_acs.log (
	DEL error_acs.log
)

gdcc-acc.exe cookbook.acs cookbook.o --error-file error_acs.log >> %_complog%
IF EXIST error_acs.log (
	ECHO Error compiling cookbook ACS Library>> %_complog%
	TYPE error_acs.log>> %_complog%
	ECHO Aborting compilation!>> %_complog%
	CD ..\..
	goto FAIL_ERROR_ACS
)

gdcc-acc.exe cutscene.acs cutscene.o --error-file error_acs.log >> %_complog%
IF EXIST error_acs.log (
	ECHO Error compiling cutscene ACS Library>> %_complog%
	TYPE error_acs.log>> %_complog%
	ECHO Aborting compilation!>> %_complog%
	CD ..\..
	GOTO FAIL_ERROR_ACS
)
CLS
CD ..\..

ECHO Compiling Daytime Drama PK3>> %_complog%

IF EXIST ddrama.ipk3 (
	ECHO Deleting ddrama.ipk3>> %_complog%
	DEL ddrama.ipk3
)

7z a -r -tzip -mx9 -xr!unused -x!*.bat -x!*.dbs -x!*.wad.backup? ddrama.ipk3 .\ddrama\*>> %_complog%

IF NOT EXIST ddrama.ipk3 (
	GOTO FAIL_ERROR_PK3
)
CD saves

IF EXIST *.zds (
	ECHO Deleting saves...
	DEL *.zds >> %_complog%
)
CD ..

:SUCCESS_COMPLETE
ECHO SUCCESS: Game PK3 compiled!>> %_complog%
GOTO EOF

:FAIL_ERROR_ACS
ECHO ERROR: ACS returned an error!>> %_complog%

:FAIL_ERROR_PK3
ECHO ERROR: Game PK3 failed to compile!>> %_complog%

:EOF
ECHO DONE.>> %_complog%