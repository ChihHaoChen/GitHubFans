//
//  GFFollowerItemVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/28.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
		configureItems()
    }
    
	private func configureItems()	{
		itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "GitHub Followers")
	}
	
	override func actionButtonTapped() {
		delegate.didTapGetFollowers(for: user)
	}
}
