rem Blokada spustu

@title blokowanie spustu
@param t Czas blokady 
@default t 20
@param s Czas opoznienia
@default s 5

t=t*1000
s=s*1000

press "shoot_half"
sleep s

print "blokowanie spustu na", t, "sekund..."

press "shoot_full"
sleep t
release "shoot_full"
sleep 400

release "shoot_half"
print "Koniec"

end