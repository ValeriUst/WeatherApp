//  ViewModels.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

struct WeatherViewModelCity {
	let nameCity: String
	let temper: Int
	let condition: String
	let time: Int
	
	let tempMin: Int
	let tempMax: Int
	
	let hour: String
	let tempHour: Int
	let icon: String

	init(model: WeatherModel) {
		self.nameCity = model.geoObject?.locality.name ?? ""
		self.temper = model.fact?.temp ?? 0
		self.condition = model.fact?.condition ?? ""
		self.time = model.now ?? 0
		
		self.tempMax = model.forecasts.first?.parts.day?.tempMax ?? 0
		self.tempMin = model.forecasts.first?.parts.day?.tempMin ?? 0
		
		self.hour = model.forecasts.first?.hours.first?.hour ?? ""
		self.tempHour = model.forecasts.first?.hours.first?.temp ?? 0
		self.icon = model.forecasts.first?.hours.first?.icon ?? ""
	}
}
