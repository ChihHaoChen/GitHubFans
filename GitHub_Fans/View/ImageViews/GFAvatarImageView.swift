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
	
	// MARK: - Function to download avatar images for each follower cell
	func downloadImage(from urlString: String)	{
		let cacheKey = NSString(string: urlString)
		
		if let image = cache.object(forKey: cacheKey)	{
			self.image = image
			
			return // If image already exists in cache
		}
		// No error handling due to placerholder images
		guard let url = URL(string: urlString) else { return }
		
		let task = URLSession.shared.dataTask(with: url)	{ [weak self] data, response, error in
			guard let self = self else { return }
			if error != nil	{ return }
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
			guard let data = data else { return }
			guard let image = UIImage(data: data) else { return }
			// Store the downloaded image in cache to avoid repetitive downloading
			self.cache.setObject(image, forKey: cacheKey)
			// Update UI with the main thread
			DispatchQueue.main.async {
				self.image = image
			}
		}
		task.resume()
	}
}
