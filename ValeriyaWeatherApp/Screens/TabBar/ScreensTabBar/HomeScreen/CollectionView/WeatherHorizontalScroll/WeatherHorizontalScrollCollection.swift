//  WeatherHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class WeatherHorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
	private let images = ["11", "22", "33", "44", "55", "66", "77"]
	private let labels = ["Now", "1:00PM", "2:00PM", "3:00PM", "4:00PM", "5:00PM", "6:00PM"]

	// MARK: - Content Views
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
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
	}

	// MARK: - UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHorizontalScrollCell.identifier,
															for: indexPath) as? WeatherHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		cell.layer.cornerRadius = 16
		cell.layer.masksToBounds = false
		cell.backgroundColor = UIColor(named: "purpleLight")
		let imageName = images[indexPath.item]
		cell.imageViewWeather.image = UIImage(named: imageName)
		
		
		let label = labels[indexPath.item]
		cell.timeLabel.text = labels[indexPath.item]
		
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 76, height: 76)
	}
}
