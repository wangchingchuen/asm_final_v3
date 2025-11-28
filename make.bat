@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang 

REM delete related files
REM 	del t.lst
REM 	del t.obj
REM 	del t.ilk
REM 	del t.pdb
REM 	del t.exe


REM /c          assemble without linking
REM /coff       generate object code to be linked into flat memory model 
REM /Zi         generate symbolic debugging information for WinDBG
REM /Fl		Generate a listing file
 

ML /c /coff /Zi   t.asm
if errorlevel 1 goto terminate

REM /debug              generate symbolic debugging information
REM /subsystem:console  generate console application code
REM /entry:start        entry point from WinDBG to the program 
REM                           the entry point of the program must be _start

REM /out:%1.exe         output %1.exe code
REM %1.obj              input %1.obj
REM Kernel32.lib        library procedures to be invoked from the program
REM irvine32.lib
REM user32.lib

LINK /INCREMENTAL:no /debug /subsystem:console /entry:start /out:t.exe t.obj Kernel32.lib irvine32.lib user32.lib
if errorlevel 1 goto terminate

wt -w 0 -d . cmd /c "chcp 65001 && t.exe"

REM Display all files related to this program:
DIR t.*

:terminate
pause
endlocal