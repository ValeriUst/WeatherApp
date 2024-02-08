//  UIView + AddSubview.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import Foundation
import UIKit

extension UIView {
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach {
			addSubview($0);
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
