//  NetworkService.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import Foundation

struct Constants {
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
]

final class APICaller {
	static let shared = APICaller()
	
	func getWeather(forCities cities: [(lat: Double, lon: Double)], completion: @escaping (Result<[WeatherModel], Error>) -> Void) {
		var resultsArray: [WeatherModel] = []
		let dispatchGroup = DispatchGroup() 
		
		for city in cities {
			dispatchGroup.enter()
			
			guard let url = URL(string: "\(Constants.baseURL)lat=\(city.lat)&lon=\(city.lon)&limit=1&hours=true") else {
				completion(.failure(APIError.invalidURL))
				return
			}
			
			var request = URLRequest(url: url)
			request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-Yandex-API-Key")
			
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
					resultsArray.append(result)
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
