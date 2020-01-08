//
//  FollowerListVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/02.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
		guard let usernameForAPI = username else { return }
		
		NetworkService.shared.getFollowers(for: usernameForAPI, page: 1) { (followers, errorMessage) in
			guard let followers = followers	else	{
				print("API CALLs")
				self.presentGFAlertOnMainThread(title: "Issues of the API requests", message: errorMessage!, buttonTitle: "Ok")
				
				return
			}
			print("Followers.count = \(followers.count)")
			print(followers)
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

}
