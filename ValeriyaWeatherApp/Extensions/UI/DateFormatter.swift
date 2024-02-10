//  File.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 10.02.2024.

import Foundation

extension Date {
	static func stringFromUnixtime(_ unixtime: Int) -> String {
		// Преобразовываем Unixtime
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(unixtime)))
	}
}
