//  GreenViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 09.02.2024.

import UIKit

final class GreenViewController: UIViewController {
	
	// MARK: - Content Views
	private let closeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "xmark"), for: .normal)
		button.tintColor = .red
		button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		return button
	}()
	
	// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .green
		view.addSubviews([closeButton])
		setConstraints()
    }
	
	//MARK: - Methods
	@objc private func backButtonTapped() {
		navigationController?.popViewController(animated: true)
	}
	
	// MARK: - Constraints
	private func setConstraints() {
		closeButton.snp.makeConstraints { button in
			button.top.equalToSuperview().offset(60)
			button.trailing.equalToSuperview()
			button.height.equalTo(80)
			button.width.equalTo(80)
		}
	}
}
