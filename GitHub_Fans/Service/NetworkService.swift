//
//  NetworkService.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/08.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

class NetworkService	{
	let baseURL = "https://api.github.com/users/"
	let perPageFollowers = 100
	// Baseline for Singleton, only one instance is allowed, and static
	static let shared = NetworkService()
	private init()	{}
	
	func getFollowers(for username: String, page: Int, completed: @escaping([Follower]?, String?) -> Void)	{
		let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
		
		guard let url = URL(string: endpoint)	else	{
			completed(nil, "This username created an invalid request. Please try again.")
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error	{
				completed(nil, "Unable to complete your request. Please check your internet connection.")
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else	{
				completed(nil, "Invalid response from the servier. Please try again.")
				return
			}
			
			guard let data = data else	{
				completed(nil, "The data received from the server was invalid. Please try again.")
				return
			}
			
			do	{
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completed(followers, nil)
			} catch {
				completed(nil, "The data received from the server was invalid. Please try again.")
			}
		}
		task.resume()  // To start the network call
	}
}
