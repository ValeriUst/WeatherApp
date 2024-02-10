//  CityHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

protocol CitySelectionDelegate: AnyObject {
	func didSelectCity(_ model: WeatherViewModelCity)
}
protocol AnotherCitySelectionDelegate: AnyObject {
	func didSelectCityA(_ model: WeatherViewModelCity)
}

final class CityHorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
	private var weatherData: [WeatherViewModelCity] = []
	
	// MARK: - Public Properties
	weak var delegate: CitySelectionDelegate?
	var delegateA: AnotherCitySelectionDelegate?


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
		collectionView.collectionViewLayout = layout
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(CityHorizontalScrollCell.self,
								forCellWithReuseIdentifier: CityHorizontalScrollCell.identifier)
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
		fetchWeatherData()
	}
	
	// MARK: - Configure
	private func fetchWeatherData() {
		APICaller.shared.getWeather(forCities: cities) { [weak self] result in
			switch result {
			case .success(let weatherModels):
				let weatherViewModels = weatherModels.compactMap { $0.map { WeatherViewModelCity(model: $0) } }
				self?.weatherData = weatherViewModels
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
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityHorizontalScrollCell.identifier,
															for: indexPath) as? CityHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		cell.layer.cornerRadius = 22
		cell.layer.masksToBounds = true
		
		let weatherViewModel = weatherData[indexPath.row]
		cell.configure(with: weatherViewModel)
		
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 172, height: 215)
	}
	
	// MARK: - UICollectionViewDelegate
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedCity = weatherData[indexPath.item]
		delegate?.didSelectCity(selectedCity)
		delegateA?.didSelectCityA(selectedCity)
	}
}
