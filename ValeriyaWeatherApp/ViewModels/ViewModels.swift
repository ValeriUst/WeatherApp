//  ViewModels.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

struct WeatherViewModelNow {
	let nameCity: String
	let tempNow: Int
	let conditionNow: String
	let forecasts: [Forecast]
	
	init(from weatherModel: WeatherModel) {
		nameCity = weatherModel.geoObject?.locality.name ?? ""
		tempNow = weatherModel.fact?.temp ?? 0
		conditionNow = weatherModel.fact?.condition ?? ""
		forecasts = weatherModel.forecasts ?? []
	}
	
	
//	
//	func printForecastDates() -> String {
//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "yyyy-MM-dd"
//		var datesString = ""
//		let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//		let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//		
//		for forecast in forecasts {
//			if let dateString = forecast.date, let date = dateFormatter.date(from: dateString) {
//				dateFormatter.dateFormat = "d MMM EEE"
//				let formattedDate = dateFormatter.string(from: date)
//				datesString.append("\(formattedDate)   ")
//			}
//		}
//		return datesString
//	}
}
	
struct WeatherViewModelCity {
	let nameCity: String
	let temp: Int
	
	init(from weatherModel: WeatherModel) {
		nameCity = weatherModel.geoObject?.locality.name ?? ""
		temp = weatherModel.fact?.temp ?? 0
	}
}

struct WeatherViewModelCityTime {
	let hour: String
	let temperature: Int
	//let iconURL: URL?
	
	init(hour: String?, temperature: Int?) {
		self.hour = hour ?? ""
		self.temperature = temperature ?? 0
	}
}
