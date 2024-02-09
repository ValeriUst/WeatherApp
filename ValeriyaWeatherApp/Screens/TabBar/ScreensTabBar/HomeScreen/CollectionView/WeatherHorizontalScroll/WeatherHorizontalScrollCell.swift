//  WeatherHorizontalScrollCell.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class WeatherHorizontalScrollCell: UICollectionViewCell {
	
	// MARK: - Constants
	static let identifier = "CollectionViewCellCell"
	
	// MARK: - Constants
	private let imageViewWeather: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()

	private let temperatureLabel = UILabel.makeMediumLabel(text: "", fontSize: 15, textColor: .white)
	private let timeLabel = UILabel.makeSemiBoldLabel(text: "", fontSize: 15, textColor: .white)

	// MARK: - SetUp UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews([imageViewWeather, temperatureLabel, timeLabel])
		setConstraints()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with model: WeatherViewModelCityTime) {
		temperatureLabel.text = "\(model.temperature)°C"
		timeLabel.text = "\(model.hour):00"
	}

	// MARK: - Constraints
	private func setConstraints() {
		imageViewWeather.snp.makeConstraints { image in
			image.top.equalToSuperview().offset(12)
			image.centerX.equalToSuperview()
		}
		temperatureLabel.snp.makeConstraints { label in
			label.centerX.equalToSuperview()
			label.top.equalTo(imageViewWeather.snp.bottom).offset(3)
		}
		timeLabel.snp.makeConstraints { label in
			label.centerX.equalToSuperview()
			label.top.equalTo(contentView.snp.bottom).offset(3)
		}
	}
}
