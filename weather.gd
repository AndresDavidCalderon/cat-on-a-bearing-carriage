extends Node
## The class is called weather but should be in charge
## of most per-day predictable random happenings.

enum Weather{
	SUNNY,
	RAINY
}

var forecast={}

## Define and return the forecast in that interval.
## Inclusive start and end.
func get_forecast_range(day1:int,day2:int):
	var report=[]
	for i in range(day1,day2+1):
		report.append(getdefine(i)["weather"])
	
	return report

func define_forecast(day:int):
	forecast[day]={
		"weather":Weather.values().pick_random()
	}
	if day<=2:
		forecast[day]["weather"]=Weather.SUNNY
	if day==3:
		forecast[day]["weather"]=Weather.RAINY

func get_weather_today():
	return getdefine(GlobalScore.current_day)["weather"]

func getdefine(day):
	if not day in forecast:
		define_forecast(day)
	return forecast[day]
