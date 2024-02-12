//  NetworkService.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

struct ConstantsAPI {
	static let API_KEY = "f9d50069-0119-4146-9588-dc7e699326e3"
	static let baseURL = "https://api.weather.yandex.ru/v2/forecast?"
}

enum APIError: Error {
	case failedToGetData
	case invalidURL
	case failedToDecodeData
}

let cities = [
	(lat: 55.75396, lon: 37.620393), // Москва
	(lat: 59.9342802, lon: 30.3350986), // Санкт-Петербург
	(lat: 55.03020477, lon: 82.92043304), // Новосибирск
	(lat: 56.8380127, lon: 60.59747314), // Екатеринбург
	(lat: 55.79612732, lon: 49.10641479), // Казань
	(lat: 56.32679749, lon: 44.0065155), // Нижний Новгород
	(lat: 45.03546906, lon: 38.97531128), // Краснодар
	(lat: 54.98934555, lon: 73.36821747), // Омск
	(lat: 47.22207642, lon: 39.72035599) // Ростов
]

final class APICaller {
	static let shared = APICaller()
	
	func getWeather(forCities cities: [(lat: Double, lon: Double)], completion: @escaping (Result<[WeatherModel?], Error>) -> Void) {
		var resultsArray: [WeatherModel?] = Array(repeating: nil, count: cities.count)
		
		let dispatchGroup = DispatchGroup()
		
		for (index, city) in cities.enumerated() {
			dispatchGroup.enter()
			
			guard let url = URL(string: "\(ConstantsAPI.baseURL)lat=\(city.lat)&lon=\(city.lon)&limit=1&hours=true") else {
				completion(.failure(APIError.invalidURL))
				return
			}
			
			var request = URLRequest(url: url)
			request.setValue(ConstantsAPI.API_KEY, forHTTPHeaderField: "X-Yandex-API-Key")
			
			let task = URLSession.shared.dataTask(with: request) { data, _, error in
				defer {
					dispatchGroup.leave()
				}
				
				guard let data = data, error == nil else {
					completion(.failure(APIError.failedToGetData))
					return
				}
				
				do {
					let result = try JSONDecoder().decode(WeatherModel.self, from: data)
					resultsArray[index] = result
				} catch {
					print("Failed to decode weather data:", error.localizedDescription)
					completion(.failure(APIError.failedToDecodeData))
				}
			}
			task.resume()
		}
		
		dispatchGroup.notify(queue: .main) {
			completion(.success(resultsArray))
		}
	}
}
