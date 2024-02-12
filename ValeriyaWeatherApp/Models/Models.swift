//  Models.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
	let now: Int?
	let geoObject: GeoObject?
	let fact: Fact?
	let forecasts: [Forecast]

	enum CodingKeys: String, CodingKey {
		case now
		case geoObject = "geo_object"
		case fact, forecasts
	}
}

// MARK: - GeoObject
struct GeoObject: Codable {
	let locality: Country
}

// MARK: - Country
struct Country: Codable {
	let id: Int?
	let name: String?
}

// MARK: - Fact
struct Fact: Codable {
	let uptime: Int?
	let temp: Int?
	let icon: String?
	let condition: String?

	enum CodingKeys: String, CodingKey {
		case temp, uptime
		case icon, condition
	}
}

// MARK: - Forecast
struct Forecast: Codable {
	let date: String?
	let hours: [Hour]
	let parts: Parts
	
	enum CodingKeys: String, CodingKey {
		case date
		case parts, hours
	}
}

// MARK: - Hour
struct Hour: Codable {
	let hour: String?
	let temp: Int?
	let icon: String?
	
	enum CodingKeys: String, CodingKey {
		case hour
		case temp
		case icon
	}
}

// MARK: - Parts
struct Parts: Codable {
	let night: Day?
	let day: Day?
	
	enum CodingKeys: String, CodingKey {
		case night
		case day
	}
}

// MARK: - Day
struct Day: Codable {
	let tempMin, tempMax: Int?
	
	enum CodingKeys: String, CodingKey {
		case tempMin = "temp_min"
		case tempMax = "temp_max"
	}
}
