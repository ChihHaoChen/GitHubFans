//
//  Follower.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/03.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable	{
	var login: String
	var avatarUrl: String
	
	func hash(into hasher: inout Hasher)	{ // combine Login info into Hashable info
		hasher.combine(login)
	}
}
