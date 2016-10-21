@title Automatic Geometric Focus Bracketing
@param m manual-0 | autoDoF-1
@default m 0
@param a begining (mm)
@default a 60
@param z end (mm)
@default z 10000
@param r start distance (mm)
@default r 50
@param q quotient (/1000)
@default q 1050
@param t interval (s/10)
@default t 5
@param n divisor of DoF (/300)
@default n 200
@param x is it movie? (1/0)
@default x 0

rem setting precision multiplier:
let y=1000

rem multiplying variables by multiplier:
let a=a*y
let z=z*y
let r=r*y

rem presets:
let f=a
let i=1

rem choice of working mode:
if a<z then q=1000000/q

rem decreasing precision if numbers are to high:
if (m = 0) then
	while 1 = 1
		if ((f/10000)>(180000/q)) then
			let y=y/10
			let f=f/10
			let z=z/10
			let r=r/10
		endif
rem setting focus distance:
		set_focus (f/y)
rem disp of picture number and focus distance:
		print "#", i, "f:", (f/y)/1000, "m", (f/y)%1000, "mm"
		sleep (t*100)
rem if film=1 it does not take photo, if=0 it does with focusing:
		if x = 0 then 
			shoot 
		endif
rem increasing photo number by one:
		let i=(i+1)
rem focus dist change (geometric sequence):
		let f=r+((f-r)*q/1000)
rem when computed focus dist is bigger than set end of focus:
		if f>z then 
			let f=z
		endif
	wend
else
rem second mode - adds part of DoF to focus dist:
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
rem dof read from camera:
		get_dof d
rem multiplying to more precise computations:
		let d=(d*y)
rem adding (dof divisor)/300 to focus distance:
		let f=f+(d*n/300)
		if f>z then 
			let f=z
		endif
	wend
endif
end