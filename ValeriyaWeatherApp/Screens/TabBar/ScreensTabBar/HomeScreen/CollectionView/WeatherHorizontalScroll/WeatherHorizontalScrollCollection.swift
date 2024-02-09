//  WeatherHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class WeatherHorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
	var weatherData: [WeatherViewModelCityTime] = []


	// MARK: - Content Views
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
		layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25) 
		return layout
	}()
	
	private func setupCollectionView() {
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.collectionViewLayout = layout
		collectionView.register(WeatherHorizontalScrollCell.self,
								forCellWithReuseIdentifier: WeatherHorizontalScrollCell.identifier)
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
		fetchWeatherData()
		
	}
	private func fetchWeatherData() {
		APICaller.shared.getWeather(forCities: cities) { [weak self] result in
			switch result {
			case .success(let weatherModels):
				let allWeatherData = weatherModels.flatMap { weatherModel -> [WeatherViewModelCityTime] in
					return weatherModel.forecasts?.flatMap { forecast -> [WeatherViewModelCityTime] in
						return forecast.hours.map { hour in
							return WeatherViewModelCityTime(hour: hour.hour ?? "", temperature: hour.temp ?? 0)
						} ?? []
					} ?? []
				}
				self?.weatherData = allWeatherData
				DispatchQueue.main.async {
					self?.collectionView.reloadData()
				}
			case .failure(let error):
				print("Failed to fetch weather data: \(error)")
			}
		}
	}
	
	// MARK: - UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return weatherData.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHorizontalScrollCell.identifier, for: indexPath) as? WeatherHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		// Получите объект WeatherViewModelCityTime для текущего индекса
		let weatherViewModel = weatherData[indexPath.row]
		// Настройте ячейку с использованием данных из объекта WeatherViewModelCityTime
		cell.configure(with: weatherViewModel)
		
		cell.layer.cornerRadius = 16
		cell.layer.masksToBounds = false
		cell.backgroundColor = UIColor(named: "purpleLight")
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 76, height: 76)
	}
}
