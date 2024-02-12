//  UICollectionView.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 12.02.2024.

import Foundation
import UIKit

/// расстояние по бокам от collectionView
private let inset: CGFloat = 20
private let sectionInset: CGFloat = 25

extension HomeViewController {
	func setupCollectionView(collectionView: UICollectionView, cellType: AnyClass) {
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor  = .clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
		
		if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.scrollDirection = .horizontal
			flowLayout.minimumLineSpacing = inset
			flowLayout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
		}
	}
}
