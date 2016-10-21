rem Latarka

@title Latarka
@param t Czas swiecenia [s]
@default t 10
@param m Czas swiecenia [m]
@default m 0

if t<0 then let t=0
if m<0 then let m=0

t=t+m*60

if t=0 then let t=10

set_led 9 1

for x=1 to t
print t+1-x
set_led 4 1
set_led 7 0
sleep 500
set_led 4 0
set_led 7 1
sleep 500
next x

set_led 9 0
set_led 4 0
set_led 7 0