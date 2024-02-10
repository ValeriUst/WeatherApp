//  ViewModels.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

struct WeatherViewModelCity {
	let nameCity: String
	let temper: Int
	let condition: String
	let time: Int
	let dayNight: [Forecast]

	init(model: WeatherModel) {
		self.nameCity = model.geoObject?.locality.name ?? ""
		self.temper = model.fact?.temp ?? 0
		self.condition = model.fact?.condition ?? ""
		self.time = model.now ?? 0
		self.dayNight = model.forecasts
	}
}

struct WeatherViewModelCityTime {
	let hour: String
	let temperature: Int
	//let icon: String?
	
	init(hour: String?, temperature: Int?) {
		self.hour = hour ?? ""
		self.temperature = temperature ?? 0
		//self.icon = icon ?? ""
	}
}
