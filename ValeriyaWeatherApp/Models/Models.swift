//  Models.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
	let geoObject: GeoObject?
	let fact: Fact?
	let forecasts: [Forecast]?

	enum CodingKeys: String, CodingKey {
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
	let id: Int
	let name: String
}

// MARK: - Fact
struct Fact: Codable {
	let temp: Int?
	let icon: String?
	let condition: String?

	enum CodingKeys: String, CodingKey {
		case temp
		case icon, condition
	}
}

// MARK: - Forecast
struct Forecast: Codable {
	let date: String?
	let hours: [Hour]
	
	enum CodingKeys: String, CodingKey {
		case date
		case hours
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
