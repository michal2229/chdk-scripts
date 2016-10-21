@param b punkt koncowy (mm)
@default b 32000
@param q iloraz (/100)
@default q 103

f=50000
b=b*1000


while 1=1
	set_focus (f/1000)
	sleep 2000
	shoot
	if f<b then 
		let f=f*q/100
	endif
wend