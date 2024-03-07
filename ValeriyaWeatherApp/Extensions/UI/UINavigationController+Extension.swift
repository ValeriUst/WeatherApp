//  UINavigationController+Extension.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 07.02.2024.

import UIKit

extension UINavigationController {
	func configureTabBarItem(imageName: String, imageSize: CGSize) {
		guard let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
			  let viewController = self.viewControllers.first else {
			return
		}
		// Создаем изображение с нужным размером
		let resizedImage = image.resized(to: imageSize)
		viewController.tabBarItem = UITabBarItem(title: title, image: resizedImage, selectedImage: resizedImage)
	}
}

extension UIImage {
	func resized(to size: CGSize) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { _ in
			self.draw(in: CGRect(origin: .zero, size: size))
		}
	}
}
