repeat
	print(get_orientation_sensor)
	sleep(100)
	if is_pressed "menu" then
		key="MENU"
	end
until key=="MENU"