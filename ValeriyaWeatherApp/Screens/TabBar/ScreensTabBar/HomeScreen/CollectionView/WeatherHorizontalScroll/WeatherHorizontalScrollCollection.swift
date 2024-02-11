//  WeatherHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class WeatherHorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
		
	private var weatherViewModel: [WeatherViewModelCity] = []

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
	
	func update(with weatherViewModel: [WeatherViewModelCity]) {
		self.weatherViewModel = weatherViewModel
		collectionView.reloadData()
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
		collectionViewCity.delegate = self
	}
	
	// MARK: - UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return weatherViewModel.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHorizontalScrollCell.identifier, 
															for: indexPath) as? WeatherHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		
		let weatherViewModel = weatherViewModel[indexPath.item]
		cell.configure(with: weatherViewModel, atIndex: indexPath.item)
		
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

// MARK: - Extension CitySelectionDelegate
extension WeatherHorizontalScrollCollection: CitySelectionDelegate {
	func didSelectCity(_ model: WeatherViewModelCity) {
		print("Выбран городfffff: \(model.nameCity)")
		
		if let index = weatherViewModel.firstIndex(where: { $0.nameCity == model.nameCity }) {
			let indexPath = IndexPath(row: index, section: 0)
			if let cell = collectionView.cellForItem(at: indexPath) as? WeatherHorizontalScrollCell {
				cell.configure(with: model, atIndex: index)
			}
		}
	}
}
