.SUFFIXES: .h .spr .bas .tok

ALL: ../prg/oblast

../prg/oblast: game.arc
	pucrunch -fshort game.arc $@

game.arc: main.arc menu.tok
	tools/linkb --big --ofile=game.arc menu.tok main.arc

main.arc: game.xa tank3.h tank2.h tank1.h tank1a.h shell.h gauge.h game.fon main.fon ddtank.scr ddtitle ddtank.bmp
	xa -o main.arc -a -O PETSCREEN -l game.sym game.xa

# non-rotating
shell.h: shell.spr
	tools/spr2data -byt $? > $@

gauge.h: gauge.spr
	tools/spr2data -byt $? > $@

ddtank.scr: ddtank
	dd ibs=1 if=$? count=1026 of=$@

ddtank.bmp: ddtank
	awk 'BEGIN{printf("%c%c",0,160)}' > $@
	dd ibs=1 if=$? skip=1026 count=8192 obs=1 seek=2 of=$@

# all others rotate
.spr.h:
	tools/spr2data -byt $? | tools/rotator -byt > $@

.bas.tok:
	tools/bt --ofile=$@ $?

clean:
	rm -f ../prg/oblast *.arc *.sym *.h *.tok ddtank.*

