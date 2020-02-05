//
//  NetworkService.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/08.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class NetworkService	{
	
	// Baseline for Singleton, only one instance is allowed, and static
	static let shared = NetworkService()
	private let baseURL = "https://api.github.com/users/"
	let perPageFollowers = 100
	let cache = NSCache<NSString, UIImage>()

	private init()	{}
	
	func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void)	{
		let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
		
		guard let url = URL(string: endpoint)	else	{
			completed(.failure(.invalideUsername))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error	{
				completed(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else	{
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else	{
				completed(.failure(.invalidData))
				return
			}
			
			do	{
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completed(.success(followers))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		task.resume()  // To start the network call
	}
	
	
	func getUserInfo(for username: String, completed: @escaping(Result<User, GFError>) -> Void)	{
		// Escaping makes closure outlives the main function.
		let endpoint = baseURL + "\(username)"
		
		guard let url = URL(string: endpoint)	else	{
			completed(.failure(.invalideUsername))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error	{
				completed(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else	{
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else	{
				completed(.failure(.invalidData))
				return
			}
			
			do	{
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				decoder.dateDecodingStrategy = .iso8601
				let user = try decoder.decode(User.self, from: data)
				completed(.success(user))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		task.resume()  // To start the network call
	}
	
	
	// MARK: - Function to download avatar images for each follower cell
	func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)	{
		let cacheKey = NSString(string: urlString)
		
		if let image = cache.object(forKey: cacheKey)	{
			completed(image)
			
			return // If image already exists in cache
		}
		// No error handling due to placerholder images
		guard let url = URL(string: urlString) else {
			completed(nil)
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self,
				error == nil,
				let response = response as? HTTPURLResponse, response.statusCode == 200,
				let data = data,
				let image = UIImage(data: data) else {
					completed(nil)
					return
			}
			// Store the downloaded image in cache to avoid repetitive downloading
			self.cache.setObject(image, forKey: cacheKey)
			// Update UI with the main thread
			DispatchQueue.main.async {
				completed(image)
			}
		}
		task.resume()
	}
}
