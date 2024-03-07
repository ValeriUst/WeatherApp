//  UIButton+ Extension.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit

extension UIButton {
	static func makeImageButton(named imageName: String, target: Any, action: Selector) -> UIButton {
		let button = UIButton()
		button.setImage(UIImage(named: imageName), for: .normal)
		button.addTarget(target, action: action, for: .touchUpInside)
		return button
	}
}
