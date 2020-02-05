//
//  GFTabBarController.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/31.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoriteNC()]
    }
	
	
	// MARK: - The function to create Search NC
	func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: searchVC)
	}
	
	
	// MARK: - The function to create Favorite NC
	func createFavoriteNC() -> UINavigationController {
		let favoriteListVC = FavoriteListVC()
		favoriteListVC.title = "Favorite"
		favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		
		return UINavigationController(rootViewController: favoriteListVC)
	}
}
