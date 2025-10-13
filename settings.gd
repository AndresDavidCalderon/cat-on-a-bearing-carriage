extends Node

func db_to_slider_value(db:float):
	return ((db+30)/30)*100

func value_to_db(val:float):
	return (val/100)*30-30

func set_volume_to_value(bus_name:String,volume:float):
	var idx=AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(idx,value_to_db(volume))

func set_value_to_volume_slider(bus_name:String,slider:HSlider):
	var idx=AudioServer.get_bus_index(bus_name)
	slider.value=db_to_slider_value(AudioServer.get_bus_volume_db(idx))
