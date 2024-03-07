//  Constants.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 12.02.2024.

import UIKit

struct Constants {
	static let standardInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
	static let standardOffsets = 25
	
	static let sizeCellCity = CGSize(width: 172, height: 215)
	static let sizeCellWeather = CGSize(width: 76, height: 76)
	static let sizeCellDefaults = CGSize(width: 100, height: 100)
	
	static let cornerRadiusCity: CGFloat = 22
	static let cornerRadiusStandard: CGFloat = 16
	static let cornerRadiusImage: CGFloat = 22
	static let cornerRadiusTabbar: CGFloat = 10
	
	static let todayLabel = "Today"
	static let nowLabel = "Now"
	static let swipeLabel = "Swipe down for details"
	static let degreeLabel = "°C"
	static let urlIcon = "https://yastatic.net/weather/i/icons/funky/dark/"
	static let date = "dd MMM EEE"
	
	static let errorCity = "Имя города неизвестно"
	static let errorTemperature = "Температура неизвестна"
	static let errorPrecipitation = "Осадки неизвестны"
	static let errorDate = "Дата неизвестна"

	
	// MARK: - Constants UI
	static let swipeFontSize: CGFloat = 12
	static let todayFontSize: CGFloat = 20
	static let nameCityFontSize: CGFloat = 28
	static let dateFontSize: CGFloat = 12.91
	static let temperatureTodayFontSize: CGFloat = 12.91
	static let temperatureFontSize: CGFloat = 36
	static let precipitationFontSize: CGFloat = 21.33
}
