//  HomeViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
	
	// MARK: - Constants
	private var weatherData: [WeatherModel] = [WeatherModel]()
	
	private let numberOfCopies = 50  // Количество копий элементов
	
	private let section = 0  // Количество секций
	
	private let minusSection = 1
	
	private let startItem = 0
	
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
		image.layer.cornerRadius = Constants.cornerRadiusImage
		return image
	}()
	
	//UICollectionView + setup
	private let collectionViewCity = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	private let collectionViewWeatherHours = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	private func setupCollectionView() {
		setupCollectionView(collectionView: collectionViewCity, cellType: CityCell.self)
		
		setupCollectionView(collectionView: collectionViewWeatherHours, cellType: WeatherHoursCell.self)
	}
	
	//UILabels
	private let swipeDownLabel = UILabel.makeLabel(text: Constants.swipeLabel, fontSize: 12, font: UIFont.robotoRegular(size: 12), textColor: .white)
	
	private let todayLabel = UILabel.makeLabel(text: Constants.todayLabel, fontSize: 20, font: .poppinsMedium(size: 20), textColor: .white)
	
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
		view.backgroundColor = Colors.backPurple
		setupAddSubviews()
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
		temperatureLabel.text = "\(model.fact?.temp ?? 0)\(Constants.degreeLabel)"
		precipitationLabel.text = model.fact?.condition?.capitalized ?? ""
		temperatureTodayLabel.text = "\(model.forecasts.first?.parts.day?.tempMin ?? 0)\(Constants.degreeLabel)/\(model.forecasts.first?.parts.day?.tempMax ?? 0)\(Constants.degreeLabel)"

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = Constants.date
		let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.now ?? 0)))

		dateLabel.text = dateString
	}
	
	// Получение данных о погоде для городов из API
	private func fetchWeatherData() {
		
		APICaller.shared.getWeather(forCities: cities) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let weatherData):
								
				self.weatherData = weatherData.compactMap { $0 }
				
				DispatchQueue.main.async {
					self.collectionViewWeatherHours.reloadData()
					self.collectionViewCity.reloadData()
					self.firstWeatherData()
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	private func firstWeatherData() {
		guard let firstWeatherModel = weatherData.first else {
			return
		}
		configure(with: firstWeatherModel)
	}

	//MARK: - Methods
	
	// Прокрутка скролла с прогнозом по часам в конец списка
	@objc private func swipeRightPressed() {
		let lastItem = collectionViewWeatherHours.numberOfItems(inSection: section) - minusSection
		
		let lastItemIndexPath = IndexPath(item: lastItem,
										  section: section)
		
		collectionViewWeatherHours.scrollToItem(at: lastItemIndexPath,
												at: .right, animated: true)
	}
	
	@objc private func swipeDownPressed() {
	}
	
	//Открытие контроллера при нажатии на кнопку options
	@objc private func optionsButtonPressed() {
		let greenVC = GreenViewController()
		navigationController?.pushViewController(greenVC, animated: true)
	}
	
	//Открытие модального окна при нажатии на кнопку person
	@objc func personButtonPressed() {
		let profileVC = ModalViewController()
		profileVC.modalPresentationStyle = .fullScreen
		present(profileVC, animated: true, completion: nil)
	}
	
	// Добавление вью
	private func setupAddSubviews() {
		view.addSubview(scrollView)
		scrollView.delegate = self
		scrollView.addSubview(viewContainer)
		viewContainer.addSubviews([headImage, personButton, swipeDownButton, optionsButton, nameCityLabel, dateLabel, temperatureTodayLabel, temperatureLabel, precipitationLabel, swipeDownLabel, todayLabel, collectionViewCity, collectionViewWeatherHours, swipeRightButton])
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
			button.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardOffsets)
		}
		optionsButton.snp.makeConstraints { button in
			button.top.equalTo(viewContainer.snp.top).offset(88)
			button.trailing.equalTo(viewContainer.snp.trailing).inset(27)
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
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardOffsets)
			label.width.equalTo(195)//как ограничить
		}
		dateLabel.snp.makeConstraints { label in
			label.top.equalTo(nameCityLabel.snp.bottom).offset(14)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardOffsets)
		}
		temperatureTodayLabel.snp.makeConstraints { label in
			label.centerY.equalTo(dateLabel.snp.centerY)
			label.leading.equalTo(dateLabel.snp.trailing).offset(10)
		}
		temperatureLabel.snp.makeConstraints { label in
			label.top.equalTo(viewContainer.snp.top).offset(163)
			label.trailing.equalTo(viewContainer.snp.trailing).inset(Constants.standardOffsets)
		}
		precipitationLabel.snp.makeConstraints { label in
			label.top.equalTo(temperatureLabel.snp.bottom).offset(7)
			label.trailing.equalTo(viewContainer.snp.trailing).inset(Constants.standardOffsets)
		}
		collectionViewCity.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(headImage.snp.bottom).offset(30)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing)
			collectionView.height.equalTo(215)
		}
		todayLabel.snp.makeConstraints { label in
			label.top.equalTo(collectionViewCity.snp.bottom).offset(27)
			label.leading.equalTo(viewContainer.snp.leading).offset(Constants.standardOffsets)
		}
		collectionViewWeatherHours.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(todayLabel.snp.bottom).offset(6)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing).inset(Constants.standardOffsets)
			collectionView.height.equalTo(115)
		}
		swipeRightButton.snp.makeConstraints { button in
			button.centerY.equalTo(collectionViewWeatherHours.snp.centerY)
			button.trailing.equalTo(viewContainer.snp.trailing).inset(5)
		}
	}
}

// MARK: - CollectionView Setup (UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout)
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == collectionViewCity {
			return weatherData.count * numberOfCopies
			
		} else if collectionView == collectionViewWeatherHours {
			return 23
		}
		return weatherData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == collectionViewCity {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.identifier, 
																for: indexPath) as? CityCell else {
				return UICollectionViewCell()
			}
			let arrayIndex = arrayIndexForRow(indexPath.row)
			let weatherViewModel = weatherData[arrayIndex]
			cell.configure(with: weatherViewModel)
			return cell
			
		} else if collectionView == collectionViewWeatherHours {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHoursCell.identifier, 
																for: indexPath) as? WeatherHoursCell else {
				return UICollectionViewCell()
			}
			if let selectedIndexPath = collectionViewCity.indexPathsForSelectedItems?.first {
				let realIndex = arrayIndexForRow(selectedIndexPath.row)
				let selectedCity = weatherData[realIndex]
				let hourIndex = indexPath.item
				cell.configure(with: selectedCity, index: hourIndex)
			}
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
			return Constants.sizeCellCity
			
		} else if collectionView == collectionViewWeatherHours {
			return Constants.sizeCellWeather
		}
		return Constants.sizeCellDefaults
	}
}

// MARK: - UIScrollViewDelegate
// Реализация скролла вправо и влево
// Бесконечный скролл
extension HomeViewController: UIScrollViewDelegate {
	
	// Функция прокрутки до середины
	func scrollToMiddle(atIndex: Int, animated: Bool = true) {
		let middleIndex = atIndex + numberOfCopies * weatherData.count / 2
		collectionViewCity.scrollToItem(at: IndexPath(item: middleIndex, section: section),
										at: .centeredHorizontally, animated: animated)
	}
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if scrollView == collectionViewCity {
			let contentOffsetX = scrollView.contentOffset.x
			let contentWidth = scrollView.contentSize.width
			let viewWidth = scrollView.bounds.width
			
			// Проверяем, достиг ли скролл конца коллекции
			if contentOffsetX <= 0 {
				// Перемещаемся к концу коллекции
				let lastIndex = collectionViewCity.numberOfItems(inSection: section) - minusSection
				let lastIndexPath = IndexPath(item: lastIndex, 
											  section: section)
				collectionViewCity.scrollToItem(at: lastIndexPath,
												at: .right, animated: false)
			} else if contentOffsetX >= (contentWidth - viewWidth) {
				// Перемещаемся к началу коллекции
				let firstIndexPath = IndexPath(item: startItem, 
											   section: startItem)
				collectionViewCity.scrollToItem(at: firstIndexPath,
												at: .left, animated: false)
			}
		}
	}
}

