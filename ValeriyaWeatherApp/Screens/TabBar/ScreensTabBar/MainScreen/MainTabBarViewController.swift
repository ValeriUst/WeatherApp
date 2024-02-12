//  MainTabBarViewController.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit

final class MainTabBarViewController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewControllers()
		setTabBarAppearance()
	}
	
	private func setupViewControllers() {
		let vc1 = UINavigationController(rootViewController: HomeViewController())
		let vc2 = UINavigationController(rootViewController: SearchViewController())
		let vc3 = UINavigationController(rootViewController: CompassViewController())
		let vc4 = UINavigationController(rootViewController: SettingViewController())
		
		setViewControllers([vc1, vc2, vc3, vc4], animated: true)
		
		vc1.configureTabBarItem(imageName: "home", imageSize: CGSize(width: 34, height: 34))
		vc2.configureTabBarItem(imageName: "search", imageSize: CGSize(width: 34, height: 34))
		vc3.configureTabBarItem(imageName: "compass", imageSize: CGSize(width: 34, height: 34))
		vc4.configureTabBarItem(imageName: "setting", imageSize: CGSize(width: 34, height: 34))
	}
	
	private func setTabBarAppearance() {
		tabBar.tintColor = UIColor.white
		tabBar.backgroundColor = Colors.purpleLight
		tabBar.unselectedItemTintColor = Colors.whiteLight
		tabBar.layer.cornerRadius = Constants.cornerRadiusTabbar
	}
}
