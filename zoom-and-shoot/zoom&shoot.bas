@title Zoom & Shoot
@param m ilosc zdjec z kazdym stopniem zoomu
@default m 1
@param s poczatkowy stopien zoomu
@default s 0
@param n stopien koncowy (8/14/129)
@default n 8
@param p strzelac (0-nie 1-raz 2-zawsze)
@default p 2
@param a AF (0-nie 1-raz 2-za kazdym razem)
@default a 0
@param f MF (mm)
@default f 3000
@param t czas miedzy stopniami zoomu (s/10)
@default t 6
@param u czas oponienia AF (s/10)
@default u 10

if a>0 then
	press "shoot_half"
	sleep u*100
	get_focus f
	release "shoot_half"
endif

for i=s to n
	for j=1 to m
		set_zoom i
		sleep t*100

		if a>1 then
			press "shoot_half"
			sleep u*100
			get_focus f
			release "shoot_half"
		endif

		set_focus f
		print "zoom", i, "#", j
		sleep 200

		if p>0 then
			shoot 
			if p=1
				p=0
			endif
		endif
	next j
next i
end