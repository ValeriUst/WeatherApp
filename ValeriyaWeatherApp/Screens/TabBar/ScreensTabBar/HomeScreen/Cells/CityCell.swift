//  CityCell.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 08.02.2024.

import UIKit
import SnapKit

final class CityCell: UICollectionViewCell {
		
	// MARK: - Constants
	
	private let imageViewCity: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let nameCityLabel = UILabel.makeLabel(text: "", fontSize: 18, font: .poppinsSemiBold(size: 20), textColor: .white)
	private let temperatureLabel = UILabel.makeLabel(text: "", fontSize: 18.8, font: .poppinsSemiBold(size: 18.8), textColor: .white)
	
	// MARK: - SetUp UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews([imageViewCity, nameCityLabel, temperatureLabel])
		setConstraints()
		setupCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCell() {
		layer.cornerRadius = Constants.cornerRadiusCity
		layer.masksToBounds = true
	}
	
	// MARK: - Configure Cell
	
	func configure(with model: WeatherModel) {
		temperatureLabel.text = "\(model.fact?.temp ?? 0)\(Constants.degreeLabel)"
		nameCityLabel.text = model.geoObject?.locality.name ?? ""
		
		switch model.fact?.condition ?? "" {
		case "clear":
			imageViewCity.image = UIImage(named: "sun")
		case "partly-cloudy":
			imageViewCity.image = UIImage(named: "sun")
		case "cloudy":
			imageViewCity.image = UIImage(named: "sun")
		default:
			imageViewCity.image = UIImage(named: "rain")
		}
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		imageViewCity.snp.makeConstraints { image in
			image.leading.trailing.top.bottom.equalToSuperview()
		}
		nameCityLabel.snp.makeConstraints { label in
			label.top.equalToSuperview().offset(Constants.standardOffsets)
			label.leading.equalToSuperview().offset(Constants.standardOffsets)
			label.width.equalTo(80)//вопрос как ограничить
		}
		temperatureLabel.snp.makeConstraints { label in
			label.top.equalToSuperview().offset(Constants.standardOffsets)
			label.leading.equalTo(nameCityLabel.snp.trailing).offset(10)
		}
	}
}
