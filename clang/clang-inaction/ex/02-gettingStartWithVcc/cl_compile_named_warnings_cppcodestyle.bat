@echo off

REM  this call of cl  produces and obj file and the executable named after a source file

del *.obj
del *.exe
cl sample.c /nologo /FeOutProg.exe /W4 /TP