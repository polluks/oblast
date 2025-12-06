#
# BASIC menu portion of Oblast
# (C)2025 Cameron Kaiser. All rights reserved.
# Freeware under the Floodgap Free Software License.
#
# visit oldvcr.blogspot.com
# 
1 poke808,234:poke52,31:poke56,31:clr:su=53265:bd=53280:jy=56320:k=198:goto10
#
# subroutine to set level
# (seeds begin at $a800, max 383 levels -> $bff0)
#
2 o=sl*16:pokepb,oand255:pokepb+1,(o/256)+168:cf=32:pokepb+8,32:j=int(sl/100):jm=sl-j*100:jn=int(jm/10):jo=jm-jn*10:pokepb+18,j:pokepb+19,jn:pokepb+20,jo:waitjy,16:return
5 syssy+36,y$:ll=notll:print"{r} "pf$(-ll)" : "left$(y$+ss$,29)" : "pf$(-ll)" {R}":w=usr(w):return
#
# start, mark game as unconfigured, default level 0, default high score
# jump table expected at 13952, parameter block expected at 7680
#
10 pokebd,0:pokesu,11:print"{enhSk}";:hs=15000:sy=13952:pb=7936:cf=0:sl=0:el=59903:poke785,(sy+42)and255:poke786,(sy+42)/256:deffnj(e)=36+(e>9)+(e>99)+(e>999)+(e>9999)+(e>99999)
20 fori=832to891:pokei,255:next:fori=892to895:pokei,0:next:fori=896to960:pokei,255:next
#-echar
30 t$="%ac%a2%a2%a2%a2%bb":u$="%bc{r}%a2%a2%a2%a2{R}%be":v1$="{r}%a1 ":v2$=" {R}%a1":sp$="{]]]}":dimpf$(1),tr$(3),yn$(1):pf$(0)="%b5":pf$(1)=" ":ss$="                             ":yn$(0)="{V} NO{e}":yn$(1)="{Y}YES{e}":tr$(0)=" None":tr$(1)="Horiz":tr$(2)="Vert.":tr$(3)="  H/V"
#
# main menu entry
#
#                      1234567891123456789212345678931234567894
60 restore:print"{S}%9e          SELECT GAME DEFAULT:{q}":printsp$"{V}"t$:printsp$v1$"F1"v2$" {e}Regular Duty":printsp$"{V}"u$"{e} for the default{kq}"
90 printsp$"%9c"t$:printsp$v1$"F3"v2$" {e}Hazard Pay":printsp$"%9c"u$"{e} for the adventurous{q}"
110 printsp$"{Z}"t$:printsp$v1$"F5"v2$" {e}More Like Classic Blasto":printsp$"{Z}"u$"{e} for the nostalgic{q}":printsp$"{Y}"t$:printsp$v1$"F7"v2$" {e}Blow Everything Up Fast":printsp$"{Y}"u$"{e} for the maniac{q}"
#         1234567891123456789212345678931234567894
150 print" Or press RETURN for even more settings":y$="TODAY'S HIGH SCORE"+str$(hs):o=(41-len(y$))/2:print"{q}%9e"spc(o)y$"{qe}"
160 print"%ac%a2%bb    %ac%a2%bb":print"{r}%a1H{R}%a1elp {r}%a1C{R}%a1redits  %b8%b92025 Cameron Kaiser":print"%bc{r}%a2{R}%be    %bc{r}%a2{R}%be         oldvcr.blogspot.com";
#--echar
190 syssy:pokek,.:w=peek(2):poke56576,151:poke53272,31:ifcf>0andw=47then1000
200 pokesu,27:syssy+6:pokesu,11:w=peek(2):ifw=13then3000
210 syssy+3:ifw=67then5000
220 ifw=72then6000
# set game parameters. data statement order is:
# bomb density, tree density, trails?, fuel ticks, glass tank?, fast bullets?
250 forj=133tow:readw1,w2,w3,w4,w5,w6:next:pokepb+2,w1:pokepb+3,w2:pokepb+4,w3:pokepb+5,w4:pokepb+6,w5:pokepb+7,w6:print"{eS}":poke214,24:print:pokesu,27:w=8:ll=0:syssy+33:sl=0
260 y$="":gosub5:y$="ATTENTION TANK COMMANDER":gosub5:y$="BATTLEFIELD CONDITIONS REPORT":gosub5:w=(w/8)*64:y$="":gosub5:w=(w/64)*8
270 ifw1<155theny$="HIGH BOMB HAZARD":gosub5
290 ifw4<30theny$="FAST FUEL COUNTDOWN":gosub5
300 y$="SHELLS RECYCLE ":ifw6=1theny$=y$+"-FAST-":goto320
310 y$=y$+"NORMAL SPEED"
320 gosub5:y$="":gosub5:y$="TANK IS ":ifw5=1theny$=y$+"-VULNERABLE-":goto340
330 y$=y$+"INDESTRUCTABLE"
340 gosub5:y$="":gosub5:w=(w/8)*175:w=usr(w):w=(w/175)*8:y$="STAND BY FOR LAUNCH":gosub5:w=(w/8)*175:y$="":gosub5:gosub2:syssy+3:syssy+9
# end of game screen
500 pokesu,11:syssy+3:waitjy,16:poke53272,31:pokebd,0:poke53269,0:poke53281,0:print"{VS}";:w=56:sc=peek(pb+9)+peek(pb+10)*256:bb=1000:gosub10010:pokesu,27:syssy+21:print"{q}"tab(15)"Out of Fuel!":u=usr(w)
530 y$="Bombs detonated:"+str$(sc):print"{q}"tab((42-len(y$))/2)y$:u=usr(w):w=47:j$="{qq}          Special Bonuses x"+str$(bb)+"{Q}"+chr$(13)
550 fori=11to14:reada$:e=peek(pb+i)*bb:sc=sc+e:printj$"{q}  "a$;tab(fnj(e))e:w=usr(w):j$="":next:reada$:ifpeek(pb+7)thenprint"{q}  "a$;tab(35)"n/a":goto600
580 e=peek(pb+15)*bb:sc=sc+e:print"{q}  "a$;tab(fnj(e))e
600 w=usr(w):fori=16to17:reada$:e=peek(pb+i)*bb:ifpeek(pb+6)=0thenprint"{q}  "a$;tab(35)"n/a":goto630
620 sc=sc+e:print"{q}  "a$;tab(fnj(e))e
630 w=usr(w):next:y$="FINAL SCORE":ifsc>hstheny$="TODAY'S NEW HIGH SCORE"
640 y$=y$+":"+str$(sc):waitjy,16:print"{qqq}"tab((42-len(y$))/2)y$:ifsc>hsthenhs=sc:syssy+27:syssy+3:syssy+24:goto990
650 ifpeek(jy)<>111andpeek(203)=64goto650
990 pokesu,11:syssy+3:pokek,.:waitjy,16:goto60
# fast start
1000 syssy+3:print"{eSqqqqqqqqqqq}"tab(14)"Quick Start!":pokesu,27:w=usr(64):gosub2:syssy+9:goto500
# menu
2000 end
# config screen
3000 pokesu,11:poke53269,127:poke53271,120:poke53277,127:poke53275,127:poke53264,0:ifcf=0thenrestore:readw1,w2,w3,w4,w5,w6:cf=32:sl=0
#-echar
3080 print"{eSZ}"tab(9)"%ac%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%bb":printtab(9)"{r}%a1%1f                    {RZ}%a1":printtab(9)"{r}%a1%1f GAME CONFIGURATION {RZ}%a1"
3090 printtab(9)"{r}%a1%1f                    {RZ}%a1":printtab(9)"%bc{r}%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2%a2{R}%be":syssy+30,96,50
3100 forx=21to23:poke781,x:sysel:next:poke214,20:print:printtab(7)"{V}F1 %9cF3 {Z}F5 {Y}F7{e} to load preset":print"  Press game option letter to change":printtab(10)"{P}Press RETURN to play"
3200 poke781,6:sysel:poke781,8:sysel:poke781,10:sysel:poke781,14:sysel
3210 print"{sqqqqqq} %9bA){e} Starting Level"tab(fnj(sl))sl:print"{q} %9bB){e} Bomb Density (lower: more)"tab(fnj(w1))w1:print"{q} %9bC){e} Tree Density (higher: more)"tab(fnj(w2))w2
3250 print"{q} %9bD){e} Trails?%9e"tab(33)tr$(w3):print"{q} %9bE){e} Fuel Rate (lower: faster)"tab(fnj(w4))w4:print"{q} %9bF){e} Tank Takes Hits?"tab(35)yn$(w5):print"{q} %9bG){e} Fast Cycle Shells?"tab(35)yn$(w6):pokesu,27
#--echar
3310 pokek,.:waitk,1:w=peek(631):ifw>132andw<137thenrestore:fori=133tow:readw1,w2,w3,w4,w5,w6:next:goto3200
3330 ifw=70thenw5=-(not-w5):goto3210
3340 ifw=71thenw6=-(not-w6):goto3210
3350 ifw=68thenw3=(w3+1)and3:goto3210
3360 ifw=13then4000
3370 ifw<65orw>69then3310
#-echar
3400 forx=21to23:poke781,x:sysel:next:poke214,21:print:print" {e}Enter value up to 255 and press RETURN":w=w-65:f$="":poke214,6+w+w:print:printtab(35)"%1c%a3%a3%a3{Q|||e}   {|||}";:poke204,.:pokek,.
#--echar
3410 waitk,255:geta$:ifa$=chr$(13)andlen(f$)>0thenpoke204,1:poke781,7+w+w:sysel:onw+1goto3500,3510,3520,3410,3530
3420 ifa$=chr$(13)andlen(f$)=0thenpoke204,1:poke781,7+w+w:sysel:goto3100
3430 ifa$=chr$(20)andlen(f$)>0thenf$=left$(f$,len(f$)-1):poke204,1:print"{|}  {||}";:poke204,.:goto3410
3440 ifa$<"0"ora$>"9"orlen(f$)=3orval(f$+a$)>255goto3410
3490 printa$;:f$=f$+a$:goto3410
3500 sl=val(f$):goto3100
3510 w1=val(f$):goto3100
3520 w2=val(f$):goto3100
# consider fuel rate 0 to be invalid
3530 w4=val(f$):w4=(-1*(w4=0))+w4:goto3100
4000 pokesu,11:poke53269,0:pokek,.:pokepb+2,w1:pokepb+3,w2:pokepb+4,w3:pokepb+5,w4:pokepb+6,w5:pokepb+7,w6:goto1000
# credits
5000 syssy+39:goto60
# help
6000 gosub10020:print"{eS}":poke214,24:print:ll=0:pokesu,27:syssy+33
6010 ready$:ify$="x"thenwaitjy,16:waitjy,16,16:pokesu,11:syssy+3:goto60
6020 w=8:ify$=" "thenw=128
6030 gosub5:goto6010
# 
#         f1              f3              f5              f7
10000 data166,32,0,40,1,0,150,40,0,40,1,0,176,96,3,40,1,1,100,32,0,10,0,1
10010 poke65,peek(122):poke66,peek(123):return
10011 data"Crater in One","One Tree Hill","Complete Deadwood","Trigger Happy","Cheap Shot","Safe Driver","Saved by the Bell"
10020 poke65,peek(122):poke66,peek(123):return
10030 data"","ATTENTION TANK COMMANDER","BATTLEFIELD OPS BRIEFING"," "
#-echar
#          -----------------------------
10031 data" ^                         ^","_ %a8  MOVE TANK UP DOWN    _ %a8"," %dc     LEFT OR RIGHT       %dc",""
10034 data"      FIRE SHELLS AND"," %bf   DESTROY ALL BOMBS     %bf","    BEFORE FUEL RUNS OUT"," "
10040 data"     DRIVING OVER BOMBS","%b8%bf%b9  OR TREES WILL SLOW   %bf%b9%bf","         DOWN TANK",""
#--echar
10043 data"EXPLOSIONS STALL TANK","IF TANK IS VULNERABLE"," ","MORE INFO IN MANUAL","GOOD LUCK COMMANDER","PRESS FIRE"," ","x" 
