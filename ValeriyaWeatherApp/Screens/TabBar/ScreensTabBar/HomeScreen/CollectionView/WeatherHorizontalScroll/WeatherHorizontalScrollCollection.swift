//  WeatherHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class WeatherHorizontalScrollCollection: UICollectionViewController, 
												UICollectionViewDelegateFlowLayout,
												AnotherCitySelectionDelegate {
	private var selectedCityName: String?
	
	func didSelectCityA(_ model: WeatherViewModelCity) {
		print("Выбран город ЧАСЫ: \(model.nameCity)")
	}
	
	// MARK: - Constants
	private var weatherData: [WeatherViewModelCityTime] = []
	
	private let collectionViewCity = CityHorizontalScrollCollection(collectionViewLayout: UICollectionViewFlowLayout())
	
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
		collectionViewCity.delegateA = self
		fetchWeatherData()
	}
	
	// MARK: - Configure
	private func fetchWeatherData() {
		APICaller.shared.getWeather(forCities: cities) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let weatherModels):
				self.weatherData = weatherModels
					.compactMap { $0?.forecasts }
					.flatMap { $0 }
					.compactMap { $0.hours.map { WeatherViewModelCityTime(hour: $0.hour ?? "", temperature: $0.temp ?? 0) } }
					.flatMap { $0 }
				
				DispatchQueue.main.async {
					self.collectionView.reloadData()
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
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHorizontalScrollCell.identifier, 
															for: indexPath) as? WeatherHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		let weatherViewModel = weatherData[indexPath.item]
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
