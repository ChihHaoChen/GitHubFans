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
		
		NetworkService.shared.getFollowers(for: usernameForAPI, page: 1) { (result) in
			
			switch result	{
				case .success(let followers):
					print(followers)
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Issues of the API requests", message: error.rawValue, buttonTitle: "Ok")
			}
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

}
