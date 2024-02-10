//  UILabel + Extension.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import Foundation
import UIKit

extension UILabel {
	static func makeLabel(text: String, fontSize: CGFloat, font: UIFont?, textColor: UIColor) -> UILabel {
		let label = UILabel()
		label.text = text
		label.numberOfLines = 3
		label.font = font ?? UIFont.systemFont(ofSize: fontSize)
		label.textColor = textColor
		return label
	}
}
