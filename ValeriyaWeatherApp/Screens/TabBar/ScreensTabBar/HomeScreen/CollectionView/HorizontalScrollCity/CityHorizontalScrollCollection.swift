//  CityHorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class CityHorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
	private let images = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	
	// MARK: - Content Views
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
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
		
	}
	
	// MARK: - UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityHorizontalScrollCell.identifier,
															for: indexPath) as? CityHorizontalScrollCell else {
			return UICollectionViewCell()
		}
		cell.layer.cornerRadius = 22
		cell.layer.masksToBounds = true
		let imageName = images[indexPath.item]
		cell.imageViewCity.image = UIImage(named: imageName)
		return cell
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 172, height: 215)
	}
}
