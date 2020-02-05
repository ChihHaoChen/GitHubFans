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
	let placeholderImage = Images.ghPlaceholder
	
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
	
	
	func downloadImage(fromURL url: String) {
		NetworkService.shared.downloadImage(from: url) { [weak self] image in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.image = image
			}
		}
	}
}
