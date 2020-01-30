//
//  GFError.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/14.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

enum GFError: String, Error	{
	case invalideUsername = "This username created an invalid request. Please try again."
	case unableToComplete = "Unable to complete your request. Please check your internet connection."
	case invalidResponse = "Invalid response from the servier. Please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
	case unableToFavorite = "There was an error to favorite this user."
	case alreadyInFavorites = "You've already favorited this user. You must REALLY like him/her!"
	
}
