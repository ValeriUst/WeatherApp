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
final class APICaller {
	static let shared = APICaller()
	
	func getWeather(completion: @escaping (Result<WeatherModel, Error>) -> Void) {
		guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&hours=true") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		
		var request = URLRequest(url: url)
		request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-Yandex-API-Key")
		
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(APIError.failedToGetData))
				return
			}
			
			//print("Received data:", String(data: data, encoding: .utf8))
			
			do {
				let results = try JSONDecoder().decode(WeatherModel.self, from: data)
				completion(.success(results))
			} catch {
				print("Failed to decode weather data:", error.localizedDescription)
				completion(.failure(APIError.failedToDecodeData))
			}
		}
		task.resume()
	}
}
