//  ModalViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 09.02.2024.

import UIKit

final class ModalViewController: UIViewController {
	
	// MARK: - Content
	
	private let helloLabel = UILabel.makeLabel(text: "Hello World!", fontSize: 30, font: .poppinsSemiBold(size: 30), textColor: .white)

	private let closeButton: UIButton = {
	let button = UIButton()
	button.setImage(UIImage(systemName: "xmark"), for: .normal)
	button.tintColor = .white
	button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
	return button
}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.backPurple
		view.addSubviews([helloLabel, closeButton])
		setConstraints()
	}
	
	//MARK: - Methods
	
	@objc private func closeButtonPressed() {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Constraints
	
	private func setConstraints() {
		helloLabel.snp.makeConstraints { label in
			label.centerX.equalToSuperview()
			label.centerY.equalToSuperview()
		}
		closeButton.snp.makeConstraints { button in
			button.top.equalToSuperview().offset(60)
			button.trailing.equalToSuperview()
			button.height.equalTo(80)
			button.width.equalTo(80)
		}
	}
}
