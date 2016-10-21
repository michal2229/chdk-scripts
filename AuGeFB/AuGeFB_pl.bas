@title Automatyczny Geometryczny Bracketing Ostrosci
@param m M-0 | aDoF-1
@default m 0
@param a poczatek (mm)
@default a 60
@param z koniec (mm)
@default z 10000
@param r poczatek pomiaru ogniskowej (mm)
@default r 50
@param q iloraz (/1000)
@default q 1030
@param t interwal (s/10)
@default t 5
@param n dzielnik DoF (/300)
@default n 200
@param x film? (1/0)
@default x 0

rem ustawienie mnoznika precyzji:
let y=1000

rem mnozenie zmiennych przez mnoznik:
let a=a*y
let z=z*y
let r=r*y

rem nastawy poczatkowe:
let f=a
let i=1

rem wybor trybu pracy:
if (m = 0) then
	while 1 = 1
rem zmniejszenie precyzji przy zbyt duzych liczbach:
		if ((f/10000)>(180000/q)) then
			let y=y/10
			let f=f/10
			let z=z/10
			let r=r/10
		endif
rem ustawianie odleglosci ostrosci:
		set_focus (f/y)
rem wyswietlanie numeru zdjecia/(ilosci zmian ostrosci) i aktualnej odleglosci ostrosci:
		print "#", i, "f:", (f/y)/1000, "m", (f/y)%1000, "mm"
		sleep (t*100)
rem jesli film=1 - nie robi zdjecia; jesli film=0 - robi zdjecie z kazdym nowym ustawieniem ostrosci:
		if x = 0 then 
			shoot 
		endif
rem zwiekszenie numeru zdjecia o 1
		let i=(i+1)
rem zmiana odleglosci ostrosci (kolejny wyraz ciagu geometrycznego) z uwzglednieniem poczatku pomiaru r:
		let f=r+((f-r)*q/1000)
rem jesli obliczona odleglosc ostrosci jest wieksza niz ustawiony koniec: odleglosc ostrosci ustawiana jest na koniec:
		if f>z then 
			let f=z
		endif
	wend
else
rem drugi tryb pracy - zamiast ilorazu bierze pod uwage glebie ostrosci (dodaje czesc glebi do aktualnej odleglosci ostrosci):
	while 1 = 1
		if (f/1000>1000) then
			let y=y/10
			let f=f/10
			let z=z/10
		endif
		set_focus (f/y)
		print "#", i, "f:", (f/y)/1000, "m", (f/y)%1000, "mm"
		sleep (t*100)
		if x = 0 then 
			shoot 
		endif
		let i=(i+1)
rem	odczytywanie glebi ostrosci w milimetrach:
		get_dof d
rem mnozenie glebi istrosci przez mnoznik:
		let d=(d*y)
rem dodanie (dzielnik DoF)/300 glebi ostrosci do aktualnej odleglosci ostrosci:
		let f=f+(d*n/300)
		if f>z then 
			let f=z
		endif
	wend
endif
end