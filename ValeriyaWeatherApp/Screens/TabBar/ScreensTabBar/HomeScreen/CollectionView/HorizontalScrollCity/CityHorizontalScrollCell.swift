//  CityHorizontalScrollCell.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class CityHorizontalScrollCell: UICollectionViewCell {
	
	// MARK: - Constants
	static let identifier = "CollectionViewCellCell"
	
	// MARK: - Constants
	let imageViewCity: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let nameCityLabel = UILabel.makeSemiBoldLabel(text: "Jaipur", fontSize: 20, textColor: .white)
	private let temperatureLabel = UILabel.makeSemiBoldLabel(text: "30°C", fontSize: 18.8, textColor: .white)
	
	// MARK: - SetUp UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews([imageViewCity, nameCityLabel, temperatureLabel])
		setConstraints()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		imageViewCity.snp.makeConstraints { image in
			image.leading.trailing.top.bottom.equalToSuperview()
		}
		nameCityLabel.snp.makeConstraints { label in
			label.top.equalToSuperview().offset(19)
			label.leading.equalToSuperview().offset(24)
		}
		temperatureLabel.snp.makeConstraints { label in
			label.centerY.equalTo(nameCityLabel.snp.centerY)
			label.leading.equalTo(nameCityLabel.snp.trailing).offset(10)
		}
	}
}
