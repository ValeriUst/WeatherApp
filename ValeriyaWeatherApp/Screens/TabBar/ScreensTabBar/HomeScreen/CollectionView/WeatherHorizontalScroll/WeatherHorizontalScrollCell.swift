//  WeatherHorizontalScrollCell.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit
import SDWebImage
import SDWebImageSVGCoder

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

	private let temperatureLabel = UILabel.makeLabel(text: "", fontSize: 15, font: .poppinsMedium(size: 15), textColor: .white)
	
	private let timeLabel = UILabel.makeLabel(text: "", fontSize: 15, font: .poppinsSemiBold(size: 15), textColor: .white)

	// MARK: - SetUp UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews([imageViewWeather, temperatureLabel, timeLabel])
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - ConfigureCell
	func configure(with model: WeatherViewModelCity){
		temperatureLabel.text = "\(model.tempHour)"
		timeLabel.text = "\(model.hour):00"
		
		if let iconURLString = model.icon {
			let iconURL = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(iconURLString).svg")
			imageViewWeather.sd_setImage(with: iconURL,
										 placeholderImage: nil,
										 context: [.imageCoder: CustomSVGDecoder(fallbackDecoder: SDImageSVGCoder.shared)])
		} else {
			imageViewWeather.image = UIImage(named: "11")
		}
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
