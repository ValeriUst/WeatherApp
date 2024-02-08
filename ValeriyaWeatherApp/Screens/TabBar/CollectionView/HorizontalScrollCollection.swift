//  HorizontalScrollCollection.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class HorizontalScrollCollection: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Constants
	private let images = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
	
	// MARK: - Content Views
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
		return layout
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .clear
		collectionView.collectionViewLayout = layout
		collectionView.register(HorizontalScrollCell.self, 
								forCellWithReuseIdentifier: HorizontalScrollCell.identifier)
	}
	
	// MARK: - UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalScrollCell.identifier, 
															for: indexPath) as? HorizontalScrollCell else {
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
