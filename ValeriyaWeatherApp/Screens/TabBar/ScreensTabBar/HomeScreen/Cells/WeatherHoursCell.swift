//  WeatherHoursCell.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit
import SDWebImage
import SDWebImageSVGCoder

final class WeatherHoursCell: UICollectionViewCell {
	
	// MARK: - Constants
	static let identifier = "WeatherHoursCell"
		
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
		setupCell()
		addSubviews([imageViewWeather, temperatureLabel, timeLabel])
		setConstraints()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCell() {
		backgroundColor = Colors.purpleLight
		layer.cornerRadius = Constants.cornerRadiusStandard
		layer.masksToBounds = false
	}

	// MARK: - ConfigureCell
	
	func configure(with model: WeatherModel, index: Int) {
		let formatterDate = DateFormatter()
		formatterDate.dateFormat = "h:00 a"
		formatterDate.timeZone = TimeZone(secondsFromGMT: model.now ?? 0 * 3600)
		let date = Date()
		let calendar = Calendar.current
		
		if index == 0 {
			if let fact = model.fact {
				temperatureLabel.text = "\(fact.temp ?? 0)\(Constants.degreeLabel)"
				timeLabel.text = Constants.nowLabel
				
				if let iconURLString = fact.icon {
					setImage(with: iconURLString)
				} else {
					imageViewWeather.image = UIImage(named: "11")
				}
			}
		} else {
			let indexOne = index + 1
			if let forecast = model.forecasts.first,
			   forecast.hours.indices.contains(indexOne) {
				let nextWeather = forecast.hours[indexOne]
				temperatureLabel.text = "\(nextWeather.temp ?? 0)\(Constants.degreeLabel)"
				
				let nextHourDate = calendar.date(byAdding: .hour, value: index + 1, to: date)!
				timeLabel.text = formatterDate.string(from: nextHourDate)
				
				if let iconURLString = nextWeather.icon {
					setImage(with: iconURLString)
				} else {
					imageViewWeather.image = UIImage(named: "11")
				}
			}
		}
	}

	private func setImage(with urlString: String) {
		if let iconURL = URL(string: "\(Constants.urlIcon)\(urlString).svg") {
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
			image.height.equalTo(30)
			image.width.equalTo(30)
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
