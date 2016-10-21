@title Ostrosc
@param m M-0 | aDoF-(~0)
@default m 0
@param a poczatek (mm)
@default a 50
@param z koniec (mm)
@default z 30000
@param q iloraz (/100)
@default q 103
@param t interwal (s)
@default t 1

let a=a*1000
let z=z*1000

let d=10
let f=a
let i=1
	
if m = 0 then
	while 1 = 1
		set_focus (f/1000)
		print "zdj:", i
		sleep t*1000
		shoot
		let i=i+1
		if f<z then 
			let f=f*q/100
		endif
	wend
else
	while 1 = 1
		set_focus (f/1000)
		print "zdj:", i
		sleep t*1000
		shoot
		let i=i+1
		if f < z then 
			get_dof d
			d=d*1000
			let f=f+(d*2/3)
		endif
	wend
endif