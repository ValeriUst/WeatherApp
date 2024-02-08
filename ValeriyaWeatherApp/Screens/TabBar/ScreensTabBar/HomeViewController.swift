//  HomeViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
	
	private let collectionViewController = HorizontalScrollCollection(collectionViewLayout: UICollectionViewFlowLayout())

	
	// MARK: - Content
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
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
	
	private let swipeDownLabel: UILabel = {
		let label = UILabel()
		label.text = "Swipe down for details"
		label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
		label.font = UIFont.robotoRegular(size: 12)
		return label
	}()

	private let nameCityLabel = UILabel.makeSemiBoldLabel(text: "Hyderabad", fontSize: 28, textColor: .white)
	private let dateLabel = UILabel.makeRegularLabel(text: "20 Apr Wed  20°C/29°C", fontSize: 12.91, textColor: .white)
	private let temperatureLabel = UILabel.makeSemiBoldLabel(text: "24°C", fontSize: 36, textColor: .white)
	private let precipitationLabel = UILabel.makeRegularLabel(text: "Clear sky", fontSize: 21.33, textColor: .white)

	private let personButton = UIButton.makeImageButton(named: "person", target: self, action: #selector(personButtonPressed))
	private let optionsButton = UIButton.makeImageButton(named: "ButtonLeft", target: self, action: #selector(optionsButtonPressed))
	private let swipeDownButton = UIButton.makeImageButton(named: "vector", target: self, action: #selector(swipeDownPressed))

	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = UIColor(named: "backPurple")
		view.addSubview(scrollView)
		scrollView.addSubview(viewContainer)
		scrollView.addSubview(collectionViewController.view)
		collectionViewController.didMove(toParent: self)
		view.addSubviews ([headImage, personButton, swipeDownButton, optionsButton, nameCityLabel, dateLabel, temperatureLabel, precipitationLabel, swipeDownLabel])
		setConstraints()
    }

	//MARK: - Methods
	@objc func swipeDownPressed() {
		print("swipeDownPressed")
	}
	@objc func optionsButtonPressed() {
		print("optionsButtonPressed")
	}
	@objc func personButtonPressed() {
		print("personButtonPressed")
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		scrollView.snp.makeConstraints { scroll in
			scroll.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			scroll.leading.equalToSuperview()
			scroll.trailing.equalToSuperview()
			scroll.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
		viewContainer.snp.makeConstraints { view in
			view.edges.equalTo(scrollView)
			view.width.equalTo(scrollView.snp.width)
			view.height.equalTo(1000)
		}
		headImage.snp.makeConstraints { image in
			image.top.equalTo(viewContainer.snp.top)
			image.leading.trailing.equalTo(viewContainer)
			image.height.equalTo(381)
		}
		personButton.snp.makeConstraints { button in
			button.top.equalTo(viewContainer.snp.top).offset(55)
			button.leading.equalTo(viewContainer.snp.leading).offset(25)
		}
		optionsButton.snp.makeConstraints { button in
			button.top.equalTo(viewContainer.snp.top).offset(58)
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
			label.leading.equalToSuperview().offset(25)
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
			label.top.equalTo(temperatureLabel.snp.bottom).offset(10)
			label.trailing.equalTo(viewContainer.snp.trailing).offset(-25)
		}
		collectionViewController.view.snp.makeConstraints { collectionView in
			collectionView.top.equalTo(headImage.snp.bottom).offset(30)
			collectionView.leading.trailing.equalToSuperview()
			collectionView.height.equalTo(215)
		}
	}
}
