//
//  GFRepoItemVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/28.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
		configureItems()
    }
    
	private func configureItems()	{
		itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
		itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
	}
}
