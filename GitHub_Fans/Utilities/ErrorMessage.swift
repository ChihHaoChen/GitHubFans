//
//  ErrorMessage.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/08.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

enum ErrorMessage: String	{
	case invalideUsername = "This username created an invalid request. Please try again."
	case unableToComplete = "Unable to complete your request. Please check your internet connection."
	case invalidResponse = "Invalid response from the servier. Please try again."
	case invalidData = "The data received from the server was invalid. Please try again."
	
}
