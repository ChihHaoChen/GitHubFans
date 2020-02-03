//
//  GFAvatarImageView.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/09.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
	let cache =  NetworkService.shared.cache
	let placeholderImage = UIImage(named: "avatar-placeholder")!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure()	{
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}
}
