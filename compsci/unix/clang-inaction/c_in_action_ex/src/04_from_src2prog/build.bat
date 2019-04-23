@echo off


@echo "clean prev build artifacts"
del *.obj
del *.exe

echo "compiling into obj files"
cl /nologo *.c  /c  /W4

echo "linking"
link *.obj /out:main.exe
