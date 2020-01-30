//
//  PersistenceService.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/30.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

enum PersistenceActionType {
	case add, remove
}

enum PersistenceService	{
	static private let defaults = UserDefaults.standard
	
	enum Keys {
		static let favorites = "favorites"
	}
	
	static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
		retrieveFavorites { (result) in
			switch result {
				case .success(let favorites):
					var retrievedFavorites = favorites
					switch actionType {
						case .add:
							guard !retrievedFavorites.contains(favorite) else {
								completed(.alreadyInFavorites)
								return
							}
							retrievedFavorites.append(favorite)
						case .remove:
							retrievedFavorites.removeAll { $0.login == favorite.login }
					}
					completed(saveFavorites(favorites: retrievedFavorites))
				case .failure(let error):
					completed(error)
			}
		}
	}
	
	// MARK: - To Decode Data
	static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void)	{
		guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
			completed(.success([]))
			return
		}
		do	{
			let decoder = JSONDecoder()
			let favorites = try decoder.decode([Follower].self, from: favoriteData)
			completed(.success(favorites))
		} catch {
			completed(.failure(.unableToFavorite))
		}
	}
	// MARK: - To Encode the Follower into Data
	static func saveFavorites(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavorites = try encoder.encode(favorites)
			defaults.set(encodedFavorites, forKey: Keys.favorites)
			return nil
		} catch {
			return .unableToFavorite
		}
	}
}
