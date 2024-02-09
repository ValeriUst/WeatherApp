//  HomeViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
	
	// MARK: - Constants
	private let collectionViewCity = CityHorizontalScrollCollection(collectionViewLayout: UICollectionViewFlowLayout())
	private let collectionViewWeather = WeatherHorizontalScrollCollection(collectionViewLayout: UICollectionViewFlowLayout())

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
	
	//UILabels
	private let swipeDownLabel = UILabel.makeRobotoRegular(text: "Swipe down for details", fontSize: 12, textColor: .white)
	private let nameCityLabel = UILabel.makeSemiBoldLabel(text: "Hyderabad", fontSize: 28, textColor: .white)
	private let dateLabel = UILabel.makeRegularLabel(text: "20 Apr Wed  20°C/29°C", fontSize: 12.91, textColor: .white)
	private let temperatureLabel = UILabel.makeSemiBoldLabel(text: "24°C", fontSize: 36, textColor: .white)
	private let precipitationLabel = UILabel.makeRegularLabel(text: "Clear sky", fontSize: 21.33, textColor: .white)
	private let todayLabel = UILabel.makeMediumLabel(text: "Today", fontSize: 20, textColor: .white)
	
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
		viewContainer.addSubviews([headImage, personButton, swipeDownButton, optionsButton, nameCityLabel, dateLabel, temperatureLabel, precipitationLabel, swipeDownLabel, todayLabel, swipeRightButton,collectionViewCity.view, collectionViewWeather.view])
		setConstraints()
    }
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	//MARK: - Methods
	// Прокрутка скролла в конец
	@objc func swipeRightPressed() {
		let lastItem = collectionViewWeather.collectionView.numberOfItems(inSection: 0) - 1
		let lastItemIndexPath = IndexPath(item: lastItem, section: 0)
		collectionViewWeather.collectionView.scrollToItem(at: lastItemIndexPath, at: .right, animated: true)
	}
	@objc func swipeDownPressed() {
		print("swipeDownPressed")
	}
	@objc func optionsButtonPressed() {
		print("optionsButtonPressed")
		let greenVC = GreenViewController()
		navigationController?.pushViewController(greenVC, animated: true)
	}
	
	//Открытие модального окна при нажатии на кнопку
	@objc func personButtonPressed() {
		let profileVC = ModalViewController()
		profileVC.modalPresentationStyle = .fullScreen
		present(profileVC, animated: true, completion: nil)
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
		}
		dateLabel.snp.makeConstraints { label in
			label.top.equalTo(nameCityLabel.snp.bottom).offset(14)
			label.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		temperatureLabel.snp.makeConstraints { label in
			label.top.equalTo(viewContainer.snp.top).offset(163)
			label.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
		}
		precipitationLabel.snp.makeConstraints { label in
			label.top.equalTo(temperatureLabel.snp.bottom).offset(7)
			label.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
		}
		collectionViewCity.view.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(headImage.snp.bottom).offset(30)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing)
			collectionView.height.equalTo(215)
		}
		todayLabel.snp.makeConstraints { label in
			label.top.equalTo(collectionViewCity.view.snp.bottom).offset(27)
			label.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		collectionViewWeather.view.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(todayLabel.snp.bottom).offset(6)
			collectionView.leading.equalTo(viewContainer.snp.leading)
			collectionView.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
			collectionView.height.equalTo(115)
		}
		swipeRightButton.snp.makeConstraints { button in
			button.centerY.equalTo(collectionViewWeather.view.snp.centerY)
			button.trailing.equalTo(viewContainer.snp.trailing).offset(-5)
		}
	}
}
