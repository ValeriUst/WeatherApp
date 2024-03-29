//  SceneDelegate.swift
//  ValeriyaWeatherApp
//  Created by Валерия Устименко on 06.02.2024.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.windowScene = windowScene
		let vc = MainTabBarViewController()
		let navigationController = UINavigationController(rootViewController: vc)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
