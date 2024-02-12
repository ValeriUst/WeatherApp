//  HomeViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
	
	// MARK: - Constants
	private var weatherData: [WeatherModel] = [WeatherModel]()
	
	private let numberOfCopies = 50  // Количество копий элементов
	
	var selectedIndex:IndexPath?

	// MARK: - Content

	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.contentInsetAdjustmentBehavior = .never
		scroll.translatesAutoresizingMaskIntoConstraints = false
		return scroll
	}()
	
	private let viewContainer: UIView = {
		let viewContainer = UIView()
		viewContainer.translatesAutoresizingMaskIntoConstraints = false
		return viewContainer
	}()
	
	private let headImage: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "pdf")
		image.contentMode = .scaleAspectFill
		image.layer.cornerRadius = 30
		return image
	}()
	
	//UICollectionView
	private let collectionViewCity = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	private let collectionViewWeatherHours = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	private func setupCollectionView() {
		setupCollectionView(collectionView: collectionViewCity, cellType: CityCell.self)
		
		setupCollectionView(collectionView: collectionViewWeatherHours, cellType: WeatherHoursCell.self)
	}
	
	//UILabels
	private let swipeDownLabel = UILabel.makeLabel(text: "Swipe down for details", fontSize: 12, font: UIFont.robotoRegular(size: 12), textColor: .white)
	
	private let todayLabel = UILabel.makeLabel(text: "Today", fontSize: 20, font: .poppinsMedium(size: 20), textColor: .white)
	
	private let nameCityLabel = UILabel.makeLabel(text: "", fontSize: 28, font: .poppinsSemiBold(size: 28), textColor: .white)
	
	private let dateLabel = UILabel.makeLabel(text: "", fontSize: 12.91, font: .poppinsRegular(size: 12.91), textColor: .white)
	
	private let temperatureTodayLabel = UILabel.makeLabel(text: "", fontSize: 12.91, font: .poppinsRegular(size: 12.91), textColor: .white)

	private let temperatureLabel = UILabel.makeLabel(text: "", fontSize: 36, font: .poppinsSemiBold(size: 36), textColor: .white)

	private let precipitationLabel = UILabel.makeLabel(text: "", fontSize: 21.33, font: .poppinsRegular(size: 21.33), textColor: .white)

	//UIButtons
	private let personButton = UIButton.makeImageButton(named: "person", target: self, action: #selector(personButtonPressed))
	
	private let optionsButton = UIButton.makeImageButton(named: "ButtonLeft", target: self, action: #selector(optionsButtonPressed))
	
	private let swipeDownButton = UIButton.makeImageButton(named: "vector", target: self, action: #selector(swipeDownPressed))
	
	private let swipeRightButton = UIButton.makeImageButton(named: "vectorRight", target: self, action: #selector(swipeRightPressed))

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor(named: "backPurple")
		view.addSubview(scrollView)
		scrollView.addSubview(viewContainer)
		viewContainer.addSubviews([headImage, personButton, swipeDownButton, optionsButton, nameCityLabel, dateLabel, temperatureTodayLabel, temperatureLabel, precipitationLabel, swipeDownLabel, todayLabel, collectionViewCity, collectionViewWeatherHours, swipeRightButton])
		setupCollectionView()
		setConstraints()
		fetchWeatherData()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	// MARK: - Configure
	private func configure(with model: WeatherModel) {
		nameCityLabel.text = model.geoObject?.locality.name
		temperatureLabel.text = "\(model.fact?.temp ?? 0)°C"
		precipitationLabel.text = model.fact?.condition?.capitalized ?? ""
		temperatureTodayLabel.text = "\(model.forecasts.first?.parts.day?.tempMin ?? 0)°C/\(model.forecasts.first?.parts.day?.tempMax ?? 0)°C"

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM EEE"
		let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.now ?? 0)))

		dateLabel.text = dateString
		
		collectionViewWeatherHours.reloadData()

	}
	
	private func fetchWeatherData() {
		APICaller.shared.getWeather(forCities: cities) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let weatherData):
				
				print(weatherData)
				
				self.weatherData = weatherData.compactMap { $0 }
				
				DispatchQueue.main.async {
					self.collectionViewCity.reloadData()
					self.collectionViewWeatherHours.reloadData()
				}
			case .failure(let error):
				print("Failed to fetch detailed weather data:", error)
			}
		}
	}

	//MARK: - Methods
	
	// Прокрутка скролла в конец
	@objc private func swipeRightPressed() {
		let lastItem = collectionViewWeatherHours.numberOfItems(inSection: 0) - 1
		let lastItemIndexPath = IndexPath(item: lastItem, section: 0)
		collectionViewWeatherHours.scrollToItem(at: lastItemIndexPath, at: .right, animated: true)
	}
	
	@objc private func swipeDownPressed() {
		print("swipeDownPressed")
	}
	
	@objc private func optionsButtonPressed() {
		let greenVC = GreenViewController()
		navigationController?.pushViewController(greenVC, animated: true)
	}
	
	//Открытие модального окна при нажатии на кнопку
	@objc func personButtonPressed() {
		let profileVC = ModalViewController()
		profileVC.modalPresentationStyle = .fullScreen
		present(profileVC, animated: true, completion: nil)
	}
	
	private func arrayIndexForRow(_ row : Int)-> Int {
		return row % weatherData.count
	}

	// MARK: - Constraints
	private func setConstraints() {
		scrollView.snp.makeConstraints { scroll in
			scroll.top.leading.trailing.bottom.equalToSuperview()
		}
		viewContainer.snp.makeConstraints { view in
			view.edges.equalTo(scrollView)
			view.width.equalTo(scrollView.snp.width)
			view.height.equalTo(950)
		}
		headImage.snp.makeConstraints { image in
			image.top.equalTo(viewContainer.snp.top)
			image.leading.equalTo(viewContainer.snp.leading)
			image.trailing.equalTo(viewContainer.snp.trailing)
			image.height.equalTo(381)
		}
		personButton.snp.makeConstraints { button in
			button.top.equalTo(viewContainer.snp.top).offset(80)
			button.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		optionsButton.snp.makeConstraints { button in
			button.top.equalTo(viewContainer.snp.top).offset(88)
			button.trailing.equalTo(viewContainer.snp.trailing).offset(-27)
		}
		swipeDownLabel.snp.makeConstraints { label in
			label.centerX.equalTo(headImage.snp.centerX)
			label.bottom.equalTo(swipeDownButton.snp.top).offset(-9)
		}
		swipeDownButton.snp.makeConstraints { button in
			button.centerX.equalTo(headImage.snp.centerX)
			button.bottom.equalTo(headImage.snp.bottom).offset(-11)
		}
		nameCityLabel.snp.makeConstraints { label in
			label.top.equalTo(viewContainer.snp.top).offset(170)
			label.leading.equalTo(viewContainer.snp.leading).offset(25)
			label.width.equalTo(195)//как ограничить 
		}
		dateLabel.snp.makeConstraints { label in
			label.top.equalTo(nameCityLabel.snp.bottom).offset(14)
			label.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		temperatureTodayLabel.snp.makeConstraints { label in
			label.centerY.equalTo(dateLabel.snp.centerY)
			label.leading.equalTo(dateLabel.snp.trailing).offset(10)
		}
		temperatureLabel.snp.makeConstraints { label in
			label.top.equalTo(viewContainer.snp.top).offset(163)
			label.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
		}
		precipitationLabel.snp.makeConstraints { label in
			label.top.equalTo(temperatureLabel.snp.bottom).offset(7)
			label.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
		}
		collectionViewCity.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(headImage.snp.bottom).offset(30)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing)
			collectionView.height.equalTo(215)
		}
		todayLabel.snp.makeConstraints { label in
			label.top.equalTo(collectionViewCity.snp.bottom).offset(27)
			label.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		collectionViewWeatherHours.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(todayLabel.snp.bottom).offset(6)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
			collectionView.height.equalTo(115)
		}
		swipeRightButton.snp.makeConstraints { button in
			button.centerY.equalTo(collectionViewWeatherHours.snp.centerY)
			button.trailing.equalTo(viewContainer.snp.trailing).offset(-5)
		}
	}
}

// MARK: - CollectionView Setup (UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout)
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == collectionViewCity {
			return weatherData.count * numberOfCopies
		} else if collectionView == collectionViewWeatherHours {
			return weatherData.count
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == collectionViewCity {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.identifier, for: indexPath) as? CityCell else {
				return UICollectionViewCell()
			}
			cell.layer.cornerRadius = 22
			cell.layer.masksToBounds = true
			
			let arrayIndex = arrayIndexForRow(indexPath.row)
			
			let weatherViewModel = weatherData[arrayIndex]
			
			cell.configure(with: weatherViewModel)
	
			return cell
			
			
		} else if collectionView == collectionViewWeatherHours {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHoursCell.identifier, for: indexPath) as? WeatherHoursCell else {
				return UICollectionViewCell()
			}
			let weatherModel = weatherData[indexPath.row]
			
			cell.configure(with: weatherModel)
			
			return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView == collectionViewCity {
			let arrayIndex = arrayIndexForRow(indexPath.row)
			let realIndex = arrayIndex % weatherData.count
			let selectedCity = weatherData[realIndex]
			
			configure(with: selectedCity)
		
 			collectionViewWeatherHours.reloadData()
		}
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if collectionView == collectionViewCity {
			return CGSize(width: 172, height: 215)
			
		} else if collectionView == collectionViewWeatherHours {
			return CGSize(width: 76, height: 76)
		}
		return CGSize(width: 100, height: 100)
	}
}

extension HomeViewController {
	// Функция прокрутки до середины
	func scrollToMiddle(atIndex: Int, animated: Bool = true) {
		let middleIndex = atIndex + numberOfCopies * weatherData.count / 2
		collectionViewCity.scrollToItem(at: IndexPath(item: middleIndex, section: 0), at: .centeredHorizontally, animated: animated)
	}
}
