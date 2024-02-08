//  UILabel + Extension.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import Foundation
import UIKit

extension UILabel {
	static func makeSemiBoldLabel(text: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.poppinsSemiBold(size: fontSize)
		label.textColor = textColor
		return label
	}
	
	static func makeRegularLabel(text: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.poppinsRegular(size: fontSize)
		label.textColor = textColor
		return label
	}
	static func makeMediumLabel(text: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.poppinsMedium(size: fontSize)
		label.textColor = textColor
		return label
	}
}
